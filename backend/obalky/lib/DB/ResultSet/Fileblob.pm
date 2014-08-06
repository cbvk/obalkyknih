
package DB::ResultSet::Fileblob;
use base 'DBIx::Class::ResultSet';

use Obalky::Config;
use File::Copy;

use strict;
use Data::Dumper;
use locale;

#for original cover image
sub new_from_file {
	my($pkg,$medium,$filename) = @_;
	my $obj = $pkg->create( { medium => $medium, content => '' });
	my $id = $obj->id;
	#orig files are grouped in dir
	my $dirGroupName = int($id/100000+1)*100000;
	mkdir($Obalky::Config::FILEBLOB_DIR.'/'.$dirGroupName) unless (-d $Obalky::Config::FILEBLOB_DIR.'/'.$dirGroupName);
	#copy from www/upload dir
	copy($filename, $Obalky::Config::FILEBLOB_DIR.'/'.$dirGroupName.'/'.$id) or die "$filename: $!";
	return $obj;
}

#for resampled cover images
sub new_from_data {
	my($pkg,$medium,$content) = @_;
	return $pkg->create( { medium => $medium, content => $content });
}

1;
