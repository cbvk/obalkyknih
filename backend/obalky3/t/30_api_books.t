
use strict;
use warnings;
use Test::More 'no_plan';
use utf8;

use Data::Dumper;
use URI::Escape;
use JSON;

binmode(STDOUT,':utf8');

#use ok "Test::WWW::Mechanize::Catalyst" => "Obalky";
use Test::WWW::Mechanize::Catalyst;

my $request = { 
	'callbacks' => 
		[ { 'name' => 'obalky_display_mine', 'id' => 'obalky_test' } ],
	'permalink' => 
		'http://aleph.muni.cz/F?func=find-c&ccl_term=sys=000591391',
	'bibinfo' => {
		'title' => "Schlagfertigkeit\x{a0}\x{10c}esky",
		'authors' => [ "N\x{f6}llke, Matthias,\x{a0}1962-",
						"Mich\x{148}ov\x{e1}, Iva" ],
		'year' => '2009.',
#		'isbn' => '9788024730042',
		'isbn' => '978-80-7203-884-8',
	} 
};

my $ua1 = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Obalky');
$ua1->get_ok("/api/books?books=".uri_escape_utf8(to_json([])));
$ua1->content_is("obalky.callback([]);\n","api/books neco vraci..");

my $ua2 = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Obalky');
$ua2->get_ok("/api/books?books=".uri_escape_utf8(to_json([$request])));
is($ua2->ct, 'text/javascript');

ok($ua2->content =~ /^obalky.callback\((.+)\)\;$/,"api/books vola callback");
my $json = from_json($1); # warn Dumper($json);
is(ref $json, 'ARRAY', "api/books vraci pole");
my $book1 = $json->[0];
is(ref $book1, 'HASH', "api/books vraci knihu");
ok($book1->{cover_medium_url}, "api/books vraci obalku");

# http://www.obalkyknih.cz/api/books?books=%5B%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000192901%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228072030981%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_1%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000118883%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228072030981%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_2%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000487835%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228845228681%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_3%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000360213%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228071981737%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_4%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000284202%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228071981737%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_5%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000254980%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228071982482%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_6%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000234323%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228071981737%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_7%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000205233%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228071981737%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_8%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000179245%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228071981737%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_9%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000111957%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228071982482%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_10%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000045877%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228071981737%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_11%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000188849%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228020504729%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_12%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000101823%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228020504729%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_13%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000172816%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%22%3Cbr%3E%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_14%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000047899%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228085637049%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_15%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000142718%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%22224644781X%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_16%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000100118%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%223770523237%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_17%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000032984%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228020703357%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_18%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000450809%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%228845212203%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_19%22%7D%5D%7D%2C%7B%22permalink%22%3A%22http%3A%2F%2Faleph.muni.cz%2FF%3Ffunc%3Dfind-c%26ccl_term%3Dsys%3D000598960%22%2C%22bibinfo%22%3A%7B%22isbn%22%3A%22%3Cbr%3E%22%7D%2C%22callbacks%22%3A%5B%7B%22name%22%3A%22obalky_display_thumbnail%22%2C%22id%22%3A%22obalky_callback_20%22%7D%5D%7D%5D&protocol=http://')}

