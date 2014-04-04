#!/usr/bin/perl -w

use Data::Dumper;
use XML::Simple;

use FindBin;
use lib "$FindBin::Bin/../lib";
use Obalky::Tools;
use DB;

# 1. Smaz vsechny book->work a vsechny #work
DB->resultset('Book')->update({work => undef });
DB->resultset('Work')->delete;

binmode(STDOUT,"utf8");

print '<?xml version="1.0" encoding="utf-8" ?>'."\n";
print "<obalkyknih>\n";
my $tocs = DB->resultset('Toc')->search(undef,{columns => 
		[qw/id book product full_text/]});
while(my $toc = $tocs->next) {
	print $toc->to_xml;
}
print "</obalkyknih>\n";

