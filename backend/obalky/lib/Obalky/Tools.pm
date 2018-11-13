
package Obalky::Tools;

use LWP::UserAgent;
use File::Copy;
use Obalky::Config;
use Data::Dumper;

# Samostatna knihovna

sub valid_email {
	my($pkg,$email) = @_;
	# nebudeme to prehanet..
	return ($email =~ /^\S+\@\S+\.\S+$/) ? 1 : 0;
}

sub slurp {
	my($pkg,$filename,$encoding) = @_;
	my $content = '';
	open(FILE,$encoding ? "<encoding($encoding)" 
			: "<bytes",$filename) or die "$filename: $!";
	while(sysread(FILE,$content,16384,length($content))) {}
	close(FILE);
	return $content;
}

sub wget {
	my($pkg,$url) = @_;
	my $ua = new LWP::UserAgent;
	my $res = $ua->get($url);
	die $url.": ".$res->status_line unless($res->is_success);
	return $res->content if($res->is_success);
}

sub wget_to_file {
	my($pkg,$url,$file) = @_;
	unlink $file;
	my $ua = LWP::UserAgent->new;
	my $res = $ua->mirror($url,$file);
	return ($res and $res->is_success) ? $file : undef;
}


# pro obrazek o velikosti w:h vrat rozmery max maxw:maxh stejneho pomeru stran
sub resize {
	my($pkg,$maxw,$maxh,$w,$h) = @_;
	return ($maxw,$maxh) unless($w or $h);
	return ($h*$maxw/$w > $maxh) ? # au, matika boli..
			(int($w*$maxh/$h),$maxh) : ($maxw,int($h*$maxw/$w));
}

sub image_size {
	my($pkg,$file) = @_;
	my $DEVNULL = "";#"2>/dev/null >/dev/null";
	my $sizecmd = "/usr/bin/identify -format '\%wx\%h' '$file' $DEVNULL";
	my $dim = `$sizecmd`;
	my($width,$height) = ($dim and $dim =~ /^(\d+)x(\d+)/); # or die!!!
	warn "identify('$file') failed ($dim)!\n" unless($height);
	_do_log("identify('$file') failed ($dim)!");
	return $height ? ($width,$height) : ();
}

# take v C::API.pm
my $OCR_DIR_INPUT  = "/opt/obalky/ocr/input";
my $OCR_DIR_OUTPUT = "/opt/obalky/ocr/output";
my $OCR_DIR_INPUT_NKP  = "/opt/store/toc_ocr/in";
my $OCR_DIR_OUTPUT_NKP = "/opt/store/toc_ocr/out";
my $OCR_DIR_ORPHAN_NKP = "/opt/store/toc_ocr/orphan";

use DB;
use Encode;

# perl -wC -I/opt/obalky/lib -MObalky::Tools -e Obalky::Tools::cmdCronTocOcr
sub cmdCronTocOcr {
	my $Toc = DB->resultset('Toc') or die;
	foreach my $in (glob("$OCR_DIR_INPUT/*")) {
		my($tocId,$suffix) = ($in =~ /\/(\d+)\.?(\w*)$/);
		my $toc = $Toc->find($tocId) or die $tocId;
		my $out = "$OCR_DIR_OUTPUT/$tocId.pdf";
              my $outTxt = "$OCR_DIR_OUTPUT/$tocId.txt";
		my $inpdf = "$OCR_DIR_INPUT/$tocId.pdf";
		unless(-f $inpdf) { # zkonvertuj vstupni soubor(y) na pdf
			if(-d "$OCR_DIR_INPUT/$tocId") {
				system("gm convert $OCR_DIR_INPUT/$tocId/* $inpdf");
			} else {
				system("gm convert $in $inpdf");
			}
		}
		unless(-f $out) { # udelej na vstupnim pdf OCR
			warn "Running ocr/run.sh $inpdf $out\n" if($ENV{DEBUG});
			_do_log("Running ocr/run.sh $inpdf $out");
			system("/opt/obalky/ocr/run.sh $inpdf $out >/dev/null 2>/dev/null");
		}
		if(-f $out) { # OCR na file system
			my $text = decode_utf8(`cat $outTxt`);
			my $content = Obalky::Tools->slurp($in);
			warn "Updating $tocId, text ".length($text)." chars, PDF ".length($content)." bytes\n";
			_do_log("Updating $tocId, text ".length($text)." chars, PDF ".length($content)." bytes");
			$toc->update({ full_text => $text, pdf_file => undef });
			# metadata changed; do FE sync
			DB->resultset('FeSync')->book_sync_remove($toc->book->id);
			# PDF files are grouped in dir
			my $dirGroupName = int($tocId/10000+1)*10000;
			mkdir($Obalky::Config::TOC_DIR.'/'.$dirGroupName) unless (-d $Obalky::Config::TOC_DIR.'/'.$dirGroupName);
			# place PDF onto file system
			open(OUTFILE, ">".$Obalky::Config::TOC_DIR.'/'.$dirGroupName.'/'.$tocId.'.pdf');
			print OUTFILE $content;
			close(OUTFILE);
			unlink $in, $inpdf, $out, $outTxt; # done
		}
	}
}

# perl -wC -I/opt/obalky/lib -MObalky::Tools -e Obalky::Tools::cmdCronTocOcrNkp
sub cmdCronTocOcrNkp {
	my $Toc = DB->resultset('Toc') or die;
	my $feSync = 0;
	foreach my $in (glob("$OCR_DIR_OUTPUT_NKP/*")) {
		my($tocId,$unused,$suffix) = ($in =~ /\/(\d+)(\.\d+)?\.?(\w*)$/);
		my $toc = $Toc->find($tocId);
		# zaznam uz neni v DB, podezrele, ale neni
		# presunout do adresare se sirotky
		unless ($toc) {
			move($in, "$OCR_DIR_ORPHAN_NKP/$tocId.$suffix");
			warn "!!! ORPHAN... $tocId.$suffix";
			_do_log("!!! ORPHAN... $tocId.$suffix");
		}
		# ochrana pred nulovym obsahem souboru
		unless (-s $in) {
			unlink $in;
			warn "!!! EMPTY... $tocId.$suffix";
			_do_log("!!! EMPTY... $tocId.$suffix");
			next;
		}
		# PDF
		if ($suffix eq 'pdf') {
			my $out = "$OCR_DIR_OUTPUT_NKP/$tocId.pdf";
			my $content = Obalky::Tools->slurp($in);
			$toc->update({ pdf_file => undef });
			warn "Updating PDF $tocId, ".length($content)." bytes\n";
			_do_log("Updating PDF $tocId, ".length($content)." bytes");
			# PDF files are grouped in dir
			my $dirGroupName = int($tocId/10000+1)*10000;
			mkdir($Obalky::Config::TOC_DIR.'/'.$dirGroupName) unless (-d $Obalky::Config::TOC_DIR.'/'.$dirGroupName);
			# place PDF onto file system
			my $tocFile = $Obalky::Config::TOC_DIR.'/'.$dirGroupName.'/'.$tocId.'.pdf';
			open(OUTFILE, ">".$tocFile);
			print OUTFILE $content;
			close(OUTFILE);
			# change owner and access rights
			system('chown obalky:obalky '.$tocFile);
			system('chmod 644 '.$tocFile);
			# metadata changed; do FE sync
			DB->resultset('FeSync')->book_sync_remove($toc->book->id) unless ($feSync);
			$feSync = 0;
			unlink $in; # done
		}
		# FULLTEXT
		if ($suffix eq 'txt') {
			my $outTxt = "$OCR_DIR_OUTPUT_NKP/$tocId.txt";
			my $text = decode('cp1250', `cat $in`);
			$toc->update({ full_text => $text });
			warn "Updating FULLTEXT $tocId, text ".length($text)." chars\n";
			_do_log("Updating FULLTEXT $tocId, text ".length($text)." chars");
			# metadata changed; do FE sync
			DB->resultset('FeSync')->book_sync_remove($toc->book->id);
			$feSync = 1;
			unlink $in; # done
		}
	}
}

sub _do_log {
    my($msg) = @_;
    open(LOG,">>utf8","/opt/obalky/log/ocr_nkp.log");
    print LOG localtime." ".$msg."\n";
    close(LOG);
}


#sub is_ocr_done {
#	my($pkg
#}


#use MD5;
#
#sub compute_md5 {
#	my($pkg,$filename) = @_;
#	my $ctx = new MD5; $ctx->reset();
#	open(FILE,$filenam) or die;
#	$ctx->addfile(FILE);
#	close(FILE);
#	return $ctx->hexdigest();
#}

#use Cache::Memcached::XS;
#
#my $mem = new Cache::Memcached {
#	'servers' => [ "127.0.0.1:11211" ]
#	'compress_threshold' => 10_000,
#	'debug' => 0,
#};
#
#sub cover_cache_get {
#	my($id) = @_;
#	return $mem->get($id->to_string);
#}
#
#sub cover_cache_store {
#	my($id,$cover) = @_;
#	$mem->set($id->to_string,$cover->id);
#}

1;
