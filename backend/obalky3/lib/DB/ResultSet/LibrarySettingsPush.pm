package DB::ResultSet::LibrarySettingsPush;
use base 'DBIx::Class::ResultSet';

use strict;
use Data::Dumper;
use locale;

sub edit_settings {
	my($pkg,$id,$params,$library) = @_;
	my @errors;

	push @errors, "Neplatný identifikátor oprávnění.\n"  unless ($id =~ /^\d+$/);
	
	my $url = $params->{url};
	my $email = $params->{email};
	my $full_container = $params->{full_container} eq "on" ? 1 : 0;
	my $frequency = $params->{frequency};
	my $item_count = $params->{item_count};
	
	my $urltype;
	
	my $settings = DB->resultset('LibrarySettingsPush')->find($id);
	if ($settings) {
		if (!$url) {
			push @errors, "Nutne vyplnit Url.\n";
		}
		else {
			push @errors, "Na tuto akci nemate opravneni.\n" unless ($settings->get_column('library') == $library->id);
		}
	} else {
		push @errors, "Neni co editovat. Zaznam neexistuje.\n";
	}
	
	my $modified = 0;
	
	unless (@errors) {	
		my $modifiedParams = undef;
		
		if ($settings->get_column('url') ne $url) {
			$modifiedParams->{url} .= $url;
		}
		if ($settings->get_column('email') ne $email) {
			$modifiedParams->{email} .= $email;
		}
		if ($settings->get_column('full_container') != $full_container) {
			$modifiedParams->{full_container} .= $full_container ? 'true' : 'false';
		}
		if ($settings->get_column('frequency') ne $frequency) {
			$modifiedParams->{frequency} .= $frequency;
		}
		if ($settings->get_column('item_count') ne $item_count) {
			$modifiedParams->{item_count} .= $item_count;
		}
		
		
		if ($modifiedParams) {
			$settings->update({
				url => $url,
				email => $email,
				full_container => $full_container,
				frequency => $frequency,
				item_count => $item_count
			});	
			
			# prenes zmenenou hodnotu jako novou hodnotu na vsechny FE
			# na FE bude stara i nova hodnota az do uplneho znovunacteni prav
			my $fe = DB->resultset('FeList')->search({ id => $settings->fe->id });
		DB->resultset('FeSync')->request_sync_settings_push_modify($library, $modifiedParams, $fe);
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
	
	my $settings = DB->resultset('LibrarySettingsPush')->find($id);
	if ($settings) {
		push @errors, "Na tuto akci nemate opravneni.\n" unless ($settings->get_column('library') == $library->id);
	} else {
		push @errors, "Neni co smazat. Zaznam neexistuje.\n";
	}
	
	unless (@errors) {
		$settings->delete;	
		my $fe = DB->resultset('FeList')->search({ id => $settings->fe->id });
		DB->resultset('FeSync')->request_sync_settings_push_remove($library, $fe);
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

sub add_settings {
	my($pkg,$params,$library) = @_;
	my @errors;
	
	#najde vhodny FE, aby kniznice boli rovnomerne rozlozene medzi vsetky dostupne
	my $fe_query = "SELECT felist.id
  FROM `fe_list` AS felist
       LEFT OUTER JOIN (
         SELECT fe, IFNULL(COUNT(*), 0) AS cnt FROM library_settings_push GROUP BY fe ORDER BY 2
       ) AS push ON push.fe = felist.id
 WHERE  felist.flag_active = 1
 ORDER BY push.cnt
 LIMIT 1";
 
 	my $dbh = DBI->connect(DB->dsn,DB->user,DB->pass);
 
 	my $sth = $dbh->prepare($fe_query);
	$sth->execute();
 
	my @row = $sth->fetchrow_array;
	my($fe_id) = @row;
	
	my $url = $params->{url};
	my $email = $params->{email};
	my $full_container = $params->{full_container} eq "on";
	my $frequency = $params->{frequency};
	my $item_count = $params->{item_count};
	
	my $urltype;
	
	push @errors, "Neplatny identifikator knihovny.\n" unless ($library);
	
	if (!$url) {
		push @errors, "Nutne vyplnit Url.\n";
	}
	
	unless (@errors) {
		DB->resultset('LibrarySettingsPush')->create({
			library => $library,
			url => $url,
			email => $email,
			full_container => $full_container,
			frequency => $frequency,
			item_count => $item_count,
			fe => $fe_id
		});
		# prenes novou hodnotu na vsechny FE
		my $fe = DB->resultset('FeList')->search({ id => $fe_id });
		warn Dumper($fe);
		DB->resultset('FeSync')->request_sync_settings_push_create($library, $url, $email, $fe, $full_container, $frequency, $item_count);
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

1;
