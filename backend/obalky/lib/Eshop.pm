
package Eshop;

use Obalky::BibInfo;
use Obalky::Media;
use Obalky::Config;

use Data::Dumper;
use utf8;

my %eshop;
sub get_eshops { %eshop }

sub get_eshop {
	my($pkg,$name) = @_;
	return $eshop{$name};
}
sub get_logo_url {
	my $eshop = shift;
	return $Obalky::Config::WWW_URL."/img/logo/".$eshop->name.".gif";
}

sub register {
	my $pkg = shift @_;
	my($eshop) = ($pkg =~ /^Eshop\:\:(.+)/) or die;
	$eshop{$eshop} = bless { eshop => $eshop, @_ }, $pkg;
	$eshop{$eshop}->{name} = $1;
	$eshop{$eshop}->{found} = 0;
	$eshop{$eshop}->{fails} = 0;
	$eshop{$eshop}->{fetch} = 0;
	$eshop{$eshop}->{display} = 1 unless(defined $eshop{$eshop}->{display});
#	warn "Registered $eshop\n";
}

sub example {
	my($eshop) = @_;
	my $ean = $eshop->{test};
	return Obalky::BibInfo->new_from_params({ ean => $ean });
}

## use Eshop::Amazon;
use Eshop::Kosmas;
use Eshop::Legacy;
use Eshop::Martinus;
use Eshop::Zbozi;
use Eshop::SKAT;
use Eshop::TOC;
use Eshop::SCKN;

use Eshop::Legacy;
use Eshop::SimpleURL;
use Eshop::OpenLibrary;
use Eshop::GoogleBooks;
use Eshop::LibraryThing;
use Eshop::Static;
use Eshop::Upload;
use Eshop::NKP_OAI;

sub name { shift->{name} };

sub can_harvest {
	my($eshop) = @_;
	return $eshop->{harvest} ? 1 : 0;
}

sub might_cover_bibinfo { 1 }
# ean_prefix ?
#sub might_cover_bibinfo {
#	my($eshop,$bibinfo) = @_;
#	my $czech = $bibinfo->is_czech;
#	return (not defined $czech or $czech);
#}

sub new {
	my($pkg,$class,$temp) = @_;
	mkdir $temp."/".$class;
	return bless { class=> $class, temp => $temp }, $pkg;
}

sub fetch_image {
	my($pkg,$ean13,$url,$dir) = @_;
	my $suff = ($url =~ /\.gif$/) ? ".gif" : ".jpg";

   	my $filename = $ean13.$suff;
	##print "WGET $url\n";
	unlink($dir."/".$filename); # pro jistotu
	eval {
		local $SIG{ALRM} = sub { die "alarm\n" };
		alarm 5;
		system("wget -q -O '$dir/$filename' '$url'");
		alarm 0;
	};
	if($@) {
		warn "TIMEOUT: $url\n";
	}
	if(-f $dir."/".$filename and -s $dir."/".$filename > 1000) {
		return $filename;
	} else {
		unlink($dir."/".$filename);
		return;
	}
}
sub get_crawled {
	my($pkg) = @_;
	my @all; my %all;
	foreach(grep $eshop{$_}->{crawl}, keys %eshop) {
		my $name = $eshop{$_}->{eshop};
		push @all,$eshop{$_} unless($all{$name});
		$all{$name}++;
	}
	return @all;
}
sub get_harvested {
	my($pkg,$ean13) = @_;

	my @order_cze = qw/Kanzelsberger/; # prioritni
	my @order_xxx = qw/Amazon/;
	my @order = ($ean13 and 0 ) ? #$pkg->is_czech($ean13)) ? 
		(@order_cze,@order_xxx) : (@order_xxx,@order_cze);
	my @all; my %all;
	foreach(grep $eshop{$_}->{harvest}, (@order,keys %eshop)) {
		my $name = $eshop{$_}->{eshop};
		push @all,$eshop{$_} unless($all{$name});
		$all{$name}++;
	}
	return @all;
}


1;
