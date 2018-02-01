#!/usr/bin/perl -w

use FindBin;
use lib "$FindBin::Bin/../lib";
use strict;
use warnings;
use DB;
use DBI;
use Data::Dumper;
use Storable;
use Fcntl qw(:flock);
use List::Util qw(min);

#Vylucny beh
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Locked...";
	die;
}

#Vytvorenie spojenia s DB
die "Connection failed" if (!createDBConnection());

#Nastavenie parametrov pre pracu s roznymi zdrojmi obrazkov
my @types = ('Fileblob','Toc'); #typ 'Orig' pre optimalizaciu obrazkov cover-orig 
my $typeInfo = createTypeInfo();

#my $COMMAND = './zopflipng --lossy_transparent --lossy_8bit --filters=01234mepb -y '; #! asi 5x pomalsi
my $COMMAND = './zopflipng --lossy_transparent --lossy_8bit -y ';
my $SCRIPT_DIR = '/opt/obalky/data';

my $FILEBLOB_COUNT = 600;
my $TOC_THUMBNAIL_COUNT = 400;
my $FILEBLOB_EXPORT_COUNT = 200; #pre orig. obrazky - momentalne nevyuzite

my $SESSION_DIR = "/opt/obalky/fileblob_optimize";
mkdir($SESSION_DIR) unless (-d $SESSION_DIR);

my ($originalSize, $optimizedSize);
my $lastIDs = eval { retrieve("$SESSION_DIR/lastIDs.str") } || {};

foreach my $type (@types){
	#next if ($type ne 'Fileblob'); #DEBUG;
	warn "Optimizing: " .$type if ($ENV{DEBUG});

	my $DIR = $typeInfo->{$type}->{filesrcdir};	
	my $lastID = $lastIDs->{$type} || 0;
	
	#Ziskanie dat z DB/adresara
	my @blobs = getFileblobs($type, $lastID);
	next if (!@blobs);

	#Pre obrazky ulozene na disku netreba vytvarat pomocny adresar
	mkdir($DIR) unless (-d $DIR || $type eq 'Orig');

	my $i = 1;
	foreach my $blob (@blobs) {
		my $id;
		($type eq 'Orig') ? ($id = $blob) : ($id = $blob->id);

		#Optimalizacia obrazku
		optimizeBlob($DIR, $blob, $type);

		$lastIDs->{$type} = $id + 1;
		last if ($type eq 'Orig' && $i == $FILEBLOB_EXPORT_COUNT);
		$i++;		
	}

	#Logovanie statistik, naposledy prehladavanych ID
	log_data($type);
}

#Naviazanie spojenia
sub createDBConnection{
	return DBI->connect("DBI:mysql:database=obalky","obalky","visk2009");
}

#Ziska pole zaznamov
sub getFileblobs{
	my ($type, $lastID) = @_;

	if ($type eq 'Fileblob'){
		return DB->resultset($type)->search(
			    {medium => {-not_in => ['cover-orig']}, content => { '!=', '' },
		    	id => { -between => [$lastID, $lastID+1000000000] } },
		    	{sort_by => 'id', rows => $FILEBLOB_COUNT})->all;
	}
	elsif ($type eq 'Toc'){
		return DB->resultset($type)->search(
			    {pdf_thumbnail => { '!=', undef },
		    	id => { -between => [$lastID, $lastID+1000000000] } },
		    	{sort_by => 'id', rows => $TOC_THUMBNAIL_COUNT})->all;		
	}	
	#Ak zoznam obrazkov tahame z adresara, nie z DB
	elsif ($type eq 'Orig'){
		my ($lastDir, $baseDir, $blobDir, @blobDirContents);
		
		#Naposledy spracovany adresar
		$lastDir = $lastIDs->{lastDir} || 0;
		
		#Ziskanie nazvu adresaru, ktory sa bude spracovavat
		$baseDir = $typeInfo->{$type}->{filesrcdir};
		
		opendir DIR, $baseDir or return undef;
		$blobDir = min (grep {$_ ne '.' && $_ ne '..' && $_ > $lastDir} readdir DIR);
		closedir DIR;
		return if (!$blobDir);
		$typeInfo->{$type}->{'fileblobdir'} = $baseDir.'/'.$blobDir;

		#Ziskanie obrazkov v adresari
		opendir BLOBDIR, $typeInfo->{$type}->{fileblobdir} or return undef;
		@blobDirContents = grep {$_ ne '.' && $_ ne '..' && $_ > $lastID} readdir BLOBDIR;
		closedir BLOBDIR;
		@blobDirContents = sort {$a <=> $b} @blobDirContents;

		#Nastavenie adresaru ako spracovaneho
		$lastIDs->{'lastDir'} = $blobDir if ((scalar (@blobDirContents)) <= $FILEBLOB_EXPORT_COUNT);
		warn "Actual dir : ".$blobDir."\nFiles: ".scalar (@blobDirContents)."\nLast ID: $lastID\nNext searched directory: ". $lastIDs->{'lastDir'} if  ($ENV{DEBUG});
		
		return @blobDirContents;
	}
}

sub optimizeBlob{
	my ($dir, $blob, $type) = @_;
	my ($fileName, $fileSize, $tableColumn);
	
	if ($type eq 'Orig'){
		$fileName = $typeInfo->{$type}->{fileblobdir}.'/'.$blob;
		$fileSize = -s $fileName;
	}
	else {
		$tableColumn = $typeInfo->{$type}->{attr};
		$fileName = $dir."/".$blob->id;;
		open(FILE, ">".$fileName);
		print FILE $blob->$tableColumn;
		close(FILE);
		$fileSize = length($blob->$tableColumn);
	}
	
	my $errCode = (system ($COMMAND.$fileName." $fileName") >> 8);
	if ($errCode != 0){
		warn "Error ".$errCode if ($ENV{DEBUG});
		return;
	}
	
	$originalSize->{$type} += $fileSize;
	my $content = '';
	open(FILE, "<".$fileName);
	while(sysread(FILE,$content,32768,length($content))) {};
	close(FILE);
	$optimizedSize->{$type} += length($content);
	if ($type eq 'Orig'){
		DB->resultset('Fileblob')->update_or_create({medium => 'cover-orig', id => $blob, content => $content});
	}
	else{
		unlink $fileName; #zmaze obrazok ulozeny na disku
		$blob->update({$tableColumn => $content});		
	}
}

sub createTypeInfo{
	my %typeInfo;
	
	$typeInfo{'Fileblob'}{db} = 'Fileblob';
	$typeInfo{'Orig'}{db} = 'Fileblob';
	$typeInfo{'Toc'}{db} = 'Toc';
	$typeInfo{'Fileblob'}{attr} = 'content';
	$typeInfo{'Toc'}{attr} = 'pdf_thumbnail';
	$typeInfo{'Fileblob'}{filesrcdir} = '/opt/store/fileblob_optimize';
	$typeInfo{'Toc'}{filesrcdir} = '/opt/store/fileblob_optimize';
	$typeInfo{'Orig'}{filesrcdir} = '/opt/store/fileblob_export';

	return \%typeInfo;
}

sub log_data{
	my ($type) = @_;
	
	my $logOrigSize = (($originalSize->{$type}) ? ($originalSize->{$type}/1000) : (0))."kB";
	my $logReducedSize = (($originalSize->{$type}) ? ($optimizedSize->{$type}/1000) : (0))."kB";
	my $logReducedSizePercentage = (($originalSize->{$type}) ? (sprintf ("%.2f", $optimizedSize->{$type} / $originalSize->{$type} * 100)) : (100))."%";
	my $logTime = (time() - $^T)."s";
	
	store ($lastIDs, "$SESSION_DIR/lastIDs.str");

	warn "$type,$logOrigSize,$logReducedSize,$logReducedSizePercentage,$logTime\n";
	open(FILE, ">>".$SCRIPT_DIR.'/fileblob_compressor_log.csv');
	print FILE "$type,$logOrigSize,$logReducedSize,$logReducedSizePercentage,$logTime\n";
	close(FILE);
}
