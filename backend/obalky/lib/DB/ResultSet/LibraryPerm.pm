package DB::ResultSet::LibraryPerm;
use base 'DBIx::Class::ResultSet';

use strict;
use Data::Dumper;
use locale;

sub edit_permission {
	my($pkg,$id,$params,$library) = @_;
	my @errors;
	my ($permtype, $permval) = (undef, undef);
	
	push @errors, "Neplatný identifikátor oprávnění.\n"  unless ($id =~ /^\d+$/);
	
	my $perm = DB->resultset('LibraryPerm')->find($id);
	if ($perm) {
		$permtype = !$perm->get_column('ip') ? 'ref' : 'ip';
		$permval = $params->{val};
		my $permref = $permval =~ /^http/;
		my $permip = $permval =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
		push @errors, "Zadali jste neplatnou hodnotu.\n" if ($permtype eq 'ip' && !$permip);
		push @errors, "Zadali jste neplatnou hodnotu.\n" if ($permtype eq 'ref' && !$permref);
		push @errors, "Na tuto akci nemate opravneni.\n" unless ($perm->get_column('library') == $library->id);
		my $res = DB->resultset('LibraryPerm')->search({ $permtype=>$permval, id=>{'!=',$id} });
		push @errors, "Vami zadana hodnota uz existuje.\n" if ($res->count);
	} else {
		push @errors, "Neni co editovat. Zaznam neexistuje.\n";
	}
	
	unless (@errors) {
		$perm->update({ $permtype => $params->{val} });
		# prenes zmenenou hodnotu jako novou hodnotu na vsechny FE
		# na FE bude stara i nova hodnota az do uplneho znovunacteni prav
		DB->resultset('FeSync')->request_sync_perm($permtype, $permval, $library);
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

sub remove_permission {
	my($pkg,$id,$library) = @_;
	my @errors;
	
	push @errors, "Neplatný identifikátor oprávnění.\n"  unless ($id =~ /^\d+$/);
	
	my $perm = DB->resultset('LibraryPerm')->find($id);
	if ($perm) {
		push @errors, "Na tuto akci nemate opravneni.\n" unless ($perm->get_column('library') == $library->id);
	} else {
		push @errors, "Neni co smazat. Zaznam neexistuje.\n";
	}
	
	unless (@errors) {
		$perm->delete;	
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

sub add_permission {
	my($pkg,$params,$library) = @_;
	my @errors;
	my ($permtype, $permval) = (undef, undef);
	
	push @errors, "Neplatny identifikator knihovny.\n" unless ($library);
	if (!$params->{permval}) {
		push @errors, "Nutne vyplnit hodnotu.\n";
	} else {
		$permtype = $params->{permtype};
		$permval = $params->{permval};
		my $permref = $permval =~ /^http/;
		my $permip = $permval =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
		push @errors, "Neplatna URL adresa katalogu. Adresa musi zacinat http, nebo https. \n" if ($permtype eq 'ref' && !$permref);
		push @errors, "Neplatna IP adresa systemu.\n" if ($permtype eq 'ip' && !$permip);
		
		my $res = DB->resultset('LibraryPerm')->search({ $permtype => $permval });
		push @errors, "Vami zadana hodnota uz existuje.\n" if ($res->count);
	}
	
	unless (@errors) {
		DB->resultset('LibraryPerm')->create({
			library => $library,
			ref => $permtype eq 'ref' ? $permval : undef,
			ip => $permtype eq 'ip' ? $permval : undef
		});
		# prenes novou hodnotu na vsechny FE
		DB->resultset('FeSync')->request_sync_perm($permtype, $permval, $library);
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

1;
