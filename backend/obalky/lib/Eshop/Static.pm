
package Eshop::Static;
use base 'Eshop';
use utf8;

use Obalky::Media;
use Obalky::BibInfo;

sub harvest {
	my($self,$search,$dir) = @_;
	my($isbn,$ean,$isbn10,$isbn13) = $search->isbn_forms;
	return (undef) unless $ean; # Static umi jen pres ISBN
	return (undef) if($isbn13 ne '9788072038848'); # ?
	my $product_url = "http://grr.ics.muni.cz/stuff/ISBN_978-80-7203-884-8.JPEG";
	my $media = Obalky::Media->new_from_info({
		cover_url=>$product_url,
	});
    my $bibinfo = Obalky::BibInfo->new_from_ean($ean); # zname jen EAN
	return ($bibinfo,$media,$product_url);
}

__PACKAGE__->register(harvest => 1, license => 'licensed', czech => 1,
	display => 0, title => 'obalky-test', test => '9788072038848' );


1;
