#!/usr/bin/perl -w

# Crawler - stahuj vsechno, co ma nakladatel nove

use Data::Dumper;
use DateTime::Format::ISO8601;
use DateTime;
use Storable; # ??

use Fcntl qw(:flock);
#Vylucny beh crawleru
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
  	sleep 3600;
	last;
}


use FindBin;
use lib "$FindBin::Bin/../lib";

use Eshop;
use DB;

my $TMP_DIR = "/tmp/crawler"; 
system("rm -rf $TMP_DIR"); mkdir($TMP_DIR);

# drzet nekde dny, kdy jsme zdroj crawlovali a chybejici projit?
my $SESSION_DIR = "/opt/obalky/.crawler";
mkdir($SESSION_DIR);

my($mode,$force_from,$force_to) = @ARGV;
die "\nusage: DEBUG=100 $0 [today|period 2008-10-10 2008-10-20]\n\n"
		unless($mode);
my $DEBUG = $ENV{DEBUG};

my $from = DateTime->today()->subtract(days => 2);
my $to   = DateTime->today()->subtract(days => 1);

if($mode eq 'period') {
	$from = DateTime::Format::ISO8601->parse_datetime( $force_from );
	$to   = DateTime::Format::ISO8601->parse_datetime( $force_to );
}

my @eshops = Eshop->get_crawled();
my %found;

foreach my $eshop (DB->resultset('Eshop')->all) {
	# trida, ktera se o tento eshop stara..
	next if($ENV{OBALKY_ESHOP} and $eshop->id ne $ENV{OBALKY_ESHOP});
	next unless($eshop->xmlfeed_url); # test..
	warn "Crawluju ".$eshop->id." ".$eshop->name."\n" if($ENV{DEBUG});

	my $factory = "Eshop::".$eshop->name if($eshop->name); 
	unless($eshop->name) {
		$factory = "Eshop::Zbozi" if($eshop->xmlfeed_url);
	}

	my $name = $eshop->name || $eshop->id; # nase jednoznacne id eshopu
	unless($factory) {
		warn "Nevim jak crawlovat $name (".$eshop->fullname.")\n";
		next;
	}
	next unless($factory->can('crawl'));

	$found{$name} = 0;

	warn "Crawling $name from $from to $to\n" if($DEBUG);

	my $storable = eval { retrieve("$SESSION_DIR/$name.str") } || {};
#	$storable = {} if($DEBUG); # pri debugu vzdy nanovo..

	my @list;

	# priprav tmp dir jenom pro tento eshop, at si navzajem neprepisuji jpg
	system("rm -rf $TMP_DIR-$name"); mkdir "$TMP_DIR-$name" or die;

	eval { @list = $factory->crawl($storable,$from,$to,"$TMP_DIR-$name",
		   $eshop->xmlfeed_url) };
	warn $factory."->crawl(): $@" if($@);
	warn "Got list of ".scalar(@list)." products\n" if($DEBUG);

	store $storable, "$SESSION_DIR/$name.str" if(keys %$storable);

	foreach(@list) {
		my($bibinfo,$media,$product_url) = @$_;
		warn $name." found ".$bibinfo->to_some_id."\n" if($DEBUG);
		$found{$name}++;

		$eshop->add_product($bibinfo,$media,$product_url);
	}
	warn $name.": found ".$found{$name}."\n" if($DEBUG);#if($found{name});

	system("rm -rf $TMP_DIR-$name");

	open(LOG,">>utf8","/opt/obalky/www/data/crawler.csv") or die;
	my($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
	my $now = sprintf("%04d-%02d-%02dT%02d:%02d",
					$year+1900,$mon+1,$mday,$hour,$min);
	print LOG "$now\t$name\t$from\t$to\t".$found{$name}."\n";
	close(LOG);
}

