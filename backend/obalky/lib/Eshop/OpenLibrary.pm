
package Eshop::OpenLibrary;
use base 'Eshop';
use utf8;

use Data::Dumper;

use Obalky::BibInfo;
use Obalky::Media;
use Obalky::Tools;

__PACKAGE__->register(harvest => 1, # test => '9780071544337',
	title => 'OpenLibrary.org', test => '9780385472579');

sub harvest {
	my($self,$search,$dir) = @_;
    my($isbn,$ean,$isbn10,$isbn13) = $search->isbn_forms;

	return undef;

#	http://openlibrary.org/api/books?bibkeys=ISBN:0201558025,LCCN:93005405&callback=processOLBooks&details=true

    my $bibinfo = Obalky::BibInfo->new_from_params({
		isbn => $isbn13, title => $book->title, authors => $authors,
		year => $book->year });

	my $media_info;
	$media_info->{cover_url} = $book->ImageUrlLarge;

    my $media = Obalky::Media->new_from_info( $media_info );
	my $product_url = $book->url;

    return ($bibinfo,$media,$product_url);
}

1;
