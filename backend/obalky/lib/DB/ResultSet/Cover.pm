
package DB::ResultSet::Cover;
use base 'DBIx::Class::ResultSet';

use Obalky::Tools;

use Carp;

use DateTime;
use File::Path;
use File::Copy;

use GD;

use strict;
use warnings;

sub recent {
	my($pkg,$rows,$cols) = @_;
	
#	my $first = DB->resultset('Cover')->search({},
#		{ order_by => { '-desc' => 'created' }, rows => 16 })->first();
#	return [$first->book];

	my $recent = DB->resultset('Cover')->search({},
		{ order_by => { '-desc' => 'created' }, 
		  rows => $rows*$cols }); # aka "LIMIT 16"
    my @rows;
	if($cols == 1) { # pro novy design tovarny
		while($rows--) {
			my $cover = $recent->next;
			last unless($cover);
			push @rows, $cover->book;
		}
	} else { # pro starou mrizku 3x3 
		for(my $r=0;$r<$rows;$r++) {
			$rows[$r] = { cols => [] };
			for(my $c=0;$c<$cols;$c++) {
				my $cover = $recent->next;
				last unless($cover);
				push @{$rows[$r]->{cols}}, $cover->book;
			}
		}
    }
    return \@rows;
}

sub has_same_cover {
	my($pkg,$id,$md5) = @_;
	my @count = $pkg->search({ checksum => $md5 });
	return 0 unless(@count);
	return 1; # co vicesvazkove apod, kdy je jedna obalka u vice knih?
}

sub upload {
	my($pkg,$book,$upload) = @_;
    my $filename = $Obalky::WWW_DIR."/upload/".
					$upload->batch."/".$upload->filename;
	my $product; # = ...
	return $pkg->create_from_file($book,$product,$filename);
}

sub resize {

}

sub create_image_blob {
	my($pkg,$file,$type,$width,$height,$MAX_WIDTH,$MAX_HEIGHT) = @_;

	my($iw,$ih) = Obalky::Tools->resize(
					$MAX_WIDTH,$MAX_HEIGHT,$width,$height);
	return unless($iw);
    my $tmp_file = "/tmp/cover-$$.png";

	system("convert","-resize", $iw."x".$ih, $file, $tmp_file);
	return unless(-f $tmp_file);
    my $tmp_image = GD::Image->newFromPng($tmp_file);
	unlink($tmp_file);

    my $image = new GD::Image($MAX_WIDTH,$MAX_HEIGHT);
    my $white = $image->colorAllocate(255,255,0);

    $image->transparent($white); # kvuli tomuto preklapime na PNG
    $image->copy($tmp_image,$MAX_WIDTH/2-$tmp_image->width/2,
                          $MAX_HEIGHT/2-$tmp_image->height/2,0,0,
						$tmp_image->width,$tmp_image->height);

	return DB->resultset('Fileblob')->new_from_data($type,$image->png);
}

sub create_from_file {
	my($pkg,$book,$product,$orig_file) = @_;

	return unless($orig_file);

	# checksum - checksum originalu
    my $checksum = `md5sum $orig_file | head -c 32`;

	my $file = "/tmp/cover-cropped-$$.png";
	# auto-crop, postup z http://www.imagemagick.org/Usage/crop/
	system("convert -bordercolor white -border 1x1 -fuzz '3%' -trim +repage ".
				"'$orig_file' '$file'");

	my($width,$height) = Obalky::Tools->image_size($file);
	return unless($height);

	my $file_icon = $pkg->create_image_blob(
		$file,"cover-icon",$width,$height,
		$Obalky::Config::ICON_WIDTH,$Obalky::Config::ICON_HEIGHT);

	my $file_cover = $pkg->create_image_blob(
		$file,"cover-medium",$width,$height,
		$Obalky::Config::MEDIUM_WIDTH,$Obalky::Config::MEDIUM_HEIGHT);

	my $file_thumb = $pkg->create_image_blob(
		$file,"cover-thumb",$width,$height,
		$Obalky::Config::THUMB_WIDTH,$Obalky::Config::THUMB_HEIGHT);

	# original.jpg -- ukladat ho do DB?
	my $file_orig = 
		DB->resultset('Fileblob')->new_from_file("cover-orig",$orig_file);

	# FIXME: co kdyz uz obrazek s checksum v databazi je?
	my $cover = eval { DB->resultset('Cover')->update_or_create({
		book => $book, product => $product, checksum => $checksum,
		file_medium => $file_cover, file_thumb => $file_thumb,
		file_orig => $file_orig, file_icon => $file_icon, 
		orig_width => $width,    orig_height => $height
    },{ key => 'cover_product' }) };
	# warn "Created cover ".$cover->id." for book ".$book->id."\n";
	$cover = DB->resultset('Cover')->find({ checksum => $checksum }) 
					unless($cover);
	# die "Nepovedlo se vytvořit: $@\n" if($@); # or die?
	return $cover;
}

1;
