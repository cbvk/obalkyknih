#!/usr/bin/perl -w

# Doplneni neexistujicich nahledu ve velikosti ICON

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use DBI;
use Data::Dumper;

my $SCRIPT_DIR = '/opt/obalky/bin';
my $TMP_FILE = "/tmp/cover_tmp_orig.png";
my $RES_FILE = "/tmp/cover_tmp_resampled.png";
my $MAX_WIDTH = 54;
my $MAX_HEIGHT = 68;

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

#select covers with medium cover and without icon cover
my $dbh = DBI->connect("DBI:mysql:database=obalky","obalky","visk2009");
warn 'Selecting ... ';
my $cover = DB->resultset('Cover')->search(
    { file_medium => {'!=', 0}, file_icon => 0,
      id => { -between => [$lastId, $lastId+10000] } },
    { rows => 100 });
warn 'Selected '.$cover->count.' rows ...';
my $dirGroupName = 0;

die 'NOTHING TO BACKUP ...' if ($cover->count == 0);

my $i = 0;
foreach ($cover->all) {
	#load medium cover fileblob
	my $blob = DB->resultset('Fileblob')->find($_->get_column('file_medium'));
	
	#save medium cover file to tmp file
	open(OUTFILE, '>', $TMP_FILE);
	print OUTFILE $blob->get_column('content');
	close(OUTFILE);
	
	#resize
	my($width,$height) = Obalky::Tools->image_size($TMP_FILE);
	die 'Unable to determine original image size' unless($height);
	my($iw,$ih) = Obalky::Tools->resize($MAX_WIDTH,$MAX_HEIGHT,$width,$height);
	die 'Unable to determine nwe image size' unless($iw);
	system("convert","-resize", $iw."x".$ih, $TMP_FILE, $RES_FILE);
	return unless(-f $RES_FILE);
	
	#save resampled file into db
	my $content = '';
	open(INFILE, '<', $RES_FILE);
	while(sysread(INFILE,$content,32768,length($content))) {}
	close(INFILE);
	my $id_new_blob = DB->resultset('Fileblob')->create({
		mime => '',
		medium => 'cover-icon',
		content => $content
	});
	$_->update({ file_icon => $id_new_blob->id });
	
	unlink($TMP_FILE);
	unlink($RES_FILE);
	
	$i++;
	warn $i if ($i % 10 == 0);
	$lastId = $_->id;
}

#create last id file
open(OUTFILE, ">".$SCRIPT_DIR.'/fileblob_data_export_last_id');
print OUTFILE $lastId;
close(OUTFILE);

warn ' [ DONE ]      ';