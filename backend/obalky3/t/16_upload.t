
use strict;
use warnings;
use Test::More 'no_plan';
use utf8;

binmode(STDOUT,':utf8');

#use ok "Test::WWW::Mechanize::Catalyst" => "Obalky";
use Test::WWW::Mechanize::Catalyst;

my $ua = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Obalky');
$ua->get_ok("/upload");
$ua->submit_form(
	form_name => 'login',
	fields => {
		'email' => 'martin@sarfy.cz',
		'password' => 'heslo123',
	},
	button => 'submit',#Vytvořit účet',
);
$ua->content_contains("Vložení naskenovaných obálek","Uzivatel prihlasen");

$ua->submit_form(
	form_name => 'upload',
	fields => {
		'url' => 'http://grr.ics.muni.cz/stuff/ISBN_978-80-7203-884-8.JPEG',
		'free' => 1,
	},
	button => 'preview',#Vytvořit účet',
);
$ua->content_contains("Vkládání obálek","Vlozeni obalky do fronty");

$ua->form_name('insert');
my $id = $ua->value('id_1');

$ua->submit_form(
	form_name => 'insert',
	fields => {
		'isbn_1' => '978-80-7203-884-8',
		'id_1' => $id,
		'check_1' => 'on',
	},
	button => 'import',
);
$ua->content_contains("disponuje", "Presun z fronty do databaze");

$ua->get_ok("/api/cover?isbn=978-80-7203-884-8&return=js");

is($ua->ct,"text/javascript","API vraci javascript");
$ua->content_contains("img src", "API vraci obrazek");

#$ua->content_lacks("12000001", "API vraci realny obrazek, ne spacer");
#$ua->content_lacks("12000002", "API vraci realny obrazek, ne spacer");
#$ua->content_lacks("12000003", "API vraci realny obrazek, ne spacer");

#print "CT: ".$ua->ct."\n";
#warn "CT: ".$ua->ct."\n";

