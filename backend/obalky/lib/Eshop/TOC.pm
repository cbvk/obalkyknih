
package Eshop::TOC;
use base 'Eshop';
use utf8;

# 200608+

use Encode;

use LWP::UserAgent;
use ZOOM;
use MARC::Record;
use Data::Dumper;

use Obalky::BibInfo;
use Obalky::Media;
use Obalky::Tools;

__PACKAGE__->register(crawl => 0, license => 'free',
		title => 'toc.nkp.cz' );

my $g_zoom; # connection object

sub get_dir_url {
	my($self,$subdir,$from) = @_;
	my $yyyymm = $from->strftime("%Y%m");
	return "http://toc.nkp.cz/obalkyknih/$yyyymm/$subdir/";
}

sub parse_marc {
	my($pkg,$nbn,$marc,$permaurl) = @_;
	my($f001,$f015a,$f035a,$f022a,$f020a,$f245a,$f100a,$f260c) 
			= ('','','','','','','');
	my $sno;
	foreach(split(/\n/,$marc)) {
		if(/^001\s(.*)$/) {
			$f001 = $1;
		# 020 muze byt vic, 1. je ISBN souboru, 2. je ISBN svazku
		} elsif(/^015\s..\s\$a\s([^\$]+)/) {
			$f015a = $1;
		} elsif(/^020\s..\s\$a\s([^\$]+)/) {
			$f020a = $1;
		} elsif(/^022\s..\s\$a\s([^\$]+)/) {
			$f022a = $1;
		} elsif(/^035\s..\s\$a\s([^\$]+)/) {
			$f035a = $1;
		} elsif(/^245\s..\s\$a\s([^\$]+)/) {
			$f245a = $1;
		} elsif(/^260\s..\s\$c\s([^\$]+)/) {
			$f260c = $1;
		} elsif(/^100\s..\s\$a\s([^\$]+)/) {
			$f100a = $1;
		} elsif(/^998\s..\s\$a\s([^\$]+)/) {
			$sno = $1;
		}
	}

	my $bibinfo = Obalky::BibInfo->new_from_params({ nbn => $nbn });
	# HACK! NBN neni NBN ale SYSNO, $bibinfo ale nemuze byt prazdne
	delete $bibinfo->{nbn}; 

	my $sysno = $sno ? $sno : ($f001 =~ /^\d+$/ ? $f001 : undef);
	die "Chybi SYSNO (f001=$f001)!\n" unless($sysno);
	my $permalink = ($permaurl =~ /^(.*)\$(.*)$/) ? "$1$sysno$2" : undef;

	if(not $f001 or $f001 ne $nbn) {
		warn "$sno: 001 != NBN ($f001 != $nbn) discrepancy in NKC\n";
	}

	$bibinfo->oclc($1) if($f035a =~ /(\d+)/);
	# TODO: co s vice ISBN??
	$bibinfo->isbn($1) if($f020a =~ /([\d\-xX]+)\s*.*$/);
	$bibinfo->issn($1) if($f022a =~ /([\d\-xX]+)\s*.*$/);
	$bibinfo->{nbn}     = $1         if($f015a =~ /([cnb\d\-xX]+)\s*.*$/);
	$bibinfo->{title}   = $1         if($f245a =~ /^([^\/\:]+)/);
	$bibinfo->{authors} = [ $f100a ] if($f100a);
	$bibinfo->{year}    = $1         if($f260c and $f260c =~ /(\d{4})/);

	return ($bibinfo,$permalink);
}

sub nbn_to_bibinfo {
	my($pkg,$nbn) = @_;

	warn "nbn_to_bibinfo($nbn)\n" if($ENV{DEBUG});

	# cache?

	$g_zoom = new ZOOM::Connection(
		'aleph.nkp.cz',9991,databaseName=>'NKC') unless($g_zoom);

	my $res = $g_zoom->search_pqf('@attr 1=12 '.$nbn); sleep 1; # !
	#my $res = $g_zoom->search_pqf('@attr 1=1032 '.$nbn); sleep 1; # !
	if($res->size() != 1) {
		warn "$nbn: multiple $nbn records in NKC??\n" if($res->size() > 1);
##		warn "$nbn: record not found in NKC!\n" unless($res->size());
		return ($bibinfo);
	}
	my $rec = $res->record(0) or die;
	my $marc = decode_utf8($rec->render("charset=windows-1250"));

	return $pkg->parse_marc($nbn,$marc, 'http://aleph.nkp.cz'.
			'/F?func=find-c&ccl_term=sys=$&local_base=NKC01');
}

sub download {
	my($self,$subdir,$storable,$from,$to,$TMP_DIR) = @_;	

	my $ua = LWP::UserAgent->new; $ua->timeout(10);
	$ua->proxy('http', 'http://www.obalkyknih.cz:3374/');

	my $dir_url = $self->get_dir_url($subdir,$from);

	my $response_dir = $ua->get($dir_url);
	warn "getting $dir_url\n" if($ENV{DEBUG});
	my $dirlist = $response_dir->decoded_content || '';

	my @list;
	my $DEBUG_LIMIT = $ENV{DEBUG};

	while($dirlist =~ s/\<A HREF\=\"([^\"]*?\/?)([^\"\/]+)\"\>//) {
		my $file = $2;
		next if($file =~ /_tn\.jpg$/);

		my $day = int($from->strftime("%d")) % 10;
		next unless($file =~ /$day\.\D+$/);

		last if(defined $DEBUG_LIMIT and $DEBUG_LIMIT-- == 0);

		# FIX: obalkyknih/200806/contents/nkc20051629155_10.pdf

		my($nbn,$ext) = ($file =~ /^(.+)\_1\.(jpg|pdf|txt)$/) or next;
		next if($seen->{$ext}->{$nbn}++); #?

		my $response_file = $ua->mirror($dir_url.$file,"$TMP_DIR/$file");
		unless($response_file->is_success) {
			warn "Failed to download $dir_url$file: ".$response->status_line;
			next;
		}

		my($bibinfo,$product_url) = $self->nbn_to_bibinfo($nbn);
		my $media = {};
		if($ext eq 'jpg') { # obalka
			$media->{cover_url} = $dir_url.$file;
			$media->{cover_tmpfile} = "$TMP_DIR/$file";
		} elsif($ext eq 'pdf') { # PDF obsah
			$media->{tocpdf_url} = $dir_url.$file;
			$media->{tocpdf_tmpfile} = "$TMP_DIR/$file";
		} elsif($ext eq 'txt') { # TXT obsah
			$media->{toctext} = Obalky::Tools->slurp(
						"$TMP_DIR/$file","windows-1250");
		}

		# permalink? kam? pozor, nejde vyloucit nejedinecnost!
		push @list, [$bibinfo, Obalky::Media->new_from_info($media), 
					 $product_url ] if($product_url);

#		last if($ENV{DEBUG} and $bibinfo->{nbn} eq 'cnb000356585');
	}

	return @list;
}

sub crawl {
	my($self,$storable,$from,$to,$TMP_DIR) = @_;	
	die unless $from;
	my @list;
	push @list, $self->download("covers",  $storable,$from,$to,$TMP_DIR);
	push @list, $self->download("contents",$storable,$from,$to,$TMP_DIR);
	return @list;
}

1;
