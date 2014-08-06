#!/usr/bin/perl -w

# Odzalohovani plnych velikosti obalek z DB

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use DBI;
use Data::Dumper;

our $DIR = '/opt/toc_export';
our $SCRIPT_DIR = '/opt/obalky/bin';

use Fcntl qw(:flock);
#Vylucny beh
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Locked...";
	die;
}

open(LASTID, '<', $SCRIPT_DIR.'/toc_data_export_last_id');
@lastIdLines = <LASTID>;
close(LASTID);
my $lastId = $lastIdLines[0];

#get DB data
my $dbh = DBI->connect("DBI:mysql:database=obalky","obalky","visk2009");
warn 'Selecting ... ';
my $blob = DB->resultset('Toc')->search(
    { pdf_file => { '!=', undef },
      id => { -between => [$lastId, $lastId+1000] } },
    { rows => 3 });
warn 'Selected '.$blob->count.' rows ...';
my $dirGroupName = 0;

die 'NOTHING TO BACKUP ...' if ($blob->count == 0);

my $i = 0;
foreach ($blob->all) {
	#create main dir if not exists	
	$dirGroupName = int($_->id/10000+1)*10000;
	mkdir($DIR.'/'.$dirGroupName) unless (-d $DIR.'/'.$dirGroupName);
	
	#create PDF file
	open(OUTFILE, ">".$DIR.'/'.$dirGroupName.'/'.$_->id.'.pdf');
	print OUTFILE $_->pdf_file;
	close(OUTFILE);
	
	if (-e $DIR.'/'.$dirGroupName.'/'.$_->id.'.pdf') {
		#delete TOC
		DB->resultset('Toc')->find( $_->id )->update({ pdf_file => undef });
	}
	
	$i++;
	warn $i if ($i % 10 == 0);
	$lastId = $_->id;
}

#create last id file
open(OUTFILE, ">".$SCRIPT_DIR.'/toc_data_export_last_id');
print OUTFILE $lastId;
close(OUTFILE);

warn ' [ DONE ]      ';