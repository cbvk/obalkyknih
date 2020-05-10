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

my $covers_rs = DB->resultset('Cover')->search_literal(
			"$idod <= id AND id <= $iddo");
while(my $cover = $covers_rs->next) {
	my($old_thumb,$old_icon,$old_medium) = 
		($cover->file_thumb,$cover->file_icon,$cover->file_medium);
	# next if($old_icon); # ma ikonu, asi to uz je opravene..

	# pokud to ma spravne rozmery, nepredelavej ho
#	if($old_icon) {
	if(0) {
		my $test = GD::Image->new($old_icon->content);
		unless($test) {
			warn "GD::Image(".$cover->id.") failed\n";
		} else {
			if($test->width == 54 and $test->height == 68) {
				my $test2 = GD::Image->new($old_medium->content);
				next if($test2->width == 170 and $test2->height == 240);
			}
		}
	}

	print "Prepocitavam ".$cover->id."\n";

	my $file = "/tmp/$$";

	my $orig_content = $cover->file_orig->content;
	open(ORIG,">",$file);
	print ORIG $orig_content;
	close(ORIG);

	# jako v DB/ResultSet/Cover
	my $pkg = "DB::ResultSet::Cover";

    my $file_icon = $pkg->create_image_blob(
        $file,"cover-icon",$width,$height,
        $Obalky::Config::ICON_WIDTH,$Obalky::Config::ICON_HEIGHT);

    my $file_medium = $pkg->create_image_blob(
        $file,"cover-medium",$width,$height,
        $Obalky::Config::MEDIUM_WIDTH,$Obalky::Config::MEDIUM_HEIGHT);

    my $file_thumb = $pkg->create_image_blob(
        $file,"cover-thumb",$width,$height,
        $Obalky::Config::THUMB_WIDTH,$Obalky::Config::THUMB_HEIGHT);

	$cover->update({
		file_icon => $file_icon,
		file_medium => $file_medium,
		file_thumb => $file_thumb,
	});

	# smaz az po updatnuti kvuli FK delete constrains
	$old_thumb->delete;
	eval { $old_icon->delete } if($old_icon);
	$old_medium->delete;
}

