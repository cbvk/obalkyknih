
use strict;
use warnings;
use Test::More 'no_plan';
use utf8;

binmode(STDOUT,':utf8');

use Net::Amazon;
use Data::Dumper;

my $AMAZON_KEY    = 'AKIAJ33VSECN6UIK7DBA';
my $AMAZON_SECRET = '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';

my $ua = Net::Amazon->new(
        token      => $AMAZON_KEY,
        secret_key => $AMAZON_SECRET );

# Get a request object
my $response = $ua->search(isbn => '0439784549');#asin => '0201360683');

ok($response->is_success(), "Nefunkcne Amazon API: ".$response->message());

my $book = $response->properties;
ok($book, "Nalezeni objektu");
ok(ref $book eq 'Net::Amazon::Property::Book', "Nalezeni knihy");

my %info = (
	numpages => $book->numpages,
	ean => $book->ean,
	year => $book->year,
	cover_url => $book->{ImageUrlLarge},
	product_url => $book->{DetailPageURL},
	publisher => $book->publisher,
	authors => join("; ",$book->authors),
	title => $book->title,
	similar => [ "todo..." ],
	reviews => [ "todo..." ],		
	annotation => $book->ProductDescription,
);

is($info{numpages}, 672, "Pocet stran dohledane knihy");
is($info{authors}, "J. K. Rowling", "Autor dohledane knihy");

my $reviews = $book->review_set;
is($reviews->average_customer_rating, "4.5", "Hodnoceni");
#warn Dumper($reviews->average_customer_rating); # 0..5
#warn Dumper(\%info,$book);

# Net::Amazon::Attribute::Review
#        "$self->average_customer_rating()"

