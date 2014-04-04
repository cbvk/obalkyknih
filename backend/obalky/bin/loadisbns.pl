#!/usr/bin/perl -w

use DateTime::Format::MySQL;
use Data::Dumper;
use DateTime;

use FindBin;
use lib "$FindBin::Bin/../lib";
use Obalky::BibInfo;
use Obalky::Tools;
use Eshop;
use DB;

# die "\nusage: $0 < isbnlist.txt\n\n";

while(<STDIN>) {
	chomp;
	my($isbn,$ean) = split(/\s/);

	my $bibinfo = Obalky::BibInfo->new_from_params({ isbn => $ean });
	my $book = DB->resultset('Book')->find_by_bibinfo_or_create($bibinfo);
	
}

