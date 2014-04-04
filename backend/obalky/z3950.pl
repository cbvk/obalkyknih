#!/usr/bin/perl -w

use ZOOM;

my $mzk = new ZOOM::Connection('library.vse.cz',2100,databaseName=>'SOUKAT');

my $vse = new ZOOM::Connection('aleph.mzk.cz',9991,databaseName=>'MZK01-UTF');

my $cnb = 1234567;

my $zoom = $vse;

$zoom->option(preferredRecordSyntax => "usmarc");

my $res = $zoom->search_pqf('@attr 1=12 '.$cnb);

