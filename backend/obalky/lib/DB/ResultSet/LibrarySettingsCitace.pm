package DB::ResultSet::LibrarySettingsCitace;
use base 'DBIx::Class::ResultSet';

use strict;
use Data::Dumper;
use locale;

sub edit_settings {
	my($pkg,$id,$params,$library) = @_;
	my @errors;
	
	push @errors, "Neplatný identifikátor oprávnění.\n"  unless ($id =~ /^\d+$/);
	
	my $type = $params->{type};
	my $url = $params->{url};
	my $port = $params->{port};
	my $database = $params->{database};
	my $encoding = $params->{encoding};
	my $name = $params->{name};
	my $password = $params->{password};
	my $index_sysno = $params->{index_sysno};
	
	my $urltype;
	
	my $settings = DB->resultset('LibrarySettingsCitace')->find($id);
	if ($settings) {
		if (!($url && ($type eq 'marcxml' || ($port && $database && $encoding && $index_sysno)))) {
			push @errors, "Nutne vyplnit vsechny hodnoty.\n";
		} else {
			my $ip = $url =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
			my $ref = $url =~ /^http/;
			$urltype = $ref ? 'ref' : 'ip';
			
			push @errors, "Zadali jste neplatnou hodnotu url.\n" if ($urltype eq 'ip' && !$ip);
			push @errors, "Zadali jste neplatnou hodnotu url.\n" if ($urltype eq 'ref' && !$ref);
			push @errors, "Na tuto akci nemate opravneni.\n" unless ($settings->get_column('library') == $library->id);
			
			if ($type eq 'z3950') {
#				push @errors, "Port je mimo rozsah.\n" if ($port lt 0 || $port gt 65535);
				push @errors, "Spatne zvolene kodovani.\n" if ($encoding ne 'UTF-8' && $encoding ne 'CP-1250' && $encoding ne 'Marc-8');
			}
		}
	} else {
		push @errors, "Neni co editovat. Zaznam neexistuje.\n";
	}
	
	unless (@errors) {
		my $modifiedParams;
		
		if ($settings->get_column('url') ne $url) {
			$modifiedParams->{url} .= $url;
		}
		if ($settings->get_column('type') ne $type) {
			$modifiedParams->{type} .= $type;
		}
		
		if ($type eq 'z3950') {
			if ($settings->get_column('z_port') ne $port) {
				$modifiedParams->{port} .= $port;
			}
			if ($settings->get_column('z_database') ne $database) {
				$modifiedParams->{database} .= $database;
			}
			if ($settings->get_column('z_encoding') ne $encoding) {
				$modifiedParams->{encoding} .= $encoding;
			}
			if ($settings->get_column('z_name') ne $name) {
				$modifiedParams->{name} .= $name;
			}
			if ($settings->get_column('z_password') ne $password) {
				$modifiedParams->{password} .= $password;
			}
			if ($settings->get_column('z_index_sysno') ne $index_sysno) {
				$modifiedParams->{index_sysno} .= $index_sysno;
			}
		}
		
		$settings->update({
			type => $type,
			url => $url,
			z_port => $type eq 'z3950' ? $port : undef,
			z_database => $type eq 'z3950' ? $database : undef,
			z_encoding => $type eq 'z3950' ? $encoding : undef,
			z_name => $type eq 'z3950' ? $name : undef,
			z_password => $type eq 'z3950' ? $password : undef,
			z_index_sysno => $type eq 'z3950' ? $index_sysno : undef
		});	
		
		# prenes zmenenou hodnotu jako novou hodnotu na vsechny FE
		# na FE bude stara i nova hodnota az do uplneho znovunacteni prav
		DB->resultset('FeSync')->request_sync_settings_citace_modify($library, $modifiedParams);
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
	
	my $settings = DB->resultset('LibrarySettingsCitace')->find($id);
	if ($settings) {
		push @errors, "Na tuto akci nemate opravneni.\n" unless ($settings->get_column('library') == $library->id);
	} else {
		push @errors, "Neni co smazat. Zaznam neexistuje.\n";
	}
	
	unless (@errors) {
		$settings->delete;	
		DB->resultset('FeSync')->request_sync_settings_citace_remove($library);
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

sub add_settings {
	my($pkg,$params,$library) = @_;
	my @errors;
	
	my $type = $params->{type};
	my $url = $params->{url};
	my $port = $params->{port};
	my $database = $params->{database};
	my $encoding = $params->{encoding};
	my $name = $params->{name};
	my $password = $params->{password};
	my $index_sysno = $params->{index_sysno};
	my $urltype;
	
	push @errors, "Neplatny identifikator knihovny.\n" unless ($library);
	
	if (!($url && ($type eq 'marcxml' || ($port && $database && $encoding && $index_sysno)))) {
		push @errors, "Nutne vyplnit vsechny hodnoty.\n";
	} else {
		my $ip = $url =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
		my $ref = $url =~ /^http/;
		$urltype = $ref ? 'ref' : 'ip';
		
		push @errors, "Zadali jste neplatnou hodnotu url.\n" if ($urltype eq 'ip' && !$ip);
		push @errors, "Zadali jste neplatnou hodnotu url.\n" if ($urltype eq 'ref' && !$ref);
		
		if ($type eq 'z3950') {
#			push @errors, "Port je mimo rozsah.\n" if ($port lt 0 || $port gt 65535);
			push @errors, "Spatne zvolene kodovani.\n" if ($encoding ne 'UTF-8' && $encoding ne 'CP-1250' && $encoding ne 'Marc-8');
		}
	}
	
	unless (@errors) {
		DB->resultset('LibrarySettingsCitace')->create({
			library => $library,
			type => $type,
			url => $url,
			z_port => $type eq 'z3950' ? $port : undef,
			z_database => $type eq 'z3950' ? $database : undef,
			z_encoding => $type eq 'z3950' ? $encoding : undef,
			z_name => $type eq 'z3950' ? $name : undef,
			z_password => $type eq 'z3950' ? $password : undef,
			z_index_sysno => $type eq 'z3950' ? $index_sysno : undef
		});
		# prenes novou hodnotu na vsechny FE
		DB->resultset('FeSync')->request_sync_settings_citace_create($library, $type, $url, $port, $database, $encoding, $name, $password, $index_sysno);
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

1;
