#!/usr/bin/perl -w

use Date::Simple qw/date today/;
use Data::Dumper;
use Encode;
use ZOOM;
use URI;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Obalky::BibInfo;
use Eshop;
use DB;

my $URL = "http://toc.nkp.cz/obalkyknih";

sub get_marc {
	my($outdir,$base,$cnbs) = @_;
	my $zoom;
	
	$zoom = new ZOOM::Connection('aleph.nkp.cz',9991,
			databaseName=>'NKC01') if($base eq 'NKC');
	$zoom = new ZOOM::Connection('aleph.mzk.cz',9991,
			databaseName=>'MZK01-UTF') if($base eq 'MZK');
	$zoom = new ZOOM::Connection('library.vse.cz',2100,
			databaseName=>'SOUKAT') if($base eq 'VSE');
	$zoom = new ZOOM::Connection('aleph.vkol.cz',9991,
			databaseName=>'SVK01') if($base eq 'SVK');
	$zoom->option(preferredRecordSyntax => "usmarc");
	
	die "$base: No zoom\n" unless($zoom);
	
	my $count = 0;
	foreach my $cnb (@$cnbs) {
		warn "$base: \@attr 1=12 $cnb\n" if($ENV{DEBUG});
		my $res = $zoom->search_pqf('@attr 1=12 '.$cnb); 
		my $rec = $res->record(0);
		unless($rec) {
			warn $cnb.": $cnb not found\n";
			next;
		}
		if($res->size() != 1) {
			warn $cnb.": multiple $cnb records in NKC??\n";
			next;
		}
		print "$count/".scalar(@$cnbs)."...\n" unless($count++ % 1000);
#		print "$cnb: OK\n";

		my $marc = decode_utf8($rec->render("charset=windows-1250"));
		open(MARC,">utf8","$outdir/$cnb.marc") or die;
		print MARC $marc;
		close(MARC);
	}
}

sub download {
	my($type,$yyyymm,$base,$tmpdir,$outdir) = @_;
	warn "stahuju $base $type $yyyymm\n";

	my %cnb;
	my %cnb_txt;
	my %cnb_ext;
	
	# MZK NKC SVK VSE XXX

	open(WGET,"wget -q -O - '$URL/$base/$yyyymm/$type'|");
	while(<WGET>) {
		# HREF="/obalkyknih/NKC/201105/covers/cph20112180472_1_tn.jpg"
		while(s/HREF=\"(.*?)\"//) {
			my $url = URI->new_abs($1,"$URL/$base/$yyyymm/$type")->as_string;
			my($y4m2,$cnb,$seq,$tn,$ext) = ($url =~ 
						/\/(\d+)\/$type\/(.+?)(\_\d+)(\_tn)?\.(...)$/);
			next unless($cnb);
			next if($tn);
			next if($cnb =~ /^vse/); # VSE - tyto nevim co jsou - ignoruj
			$cnb =~ s/^vse//; # Jiri Rataj <rataj@cuni.cz> wrote: sysno, někdy 
			# s prefixem vse (to si zavedli ve zpracování, mě to netrápilo). 
			if($ext eq 'txt') {
				$cnb_txt{$cnb} = $url;
			} else {
				# warn "duplicate $cnb\n" if($cnb{$cnb});
				$cnb{$cnb} = $url;		
				$cnb_ext{$cnb} = $ext;
			}
		}
	}
	close(WGET);
	warn scalar(keys %cnb)." ".$type."(s) found in TOC for $yyyymm\n";
	
	# 'select id,nbn,cover from product where eshop = 103;'
	my %already; # seznam CNB, ke kterym uz obalku mame
	open(NBN,"mysql obalky -e ".
		"'select nbn,cover,toc,id from product where eshop = 103' |") or die;
	while(<NBN>) {
		my($nbn,$cover,$toc,$id_crlf) = split(/\t/);
		#600270996   nkc20081804695  NULL
		$already{$nbn}++ if(($type eq 'covers' and $cover ne 'NULL') or 
							($type eq 'contents' and $toc ne 'NULL'));
	}
	warn scalar(keys %already)." $type from TOC found in obalkyknih.cz\n";
	
	get_marc($outdir,$base,[sort keys %cnb]);
	
	foreach my $cnb (sort keys %cnb) {
		next unless(-f "$outdir/$cnb.marc");
		next if($already{$cnb});
	#	print "missing $cnb\n";
	}

	my $eshop = DB->resultset('Eshop')->find_by_name('TOC');
	
	my $count = 0;
	foreach my $cnb (sort keys %cnb) {
		if($already{$cnb}) {
			print "already $cnb\n";
			next;
		}
	
		next unless(open(MARC,"<utf8","$outdir/$cnb.marc"));

		my $marc = ''; $marc .= $_ while(<MARC>);
		close(MARC);
	
		my $info = {};
		my $tmpfile = "$tmpdir/$cnb.".$cnb_ext{$cnb};
		my $file_url = $cnb{$cnb};
		system("wget -q -O $tmpfile $file_url");
		if($type eq 'covers') {
			$info->{cover_url} = $file_url;
			$info->{cover_tmpfile} = $tmpfile;
		} else {
			$info->{tocpdf_url} = $file_url;
			$info->{tocpdf_tmpfile} = $tmpfile;
			if($cnb_txt{$cnb}) {
				$info->{toctext} = Obalky::Tools->wget($cnb_txt{$cnb});
			}
		}
		my $media = Obalky::Media->new_from_info($info);
	
		my %perma = (
			'NKC' => 'http://aleph.nkp.cz'.
					'/F?func=find-c&ccl_term=sys=$&local_base=NKC01',
			'MZK' => 'http://aleph.mzk.cz'.
					'/F?func=find-c&ccl_term=sys=$&local_base=MZK01',
			'VSE' => 'http://library.vse.cz'.
					'/F?func=find-c&ccl_term=sys=$&local_base=SOUKAT',
			'SVK' => 'http://aleph.vkol.cz'.
					'/F?func=find-c&ccl_term=sys=$&local_base=SVK01',
		);
		my($bibinfo,$product_url) = 
				Eshop::TOC->parse_marc($cnb,$marc,$perma{$base});

		unless($product_url) {
			print Dumper($bibinfo,$cnb,$marc); exit;
			print "discrepancy\n";
			next;
		}
	
#		if($bibinfo->nbn and $already{$bibinfo->nbn}) {
#			print "cnb $cnb uz je jako nbn ".$bibinfo->nbn."\n";
#			next;
#		}
	
		print "add $type [$cnb] ".$bibinfo->to_some_param."\n";
		$count++;
	
#		next if($cnb ne 'zpk20091992624');

#		print Dumper($bibinfo,$media,$product_url);

		my $product = $eshop->add_product($bibinfo,$media,$product_url);
		print "[$cnb] added as #".$product->id."\n";
	}
	print "Nahrano $count/".scalar(keys %cnb)." obalek\n";
	
	
}

my($yyyymm,$base,$type) = @ARGV;
die "\nusage: $0 [thismonth|201105] [NKC] [covers]\n\n" unless($yyyymm);

if($yyyymm eq 'thismonth') {
	$yyyymm = $1.$2 if(today() =~ /^(\d\d\d\d)\-(\d\d)/);
}

foreach my $do_type ($type ? ($type) : ("covers","contents")) {
	foreach my $do_base ($base ? ($base) : ("NKC","MZK","SVK","VSE")) {
		# next if($do_base eq 'VSE'); # jeste neumime, Z39 nam vraci usmarc..
		my $outdir = "/tmp/marc"; system("rm -rf $outdir && mkdir $outdir");
		my $tmpdir = "/tmp/file"; system("rm -rf $tmpdir && mkdir $tmpdir");
		download($do_type,$yyyymm,$do_base,$tmpdir,$outdir);
	}
}
