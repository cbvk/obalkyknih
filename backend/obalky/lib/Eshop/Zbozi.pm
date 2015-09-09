

package Eshop::Zbozi;
use base 'Eshop::Mechanize';
use WWW::Mechanize;
use Data::Dumper;
use XML::Simple;
use Time::localtime;
use lib "../lib";
use strict;
use File::Path;# qw(make_path remove_tree);
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Encode;

use DB;
use strict;
use utf8;

__PACKAGE__->register(crawl => 1, license => 'licensed', czech => 0 );

sub download_toc {
	my($pkg,$tmp_dir,$item,$ean) = @_;

	my $firsttocfile;
	my $toc_file;

	if($item->{TOC}) {
		my $toc_dir = "$tmp_dir/$ean";
		system("rm -rf $toc_dir");
		mkdir $toc_dir or die;
		my $pages = $item->{TOC}->{PAGEURL} || [];
		foreach(my $i=0;$i<@$pages;$i++) {
			my $i4 = sprintf("%04d",$i); # budeme radit abecedne
			my $page = $pages->[$i];
			next unless($page);
			$firsttocfile = $page unless($firsttocfile);
#			warn "wget: $page\n";
			if(system("wget -q $page -O $toc_dir/$i4 >/dev/null")) {
				warn "$page: failed to wget!\n";
				return;
			}
		}
		$toc_file = "$tmp_dir/$ean.pdf";
		system("convert $toc_dir/* $toc_file");
		die "Konstrukce PDF z $toc_dir se nezdarila" unless(-s $toc_file);
		system("rm -rf $toc_dir");
	}
	return $toc_file;
}


sub process_shopitem {
	my($self,$tmp_dir,$item) = @_;

	my $product_url = $item->{URL} or die;
	my $authors = $item->{AUTHORS} // '';
	$product_url =~ s/^\<//; $product_url =~ s/\>$//; # MLP fix
	$authors =~ s/^\<//; $authors =~ s/\>$//; # MLP fix

	my $info;
	my $ean = $item->{ISBN} || $item->{EAN} || $item->{PRODUCTNO};
	$ean = $1 if(not $ean and $item->{DESCRIPTION} =~ /\D([\d\-]{12,})\D/);
	unless($ean) {
		warn "EAN not found for $product_url\n";
		return;
	}
	
	# podpora stahovani po castech (for i in 0 .. 1 ; do ZBOZI_PART=$i ...)
	return if(defined $ENV{ZBOZI_PART} and $ean !~ /$ENV{ZBOZI_PART}$/);

	my $title = $item->{PRODUCT};
	if (defined $title) {
		$title =~ s/ - SLEVA \d+\%//g;
		$title =~ s/^<\s*//g;
		$title =~ s/\s*>$//g;
	}

	$info->{price_vat} = $item->{PRICE_VAT};
	$info->{price_cur} = 'CZK';

	$info->{review_impact} = $Obalky::Media::REVIEW_ANNOTATION;
	$info->{review_html} = $item->{DESCRIPTION};

	my $cover_url = $item->{IMGURL};
	if($cover_url) {

		# knihy.abz.cz dava Zbozi.cz jen prtave nahledy, oprav na fullsize
		$cover_url =~ s/^(.*knihy.abz.cz.*)\_zbozi(.*)/$1_main$2/;
		warn "$ean: $cover_url\n" if($ENV{DEBUG});

		my $ext = $1 if($cover_url =~ /\.(jpe?g|pdf|txt|png|tiff?|gif)$/i);
		unless($ext) {
			warn "Neznama pripona v $cover_url\n";
			return;
		}
		my $temp = "$tmp_dir/$ean.$ext";
		system ("wget -q $cover_url -O $temp >/dev/null") and return;

##		if($ext eq 'jpg' or $ext eq 'gif') { # obalka
			$info->{cover_url} = $cover_url;
			$info->{cover_tmpfile} = $temp;
##		} elsif($ext eq 'pdf') { # PDF obsah
##			$info->{tocpdf_url} = $file;
##			$info->{tocpdf_tmpfile} = $temp;
##		} elsif($ext eq 'txt') { # TXT obsah
##			$info->{toctext} = Obalky::Tools->slurp(
##                 $temp,"windows-1250");
##		}
	}

	# zpracuj obsahy ve formatu MKP 
	# $info->{tocpdf_url} = $firsttocfile; # to ma vest k nam na PDF
	$info->{tocpdf_tmpfile} = $self->download_toc($tmp_dir,$item,$ean);

    my $bibinfo = Obalky::BibInfo->new_from_params({
		ean => $ean, title => $title, 
		authors=> $authors, year => $item->{ROKVYDANI} });
	my $media = Obalky::Media->new_from_info( $info );

	# rmdir "/tmp/cover.$$.$ean";
	return [ $bibinfo,$media,$product_url ];
}

sub crawl {
	my($self,$storable,$from,$to,$tmp_dir,$feed_url) = @_;

	return [] unless($feed_url);

	system("wget -q $feed_url -O $tmp_dir/feed.xml") and die "$tmp_dir: $!";
	warn "Got xml feed\n" if($ENV{DEBUG});

	my $tm = localtime;
	my $date = $tm->mday."-".$tm->mon."-".$tm->year;

	# maji blbe psane kodovani
#	$xml_content =~ s/windows-1250/utf-8/ if($feed_url =~ /fragment/); 
#	$xml_content =~ s/iso-8859-2/utf-8/ if($feed_url =~ /knihy.abz.cz/);
	my $xml_content =~ s/windows-1250/utf-8/ if($feed_url =~ /mlp.cz/);
#	if($feed_url =~ /mlp.cz/) { # tito jsou uplne mimo, upravime pres enca
#		system("enconv -L cs -x utf8 $tmp_dir/feed.xml") and die;
#		open(TMP,"<utf8","$tmp_dir/feed.xml");
#		my $xml_content = join("",<TMP>);
#		close(TMP);
#		$xml_content =~ s/windows-1250/utf-8/;
#		open(TMP,">utf8","$tmp_dir/feed.xml");
#		print TMP $xml_content;
#		close(TMP);
#	}
	my $err;

	my $xml = eval { XMLin("$tmp_dir/feed.xml",
		SuppressEmpty => 1, ForceArray => ["SHOPITEM","PAGEURL"]); };
	if($@) {
		warn "$feed_url: $@";
		return ();
	}

	my $demo = $ENV{DEBUG} ? 300 : 3_000_000; # vsechno naraz..

	my $items = @{$xml->{SHOPITEM}};
	warn "$items SHOPITEMs\n" if($ENV{DEBUG});

	my @books;
	foreach my $item (@{$xml->{SHOPITEM}}) {

		# do $storable cache ukladej $md5 serializovaneho XML a timestamp
		my $md5 = md5_hex(encode_utf8(XMLout($item)));
		my $lastmonth = time-31*24*60; # znovu sklid starsi nez mesic
		next if($storable->{$md5} and $storable->{$md5} > $lastmonth);
		$storable->{$md5} = time;

		my $book = $self->process_shopitem($tmp_dir,$item);
		warn Dumper($book) if($ENV{DEBUG} and $ENV{DEBUG} > 1);
		push @books, $book if($book);
		last unless($demo--);
	}
	return @books;
}

#sub cover_link {
#    my($self,$mech,$ean) = @_;
#	print "Zbozi: $ean\n";
#	my $cover_url = "http://fcvitejeves.cz/obalky.xml";
#	my $url = $cover_url;
#	return $cover_url ? ($cover_url,$url) : ();
#}


1;
