
package DB::ResultSet::User;
use base 'DBIx::Class::ResultSet';

use Obalky::Tools;
use utf8;

use DB::Result::Library;
use Captcha::reCAPTCHA::V2;

#use strict;
use HTTP::Request::Common;
use LWP::UserAgent;
use Obalky::Config;
use Data::Dumper;
use DateTime;
use locale;
use JSON;

sub find_by_email {
	my($pkg,$email) = @_;
	die "Neplatný e-mail '$email'.\n" unless $email =~ /\@.+\..+/;
	my($user) = $pkg->search({ login => $email });
	return $user;
}

sub resetpassword {
	#my($pkg,$email,$password) = @_;
	my($pkg,$reset,$pass1,$pass2) = @_;
	die "Zadaná hesla se liší. Napište heslo znovu\n" if($pass1 ne $pass2);
	my $email = $pkg->reset_decode($reset);
	my $user = $pkg->find_by_email($email);
	die "Uživatel nenalezen\n" unless($user);
	$user->update({ password => $pass1 });
	# dekoduj datum a email z $reset, nastav heslo
	return 1;
}

sub reset_encode {
	my($pkg,$email) = @_;
	my $today = DateTime->today()->ymd;
	my $string = $today." ".$email;
	my $reset = join("",unpack("H*",$string)); # nic svetobornyho..
	return $reset;
}
sub reset_decode {
	my($pkg,$reset) = @_;
	my $today = DateTime->today()->ymd;
	my $string = join("",pack("H*",$reset)); #!
	my($date,$email) = split(/\s/,$string);
	die "Časová platnost kódu pro vyresetování hesla vypršela\n" 
				if($date ne $today);
	return $email;
}

sub sendpassword {
	my($pkg,$email) = @_;
	die "Uživatel s e-mailovou adresou <a href=\"mailto:$email\">$email</a>".
			" nebyl v systému nalezen.\n" unless $pkg->find_by_email($email);

	my $reset = $pkg->reset_encode($email);
	my $admin_email = $Obalky::ADMIN_EMAIL;

	open(MUTT,"|mutt -b '$admin_email' ".
			"-s 'obalkyknih.cz -- vyresetovani hesla' '$email'");
	print MUTT <<EOF;

Pro vyresetovani hesla v systemu obalkyknih.cz prosim pouzijte
nasledujici odkaz:

https://www.obalkyknih.cz/lostpassword?reset=$reset

Hezky den,
obalkyknih.cz
EOF
	close(MUTT);
	return 1;
}

sub signup {
	my($pkg,$hash) = @_; 
	my $login = $hash->{email};
	my $libcode = $hash->{libcode};
	$libcode =~ s/[ \-]//g;
	my $libpurpose = $hash->{purpose_description};
	
	my @errors;
	
	#reCaptcha verify
	my $rc = Captcha::reCAPTCHA::V2->new;
	my $rc_html = $rc->html($Obalky::Config::RECAPTCHA_SITEKEY);
	my $result = $rc->verify($Obalky::Config::RECAPTCHA_SECRET, $hash->{'g-recaptcha-response'});
	push @errors, "Potvrďte, že nejste robot."
		unless ($result->{success});

	push @errors, "Není vyplněno plné jméno uživatele."
		if(not $hash->{fullname} or $hash->{fullname} !~ /\s/);

	push @errors, "... Neplatný e-mail '$login'.\n" 
		unless(Obalky::Tools->valid_email($login));

	push @errors, "Uživatel s e-mailem <a href=\"mailto:$login\">$login</a>".
			" už v systému existuje."  if($pkg->find_by_email($login));

	push @errors, "Není vyplněno heslo." unless($hash->{password1});
	push @errors, "Zadaná hesla se liší." 
		if($hash->{password1} ne $hash->{password2});

	if ($hash->{protirob}) {
		push @errors, "Ochrana proti robotům - nesprávný výsledek!\n";
	}

	if ($hash->{konference}) {
	        open(MUTT,"|mutt -b 'info\@obalkyknih.cz' ".
                        "-s 'obalkyknih.cz -- novy clen konference' '$email'");
	}


	unless($hash->{eshop_name} or $hash->{libcode}) {
		push @errors, "Registrovat se můžou jen knihovny nebo nakladatelství\n";
	}

	if($hash->{libcode} && length($libcode)!=6) {
		push @errors, "SIGLA musí obsahovat 6 znaků bez mezer a pomlček\n";
	}

	my $eshop;
	if($hash->{eshop_name}) {
		push @errors, "Neplatná URL adresa XML feedu."
			if($hash->{xmlfeed} and not $hash->{xmlfeed} =~ /^http[s]{0,1}\:\/\/.+\..+$/);
		
		my $eshopinfo = { fullname => $hash->{eshop_name},
						  web_url => $hash->{eshop_url},
						  logo_url => $hash->{logo_url},
						  xmlfeed_url => $hash->{xmlfeed} };

		$eshop = DB->resultset('Eshop')->find(
				{ web_url => $hash->{eshop_url} });
		if($eshop) { # fix: create_or_update ?
			$eshop->update($eshopinfo);
		} else {
			$eshop = DB->resultset('Eshop')->create($eshopinfo);
		}
		push @errors, "Interní chyba: Nelze vytvořit e-shop." unless($eshop);
	}

	if($libcode) { 
		push @errors, "Není vyplněn název knihovny."
			unless($hash->{libname});
		push @errors, "Není vyplněn stručný popis použití služby Obálkyknih.cz."
			unless($hash->{libpurpose});

=begin
		push @errors, "Není vyplněno město knihovny."  unless($hash->{libcity});
		push @errors, "Není vyplněna adresa knihovny." unless($hash->{libaddress});
		if($hash->{libaddress}) {
			my @lines = split(/\n/,$hash->{libaddress});
			push @errors, "Neúplná adresa knihovny - má mít aspoň 3 řádky."
						if(scalar(@lines) < 3);
		}
		push @errors, "Není vyplňěn e-mail ředitele/vedoucího knihovny"
			unless(Obalky::Tools->valid_email($hash->{libemailboss}));
		push @errors, "Není vyplňěn e-mail pro zasílání komerčních sdělení."
			unless($hash->{libemailads});
		push @errors, "E-mail pro zasílání komerčních sdělení není korektní."
			unless(Obalky::Tools->valid_email($hash->{libemailads}));
		push @errors, "Neplatná URL adresa webového katalogu."
			unless($hash->{libopac} =~ /^http\:\/\/.+\..+$/);
=cut
	}

	my($user,$library);
	unless(@errors) {
		my $skipmember = ($hash->{libskipmember} and 
				lc($hash->{libskipmember}) ne 'off');
		my $flagadmin = 0;
		if($libcode) {
			my $libinfo = { code => $libcode, city => $hash->{libcity},
				name => $hash->{libname}, purpose_description => $hash->{libpurpose},
				emailboss => $hash->{libemailboss}, address => $hash->{libaddress},
				emailads => $hash->{libemailads}, skipmember => $skipmember };

			$library = DB->resultset('Library')->find_by_code($libcode);
			if($library) { # fix: create_or_update ?
				$library->update($libinfo);
			} else {
				$library = DB->resultset('Library')->create($libinfo);
				$flagadmin = 1;
			}
			push @errors, "Interní chyba: Nelze vytvořit knihovnu '$libcode'."
				unless($library);
		}

		unless(@errors) {
			eval { $user = $pkg->create({
				login => $login, fullname => $hash->{fullname},
				password => $hash->{password1},
				library => $library ? $library->id : undef,
				eshop => $eshop ? $eshop->id : undef,
				flag_library_admin => $flagadmin
			}) };

			push @errors, $@ if $@;
			push @errors, "Interní chyba: Nelze vytvořit uživatele '$login'."
					unless($user);

			if($user) {
				my $test = $pkg->find($user->id);
				push @errors, "Nevytvořena knihovna."
						if($library and not $test->library);
				push @errors, "Nevytvořena společnost."
						if($eshop and not $test->eshop);
				
				# Info email knihovni a info email spravci
				if ($library and $test->library and $flagadmin) {
					my $admin_email = $Obalky::ADMIN_EMAIL;
					open(MUTT,"|mutt -b '$admin_email' -s 'obalkyknih.cz -- registrace knihovny' '$login'");
					print MUTT <<EOF;

Vas uzivatelsky ucet pro knihovny byl vytvoren.

Vyckejte prosim na schvaleni registrace spravcem systemu Obalky knih.cz.
Po schvaleni budete schopni pridat prava pro Vas knihovni katalog, ve kterem planujete sluzby projektu Obalky knih.cz vyuzivat.

Hezky den,
obalkyknih.cz
EOF
					close(MUTT);
					
					open(MUTT,"|mutt -b '$admin_email' -s 'obalkyknih.cz -- registrace knihovny' '$admin_email'");
					print MUTT <<EOF;

Vytvoren novy uzivatelsky ucet knihovny.
Nutne povolit, nebo zamitnout po zalogovani jako: $admin_email
na strance https://www.obalkyknih.cz/login

Login: $login
Sigla: $libcode

Popis pouziti: $libpurpose

Hezky den,
obalkyknih.cz
EOF
					close(MUTT);
				}
			}
		}
	}

	if(@errors) {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return $user;
}


sub get_xmlfeeds {
	my($pkg) = @_;
	my @feeds;
	foreach($pkg->all) {
		push @feeds,$_->xmlfeed_url if($_->xmlfeed_url);
	}
	return \@feeds;
}


sub change_password {
	my($pkg,$userData,$emailOld,$emailNew,$emailConfirm,$flagReviewReport) = @_;
	my $err = 0;
	my $errMsg = 'Chyba !';
	
	return unless ($emailOld and $emailNew and $emailConfirm and $userData);
	my $user = DB->resultset('User')->find($userData->id);
	my $password = $user->get_column('password');
	my $library_admin = $user->get_column('flag_library_admin');
	
    if ($emailOld ne '') {
	    if ($emailNew ne $emailConfirm) {
	    	$errMsg = 'Vámi zadané nové heslo se neshoduje !';
	    	$err = 1;
	    }
	    if ($emailOld eq '' || $emailNew eq '' || $emailConfirm eq '') {
	    	$errMsg = 'Nutné vyplnit všechny položky formuláře !';
	    	$err = 1;
	    }
	    if (!$err && length($emailNew) < 6) {
	    	$errMsg = 'Minimální délka nového hesla je 6 znaků !';
	    	$err = 1;
	    }
	    if (!$err && $emailOld ne $password) {
	    	$errMsg = 'Vámi zadané původní heslo není platné !';
	    	$err = 1;
	    }
    }
    unless ($err) {
    	$user->update({ password => $emailNew }) if ($emailOld ne '');
    	return 'Vaše nastavení bylo uloženo';
    }
    
    return $errMsg;
}


1;
