#!/usr/bin/perl -w

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use Data::Dumper;
use Business::Barcode::EAN13 qw/valid_barcode check_digit/;

use Fcntl qw(:flock);
#Vylucny beh
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
  	sleep 3600;
	last;
}

foreach my $row ( DB->resultset('Book')->search({ 'ean13' => {'!=' => undef} }) ) {
	my $ean13 = $row->get_column('ean13');
	my $suffix = substr($ean13, 0, 3);
	next if (length($ean13)!=13);
	next if ($suffix eq '978' || $suffix eq '977' || $suffix eq '858' || $suffix eq '859');
	next if (substr($ean13, 0, 2) eq '00');
	
	warn "<$ean13>";
	if (substr($ean13, -2, 1) eq check_digit('0'.substr($ean13, 0, -2)) and substr($ean13, -1) eq check_digit(substr($ean13, 0, -1))) {
		my $newEan13 = '0'.substr($ean13, 0, -2).check_digit('0'.substr($ean13, 0, -2));
		warn "$ean13 -> $newEan13\n";
		$row->update({ ean13 => $newEan13 });
	}
}
