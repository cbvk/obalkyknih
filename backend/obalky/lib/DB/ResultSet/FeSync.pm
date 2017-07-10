
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
use Scalar::Util qw(reftype);
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Encode qw(encode);
use HTML::Entities;
use Obalky::Config;

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
	my($pkg,$param,$type,$instances,$forced) = @_;
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
		next unless ($param->{$_});
		my $id_param;
		my $curParam = $param->{$_};
		my $curParamRefType = reftype($curParam);
		$curParamRefType = "" unless ($curParamRefType);
		if ($curParamRefType eq 'HASH') {
			if ($curParam->{type} eq 'post') {
				$id_param = DB->resultset('FeSyncParam')->create({
					param_name => $_,
					post_data => $curParam->{value},
					flag_post_data => 1
				});
			}
		} else {
			$id_param = DB->resultset('FeSyncParam')->find_or_create({
				param_name => $_,
				param_value => $curParam
			}, { rows => 1 });
		}
		push @params, $id_param->id;
	}
	return 0 unless(@params);
	
	# some reference failed
	return 0 unless ($sync_type && @insts && @params);
	
	# create sync event
	# loop over all FE instances
	my $dt = DateTime->now(time_zone=>'local');
	foreach (@insts) {
		# FE sync header
		my $sync = DB->resultset('FeSync')->create({
			fe_instance => $_->id,
			fe_sync_type => $sync_type->id,
			retry_date => $dt->datetime()
		});
		
		# M:N vazba mezi sync hlavickou a parametrem
		map { DB->resultset('FeSync2param')->create({ id_sync => $sync->id, id_sync_param => $_ }) } @params;
		
		# pokud sync udalost vznikla napr. pri skenovani, pozadujeme aby se udalost provedla okamzite
		$pkg->do_sync($sync->id) if ($forced);
	}
	
	return 1;
}


=head2 do_sync

Returns: integer  0 = chyba, 1 = uspech

Rizeni synchronizacni udalosti. Prochazi databazi a zpousti funkci pro vykon synchronizacni udalosti.
=cut
sub do_sync {
	my($pkg,$forced) = @_;
	my $dt   = DateTime->now(time_zone=>'local');
	my $date = $dt->ymd; # yyyy-mm-dd
	my $time = $dt->hms; # hh:mm:ss
	
	my $search_params;
	$search_params = {
		flag_synced => 0,
		retry_date => { '<=', "$date $time" }
		#,'me.id' => 4408508 #debug
	} unless ($forced);
	
	$search_params = {
		id_sync => $forced
	} if ($forced);
	
	my $sync = DB->resultset('FeSync')->search($search_params, {
		join => [
			{'fe_sync2params' => 'id_sync_param'},
			'fe_sync_type', 'fe_instance'],
		'+select' => [
			'id_sync_param.param_name',
			'id_sync_param.param_value',
			'id_sync_param.flag_post_data',
			'id_sync_param.post_data',
			'fe_sync_type.sync_type_code',
			'fe_instance.ip_addr',
			'fe_instance.port'],
		'+as' => [
			'param_name', 'param_value', 'flag_post_data', 'post_data', 'sync_type_code', 'ip_addr', 'port'],
		order => 'fe_instance'
	});
	# Posli vsechny nevyrizene pozadavky
	# prochazi cele pole ziskane z DB, sezarene podle id_instance
	# DB dotaz je joinovany na urovni parametru
	# cyklus postupne prochazi vsechny radky (parametry) a zmena id_instance znamena ze je vypis parametru
	# u jedne instance hotovy a muzeme poslat jako na FE
	my @params = ();
	my @post_data = ();
	my $last_id = 0; # posledni prochazene ID FE (toto je inicializace)
	my $sync_last = undef;
	foreach ($sync->all) {
		# pokud se zjisti zmena id_sync znamena to ze parametry mame seskladane a je mozne poslat na FE
		if ($last_id != $_->id && $last_id != 0) {
			__PACKAGE__->send_fe_request($sync_last, \@params, \@post_data);
			@params = ();
			@post_data = ();
		}
		
		if ($_->get_column('flag_post_data') == 0) {
			push @params, $_->get_column('param_name').'='.uri_escape_utf8($_->get_column('param_value'));
		} else {
			my $first_char = substr($_->get_column('post_data'), 0, 1);
			my $is_json = ($first_char eq '[' || $first_char eq '{') ? 1 : 0;
			push @post_data, '"'.$_->get_column('param_name').'":'.($is_json?'':'"').$_->get_column('post_data').($is_json?'':'"');
			my $post_data = $_->get_column('post_data');
		}
		$sync_last = $_;
		$last_id = $_->id;
	}
	__PACKAGE__->send_fe_request($sync_last, \@params, \@post_data);
	
	return 1;
}


=head2 send_fe_request

Vykonava synchronizacni udalost. Posila na definovane FE parametry.
=cut
sub send_fe_request {
	my($pkg,$sync,$params,$post_data) = @_;
	return 0 unless($params && $sync);
	
	# Podle typu synchronizace rozhodne jak a kam poslat pozadavek na FE
	# budeme kontaktovat FE pomoci GET data
	my $ua = LWP::UserAgent->new;
	$ua->timeout(10);
	
	my $req;
	my $url = 'http://'.$sync->get_column('ip_addr').':'.$sync->get_column('port').'/?'.join('&', @$params);
	#warn $url; #debug

	if (!$post_data) {
		$req = HTTP::Request->new(GET => $url);
	} else {
		$req = HTTP::Request->new(POST => $url);
		my $content = encode('UTF-8', '{'.join(',', @$post_data).'}');
		$req->content($content);
	}

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


=head2 book_sync_remove

Pro zadane dilo provede vymazani na vsech frontendech podle book_id

=cut
sub book_sync_remove {
	my($pkg,$id,$fe,$forced) = @_;
	return unless($id);
	my $sync_params;
	my $checksum_differs = 1;
	
	my $book = DB->resultset('Book')->find($id);
	if ($book) {
		$sync_params->{book_id} = $book->get_column('id_parent') ? $book->get_column('id_parent') : $id;
		$sync_params->{isbn} = $book->get_column('ean13') if ($book->get_column('ean13'));
		$sync_params->{nbn} = $book->get_column('nbn') if ($book->get_column('nbn'));
		$sync_params->{oclc} = $book->get_column('oclc') if ($book->get_column('oclc'));
		my $metadata = $book->enrich;
		my $metadata_json = encode('UTF-8', to_json($metadata));
		my $metadata_checksum = md5_hex($metadata_json);
		$checksum_differs = 0 if ($metadata_checksum eq $book->get_column('metadata_checksum'));
		if ($checksum_differs) {
			my $dt = DateTime->now(time_zone=>'local');
			$book->update({ metadata_checksum => $metadata_checksum, metadata_change => $dt->datetime });
		}
		$sync_params->{metadata} = {
			'value' => $metadata_json,
			'type' => 'post'
		} if (defined $metadata);
	} else {
		$sync_params->{book_id} = $id;
	}
	if ($sync_params and $checksum_differs) {
		$sync_params->{remove} = 'true';
		DB->resultset('FeSync')->set_sync($sync_params, 'metadata_changed', $fe, $forced);
	}
}

sub auth_sync_remove {
	my($pkg,$id,$fe,$forced) = @_;
	return unless($id);
	my $sync_params;
	my $checksum_differs = 1;
	
	$sync_params->{book_id} = $id;
	
	my $auth = DB->resultset('Auth')->find($id);
	if ($auth) {
		my $metadata = $auth->enrich;
		my $metadata_json = encode('UTF-8', to_json($metadata));
		my $metadata_checksum = md5_hex($metadata_json);
		$checksum_differs = 0 if ($metadata_checksum eq $auth->get_column('metadata_checksum'));
		if ($checksum_differs) {
			my $dt = DateTime->now(time_zone=>'local');
			$auth->update({ metadata_checksum => $metadata_checksum, metadata_change => $dt->datetime });
		}
		$sync_params->{metadata} = {
			'value' => $metadata_json,
			'type' => 'post'
		} if (defined $metadata);
	}
	if ($sync_params) {
		$sync_params->{remove_auth} = 'true';
		DB->resultset('FeSync')->set_sync($sync_params, 'metadata_changed', $fe, $forced);
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

sub request_sync_settings_citace_remove {
	my($pkg, $library) = @_;
	
	my $sync_params = 
	{
		settings_citace_remove => 'true',
		sigla => $library->get_column('code')
	};
	
	# pouze instance FE na portu 8080
	my $fe = DB->resultset('FeList')->search({ port => 8080 });
	
	DB->resultset('FeSync')->set_sync($sync_params, 'settings_citace_changed', $fe);
}

sub request_sync_settings_citace_modify {
	my($pkg, $library, $modifiedParams) = @_;
	
	$modifiedParams->{settings_citace_modify} .= 'true';
	$modifiedParams->{sigla} .= $library->get_column('code');
	
	# pouze instance FE na portu 8080
	my $fe = DB->resultset('FeList')->search({ port => 8080 });
	
	DB->resultset('FeSync')->set_sync($modifiedParams, 'settings_citace_changed', $fe);
}

=head2 request_sync_settings_citace

Pridej nove nastaveni citaci na vsechny frontendy

=cut
sub request_sync_settings_citace_create {
	my($pkg, $library, $type, $url, $database, $encoding, $name, $password, $index_sysno) = @_;
	
	my $sync_params = ($type eq 'marcxml') ? 
	{
		settings_create => 'true',
		sigla => $library->get_column('code'),
		type => $type,
		url => $url,
	}
	:
	{
		settings_citace_create => 'true',
		sigla => $library->get_column('code'),
		type => $type,
		url => $url,
		database => $database,
		encoding => $encoding,
		name => $name,
		password => $password,
		index_sysno => $index_sysno
	};
	
	# pouze instance FE na portu 8080
	my $fe = DB->resultset('FeList')->search({ port => 8080 });
	
	DB->resultset('FeSync')->set_sync($sync_params, 'settings_citace_changed', $fe);
}

sub request_sync_settings_push_remove {
	my($pkg, $library, $fe) = @_;
	
	my $sync_params = 
	{
		settings_push_remove => 'true',
		sigla => $library->get_column('code')
	};
	
	DB->resultset('FeSync')->set_sync($sync_params, 'settings_push_changed', $fe);
}

sub request_sync_settings_push_modify {
	my($pkg, $library, $modifiedParams, $fe) = @_;
	
	$modifiedParams->{settings_push_modify} .= 'true';
	$modifiedParams->{sigla} .= $library->get_column('code');
	
	DB->resultset('FeSync')->set_sync($modifiedParams, 'settings_push_changed', $fe);
}

=head2 request_sync_settings_citace

Pridej nove nastaveni Push api na vsechny frontendy

=cut
sub request_sync_settings_push_create {
	my($pkg, $library, $url, $email, $fe, $full_container, $frequency, $item_count) = @_;
	
	my $sync_params = {
		settings_push_create => 'true',
		sigla => $library->get_column('code'),
		url => $url,
		email => $email,
		full_container => $full_container,
		frequency => $frequency,
		item_count => $item_count
	};
	
	DB->resultset('FeSync')->set_sync($sync_params, 'settings_push_changed', $fe);
}

=head2 request_sync_perm

Pridej nove prava pristupu na vsechny frontendy

=cut
sub request_sync_review {
	my($pkg,$book,$secure) = @_;
	
	my($r_sum,$r_count) = $book->get_rating;
	my $avg = $r_sum / $r_count;
	
	my @reviews;
	my @book_reviews = $book->get_reviews;
	map {
		my $review = $_->to_info;
		$review->{library_name} = encode_entities($review->{library_name}) if ($review->{library_name});
		$review->{html_text} = encode_entities($review->{html_text}) if ($review->{html_text});
		push @reviews, $review if($review->{created});
	} @book_reviews;

	my $sync_params = {
		reviewupdate => 'true',
		book_id => $book->get_column('id'),
		rating_count => $r_count,
		rating_sum => $r_sum,
		rating_avg100 => sprintf("%2.0f",$avg),
		rating_avg5 => ($avg % 20) ? sprintf("%1.1f",$avg/20) : int($avg/20),
		review_count => scalar @reviews,
		rating_url => Obalky::Config->url($secure).'/stars?value='.sprintf("%2.0f",$avg),
		review => { type=>'post', value=>to_json(\@reviews) },
	};
	DB->resultset('FeSync')->set_sync($sync_params, 'review_changed');
}

1;
