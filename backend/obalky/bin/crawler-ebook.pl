#!/usr/bin/perl -w

use Data::Dumper;
use DateTime::Format::MySQL;
use DateTime;
use Storable; # ??

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
die "\nusage: DEBUG=100 $0 [today|period 2008-10-10 2008-10-20]\n\n"
		unless($mode);
my $DEBUG = $ENV{DEBUG};
my $from = DateTime->today()->subtract(days => 2);
my $to   = DateTime->today()->subtract(days => 1);
if($mode eq 'period') {
	$from = DateTime::Format::ISO8601->parse_datetime( $force_from );
	$to   = DateTime::Format::ISO8601->parse_datetime( $force_to );
	$to   =~ s/00:00:00/23:59:59/g;
}

$from = '2017-06-22T10:52:53';   #debug
$to = '2017-06-30T10:53:53';     #debug

#moznost upravit existujici citace starsi nez tyden
my $crawlable =  DateTime->today()->subtract(days => 90);
my @crawler_eshops = Eshop->get_crawled();
my @eshops;

#vyselektuje crawlery vhodne na zber citaci
foreach (@crawler_eshops) {
	my @tmp_eshop = DB->resultset('Eshop')->search({ name => $_->{name}}) if ($_->{name});
	push (@eshops,$tmp_eshop[0]) if ($tmp_eshop[0] && $tmp_eshop[0]->type eq 'ebook');	
}

my %found;
foreach my $eshop (@eshops) {
	# trida, ktera se o tento eshop stara..
	next if($ENV{OBALKY_ESHOP} and $eshop->id ne $ENV{OBALKY_ESHOP});
	warn "Crawluju ".$eshop->id." ".$eshop->name."\n" if($ENV{DEBUG});

	my $factory = "Eshop::".$eshop->name if($eshop->name); 
	my $name = $eshop->name || $eshop->id; # nase jednoznacne id eshopu
	unless($factory) {
		warn "Nevim jak crawlovat $name (".$eshop->fullname.")\n";
		next;
	}
	next unless($factory->can('crawl'));
	$found{$name} = 0;
	warn "Crawling $name from $from to $to\n" if($DEBUG);

	my @list;
	my $cnt = 0;

	eval { @list = $factory->crawl($from,$to)
		    };
	warn $factory."->crawl(): $@" if($@);

	while(my ($digitalRecords,$bibinfo,$media,$product_url) = splice(@list, 0, 4)) {
		next unless ($digitalRecords and $bibinfo);
		my (@productExts, @extArray);
		foreach my $rec (@{$digitalRecords}){
			my ($ext) = $rec =~ /.*\.(.*)/;
			push (@productExts, $ext);
		}		
		my $product = DB->resultset('Product')->search({ product_url => $product_url })->next;
		# v DB uz existuje
		if ($product) {
			warn "Product exists  " if($ENV{DEBUG});
		}
		
		# zalozit zaznam produktu a knihy
		else {
			warn "New product  " if($ENV{DEBUG});
			$product = $eshop->add_product($bibinfo,$media,$product_url);
			$product->book->update({ doc_type => 3 }); # eshop
		}
		add_params_types(\@productExts);
		add_params($product, $digitalRecords, \@productExts);
		$cnt++;			
	}			
	
	warn 'ebooks: #'.$cnt if ($ENV{DEBUG});
	
	open(LOG,">>utf8","/opt/obalky/www/data/crawler.csv") or die;
	my($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
	my $now = sprintf("%04d-%02d-%02dT%02d:%02d",
					$year+1900,$mon+1,$mday,$hour,$min);
	print LOG "$now\t$name\t$from\t$to\t".$found{$name}."\n";
	close(LOG);
}		

# aktualizuje zoznam koncoviek 
sub add_params_types{
	my ($exts) = @_;
	
	foreach my $ext (@{$exts}){
		DB->resultset('ProductParamsType')->find_or_create({type => $ext, description => "Ebook ".$ext." format", flag_ebook => 1});
	}
}

sub add_params{
	my ($product, $urls, $exts) = @_;

	# nacita zoznam ProductParams pre danu book/product kombinanciu
	my @params = DB->resultset('ProductParams')->search({book => $product->book->id, product => $product->id, ean13 => $product->ean13, oclc => $product->oclc, nbn => $product->nbn});
	
	# zmaze neaktualne polozky
	foreach my $param (@params){	
		$param->delete() if (!($param->other_param_type->get_column('type') ~~ @{$exts}));
	}

	# aktualizuje polozky, ktorych URL bolo pozmenene
	# ulozi novo najdene polozky
	foreach my $i (0 .. ((@{$urls}) -1)){
		my $url = @{$urls}[$i];
		my $ext = @{$exts}[$i];
		my $param_id = DB->resultset('ProductParamsType')->find({type => $ext, flag_ebook => 1})->id;
		
		my $productParam = DB->resultset('ProductParams')->find({book => $product->book->id, product => $product->id, ean13 => $product->ean13, oclc => $product->oclc, 
			nbn => $product->nbn, other_param_type => $param_id});
			
		if ($productParam){
			if ($productParam->other_param_value ne $url){				
				$productParam->update({other_param_value => $url}) if ($productParam and ($productParam->other_param_value ne $url));
			}
		}
		else{
			DB->resultset('ProductParams')->create({book => $product->book->id, product => $product->id, ean13 => $product->ean13, oclc => $product->oclc, 
				nbn => $product->nbn, other_param_value => $url,other_param_type => $param_id});
		}		
	}
}
