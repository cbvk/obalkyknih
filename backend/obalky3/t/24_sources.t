
use strict;
use warnings;
use Test::More 'no_plan';
use utf8;

binmode(STDOUT,':utf8');

# Nepouziva vubec DB!

use Eshop;

my $TMP_DIR = "/tmp/.harvest";
mkdir $TMP_DIR;

my @eshops = Eshop->get_harvested();
ok(@eshops >= 3, "Dostatek zdroju (".scalar(@eshops).")");

use Data::Dumper;
foreach my $eshop (@eshops) {
	my $example = $eshop->example;
#	next unless($eshop->name eq 'SCKN');
	ok($example->ean, $eshop->name.": Definovan testovaci EAN");
	my($bibinfo,$media,$product_url) = 
			eval { $eshop->harvest($example,$TMP_DIR) };
	ok(defined $product_url, $eshop->name.": Nejake informace nalezeny");
	my($url,$tmpfile) = ($media->{cover_url}, $media->{cover_tmpfile});
	is($@, '', $eshop->name.": Probehnuti Eshop->harvest()");
	like($url||'', qr/^http.*\.(jpe?g|gif)$/i, 
					$eshop->name.": Nalezeni obalky");
	unlink $tmpfile if($tmpfile);

##	die $example->ean unless($product_url);
##	my $product = $eshop->add_product($bibinfo,$media,$product_url);
##	ok($product, "Pridani produktu");
##	# jeste zda ukazuje $book->cover na $url ?
}

