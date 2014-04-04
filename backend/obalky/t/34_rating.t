
use strict;
use warnings;
use Test::More 'no_plan';
use utf8;

use LWP::UserAgent;
use Data::Dumper;
use XML::Simple;
use URI::Escape;
use JSON;

use lib '../lib';
use Obalky::BibInfo;
use DB;  

binmode(STDOUT,':utf8');

#use ok "Test::WWW::Mechanize::Catalyst" => "Obalky";
use Test::WWW::Mechanize::Catalyst;

sub create_book {
	my($isbn) = @_;
    my $bibinfo = Obalky::BibInfo->new_from_params({ isbn => $isbn });
    return DB->resultset('Book')->find_by_bibinfo_or_create($bibinfo);
}

my $isbn1 = '9788072038848'; # z testu t/16_upload.t
my $book1 = create_book($isbn1);

my $isbn2 = "9780684801223"; # z testu t/24_sources.t (Eshop::Amazon example)
my $book2 = create_book($isbn2);

sub request {
	my($sysno,$isbn,$rating) = @_;
	return {
		'callbacks' => 
			[ { 'name' => 'obalky_display_mine', 'id' => 'obalky_test' } ],
		'permalink' => 
			'http://aleph.muni.cz/F?func=find-c&ccl_term=sys='.$sysno,
		'bibinfo' => {
			'title' => "Pokus t/34_rating.t",
			'authors' => [],
			'isbn' => $isbn,
		} 
	};
}
sub send_request {
	my($sysno,$isbn,$rating) = @_;
	my $request = request($sysno,$isbn);

	my $ua = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Obalky');
	if(defined $rating) {
		$ua->get_ok("/api/add_review?rating=$rating&".
							"book=".uri_escape_utf8(to_json($request)));
	} else {
		$ua->get_ok("/api/books?books=".uri_escape_utf8(to_json([$request])));
	}
	is($ua->ct, 'text/javascript');

	ok($ua->content =~ /^obalky.callback\((.+)\)\;$/,"api/books vraci JS");
	my $json = from_json($1); # warn Dumper($json);
	is(ref $json, 'ARRAY', "api/books vraci pole");

	my $info = $json->[0];
	is(ref $info, 'HASH', "api/books vraci knihu");
	return $info;
}

my $info1a = send_request('00039292',$isbn1);
my $info2a = send_request('00039293',$isbn2);

ok($info1a->{cover_medium_url}, "api/books vraci obalku");

is($info1a->{rating_count}, 0, "ISBN1 nema hodnoceni");
is($info2a->{rating_count}, 0, "ISBN2 nema hodnoceni");

my $info1b = send_request('00039292',$isbn1, 75); # 75/100
isnt($info1b->{rating_count}, 0, "ISBN1 uz ma hodnoceni");

my $work = DB->resultset('Work')->create_work($book1,$book2);
is(scalar($work->books), 2, "Vytvoreno dilo o dvou knizkach");

my $info2b = send_request('00039293',$isbn2);
isnt($info2b->{rating_count}, 0, "ISBN2 uz ma taky hodnoceni");

my $ua = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Obalky');
my $stars = $info2b->{rating_url}; $stars =~ s/http\:\/\/.+\/stars/stars/;
$ua->get_ok($stars);
is($ua->ct, 'image/gif');

