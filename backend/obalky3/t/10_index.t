
use strict;
use warnings;
use Test::More 'no_plan';
use utf8;

#use ok "Test::WWW::Mechanize::Catalyst" => "Obalky";
use Test::WWW::Mechanize::Catalyst;

my $ua = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Obalky');
$ua->get_ok("/");
$ua->title_is("Obálky knih", "Uvodni stranka");
$ua->content_contains("disponuje", "Obsah uvodni stranky");
#$ua->page_links_ok("Kontrola vsech odkazu");


#BEGIN { use_ok 'Catalyst::Test', 'Obalky' }
#BEGIN { use_ok 'Obalky::Controller::Root' }

#$ua1->get_ok("http://localhost/login?username=test01&password=mypass", 
#					"Login 'test01'");

#ok( request('/')->is_success, 'Request should succeed' );


