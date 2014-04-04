#!/usr/bin/perl -w

# Harvest - hledej vsechno, na co uzivatele dali request

use Time::HiRes qw( usleep gettimeofday tv_interval );

use DateTime::Format::MySQL;
use Data::Dumper;
use DateTime;

use Fcntl qw(:flock);
#Vylucny beh harvestu
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
  	sleep 3600;
	last;
}

use FindBin;
use lib "$FindBin::Bin/../lib";
use Obalky::Tools;
use Eshop;
use DB;

my($mode) = @ARGV;
die "\nusage: $0 [debug|news|all]\n\n" unless($mode);
my $DEBUG = 1 if($mode eq 'debug');

my $TMP_DIR = "/tmp/.harvest";
system("rm -rf $TMP_DIR") and die; mkdir $TMP_DIR;

DB->resultset('Eshop')->sync_eshops();
my @eshops = Eshop->get_harvested();

my $last_month = DateTime->today()->subtract(days => 30);
my $max_eshop_id = DB->resultset('Eshop')->max_id;

my $books_count = DB->resultset('Book')->count;
my $books = ($mode ne 'all') ? 
		DB->resultset('Book')->search([ { harvest_last_time => undef },
			{ harvest_last_time => { '<', $last_month } },
			{ harvest_max_eshop => { '<', $max_eshop_id } },
		] ) : DB->resultset('Book');

$books = DB->resultset('Book')->search([ { ean13 => '978802471156'} ]) if($ENV{DEBUG});

my %hits; my %try; my %errors; my $hits = 0;

while(my $book = $books->next) {
	my $id = $book->bibinfo->to_some_id;
	my $time_start = [gettimeofday];

	my $last_harvest   = $book->harvest_last_time;
	my $last_max_eshop = $book->harvest_max_eshop;;

	my($url,$filename);
	my $found = 0;
	foreach my $factory (@eshops) {
		my $bibinfo = $book->bibinfo;
		my $name = $factory->name;
		my $eshop = DB->resultset('Eshop')->find_by_name($name);
		next unless($ENV{DEBUG} or $factory->can_harvest);
		next unless($ENV{DEBUG} or $factory->might_cover_bibinfo($bibinfo));
		next if(not $ENV{DEBUG} and $last_harvest and ($last_harvest > $last_month) and
				$last_max_eshop and ($last_max_eshop >= $max_eshop_id));

		$eshop->update({ try_count => $eshop->try_count + 1 });

		# najdi product (book v eshopu), preskoc pokud je "cerstvy"
		# neni uplne nutne, ridime se taky book.last_harvest...
		my $product = DB->resultset('Product')->find($eshop,$book,
							{ key => product_eshop_book } );
		next if(not $ENV{DEBUG} and $product and ($product->modified > $last_month));

		$| = 1;
		print "$id: ".$eshop->name."..." if($DEBUG);
		my($product_bibinfo,$product_media,$product_url) = 
					$factory->harvest($bibinfo,$TMP_DIR);
		$try{$eshop->name}++;
		$errors{$eshop->name}++ if($@);

		#my $res = defined $product_media ? Dumper($product_media) : "NULL";
		#my $result = defined $product_media ? "Found!" : "NULL";
		#print "$id: ".$eshop->name.": $result\n" if($DEBUG);
		# print defined $product_media ? "Found!\n" : "NULL\n";

		next unless(defined $product_media); # nothing found in this eshop

		$eshop->update({ hit_count => $eshop->hit_count + 1 });
		$found++; $hits{$eshop->name}++;

		die $name unless($product_url);
		$eshop->add_product($product_bibinfo,$product_media,$product_url);

		unlink($TMP_DIR."/".$filename) if($filename);
		last;
	}

	$book->update({ harvest_last_time => DateTime->now(), 
					harvest_max_eshop => $max_eshop_id });

	my $time_elapsed = tv_interval ( $time_start, [gettimeofday]);
	sleep 1 if($time_elapsed < 1);

	if($found) {} # ..
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

#my $ratios = join(" ",map $_.":".($hits{$_}||0)."/".($try{$_}||0)
#					.($fails{$_}?"/".$fails{$_}."!":""), sort keys %try);
#print DateTime->now()." ratio=".$hits."/".$books_count." [".$ratios."]\n";


