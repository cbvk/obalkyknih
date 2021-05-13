
package Eshop::Legacy;
use base 'Eshop';
use utf8;

use Data::Dumper;
use LWP::UserAgent;

use Obalky::BibInfo;
use Obalky::Media;
use Obalky::Tools;

__PACKAGE__->register(crawl => 0, license => 'free', display => 0,
		title => 'Obálkyknih.cz');

my $LIST = "/opt/obalky/doc/legacy.txt";
my $DIR = "/opt/obalky/www/legacy";

sub crawl {
	my($self,$storable,$from,$to) = @_;	

	return (); # uz nevim co tohle cele dela.. :-(

	my $number = $1 if("$from" =~ /^2009-04-2(\d)T/);
	die "$from - nezname cislo?" unless(defined $number);
	open(LIST,"$LIST-$number") or die;
#	open(LIST,$LIST) or die;
	my @list;
	while(<LIST>) {
		my($ean12,$cpre,$c3) = (/^(\d{12})\s(\d{4})(\d{3})$/);
		next unless(defined $ean12 and defined $cpre and defined $c3);
		my $obj13 = eval { Business::ISBN->new($ean12."0"); };
		next unless $obj13;
		$obj13->fix_checksum;
		my $bibinfo = Obalky::BibInfo->new_from_ean($obj13->as_string);
		next unless($bibinfo);

		my $file = "$c3/$cpre$c3/cover.jpg";
		next unless(-f "$DIR/$file");
		my $media = Obalky::Media->new_from_info(
			{ cover_url => "http://www.obalkyknih.cz/legacy/$file",
			  cover_tmpfile => "$DIR/$file" });
		my $product_url = $Obalky::Config::LEGACY_URL."/view?".
							$bibinfo->to_some_param;
		push @list, [$bibinfo,$media,$product_url] if($bibinfo);
	}
	close(LIST);
	return @list;
}

1;
