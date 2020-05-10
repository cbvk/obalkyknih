
use strict;
use warnings;
use Test::More 'no_plan';
use utf8;

binmode(STDOUT,':utf8');
binmode(STDERR,':utf8');

#use ok "Test::WWW::Mechanize::Catalyst" => "Obalky";
use Test::WWW::Mechanize::Catalyst;

my $ua = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Obalky');
$ua->get_ok("/signup");
#$ua->follow_link( text_regex => qr/Vytvořte si účet/i);
$ua->content_contains("Vytvoření nového účtu", "Obsah registracni stranky");

sub test_signup {
	my($ua,$key,$value) = @_;
	my $fields = {
		fullname => 'Martin Sarfy TEST', 
		email => 'martinTEST@sarfy.cz', 
		password1 => 'hesloTEST',
		password2 => 'hesloTEST',
		libcode => 'TST001',
		libname => 'Knihovna TEST',
		libopac => 'http://localhost.cz/TEST',
		libaddress => "Knihovna TEST\nTestovací 007\n123 56 TEST",
		libcity => 'TEST',
		libemailboss => 'martinTEST@sarfy.cz',
		libemailads => 'martinTEST@sarfy.cz',
		libskipmember => 'on',
	};
	$fields->{$key} = $value if($key);
	$ua->submit_form(
		form_name => 'signup',
		fields => $fields,
		button => 'signup',#Vytvořit účet',
	);
	if($key) {
		$ua->content_lacks("Uživatelský účet vytvořen",
			"Vytvoreni uctu se povedlo, i kdyz $key je '$value'");
	} else {
		$ua->content_contains("Uživatelský účet vytvořen","Vytvareni uctu");
	}
}

test_signup($ua,'fullname','bez-mezery');
test_signup($ua,'email','martin@sarfy');
test_signup($ua,'password1','jine');
#test_signup($ua,'libcode','TST01');
test_signup($ua,'libcode','');
test_signup($ua,'libname','');
test_signup($ua,'libopac','http://jmeno-bez-tecky/');

test_signup($ua,'libcity','');
test_signup($ua,'libaddress','');
test_signup($ua,'libemailboss','martin@sarfy');
test_signup($ua,'libemailboss','');
test_signup($ua,'libemailads','martin@sarfy');
test_signup($ua,'libemailads','');

test_signup($ua,undef,undef); # should pass..

$ua->form_name('submit');
$ua->click("submit");# -> Prihlasit se do systemu

$ua->submit_form(
	form_name => 'login',
	fields => {
		'email' => 'martin@sarfy.cz',
		'password' => 'heslo123',
	},
	button => 'submit',#Vytvořit účet',
);
$ua->content_contains("Přihlášený uživatel: ","Prihlaseni uzivatele");
#$ua->content_contains("Odhlásit","Prihlaseni uzivatele");


