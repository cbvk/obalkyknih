
use strict;
use warnings;
use Test::More 'no_plan';
use utf8;

use Data::Dumper;
use URI::Escape;
use XML::Simple;
use LWP::UserAgent;
use JSON;

use Obalky::BibInfo;
use DB;

my $ua = new LWP::UserAgent;

# vytvor pokusne ISBN
my @isbns = qw/9780001046429 9780099273967 9780099908401 9780224602785 
			   9780586044681 9780684801223 9782070360079 9783499226014/;

for my $isbn (@isbns) {
##	next if($isbn eq @isbns[0]); # prvni preskoc..
    my $bibinfo = Obalky::BibInfo->new_from_params({ isbn => $isbn });
    my $book = DB->resultset('Book')->find_by_bibinfo_or_create($bibinfo);
}

my $isbn = $isbns[0];

my $res = $ua->get('http://www.librarything.com/api/thingISBN/'.$isbn);
ok($res->is_success,"LibraryThing thingISBN API funguje");

my $xml = XMLin($res->decoded_content);
my $isbns = $xml->{isbn};
is(ref $isbns, "ARRAY", "thingISBN API vratil seznam ISBN");

my @books = grep defined $_, map
				DB->resultset('Book')->find_by_isbn($_), @$isbns;
is(scalar(@books),scalar(@isbns),"Vraci ocekavany seznam");

my $work = DB->resultset('Work')->create_work(@books);
my @result = $work->books;
is(scalar(@result),scalar(@books),"Vytvari grupu knih")


