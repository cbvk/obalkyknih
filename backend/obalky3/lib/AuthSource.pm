
package AuthSource;

use Obalky::AuthInfo;
use Obalky::Media;
use Obalky::Config;

use Data::Dumper;
use utf8;

my %auth;
sub get_auth_list { %auth }

sub get_auth {
	my($pkg,$name) = @_;
	return $eshop{$name};
}
sub get_logo_url {
	my $eshop = shift;
	return $Obalky::Config::WWW_URL."/img/logo/".$eshop->name.".gif";
}

sub register {
	my $pkg = shift @_;
	my($auth) = ($pkg =~ /^Eshop\:\:(.+)/) or die;
	$auth{$auth} = bless { auth => $auth, @_ }, $pkg;
	$auth{$auth}->{name} = $1;
	$auth{$auth}->{found} = 0;
	$auth{$auth}->{fails} = 0;
	$auth{$auth}->{fetch} = 0;
	$auth{$auth}->{display} = 1 unless(defined $auth{$auth}->{display});
}

use Eshop::Dbpedia;
use Eshop::Upload;

sub name { shift->{name} };

sub can_harvest {
	my($eshop) = @_;
	return $eshop->{harvest} ? 1 : 0;
}

sub new {
	my($pkg,$class,$temp) = @_;
	mkdir $temp."/".$class;
	return bless { class=> $class, temp => $temp }, $pkg;
}

sub fetch_image {
	my($pkg,$id,$url,$dir) = @_;
	my $suff = ($url =~ /\.gif$/) ? ".gif" : ".jpg";

   	my $filename = $id.$suff;
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
	foreach(grep $auth{$_}->{crawl}, keys %auth) {
		my $name = $auth{$_}->{name};
		push @all,$auth{$_} unless($all{$name});
		$all{$name}++;
	}
	return @all;
}
sub get_harvested {
	my($pkg) = @_;
	my @all; my %all;
	foreach(grep $auth{$_}->{harvest}, keys %auth) {
		my $name = $auth{$_}->{name};
		push @all,$auth{$_} unless($all{$name});
		$all{$name}++;
	}
	return @all;
}


1;
