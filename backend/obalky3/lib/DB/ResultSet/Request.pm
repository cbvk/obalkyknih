
package DB::ResultSet::Request;
use base 'DBIx::Class::ResultSet';

use strict;
use Data::Dumper;
use locale;

# #request -- adept na zruseni

sub log_begin {
	my($pkg,$hash) = @_;
	return $pkg->create($hash);
}

sub log_finish {
	my($req) = @_;
	$req->update;
}

1;
