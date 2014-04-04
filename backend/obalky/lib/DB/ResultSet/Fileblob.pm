
package DB::ResultSet::Fileblob;
use base 'DBIx::Class::ResultSet';

use strict;
use Data::Dumper;
use locale;

sub new_from_file {
	my($pkg,$medium,$filename) = @_;
	my $content = '';
	open(FILE,"<",$filename) or die "$filename: $!";
	while(sysread(FILE,$content,16384,length($content))) {}
	close(FILE);
	return $pkg->create( { medium => $medium, content => $content });
}

sub new_from_data {
	my($pkg,$medium,$content) = @_;
	return $pkg->create( { medium => $medium, content => $content });
}

1;
