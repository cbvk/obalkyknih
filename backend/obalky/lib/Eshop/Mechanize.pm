
package Eshop::Mechanize;
use base 'Eshop';
use WWW::Mechanize;

use Obalky::Media;
use Obalky::BibInfo;
use utf8;

sub harvest {
    my($self,$search,$dir) = @_;
    my($isbn,$ean,$isbn10,$isbn13) = $search->isbn_forms;
	return (undef) unless $ean; # Mechanize umi jen pres ISBN (?)
	return $self->mechanize(new WWW::Mechanize,$ean);
}

sub mechanize {
	my($self,$mech,$ean) = @_;
	my($link,$product_url) = $self->cover_link($mech,$ean);
	return (undef) unless defined $link;
	my $url = ref $link ? $link->url_abs : $link;
	my $bibinfo = Obalky::BibInfo->new_from_ean($ean); # zname jen EAN
	my $media = Obalky::Media->new_from_info({ cover_url => $url });
	return ($bibinfo,$media,$product_url);
}

1;
