
package DB::ResultSet::User;
use base 'DBIx::Class::ResultSet';

use Obalky::Tools;
use utf8;

use DB::Result::Library;

#use strict;
use Data::Dumper;
use DateTime;
use locale;

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

	open(MUTT,"|mutt -b 'martin\@sarfy.cz' ".
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

	my @errors;

	push @errors, "Není vyplněno plné jméno uživatele."
		if(not $hash->{fullname} or $hash->{fullname} !~ /\s/);

	push @errors, "... Neplatný e-mail '$login'.\n" 
		unless(Obalky::Tools->valid_email($login));

	push @errors, "Uživatel s e-mailem <a href=\"mailto:$login\">$login</a>".
			" už v systému existuje."  if($pkg->find_by_email($login));

	push @errors, "Není vyplněno heslo." unless($hash->{password1});
	push @errors, "Zadaná hesla se liší." 
		if($hash->{password1} ne $hash->{password2});

	if ($hash->{protirob} != 2) {
		push @errors, "Ochrana proti robotům - nesprávný výsledek!\n";
	}

	if ($hash->{konference}) {
	        open(MUTT,"|mutt -b 'info\@obalkyknih.cz' ".
                        "-s 'obalkyknih.cz -- novy clen konference' '$email'");
	}


	unless($hash->{eshop_name} or $hash->{libcode}) {
		push @errors, "Registrovat se můžou jen knihovny nebo nakladatelství\n";
	}

	my $eshop;
	if($hash->{eshop_name}) {
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
=cut

		push @errors, "Neplatná URL adresa webového katalogu."
			unless($hash->{libopac} =~ /^http\:\/\/.+\..+$/);

		push @errors, "Neplatná URL adresa XML feedu."
			if($hash->{xmlfeed} and not $hash->{xmlfeed} =~ /^http\:\/\/.+\..+$/);
	}

	my($user,$library);
	unless(@errors) {
		my $skipmember = ($hash->{libskipmember} and 
				lc($hash->{libskipmember}) ne 'off');
		if($libcode) {
			my $libinfo = { code => $libcode, city => $hash->{libcity},
				emailboss => $hash->{libemailboss}, 
				address => $hash->{libaddress},
				emailads => $hash->{libemailads}, skipmember => $skipmember };

			$library = DB->resultset('Library')->find_by_code($libcode);
			if($library) { # fix: create_or_update ?
				$library->update($libinfo);
			} else {
				$library = DB->resultset('Library')->create($libinfo);
			}
			push @errors, "Interní chyba: Nelze vytvořit knihovnu '$libcode'."
				unless($library);
		}

		unless(@errors) { 
			eval { $user = $pkg->create({
				login => $login, fullname => $hash->{fullname},
				password => $hash->{password1},  
				library => $library ? $library->id : undef, 
				eshop => $eshop ? $eshop->id : undef
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



1;
