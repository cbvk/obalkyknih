
package DB::ResultSet::Library;
use base 'DBIx::Class::ResultSet';

use strict;
use Data::Dumper;
use locale;

sub find_by_code {
	my($pkg,$code) = @_;
	return DB->resultset('Library')->find({ code => $code });
}

sub find_none { shift->find_by_code('none') }

sub normalize_url {
	my($pkg,$url) = @_;
	$url =~ s/^https?\:\/\///; $url =~ s/^www\.//;
	return $url;
}

my %g_libraries;
my $g_lib_time;

sub do_search {
	my($pkg,$referer) = @_;
    foreach(keys %g_libraries) {
		my $url = $g_libraries{$_}->{url} or next;
		if(substr($referer,0,length($url)) eq $url) {
			return $g_libraries{$_}->{library};
		}
	}
	return undef;
}

sub find_by_referer {
	my($pkg,$referer) = @_;

	# co 10 minut nacachuj seznam knihoven
	$pkg->load_libraries() if(not $g_lib_time or (time - $g_lib_time > 600));

	return $g_libraries{'obalky'}->{library} unless($referer);
	my $library = $pkg->do_search($pkg->normalize_url($referer));
	return $library ? $library : $g_libraries{'obalky'}->{library};
}

sub load_libraries {
	my($pkg) = @_;
	#warn "DB::Library -> loading libraries (time ".time.")\n";
	foreach($pkg->all) {
		$g_libraries{$_->code} = {
			url => $pkg->normalize_url($_->webopac),
			library => $_
		}
	}
	die "'obalky' library missing" unless($g_libraries{'obalky'});
	$g_lib_time = time;
}

sub activate_library {
	my($pkg,$id) = @_;
	my @errors;
	
	push @errors, "Neplatný identifikátor knihovny.\n" 
		unless($id =~ /^\d+$/);
	
	my $ret = DB->resultset('Library')->find($id);
	push @errors, "Knihovna je aktivní.\n"
		unless ($ret->flag_active == 0);
	
	unless (@errors) {
		my $res = $ret->update({ flag_active => 1 });
		if ($res) {
			my $retUser = DB->resultset('User')->search({ library => $id })->next;
			if ($retUser) {
				my $login = $retUser->login;
				my $admin_email = $Obalky::ADMIN_EMAIL;
				open(MUTT,"|mutt -b '$admin_email' -s 'obalkyknih.cz -- aktivace Vasi knihovny' '$login'");
				print MUTT <<EOF;

Vase knihovna byla aktivovana.

Prihlaste se prosim na adrese https://www.obalkyknih.cz/login
E-MAIL: $login

a pridejte Vasi prvni adresu online katalogu, na kterem planujete zobrazovat nahledy obalek knih.

V pripade jakychkoliv dotazu nas nevahejte kontaktovat na email $admin_email

Hezky den,
obalkyknih.cz
EOF
				close(MUTT);
			}
		}
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

sub deactivate_library {
	my($pkg,$id) = @_;
	my @errors;
	
	push @errors, "Neplatný identifikátor knihovny.\n" 
		unless ($id =~ /^\d+$/);
	
	my $library = DB->resultset('Library')->find($id);
	push @errors, "Knihovna je aktivní.\n"
		unless ($library->flag_active == 0);
	
	unless (@errors) {
		my $user = DB->resultset('User')->search({ library => $id })->next;
		$user->update({ library => undef });
		$user->delete if ($user && !$user->eshop);
		$library->delete;	
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

1;
