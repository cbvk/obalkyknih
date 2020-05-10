#!/usr/bin/perl

use Data::Dumper;
use XML::Simple;
use WWW::Mechanize;
use strict;

use lib "../lib";
use Obalky;
use Obalky::Controller::API;
use DB;

my $dir = "/opt/obalky/www/data/obalky2/";
while(<>) {
	chomp;
	my $ean = $_;
	$ean =~ s/\r//;
	my $book = DB->resultset('Book')->find_by_isbn("$_");
	unless($book and $book->cover) {
		`touch /$dir/$ean.notfound`;
		next;
	}
	my ($a,$b,$c) = $book->cover->get_file("orig");

	open (OUT,">/$dir/$ean.$c");
	binmode OUT;
	print OUT $b;
	close OUT;
}
