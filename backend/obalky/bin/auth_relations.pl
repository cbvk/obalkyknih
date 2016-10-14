#!/usr/bin/perl -w

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use Data::Dumper;

use Fcntl qw(:flock);
#Vylucny beh
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
  	sleep 3600;
	last;
}

foreach my $auth ( DB->resultset('Auth')->search({ 'cover' => {'!=' => undef} }) ) {
	my @authIds1 = ();
	foreach my $rel ( DB->resultset('AuthRelation500')->search({ -or => { auth_id_source => $auth->id, auth_id_relation => $auth->id } }) ) {
		@authIds1 = ();
		push @authIds1, $rel->auth_id_source;
		push @authIds1, $rel->auth_id_relation;
		
		foreach my $authRel ( DB->resultset('Auth')->search({ id => [ @authIds1 ] }) ) {
			next if ($authRel->cover);
			$authRel->update({ cover => $auth->cover->id });
			warn "$auth->id  =>  $authRel->id";
		}
	}
	
}
