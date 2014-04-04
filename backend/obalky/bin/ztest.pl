#!/usr/bin/perl -w

#use Net::Z3950;

use ZOOM;
use MARC::Record;
use MARC::Charset 'utf8_to_marc8';
   
       # prepare STDOUT for utf8
	   #     binmode(STDOUT, 'utf8');
	   #
	   #         # print out some marc8 as utf8

MARC::Charset->ignore_errors(1);
MARC::Charset->assume_encoding('UTF-8');

#binmode(STDOUT,"utf8");

my $conn = new ZOOM::Connection(
	'sigma.nkp.cz', 9909, databaseName => 'NKC');
#$conn->option(preferredRecordSyntax => "unimarc");
#$rs = $conn->search_pqf('@attr 1=4 biologie');
#$rs = $conn->search_pqf('@attr 1=7 9788072039418');

$rs = $conn->search_pqf('@attr 1=12 nkc20081824099');
print "found ", $rs->size(), " records:\n";
my $rec = $rs->record(0);
#print $rec->render();

# my($f001,$f035a,$f022a,$f020a) = ('','','','');
# foreach(split(/\n/,$rec->render())) {
# 	if(/^001\s(.*)$/) {
# 		$f001 = $1;
# 	} elsif(/020\s..\s\$a\s([^\$]+)/) {
# 		$f020a = $1;
# 	} elsif(/022\s..\s\$a\s([^\$]+)/) {
# 		$f022a = $1;
# 	#} elsif(/035\s..\s\$a\s(\(OCo?LC\))([^\$]+)/) {
# 	} elsif(/035\s..\s\$a\s([^\$]+)/) {
# 		$f035a = $2;
# 	}
# }
# 
# print "f001=$f001 f020a=$f020a f022a=$f022a f035a=$f035a\n";

my $marc = new_from_usmarc MARC::Record(utf8_to_marc8($rec->raw));
# $marc->encoding( 'UTF-8' );
print $marc->subfield('245',"a");
#print $marc->as_formatted()."\n";
#print "\n";

