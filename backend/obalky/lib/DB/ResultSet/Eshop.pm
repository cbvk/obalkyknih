
package DB::ResultSet::Eshop;
use base 'DBIx::Class::ResultSet';

use Eshop;

use strict;
use Data::Dumper;
use locale;

sub max_id {
	my($pkg) = @_;
	my $max = 0;
	foreach($pkg->all()) {
		next if ($_->get_column('type') ne 'cover');
		$max = $_->id if($max < $_->id);
	}
	return $max;
}

sub sync_eshops {
	my($pkg) = @_;
#	Uz nevim, co to melo delat :-(
##	my %eshops = Eshop->get_eshops;
##	foreach my $info (values %eshops) {
##		$pkg->find_or_create({ name => $info->{name} }, 
##							 { key => 'eshop_name' });
##	}
}

sub find_by_name {
	my($pkg,$name) = @_;
	my($eshop,$more) = $pkg->search({ name => $name });
	die "Eshop $name not found\n" unless($eshop);
	die "Eshop->find_by_name('$name') Vice eshopu\n" if($more);
	return $eshop;
}

sub get_upload_eshop { 
	my($pkg) = @_;
	$pkg->sync_eshops;
	return $pkg->find_by_name('Upload'); 
}

1;

