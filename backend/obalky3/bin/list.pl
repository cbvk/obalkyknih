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
			databaseName=>'') if($base eq 'VSE');
	$zoom = new ZOOM::Connection('aleph.vkol.cz',9991,
			databaseName=>'SVK01') if($base eq 'SVK');
	$zoom->option(preferredRecordSyntax => "usmarc");
	
	die "$base: No zoom\n" unless($zoom);
	
	my $count = 0;
	foreach my $cnb (@$cnbs) {
			my $sno = $1 if($cnb =~ /(\d+)/);
		my $res = $zoom->search_pqf('@attr 1=12 '.$sno); 
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

sub import_cnb {
	my($type,$base,$file_cnb,$file_url,$tmpfile,$outdir) = @_;

	get_marc($outdir,$base,[$file_cnb]);

	foreach my $cnb ( ($file_cnb) ) {
		next unless(-f "$outdir/$cnb.marc");
	}

	my $eshop = DB->resultset('Eshop')->find_by_name('TOC');
	
	my $count = 0;
	foreach my $cnb ( ($file_cnb) ) {
		next unless(open(MARC,"<utf8","$outdir/$cnb.marc"));
		my $marc = ''; $marc .= $_ while(<MARC>);
		close(MARC);
	
		my $info = {};
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
	
#		my $product = $eshop->add_product($bibinfo,$media,$product_url);
#		print "[$cnb] added as #".$product->id."\n";
	}
}

my $outdir = "/tmp/marc"; system("rm -rf $outdir && mkdir $outdir");

while(<DATA>) {
	my($cnb,$url) = (/^(.*)\t(.*)$/);
	import_cnb("covers","NKC",$cnb,$url,"list/$cnb.jpg",$outdir);
}

__END__
cnb000980962	http://www.nkp.cz/tituly/images/2003/03/21.jpg
cnb000992070	http://www.nkp.cz/tituly/images/2003/12/31.jpg
cnb001064627	http://www.nkp.cz/tituly/images/2003/09/06.jpg
cnb001093295	http://www.nkp.cz/tituly/images/2003/12/18.jpg
cnb000964718	http://www.nkp.cz/tituly/images/2001/04/31.jpg
cnb000993379	http://www.nkp.cz/tituly/images/2001/03/46.jpg
cnb000991475	http://www.nkp.cz/tituly/images/2001/03/47.jpg
cnb000991236	http://www.nkp.cz/tituly/images/2001/03/48.jpg
cnb000971414	http://www.nkp.cz/tituly/images/2000/12/68.jpg
cnb001002114	http://www.nkp.cz/tituly/images/2001/06/44.jpg
cnb001003439	http://www.nkp.cz/tituly/images/2002/10/19.jpg
cnb001065413	http://www.nkp.cz/tituly/images/2002/04/74.jpg
cnb001067309	http://www.nkp.cz/tituly/images/2003/01/19.jpg
cnb001090656	http://www.nkp.cz/tituly/images/2002/04/28.jpg
cnb001092665	http://www.nkp.cz/tituly/images/2003/02/42.jpg
cnb001093255	http://www.nkp.cz/tituly/images/2003/09/12.jpg
cnb001093707	http://www.nkp.cz/tituly/images/2003/09/24.jpg
cnb001122639	http://www.nkp.cz/tituly/images/2002/06/05.jpg
cnb001001978	http://www.nkp.cz/tituly/images/2003/01/05.jpg
cnb001034883	http://www.nkp.cz/tituly/images/2003/12/14.jpg
cnb001091144	http://www.nkp.cz/tituly/images/2002/04/29.jpg
cnb001123745	http://www.nkp.cz/tituly/images/2002/06/06.jpg
cnb000999541	http://www.nkp.cz/tituly/images/2001/10/21.jpg
cnb000359223	http://www.nkp.cz/tituly/images/2002/04/50.jpg
cnb001750298	http://www.nkp.cz/tituly/images/2001/06/45.jpg
cnb000359312	http://www.nkp.cz/tituly/images/2002/01/11.jpg
cnb001181578	http://www.nkp.cz/tituly/images/2003/07/91.jpg
cnb001066876	http://www.nkp.cz/tituly/images/2002/02/66.jpg
cnb001023988	http://www.nkp.cz/tituly/images/2002/02/69.jpg
cnb001180279	http://www.nkp.cz/tituly/images/2003/09/25.jpg
cnb001291244	http://www.nkp.cz/tituly/images/2002/03/102.jpg
cnb000361025	http://www.nkp.cz/tituly/images/2002/07/73.jpg
cnb001798226	http://www.nkp.cz/tituly/images/2008/04/44.jpg
