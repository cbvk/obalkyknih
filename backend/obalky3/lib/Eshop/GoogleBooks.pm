
package Eshop::GoogleBooks;
use base 'Eshop';
use utf8;

use LWP::UserAgent;
use Data::Dumper;
use JSON;

use Obalky::BibInfo;
use Obalky::Media;
use Obalky::Tools;

# ODSTAVENY
# NENI MOZNE HARVESTOVAT PROTOZE GOOGLE V OBCHODNICH PODMINKACH NEUMOZNUJE UKLADAT OBSAH NA DISK

__PACKAGE__->register(harvest => 0,	title => 'GoogleBooks', test => '9780888643506');

my $GOOGLE_KEY = 'AIzaSyBcnG70xzI_UNQsTifxrBG-T1R9xAj0XWU';

sub harvest {
	my($self,$search,$dir) = @_;
    my($isbn,$ean,$isbn10,$isbn13) = $search->isbn_forms;
    
    # nacti aktualni knihu; bude pouzita pro rozhodovani, jestli nahrat komentar, obalku, ...
	my $origBook;
	my $resOrigBook = DB->resultset('Book')->search({ ean13 => $search->{ean13} });
	$origBook = $resOrigBook->next if ($resOrigBook);
	
	# neposilej dotaz na GOOGLE BOOKS API pokud existuje obalka
	return () if ($origBook->get_column('cover'));
    
    # dotaz na GOOGLE BOOKS API
    my $ua = LWP::UserAgent->new;
	$ua->timeout(10);
	
	my $request;
	$request = HTTP::Request->new(GET => 'https://www.googleapis.com/books/v1/volumes?q=isbn:'.$isbn13.'&key='.$GOOGLE_KEY);
	$request->header('content-type' => 'application/json');
	my $response = $ua->request($request);

	# potrebujeme return code 200
	return () unless($response and $response->is_success());
	
	my $gBookRes = decode_json $response->content;

	# potrebujeme presne 1 odpoved, tehdy mame nejvyssi pravdepodobnost, ze jsme nasli
	return () if ($gBookRes->{totalItems} != 1);
	my $gBookItem = $gBookRes->{items}->[0]->{volumeInfo};

	# autor
	my $authors;
	my $i=0;
	my @authors = ();
	while (defined $gBookItem->{authors}->[$i]) {
		push @authors, $gBookItem->{authors}->[$i];
		$i++;
	}
	$authors = join('; ', @authors);
	
	# titul a podtitul
	my $title;
	$title = $gBookItem->{title};
	$title .= ': '.$gBookItem->{subtitle} if (defined $gBookItem->{subtitle});
	
	# rok vydani
	my $publishedDate;
	$publishedDate = substr($gBookItem->{publishedDate}, 0, 4) if (defined $gBookItem->{publishedDate});

	# vytvor bibinfo
    my $bibinfo = Obalky::BibInfo->new_from_params({ isbn => $isbn13, title => $title, authors => $authors, year => $publishedDate });

	# obalka
	my $media_info;
	$media_info->{cover_url} = $gBookItem->{imageLinks}->{thumbnail};
	
	unless ($origBook->get_column('review')) {
		# komentar
		if(exists $gBookItem->{description}) {
			$media_info->{review_html} = $gBookItem->{description};
			$media_info->{review_impact} = $Obalky::Media::REVIEW_ANNOTATION;
		}
	
		# hodnoceni
		my $rating;
		$rating = $gBookItem->{averageRating}; # 0..5
		if(defined $rating and $rating ne '') {
			my $rating_sum = int(20.0*$rating) * int($gBookItem->{ratingsCount});
			my $rating_count = int($gBookItem->{ratingsCount});
			$media_info->{review_rating} = int(20.0*$rating);
			$media_info->{review_impact} ||= $Obalky::Media::REVIEW_COMMENT;
			$media_info->{rating_count} = $rating_count;
			$media_info->{rating_sum} = $rating_sum;
			my $cached_rating_sum = 0;
			my $cached_rating_count = 0;
			$cached_rating_sum = int($origBook->get_column('cached_rating_sum')) if ($origBook->get_column('cached_rating_sum'));
			$cached_rating_count = int($origBook->get_column('cached_rating_count')) if ($origBook->get_column('cached_rating_count'));
			$origBook->update({
				cached_rating_sum => int($cached_rating_sum + $rating_sum),
				cached_rating_count => int($cached_rating_count + $rating_count)
			});
		}
	}

    my $media = Obalky::Media->new_from_info( $media_info );
	my $product_url = $gBookItem->{infoLink};
	
    return ($bibinfo,$media,$product_url);
}

1;
