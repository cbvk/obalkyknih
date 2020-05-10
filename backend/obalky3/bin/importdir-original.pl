#!/usr/bin/perl -w

use Date::Simple qw/date today/;
use Data::Dumper;
use Encode;
use ZOOM;
use URI;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Obalky::BibInfo;
use Eshop;
use DB;

my $URL = "http://www.obalkyknih.cz/original";

sub import_cover {
	my($eshop,$file,$url,$ean) = @_;

    my $bibinfo = Obalky::BibInfo->new_from_params({ ean => $ean });
	return unless($bibinfo); # spatny ean? aspon varovat!

	my $media = Obalky::Media->new_from_info({
		cover_url => $url, cover_tmpfile => $file,
	});
	my $id = $bibinfo->to_some_param;
	my $product_url = "http://www.obalkyknih.cz/view?$id"; # lol
	my $book = DB->resultset('Book')->search({ean13=>$bibinfo->ean})->first;
	return if($book);
#	my $product = $eshop->add_product($bibinfo,$media,$product_url);
#	print "$file added as ".$product->id."\n";
	print "$file $id\n";
}

my($dir) = @ARGV;
die "\nusage: $0 www/original\n\n" unless($dir);

my $eshop = DB->resultset('Eshop')->find_by_name('Legacy');

open(FIND,"find $dir -type f |") or die;
while(<FIND>) {
	chomp;
	my $file = substr($_,length($dir)+1);
	next if($file =~ /oclc/);
	my($ean) = ($file =~ /.*?([\d\-X]+)\.jpe?g$/i) or next;
	import_cover($eshop,"$dir/$file","$URL/$file",$ean);
}
close(FIND);
