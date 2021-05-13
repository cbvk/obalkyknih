
package DB::ResultSet::Auth;
use base 'DBIx::Class::ResultSet';

use Data::Dumper;
use strict;
use locale;

sub get_auth_record {
	my($pkg,$authinfo) = @_;

	my $auth = DB->resultset('Auth')->find( $authinfo->{auth_id} );
	
	return ($auth);
}

sub max_id {
	my($pkg) = @_;
	my $max = 0;
	foreach($pkg->all()) {
		next if ($_->get_column('type') ne 'auth');
		$max = $_->id if($max < $_->id);
	}
	return $max;
}

sub find_by_name {
	my($pkg,$name) = @_;
	my($auth,$more) = $pkg->search({ name => $name });
	die "Eshop $name not found\n" unless($auth);
	die "Eshop->find_by_name('$name') Vice eshopu\n" if($more);
	return $auth;
}

sub get_upload_source { 
	my($pkg) = @_;
	return $pkg->find_by_name('Upload'); 
}

sub find_by_authinfo {
	my($pkg,$authinfo) = @_;

	my @auths = DB->resultset('Auth')->search({
		id => $authinfo->{auth_id},
		auth_date => $authinfo->{auth_date},
		auth_name => $authinfo->{auth_name}
	});
		
	return $auths[0];
}

1;
