#!/usr/bin/perl -w

# Odzalohovani plnych velikosti obalek z DB

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use DBI;
use Data::Dumper;

use Fcntl qw(:flock);

my $DIR = '/opt/store/fileblob_optimize';
my $SCRIPT_DIR = '/opt/obalky/bin';
my $COMMAND = './zopflipng --lossy_transparent --lossy_8bit --filters=01234mepb -y ';

my ($originalSize, $optimizedSize);
#Vylucny beh
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Locked...";
	die;
}

open(FILE, '<', $SCRIPT_DIR.'/fileblob_compressor_results');
@lastIdFileContent = <FILE>;
close(FILE);
my $lastId = $lastIdFileContent[-1] || 0;
die "Connection failed" if (!connect_to_db());
warn Dumper($lastId);
#get DB data
my $blobs = DB->resultset('Fileblob')->search(
    {medium => {-not_in => ['cover-orig']}, content => { '!=', '' },
      id => { -between => [$lastId+1, $lastId+1000000000] } },
      {sort_by => 'id', rows => 300});
warn 'Selected '.$blobs->count.' rows ...';
my $dirGroupName = 0;

die 'NOTHING TO BACKUP ...' if ($blobs->count == 0);

my $i = 0;
mkdir($DIR) unless (-d $DIR);
foreach my $blob ($blobs->all) {
	warn "dir name ".$dirGroupName;
	#create image file
	my $fileName = $DIR.'/'.$blob->id;
	optimize_blob($DIR, $blob);
	$i++; next if ($i < 30);
	$lastId = $blob->id;
	last;
}
warn "Original size: $originalSize"."K\nOptimized size: ".($optimizedSize/1000)."K\nTotal reduction: ".(($originalSize - $optimizedSize)/1000)."K (reduced to " .(sprintf ("%.3f", $optimizedSize / $originalSize * 100))."%)\n";
#create last id file
open(FILE, ">".$SCRIPT_DIR.'/fileblob_compressor_results');
print FILE "Original size: $originalSize"."K\nOptimized size: $optimizedSize"."K\nTotal reduction: ".($originalSize - $optimizedSize)."K (reduced to " .(sprintf ("%.3f", $optimizedSize / $originalSize * 100))."%)\n";
print FILE $lastId;
close(FILE);

warn ' [ DONE ]      ';


sub connect_to_db{
	return DBI->connect("DBI:mysql:database=obalky","obalky","visk2009");
}

sub optimize_blob{
	my ($dir, $blob) = @_;
	my $fileName = $dir."/".$blob->id;
	open(FILE, ">".$fileName);
	print FILE $blob->content;
	close(FILE);
	$originalSize += length($blob->content);
	system ($COMMAND.$fileName." $fileName");
	my $content = '';
	open(FILE, "<".$fileName);
	while(sysread(FILE,$content,32768,length($content))) {};
	close(FILE);
	$optimizedSize += length($content);
	unlink $fileName;
	$blob->update({content => $content});

}