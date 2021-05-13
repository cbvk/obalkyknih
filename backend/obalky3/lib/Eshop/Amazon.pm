
package Eshop::Amazon;
use base 'Eshop';
use utf8;

use Net::Amazon;
use Data::Dumper;

use Obalky::BibInfo;
use Obalky::Media;
use Obalky::Tools;

__PACKAGE__->register(harvest => 1, # test => '9780071544337',
	title => 'Amazon.com', test => '9780684801223');

my $AMAZON_KEY    = 'AKIAJ33VSECN6UIK7DBA';
my $AMAZON_SECRET = '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';

my $ua = Net::Amazon->new(
        token      => $AMAZON_KEY,
        secret_key => $AMAZON_SECRET );

sub harvest {
	my($self,$search,$dir) = @_;
    my($isbn,$ean,$isbn10,$isbn13) = $search->isbn_forms;
	my $response = $ua->search(isbn => $isbn13) if($isbn13);
	return () unless($response and $response->is_success());

	my $book = eval { $response->properties };
	return () unless(ref $book eq 'Net::Amazon::Property::Book');
	return () unless($book);

	my $authors = join(";",grep defined $_, $book->authors);

    my $bibinfo = Obalky::BibInfo->new_from_params({
		isbn => $isbn13, title => $book->title, authors => $authors,
		year => $book->year });

	my $media_info;
	$media_info->{cover_url} = $book->ImageUrlLarge;
	if($book->OurPrice =~ /^\$([\d\.]+)$/) {
		$media_info->{price_vat} = $1;
		$media_info->{price_cur} = "USD";
	}
	# urcite to chceme? je to anglicky a smrdi to amazonem
	if(exists $book->{ProductDescription}) {
		$media_info->{review_html} = $book->{ProductDescription};
		$media_info->{review_impact} = $Obalky::Media::REVIEW_ANNOTATION;
	}

# 'SimilarProducts' => { 'SimilarProduct' => [ 
#   { 'ASIN' => '0439358078', 'Title' => 'HP & the Order of the Phoenix' },
#   { 'ASIN' => '0545139708', 'Title' => 'HP & the Deathly Hallows' },

	my $review_set = $book->review_set;
	my $rating = $review_set->average_customer_rating; # 0..5
	if(defined $rating and $rating ne '') {
		# fix: productdescription -- anno BUT rating -- customer rating
		$media_info->{review_rating} = int(20.0*$rating);
		$media_info->{review_impact} ||= $Obalky::Media::REVIEW_COMMENT;
	}

#		$media_info->{$review_set->average_customer_rating;
#	foreach my $review ($review_set ? $review_set->reviews : ()) {
#		$media_info->{rating_count} = $review->total_votes;
#		$media_info->{rating_sum} = 
#				int($review->rating * $review->total_votes);
#	}

    my $media = Obalky::Media->new_from_info( $media_info );
	my $product_url = $book->url;#{DetailPageURL};

    return ($bibinfo,$media,$product_url);
}

1;
