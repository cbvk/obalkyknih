
package DB::ResultSet::Visitor;
use base 'DBIx::Class::ResultSet';

use strict;
use Data::Dumper;
use locale;

sub get_visitor {
	my($pkg,$ip,$visitor_id,$library) = @_;
	if($visitor_id) {
		my $visitor = $pkg->find($visitor_id);
		if($visitor) {
			$visitor->update({ last_ip => $ip, last_time => DateTime->now(),
							  count => $visitor->count + 1 });
			return $visitor;
		}
		# else vytvor noveho..
	}
	$library = DB->resultset('Library')->find_none unless($library);
	return $pkg->create({ library => $library, first_ip => $ip });
}

1;
