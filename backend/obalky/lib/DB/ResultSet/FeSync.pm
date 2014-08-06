
package DB::ResultSet::FeSync;
use base 'DBIx::Class::ResultSet';

use strict;
use Data::Dumper;
use locale;
use Switch;
use LWP::UserAgent;
use DateTime::Format::MySQL;
use JSON;
use URI::Escape;

our $RETRY_TIMEOUT_LONG = 24; # [hodiny] pokud FE neodpovi zkusit az dalsi den (6. a dalsi pokus)
our $RETRY_TIMEOUT_SHORT = 3; # [minuty] pokud FE neodpovi zkusit az dalsich par minut (1.-5. pokus)
our $RETRY_COUNT = 15; # pocet pokusu az se synchronizace neprepne do stavu hotovo


=head1 SYNC EVENTS

=head2 set_sync

Arguments:
	$param: string  Seznam parametru { key1=>val1, key2=>val2 }
	$type: string  Kod typu synchronizace tak jak je definovan v tabulce `fe_sync_type` (vyznam typu synchronizace je definovan v tomto baliku - resultsetu)
	$inst_group: string  Kod skupiny instaci, kde se ma synchronizace provest. Prazdny znamena na vsech instacich.

Returns: integer  0 = chyba, 1 = uspech

Vytvari sync event. Vytvorenim je nachystan na spusteni.
=cut
sub set_sync {
	my($pkg,$param,$type,$instances) = @_;
	my $sync_type = undef;
	my @insts = (); # primarni klice instanci, kde se maji parametry vykonat
	my @params = (); # primarni klice parametru, ktere se maji na instancich vykonat
	
	# podle parametru $type zjisti ID tohoto typu z tabulky fe_sync_type
	my $sync_types = DB->resultset('FeSyncType')->search([{ sync_type_code => $type }]);
	switch ($sync_types->count) {
		case 1 {
			# nalezen prave jeden typ = vporadku
			$sync_type = $sync_types->next;
		}
		# chyba v definici typu
		case 0 { warn "package DB::ResultSet::FeSync - Sync type '$type' undefined"; return 0; }
		else   { warn "package DB::ResultSet::FeSync - Multiple results for sync type '$type' "; return 0; }
	}
	
	# vyber instanci front-endu
	my $res_instance = (!$instances)
		  # undef znamena synchronizovat vsechny front-endy
		? DB->resultset('FeList')->search({ flag_active => 1 })
		  # poskytnuta vlastni skupina frontend serveru
		: $instances;
	return 0 unless($res_instance->count > 0);
	push @insts, $_ foreach $res_instance->all;
	
	# pozadujeme na FE vykonat tyto parametry
	foreach (keys %$param) {
		my $id_param = DB->resultset('FeSyncParam')->find_or_create({
			param_name => $_,
			param_value => $param->{$_}
		});
		push @params, $id_param->id;
	}
	return 0 unless(@params);
	
	# some reference failed
	return 0 unless ($sync_type && @insts && @params);
	
	# create sync event
	# loop over all FE instances
	foreach (@insts) {
		# FE sync header
		my $sync = DB->resultset('FeSync')->create({
			fe_instance => $_->id,
			fe_sync_type => $sync_type->id,
		});
		
		# M:N vazba mezi sync hlavickou a parametrem
		map { DB->resultset('FeSync2param')->create({ id_sync => $sync->id, id_sync_param => $_ }) } @params;
	}
	
	return 1;
}


=head2 do_sync

Returns: integer  0 = chyba, 1 = uspech

Rizeni synchronizacni udalosti. Prochazi databazi a zpousti funkci pro vykon synchronizacni udalosti.
=cut
sub do_sync {
	my $dt   = DateTime->now(time_zone=>'local');
	my $date = $dt->ymd; # yyyy-mm-dd
	my $time = $dt->hms; # hh:mm:ss
	my $sync = DB->resultset('FeSync')->search({
		flag_synced => 0,
		retry_date => { '<=', "$date $time" }
	}, {
		join => [
			{'fe_sync2params' => 'id_sync_param'},
			'fe_sync_type', 'fe_instance'],
		'+select' => [
			'id_sync_param.param_name',
			'id_sync_param.param_value',
			'fe_sync_type.sync_type_code',
			'fe_instance.ip_addr',
			'fe_instance.port'],
		'+as' => [
			'param_name', 'param_value', 'sync_type_code', 'ip_addr', 'port'],
		order => 'fe_instance'
	});
	
	# Posli vsechny nevyrizene pozadavky
	# prochazi cele pole ziskane z DB, sezarene podle id_instance
	# DB dotaz je joinovany na urovni parametru
	# cyklus postupne prochazi vsechny radky (parametry) a zmena id_instance znamena ze je vypis parametru
	# u jedne instance hotovy a muzeme poslat jako na FE
	my @params = ();
	my $last_id = 0; # posledni prochazene ID FE (toto je inicializace)
	my $sync_last = undef;
	foreach ($sync->all) {
		# pokud se zjisti zmena id_sync znamena to ze parametry mame seskladane a je mozne poslat na FE
		if ($last_id != $_->id && $last_id != 0) {
			__PACKAGE__->send_fe_request($sync_last, @params);
			@params = ();
		}
		
		push @params, $_->get_column('param_name').'='.uri_escape($_->get_column('param_value'));
		$sync_last = $_;
		$last_id = $_->id;
	}
	__PACKAGE__->send_fe_request($sync_last, @params);
	
	return 1;
}


=head2 send_fe_request

Vykonava synchronizacni udalost. Posila na definovane FE parametry.
=cut
sub send_fe_request {
	my($pkg,$sync,@params) = @_;
	return 0 unless(@params);
	
	# sync types which sends FE requests by HTTP GET
	my @types_GET = qw/metadata_changed perm_changed review_add/;
	
	# Podle typu synchronizace rozhodne jak a kam poslat pozadavek na FE
	# budeme kontaktovat FE pomoci GET data
	my $ua = LWP::UserAgent->new;
	$ua->timeout(10);
	if (grep $_ eq $sync->get_column('sync_type_code'), @types_GET) {
		my $params = '';
		map { $params .= $_ } $_;
		my $req = HTTP::Request->new(GET => 'http://'.$sync->get_column('ip_addr').':'.$sync->get_column('port').'/?'.join('&', @params));
		warn Dumper('http://'.$sync->get_column('ip_addr').':'.$sync->get_column('port').'/?'.join('&', @params));#debug
		
		$req->header('content-type' => 'application/json');
		my $resp = $ua->request($req);
		if ($resp->is_success) {
			# synchronizace probehla, poznacit jako ukoncenou aby se uz nikdy neprovedla
			my $ret = DB->resultset('FeSync')->find($sync->id);
			$ret->update({flag_synced => 1, retry_date => undef});
		}
		else {
			# chyba pri kontaktovani FE instance, zaznacit nejblissi termin dalsiho pokusu o kontakt
			my $ret = DB->resultset('FeSync')->find($sync->id);
			my $retry_count = $sync->get_column('retry_count');
			my $dt   = DateTime->now(time_zone=>'local');
			$dt->add(minutes => $RETRY_TIMEOUT_SHORT);
			$dt->add(hours => $RETRY_TIMEOUT_LONG) if ($retry_count>5);
			my $date = $dt->ymd; # yyyy-mm-dd
			my $time = $dt->hms; # hh:mm:ss
			# zaznac dalsi pokus o synchronizaci
			# pokud prekrocen pocet RETRY_COUNT zmen stav na vyrizene
			$ret->update({ retry_date => "$date $time", retry_count => int($retry_count+1), flag_synced => ($retry_count<$RETRY_COUNT?0:1) });
		}
	}
	# nedefinovany typ
	# je nutne mit pro vsechny typy definovane v DB reprezentaci v teto funkci send_fe_request
	else {
		warn "package DB::ResultSet::FeSync - Unknown sync type '".$sync->get_column('sync_type_code')."'";
	}
}


=head2 request_sync_remove

Pro zadane dilo provede vymazani na vsech frontendech

=cut
sub request_sync_remove {
	my($pkg,$bibinfo,$fe) = @_;
	my $sync_params = $bibinfo->to_some_hash;
	if ($sync_params) {
		$sync_params->{remove} = 'true';
		DB->resultset('FeSync')->set_sync($sync_params, 'metadata_changed', $fe);
	}
}


=head2 request_sync_perm

Pridej nove prava pristupu na vsechny frontendy

=cut
sub request_sync_perm {
	my($pkg,$type,$value,$library) = @_;
	my $sync_params = {
		permcreate => 'true',
		sigla => $library->get_column('code'),
		$type => $value
	};
	DB->resultset('FeSync')->set_sync($sync_params, 'perm_changed');
}

1;
