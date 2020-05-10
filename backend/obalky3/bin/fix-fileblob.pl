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
use DBI;

# Pregeneruj -icon, -thumb, -cover z original fileblobu

# Prochazej kazdy cover, tam kde neco chybi, udelej, jinak
# puvodni #fileblob smaz a vygeneruj novy

my($idod,$iddo) = @ARGV;
die "\nusage: $0 1 612306\n\n" unless($iddo);

my %used;

my $covers_rs = DB->resultset('Cover')->search_literal(
			"$idod <= id AND id <= $iddo");
while(my $cover = $covers_rs->next) {
	my($old_thumb,$old_icon,$old_medium,$old_orig) = 
		($cover->file_thumb,$cover->file_icon,$cover->file_medium,$cover->file_orig);
	# next if($old_icon); # ma ikonu, asi to uz je opravene..
	$used{$old_thumb}++;
	$used{$old_icon}++;
	$used{$old_medium}++;
	$used{$old_orig}++;
}

print "Used: ",scalar(keys %used),"\n";

my $files_rs = DB->resultset('Fileblob');
while(my $file = $files_rs->next) {
	my $id = $file->id;
	warn "File $id\n" unless($id % 100_000);
	if($used{$file->id}) {
	} else {
		print "DELETE FROM fileblob WHERE id = ".$file->id."\n";
	}
}

