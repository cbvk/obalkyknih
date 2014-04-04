#!/usr/bin/perl -w

BEGIN { $ENV{HARNESS_ACTIVE} = 1 }

use LWP::UserAgent;
use Data::Dumper;
use XML::Simple;

use FindBin;
use lib "$FindBin::Bin/../lib";
use Obalky::Tools;
use DB;

my($mode) = @ARGV;
die "\nusage: $0 [debug]\n\n" unless($mode);
my $DEBUG = 1 if($mode eq 'debug');

my $ua = new LWP::UserAgent;

# 1. Smaz vsechny book->work a vsechny #work
DB->resultset('Book')->update({work => undef });
DB->resultset('Work')->delete;

my $books = DB->resultset('Book');

my $count = 0;
# 2. Projdi vsechny books
while(my $book = $books->next) {
	next if($book->work); # v tomto behu uz aktualizovano
	my $bibinfo = $book->bibinfo;
	my $isbn = $bibinfo->isbn or next;

	sleep 1; # one-request-per-second policy
	my $res = $ua->get('http://www.librarything.com/api/thingISBN/'.$isbn);
	if($res->is_success) {
		my $xml = XMLin($res->decoded_content);
		my $isbns = $xml->{isbn} || [];
		print $count." (".$isbn.": ".join(" ",@$isbns).")\n" 
					unless($count++ % 1000);
		my @books = grep defined $_, map 
				DB->resultset('Book')->find_by_isbn($_), @$isbns;
		if(@books > 1) {
#			print $isbn.": ".join(" ",map $_->id, @books)."\n";
			DB->resultset('Work')->create_work(@books);
		}
	}
}

