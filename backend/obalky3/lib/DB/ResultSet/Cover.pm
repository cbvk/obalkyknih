
package DB::ResultSet::Cover;
use base 'DBIx::Class::ResultSet';

use Obalky::Tools;

use Carp;

use DateTime;
use File::Path;
use File::Copy;
use Data::Dumper;

use GD;

use strict;
use warnings;

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
	my($pkg,$file,$type,$width,$height,$MAX_WIDTH,$MAX_HEIGHT,$current_file) = @_;

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

	return DB->resultset('Fileblob')->new_from_data($type,$image->png,$current_file);
}

sub create_from_file {
	my($pkg,$book,$product,$orig_file) = @_;
	
	return unless($orig_file);
	
	if (ref $book eq 'DB::Result::Book') {
		# editace zaznamu zamcena
		return $product->cover if ($book->get_column('pomocna') eq '1');
	}

	# checksum - checksum originalu
    my $checksum = `md5sum $orig_file | head -c 32`;

	my $file = "/tmp/cover-cropped-$$.png";
	# auto-crop, postup z http://www.imagemagick.org/Usage/crop/
	system("convert -bordercolor white -border 1x1 -fuzz '3%' -trim +repage ".
				"'$orig_file' '$file'");
	warn "convert -bordercolor white -border 1x1 -fuzz '3%' -trim +repage '$orig_file' '$file'";

	my($width,$height) = Obalky::Tools->image_size($file);
	return unless($height);
	
	# zjisteni jestli uz obalka ma nejaky fileblob, nebo se bude zakladat novy
	my ($current_file_icon,$current_file_medium,$current_file_thumb,$current_file_orig) = (undef,undef,undef,undef);
	if (defined $product->cover) {
		$current_file_icon = $product->cover->file_icon;
		$current_file_medium = $product->cover->file_medium;
		$current_file_thumb = $product->cover->file_thumb;
		$current_file_orig = $product->cover->file_orig;
	}

	my $file_icon = $pkg->create_image_blob(
		$file,"cover-icon",$width,$height,
		$Obalky::Config::ICON_WIDTH,$Obalky::Config::ICON_HEIGHT,
		$current_file_icon);

	my $file_cover = $pkg->create_image_blob(
		$file,"cover-medium",$width,$height,
		$Obalky::Config::MEDIUM_WIDTH,$Obalky::Config::MEDIUM_HEIGHT,
		$current_file_medium);

	my $file_thumb = $pkg->create_image_blob(
		$file,"cover-thumb",$width,$height,
		$Obalky::Config::THUMB_WIDTH,$Obalky::Config::THUMB_HEIGHT,
		$current_file_thumb);

	# original.jpg -- ukladat ho do DB?
	my $file_orig = 
		DB->resultset('Fileblob')->new_from_file("cover-orig",$orig_file,$current_file_orig);
	
	my $cover;
	
	# cover autority
	if ((ref $product) =~ /AuthSource/) {
		my $auth = $book;
		my $source = $product;
		
		#if ($cover) {
		#	my $resAuthCover = DB->resultset('Auth')->search({ cover => $cover->id });
		#	foreach ($resAuthCover->all) { $_->update({ cover => undef }); }
		#	my $resAuthSource = DB->resultset('AuthSource')->search({ cover => $cover->id });
		#	foreach ($resAuthSource->all) { $_->update({ cover => undef }); }
		#	my $resAuthAuse = DB->resultset('Abuse')->search({ cover => $cover->id });
		#	foreach ($resAuthAuse->all) { $_->update({ cover => undef }); }
		#}
		
		# obalka jeste u produktu neni uvedena, vytvorime
		unless ($source->cover) {
			$cover = eval { DB->resultset('Cover')->create({
				checksum => $checksum,
				file_medium => $file_cover, file_thumb => $file_thumb,
				file_orig => $file_orig,    file_icon => $file_icon, 
				orig_width => $width,       orig_height => $height
		    }) };
		}
		else {
			# obalka k produktu existuje, nacteme a poznacime novou velikost obrazku obalky
			$cover = DB->resultset('Cover')->find( $source->cover->id );
			$cover->update({
				checksum => $checksum, orig_width => $width, orig_height => $height
			});
		}
		
	    # dale nepokracujeme, dalsi kod se vykonava pouze pokud se jedna o produkt knihy
	    return $cover;
	}
	
	# obalka jeste u produktu neni uvedena, vytvorime
	unless ($product->cover) {
		$cover = eval { DB->resultset('Cover')->create({
			checksum => $checksum,
			file_medium => $file_cover, file_thumb => $file_thumb,
			file_orig => $file_orig,    file_icon => $file_icon, 
			orig_width => $width,       orig_height => $height
	    }) };
	}
	else {
		# obalka k produktu existuje, nacteme a poznacime novou velikost obrazku obalky
		$cover = DB->resultset('Cover')->find( $product->cover->id );
		$cover->update({ 
			checksum => $checksum, 
			orig_width => $width, orig_height => $height
		});
	}
	
	return $cover;
}

1;
