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
my $books;
if ($mode ne 'LibraryThing') {
	$books = ($mode ne 'all')
		? DB->resultset('Book')->search([ { harvest_last_time => undef },
			{ harvest_last_time => { '<', $last_month } },
			{ harvest_max_eshop => { '<', $max_eshop_id } } ])
		: DB->resultset('Book');
} else {
	my $titleOwn = 'NOT LIKE "%ě%" COLLATE utf8_bin AND title NOT LIKE "%č%" COLLATE utf8_bin AND title NOT LIKE "%š%" COLLATE utf8_bin AND title NOT LIKE "%ř%" COLLATE utf8_bin AND title NOT LIKE "%ž%" COLLATE utf8_bin AND title NOT LIKE "%ý%" COLLATE utf8_bin AND title NOT LIKE "%á%" COLLATE utf8_bin AND title NOT LIKE "%í%" COLLATE utf8_bin AND title NOT LIKE "%é%" COLLATE utf8_bin AND title NOT LIKE "%ú%" COLLATE utf8_bin AND title NOT LIKE "%ů%" COLLATE utf8_bin AND title NOT LIKE "%ó%" COLLATE utf8_bin AND title NOT LIKE "%ň%" COLLATE utf8_bin AND title NOT LIKE "%ľ%" COLLATE utf8_bin
		AND (harvest_last_time IS NULL OR harvest_last_time < "'.$last_month.'" OR harvest_max_eshop < "'.$max_eshop_id.'") AND ean13 IS NOT NULL AND ean13 NOT LIKE "977%" AND cover IS NULL';
	$books = DB->resultset('Book')->search([ { title => \$titleOwn } ])
}

$books = DB->resultset('Book')->search([ { ean13 => '9780070359185'} ]) if($ENV{DEBUG});
#$books = DB->resultset('Book')->search([ { ean13 => '9789148517717'} ]);


my %hits; my %try; my %errors; my $hits = 0; my $hitsLibraryThing = 0;

my $hitsLibraryThingMax = 2000000;
my $idLibraryThingRet = DB->resultset('Eshop')->search({ name => 'LibraryThing' })->next; # ID LibraryThing eshopu budeme potrebovat v pripade vycerpani poctu dotazu na API (nastavi se harvest_max_eshop na toto ID-1)
my $idLibraryThing = $idLibraryThingRet->get_column('id');

while(my $book = $books->next) {
	my $id = $book->bibinfo->to_some_id;
	my $time_start = [gettimeofday];

	my $last_harvest   = $book->harvest_last_time;
	my $last_max_eshop = $book->harvest_max_eshop;;

	my($url,$filename);
	my $found = 0;
	foreach my $factory (@eshops) {
		my $bibinfo = $book->bibinfo;
		
		warn Dumper($bibinfo->ean13) if ($factory->name eq 'LibraryThing');
		
		my $name = $factory->name;
		my $eshop = DB->resultset('Eshop')->find_by_name($name);
		next unless($ENV{DEBUG} or $factory->can_harvest);
		next unless($ENV{DEBUG} or $factory->might_cover_bibinfo($bibinfo));
		next if(not $ENV{DEBUG} and $last_harvest and ($last_harvest > $last_month) and
				$last_max_eshop and ($last_max_eshop >= $max_eshop_id));
		
		# zdroje s omezenim na pocet requestu
		next if ($hitsLibraryThing > $hitsLibraryThingMax);
		next if ($factory->name eq 'LibraryThing' and $mode ne 'LibraryThing'); # LibraryThing ma vlastni prepinac a nezpracuva se v modu ALL

		$eshop->update({ try_count => $eshop->try_count + 1 });

		# najdi product (book v eshopu), preskoc pokud je "cerstvy"
		# neni uplne nutne, ridime se taky book.last_harvest...
		my $product = DB->resultset('Product')->find($eshop,$book,
							{ key => product_eshop_book } );
		next if(not $ENV{DEBUG} and $product and ($product->modified > $last_month));

		$| = 1;
		print "$id: ".$eshop->name."..." if($DEBUG);

		my($product_bibinfo,$product_media,$product_url) = $factory->harvest($bibinfo,$TMP_DIR) if ($hitsLibraryThing < $hitsLibraryThingMax);
		$try{$eshop->name}++;
		$errors{$eshop->name}++ if($@);
		$hitsLibraryThing++ if ($factory->name eq 'LibraryThing' and $product_url);
warn Dumper("\n\n\n*******************".$product_url."*******************\n\n\n") if ($factory->name eq 'LibraryThing' and $product_media);

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

	if ($hitsLibraryThing < $hitsLibraryThingMax) {
		# oznac zaznam jako crawlovany
		$book->update({ harvest_last_time => DateTime->now(), 
						harvest_max_eshop => $max_eshop_id });
	} else {
		# zaznam je mozne projit opakovane, protoze byl vycerpan pocet pokusu o kontakt API
		$book->update({ harvest_max_eshop => $idLibraryThing-1 });
	}

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


