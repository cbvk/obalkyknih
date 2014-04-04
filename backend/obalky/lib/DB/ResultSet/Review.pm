
package DB::ResultSet::Review;
use base 'DBIx::Class::ResultSet';

use Obalky::Tools;

use Carp;

use DateTime;
use File::Path;
use File::Copy;

use strict;
use warnings;

sub all_public {
	my($pkg,$month) = @_;
	#$pkg->search({ visitor_ip => { "!=" => undef } });
	$pkg->search({ -and => [
		visitor_ip => { "!=" => undef },
		\[ 'MONTH(created) = ?', [ plain_value => $month ] ]
	] });
}

1;
