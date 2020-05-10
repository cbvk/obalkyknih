#!/usr/bin/perl -w

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use URI::Escape;

use Fcntl qw(:flock);
#Vylucny beh crawleru
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
	sleep 3600;
	last;
}

my $dt   = DateTime->now(time_zone=>'local');
my $date = $dt->ymd; # yyyy-mm-dd
my $time = $dt->hms; # hh:mm:ss

my $search_params;
$search_params = {
	'me.id' => 18415324
};

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
		DB->resultset('FeSync')->send_fe_request($sync_last, \@params, \@post_data);
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

DB->resultset('FeSync')->send_fe_request($sync_last, \@params, \@post_data);
