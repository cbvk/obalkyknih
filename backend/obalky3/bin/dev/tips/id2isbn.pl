#!/usr/bin/perl

my %ids= ();
my %isbns= ();

open(ID, '<id');
while(<ID>){
	chomp;
	my($isbn, $id) = /^(\S+)\s+(\S+)/;
	$ids{$id}=$isbn;
}

while(<>){
	chomp;
	my ($id1, $id2,$count) = /^(\S+)\s+(\S+)\s+(\S+)/ or next;

	my $isbn1 = $ids{$id1};
	my $isbn2 = $ids{$id2};

	$isbns->{$isbn1} 
	
}
