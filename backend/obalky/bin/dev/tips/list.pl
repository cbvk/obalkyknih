#!/usr/bin/perl

#086288584772:	978883823623(8)	
#086288584772:	978897196680(10)
#

my %hash;

my $old;
my $line;
while(<>) {
	my($id,$rest) = /^(\d+:)\s+(\S+)/ or next;
	$hash{$id} .= "\t$rest";
}

foreach $key (keys %hash) {
	print $key.$hash{$key}."\n";
}
