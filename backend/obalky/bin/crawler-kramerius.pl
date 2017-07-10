#!/usr/bin/perl -w

use Data::Dumper;
use DateTime::Format::MySQL;
use DateTime;
use Storable;

use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use JSON;
use Encode qw(encode_utf8);

use Fcntl qw(:flock);

use FindBin;
use lib "$FindBin::Bin/../lib";
use Eshop;
use DB;

my($mode,$force_from,$force_to) = @ARGV;
die "\nusage: DEBUG=100 $0 [continue|period 2018-10-10 2018-10-20]\n\n"
		unless($mode);
my $DEBUG = $ENV{DEBUG};

my $TMP_DIR = "/tmp/crawler"; 
system("rm -rf $TMP_DIR"); mkdir($TMP_DIR);

my $SESSION_DIR = "/opt/obalky/.crawler";
mkdir($SESSION_DIR);

my $from_default = DateTime->today()->subtract(days => 2);
my $to_default   = DateTime->today()->subtract(days => 1);
$from_default = DateTime::Format::ISO8601->parse_datetime( $from_default );
$to_default   = DateTime::Format::ISO8601->parse_datetime( $to_default );
$to_default   =~ s/00:00:00/23:59:59/g;


###############################################################################

my @eshops;
push @eshops, 5060;  # CBVK Kramerius

###############################################################################


my %found;
foreach my $eshop_id (@eshops) {
	next if($ENV{OBALKY_ESHOP} and $eshop_id ne $ENV{OBALKY_ESHOP});
	
	my $eshop = DB->resultset('Eshop')->find($eshop_id);
	warn "Crawluju ".$eshop->get_column('name')."\n" if($ENV{DEBUG});

	my $factory = "Eshop::".$eshop->get_column('name'); 
	my $name = $eshop->get_column('name'); # name je jednoznacny identifikator eshopu
	unless($factory) {
		warn "Nevim jak crawlovat $name\n";
		next;
	}
	next unless($factory->can('crawl'));
	$found{$name} = 0;
	
	my $storable = eval { retrieve("$SESSION_DIR/$name.str") } || {};
	
	if ($mode eq 'period') {
		$from = $force_from;
		$to = $force_to;
	} else {
		$from = $storable->{to};
		$from = $from_default unless($from);
		$to = $to_default;
	}
	
	# priprav tmp dir jenom pro tento eshop, at si navzajem neprepisuji jpg
	system("rm -rf $TMP_DIR-$name"); mkdir "$TMP_DIR-$name" or die;
	warn "$SESSION_DIR/$name.str";
	
	warn "Crawling $name from $from to $to\n" if($DEBUG);
	
	my @list;
	eval { @list = $factory->crawl($eshop,$from,$to,"$TMP_DIR-$name") };
	warn $factory."->crawl(): $@" if($@);
	
	my $i = 0;
	foreach(@list) {
		my($bibinfo,$media,$product_url,$covers_uncommited,$eans) = @$_;
		
		next unless (defined $bibinfo);
		warn $name." found ".$bibinfo->to_some_id."\n" if($DEBUG);
		$found{$name}++;
		
		$eshop->add_product($bibinfo,$media,$product_url,$covers_uncommited,$eans);
		
		$i++;
		warn 'add_product #'.$i if ($i % 50);
	}
	warn $name.": found ".$found{$name}."\n" if($DEBUG);
	
	system("rm -rf $TMP_DIR-$name");
	
	if ($mode ne 'period') {
		$storable->{from} = $from;
		$storable->{to} = $to;
		store $storable, "$SESSION_DIR/$name.str";
	}
	
	open(LOG,">>utf8","/opt/obalky/www/data/crawler.csv") or die;
	my($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
	my $now = sprintf("%04d-%02d-%02dT%02d:%02d",
					$year+1900,$mon+1,$mday,$hour,$min);
	print LOG "$now\t$name\t$from\t$to\t".$found{$name}."\n";
	close(LOG);
}
