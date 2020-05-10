#!/usr/bin/perl -w

# Frontend synchronizace provede vsechny nevybavene pozadavky cekajici ve fronte

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;

use Fcntl qw(:flock);
#Vylucny beh crawleru
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
  	sleep 3600;
	last;
}

DB->resultset('FeSync')->do_sync;

