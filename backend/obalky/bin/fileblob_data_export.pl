#!/usr/bin/perl -w

# Odzalohovani plnych velikosti obalek z DB

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use DBI;
use Data::Dumper;

our $DIR = '/opt/fileblob_export';
our $SCRIPT_DIR = '/opt/obalky/bin';
our $TMP_TABLE = 'fileblob_orig_20140318h';

use Fcntl qw(:flock);
#Vylucny beh
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Locked...";
	die;
}

open(LASTID, '<', $SCRIPT_DIR.'/fileblob_data_export_last_id');
@lastIdLines = <LASTID>;
close(LASTID);
my $lastId = $lastIdLines[0];

#get DB data
my $dbh = DBI->connect("DBI:mysql:database=obalky","obalky","visk2009");
warn 'Selecting ... ';
my $blob = DB->resultset('Fileblob')->search(
    { medium => 'cover-orig', content => { '!=', '' },
      id => { -between => [$lastId, $lastId+1000000] } },
    { rows => 300 });
warn 'Selected '.$blob->count.' rows ...';
my $dirGroupName = 0;

die 'NOTHING TO BACKUP ...' if ($blob->count == 0);

my $i = 0;
foreach ($blob->all) {
	#create main dir if not exists	
	$dirGroupName = int($_->id/100000+1)*100000;
	mkdir($DIR.'/'.$dirGroupName) unless (-d $DIR.'/'.$dirGroupName);
	
	#create image file
	open(OUTFILE, ">".$DIR.'/'.$dirGroupName.'/'.$_->id);
	print OUTFILE $_->content;
	close(OUTFILE);
	
	#transfer to backup table
	#and remove from original table
	if (-e $DIR.'/'.$dirGroupName.'/'.$_->id) {
		#make backup
		my $sth = $dbh->prepare("
			INSERT IGNORE INTO $TMP_TABLE (id,medium,mime,content,cover)
			SELECT f.id,f.medium,f.mime,f.content,c.id
			  FROM fileblob AS f
			       LEFT OUTER JOIN cover AS c ON c.file_orig = f.id
			 WHERE f.id = ?
			 LIMIT 1");
		$sth->execute($_->id) or die;
		$sth->finish;
		
		#delete cover
		DB->resultset('Fileblob')->find( $_->id )->update({ content => '' });
	}
	
	$i++;
	warn $i if ($i % 10 == 0);
	$lastId = $_->id;
}

#create last id file
open(OUTFILE, ">".$SCRIPT_DIR.'/fileblob_data_export_last_id');
print OUTFILE $lastId;
close(OUTFILE);

warn ' [ DONE ]      ';