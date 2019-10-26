package DB::ResultSet::LibrarySettingsDoporuc;
use base 'DBIx::Class::ResultSet';

use strict;
use locale;
use utf8;
use Data::Dumper;
use Data::Validate::URI qw(is_uri);


sub edit_settings {
	my($pkg,$id,$params,$library) = @_;
	my @errors;

	push @errors, "Neplatný identifikátor oprávnění.\n"  unless ($id =~ /^\d+$/);
	
	my $url_oai_trans = $params->{url_oai_trans};
	my $is_enabled = $params->{is_enabled} eq "on" ? 1 : 0;
	
	my $settings = DB->resultset('LibrarySettingsDoporuc')->find($id);
	if ($settings) {
		if (!$url_oai_trans) {
			push @errors, "Nutné vyplnit Url.\n";
		}
		else {
			push @errors, "Na tuto akci nemáte oprávnění.\n" unless ($settings->get_column('library') == $library->id);
		}
		push @errors, "Neplatná URL adresa.\n" unless (is_uri($url_oai_trans));
	} else {
		push @errors, "Není co editovat. Záznam neexistuje.\n";
	}
	
	my $modified = 0;
	
	unless (@errors) {	
		my $modifiedParams = undef;
		
		if ($settings->get_column('url_oai_trans') ne $url_oai_trans) {
			$modifiedParams->{url_oai_trans} .= $url_oai_trans;
		}
		if ($settings->get_column('is_enabled') != $is_enabled) {
			$modifiedParams->{is_enabled} .= $is_enabled ? 'true' : 'false';
		}		
		
		if ($modifiedParams) {
			$settings->update({
				url_oai_trans => $url_oai_trans,
				is_enabled => $is_enabled
			});	
		}
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

sub remove_settings {
	my($pkg,$id,$library) = @_;
	my @errors;

	push @errors, "Neplatný identifikátor oprávnění.\n"  unless ($id =~ /^\d+$/);
	
	my $settings = DB->resultset('LibrarySettingsDoporuc')->find($id);
	if ($settings) {
		push @errors, "Na tuto akci nemáte oprávnění.\n" unless ($settings->get_column('library') == $library->id);
	} else {
		push @errors, "Není co smazat. Záznam neexistuje.\n";
	}
	
	unless (@errors) {
		$settings->delete;
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

sub add_settings {
	my($pkg,$params,$library) = @_;
	my @errors;
 
	my $url_oai_trans = $params->{url_oai_trans};
	
	push @errors, "Neplatný identifikátor knihovny.\n" unless ($library);
	
	push @errors, "Neplatná URL adresa.\n" unless (is_uri($url_oai_trans));
	
	if (!$url_oai_trans) {
		push @errors, "Nutné vyplnit Url.\n";
	}
	
	unless (@errors) {
		DB->resultset('LibrarySettingsDoporuc')->create({
			library => $library,
			url_oai_trans => $url_oai_trans,
			is_enabled => 1
		});
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

1;
