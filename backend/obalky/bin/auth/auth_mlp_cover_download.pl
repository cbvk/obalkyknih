use FindBin;
use lib "$FindBin::Bin/../lib";
use Fcntl qw(:flock);

use Obalky::Config;
use Data::Dumper;
use DB;
use File::Copy;
use MD5;
use utf8;

my $cnt = 0;
foreach (DB->resultset('AuthTmp')->search({ 'status' => 1 })->all)
{
	my $batch = MD5->hexhash($$."-auth-".(int(rand(1000000))+1)."-".time);
	my $original = $Obalky::Config::WWW_DIR."/original/$batch";
	mkdir($original) or die "Interní chyba: $original: $!";
	
	my $url = $_->get_column('img');
	$url =~ s/[\'\\]//g; # a bit of sanity check..
	($filename) = ($url =~ /([^\/]+)$/);
	die "Nelze určit jméno souboru z URL\n" unless($filename);

	print "wget -O '$original/$filename'\n";

	system("wget","-q",$url,"-O",$original."/".$filename);# == 0
	die "Ze zadaného URL <a href=\"$url\">$url</a> se nepovedlo stáhnout požadovaný soubor.\n"
		unless(-s $original."/".$filename);
	
	# checksum - checksum originalu
	my $orig_file = $original."/".$filename;
    my $checksum = `md5sum $orig_file | head -c 32`;
	
	my $file = "/tmp/cover-cropped-$$.png";
	# auto-crop, postup z http://www.imagemagick.org/Usage/crop/
	system("convert -bordercolor white -border 1x1 -fuzz '3%' -trim +repage ".
				"'$orig_file' '$file'");

	my($width,$height) = Obalky::Tools->image_size($file);
	return unless($height);

	my $file_icon = DB->resultset('Cover')->create_image_blob(
		$file,"cover-icon",$width,$height,
		$Obalky::Config::ICON_WIDTH,$Obalky::Config::ICON_HEIGHT);

	my $file_cover = DB->resultset('Cover')->create_image_blob(
		$file,"cover-medium",$width,$height,
		$Obalky::Config::MEDIUM_WIDTH,$Obalky::Config::MEDIUM_HEIGHT);

	my $file_thumb = DB->resultset('Cover')->create_image_blob(
		$file,"cover-thumb",$width,$height,
		$Obalky::Config::THUMB_WIDTH,$Obalky::Config::THUMB_HEIGHT);

	# original.jpg -- ukladat ho do DB?
	my $file_orig = DB->resultset('Fileblob')->new_from_file("cover-orig",$orig_file);
	my $dirGroupName = int($file_orig/100000+1)*100000;
	my $orig_filename = $Obalky::Config::FILEBLOB_DIR.'/'.$dirGroupName.'/'.$file_orig;
	copy($orig_file, $Obalky::Config::FILEBLOB_DIR.'/'.$dirGroupName.'/'.$file_orig->id);

	# FIXME: co kdyz uz obrazek s checksum v databazi je?
	my $cover = DB->resultset('Cover')->update_or_create({
		auth => $_->get_column('authID'), checksum => $checksum,
		file_medium => $file_cover, file_thumb => $file_thumb,
		file_orig => $file_orig, file_icon => $file_icon, 
		orig_width => $width,    orig_height => $height,
		orig_url => $_->get_column('pageUrl')
    });
    
    $_->update({ cover => $cover->id, status => 2 });
    DB->resultset('Auth')->find( $_->get_column('authID') )->update({ cover => $cover->id });
	
	print '>>> ' . $_->nazev . "\n";
}


print "\n\n-----------[ KONEC ]----------\n";