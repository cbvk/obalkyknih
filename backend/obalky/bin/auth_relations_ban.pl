#!/usr/bin/perl -w

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use DBI;
use Data::Dumper;

use Fcntl qw(:flock);
#Vylucny beh
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
  	sleep 3600;
	last;
}

my $db = DBI->connect(DB->dsn,DB->user,DB->pass);

foreach my $row (DB->resultset('Auth')->search()) {
	my $authId = $row->id;
	my $query = "SELECT * FROM auth_relation_ban WHERE auth_ids LIKE '%$authId%'";
	my $authBan = $db->prepare($query);
	$authBan->execute();
	while( my @row = $authBan->fetchrow_array ) {
		my ($pk,$auth_ids) = @row;
		my @ids = split(/#/, $auth_ids);
		warn Dumper(@ids);
		
		# hledame fotku
		my $fotoCnt = 0;
		my $fotoId = undef;
		my $fotoAuthId = undef;
		map {
			my $auth = DB->resultset('Auth')->find($_);
			if ($auth->cover->id) {
				if ($fotoId != $auth->cover->id) {
					$fotoAuthId = $auth->id;
					$fotoCnt++;
				}
				$fotoId = $auth->cover->id;
			}
		} @ids;
		
		# aktualizovat foto
		warn $fotoCnt;
		warn $fotoAuthId;
		if ($fotoCnt == 1) {
			map {
				my $auth = DB->resultset('Auth')->find($_);
				#$auth->update({ cover => $fotoId }) unless ($auth->cover->id);
				warn $auth->id.'  <-  '.$fotoAuthId unless ($auth->cover->id);
			} @ids;
		}
	}
}


die;

################################

my $i = 0;
foreach my $row ( DB->resultset('AuthRelation500')->search() ) {
	my ($auth_id_source, $auth_id_relation) = ($row->auth_id_source, $row->auth_id_relation);
	
	my $query = "SELECT * FROM auth_relation_ban WHERE auth_ids LIKE '%$auth_id_source%' OR auth_ids LIKE '%$auth_id_relation%'";
	my $authRel = $db->prepare($query);
	$authRel->execute();
	
	warn $authRel->rows;
	
	# zalozit
	unless ($authRel->rows) {
		my $auth1 = DB->resultset('Auth')->find($auth_id_source);
		my $auth2 = DB->resultset('Auth')->find($auth_id_relation);
		DB->resultset('AuthRelationBan')->create({ auth_ids => $auth_id_source.'#'.$auth_id_relation, auth_names => $auth1->get_column('auth_name').'#'.$auth2->get_column('auth_name') })
	}
	
	# doplnit
	else {
		my @row = $authRel->fetchrow_array;
		my ($pk,$auth_ids,$auth_names,$status) = @row;
		my $do = 0;
		
		unless ($auth_ids =~ m/$auth_id_source/) {
			my $auth = DB->resultset('Auth')->find($auth_id_source);
			$auth_ids .= '#'.$auth_id_source;
			$auth_names .= '#'.$auth->get_column('auth_name');
			$do = 1;
		}
		
		unless ($auth_ids =~ m/$auth_id_relation/) {
			my $auth = DB->resultset('Auth')->find($auth_id_relation);
			$auth_ids .= '#'.$auth_id_relation;
			$auth_names .= '#'.$auth->get_column('auth_name');
			$do = 1;
		}
		
		if ($do) {
			my $authRelBan = DB->resultset('AuthRelationBan')->find($pk);
			$authRelBan->update({ auth_ids => $auth_ids, auth_names => $auth_names });
		}
	}
	
	$i++;
}
