
use strict;
use warnings;
use Test::More 'no_plan';
use utf8;

binmode(STDOUT,':utf8');

#use ok "Test::WWW::Mechanize::Catalyst" => "Obalky";
use Test::WWW::Mechanize::Catalyst;

my $ua = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Obalky');
$ua->get_ok("/");
$ua->submit_form(
	form_name => 'login',
	fields => {
		'email' => 'martin@sarfy.cz',
		'password' => 'heslo123',
	},
	button => 'submit',#Vytvořit účet',
);
$ua->content_contains("Přihlášený uživatel:","Prihlaseni uzivatele");

