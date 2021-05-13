
package DB::ResultSet::Product;
use base 'DBIx::Class::ResultSet';

#use Class::DBI::Plugin::DateTime::MySQL;
use Obalky::BibInfo;

use strict;
use Data::Dumper;
use locale;

sub recent {
	my($pkg,$limit) = @_;

	my $recent = DB->resultset('Product')->search({ cover => { '-not' => undef } },
		{ order_by => { '-desc' => 'id' }, 
		  rows => $limit });
    my @rows;
	while($limit--) {
		my $cover = $recent->next;
		last unless($cover);
		push @rows, $cover;
	}
    return \@rows;
}

1;

