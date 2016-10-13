#!/usr/bin/perl -w

# Harvest - hledej vsechno, na co uzivatele dali request

use Time::HiRes qw( usleep gettimeofday tv_interval );

use DateTime::Format::MySQL;
use Data::Dumper;
use DateTime;

use Fcntl qw(:flock);
#Vylucny beh harvestu
#open(SELF,"<",$0) or die "Cannot open $0 - $!";
#while (!flock(SELF, LOCK_EX|LOCK_NB)){
#	warn "Waiting";
#  	sleep 3600;
#	last;
#}

use FindBin;
use lib "$FindBin::Bin/../lib";
use Obalky::Tools;
use AuthSource;
use DB;

my($mode) = @ARGV;
die "\nusage: $0 [debug|news|all]\n\n" unless($mode);
my $DEBUG = 1 if($mode eq 'debug');

my $TMP_DIR = "/tmp/.auth_harvest";
system("rm -rf $TMP_DIR") and die; mkdir $TMP_DIR;

my @eshops;
push @eshops, AuthSource->get_harvested();

my $last_month = DateTime->today()->subtract(days => 30);
#my $max_eshop_id = DB->resultset('Eshop')->search({ type => 'auth' })->max_id;
my $max_eshop_id = 7040;

my $rowsCount = 10000;

open(OFFSET,'</opt/obalky/bin/_auth_offset') or die('OFFSET read failed');
my $offset = <OFFSET>;
close(OFFSET);

open(OFFSET,'>utf8','/opt/obalky/bin/_auth_offset') or die('OFFSET write failed'); 
print OFFSET $offset+$rowsCount;
close(OFFSET);

my $auth_count = DB->resultset('Auth')->search({}, {
			offset => $offset,
			rows => $rowsCount
		})->count;
my $auth;

$auth_list = ($mode ne 'all')
		? DB->resultset('Auth')->search({ 
			-and => [{ cover => undef, harvest_last_time => undef },
#				-or => [
#					{ harvest_last_time => { '<', $last_month } },
#					{ harvest_max_eshop => { '<', $max_eshop_id } }
#				]
			]
		}, {
			offset => $offset,
			rows => $rowsCount
		})
		: DB->resultset('Auth')->search({}, {
			offset => $offset,
			rows => $rowsCount
		})
unless $ENV{DEBUG};

$auth_list = DB->resultset('Auth')->search({ id => 'jk01050108' }) if($ENV{DEBUG});
$auth_list = DB->resultset('Auth')->search({ id => 'hka2013765882' }) if($ENV{DEBUG} and $ENV{DEBUG} eq 2); 
my %hits; my %try; my %errors; my $hits = 0;

while(my $auth = $auth_list->next) {
#	next unless $auth->authinfo->{auth_date};
	
	my $id = $auth->id;
	warn $id;
	my $time_start = [gettimeofday];

	my $last_harvest   = $auth->harvest_last_time;
	my $last_max_eshop = $auth->harvest_max_eshop;;

	my($url,$filename);
	my $found = 0;
	foreach my $factory (@eshops) {
		my $authinfo = $auth->authinfo;
		
		my $name = $factory->name;
		my $source = DB->resultset('Eshop')->find_by_name($name);
		next unless($ENV{DEBUG} or $factory->can_harvest);
		next if(not $ENV{DEBUG} and $last_harvest and ($last_harvest > $last_month) and
				$last_max_eshop and ($last_max_eshop >= $max_eshop_id));
		
		$source->update({ try_count => $source->try_count + 1 });
		
		my $product = DB->resultset('AuthSource')->find({ eshop => $source, auth => $auth });
		
		next if(not $ENV{DEBUG} and $product and ($product->modified > $last_month));

		$| = 1;
		
		print "$id: ".$source->name."..." if($DEBUG);

		$product_authinfo = $authinfo;
		my($product_media,$product_url) = $factory->harvest($authinfo,$TMP_DIR);
		warn Dumper($product_authinfo);
		warn Dumper($product_media);
		warn Dumper($product_url);

		$try{$source->name}++;
		$errors{$source->name}++ if($@);

		next unless($product_media); # nothing found in this eshop

		$source->update({ hit_count => $source->hit_count + 1 });
		$found++; $hits{$source->name}++;
		
		die $name unless($product_url);

		$source->add_product_auth($source,$product_authinfo,$product_media,$product_url);

		unlink($TMP_DIR."/".$filename) if($filename);
		last;
	}

	# oznac zaznam jako harvestovany
	$auth->update({ harvest_last_time => DateTime->now(), 
					harvest_max_eshop => $max_eshop_id });

	my $time_elapsed = tv_interval ( $time_start, [gettimeofday]);
	sleep 1 if($time_elapsed < 1);
}

open(LOG,">>utf8","/opt/obalky/data/harvest.csv") or die;
my($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
my $now = sprintf("%04d-%02d-%02dT%02d:%02d",
                  $year+1900,$mon+1,$mday,$hour,$min);
foreach my $name (sort keys %try) {
	print LOG "$now\t$name\t".$try{$name}."\t".($hits{$name}||0).
				"\t".($errors{$name}||0)."\n";
}
close(LOG);
