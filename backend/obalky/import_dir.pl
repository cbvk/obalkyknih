#!/usr/bin/perl -w

use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Obalky::Model::CDBI;
use Obalky::Model::CDBI::Book;
#use Obalky;

foreach(Obalky::Model::CDBI::Book->retrieve_all) {
	print $_->isbn12."\n";
}
