#!/usr/bin/perl -w

use DateTime::Format::MySQL;
use Data::Dumper;
use DateTime;

use FindBin;
use lib "$FindBin::Bin/../lib";
use Obalky::Tools;
use Eshop;
use DB;

binmode(STDOUT,"utf8");

my $source = shift @ARGV;
die "\nusage: $0 Source EAN..\n\n" unless($source);

my $TMP_DIR = "/tmp/.harvest";
system("rm -rf $TMP_DIR") and die; mkdir $TMP_DIR;

DB->resultset('Eshop')->sync_eshops();
my $factory = Eshop->get_eshop($source) or die "$source: not defined\n";
my $eshop = DB->resultset('Eshop')->find_by_name($source);


foreach my $ean (@ARGV) {
	my $bibinfo = Obalky::BibInfo->new_from_params({ isbn => $ean });

	die unless($factory->can_harvest);
	die unless($factory->might_cover_bibinfo($bibinfo));

	my($product_bibinfo,$product_media,$product_url) = 
		$factory->harvest($bibinfo,$TMP_DIR);

	my $result = defined $product_url ? "Found!" : "NULL";
	print "$ean: ".$source.": $result\n";
#	print Dumper($product_media);

	$eshop->add_product($product_bibinfo,$product_media,$product_url);
}

