
package DB::ResultSet::Abuse;
use base 'DBIx::Class::ResultSet';

#use Class::DBI::Plugin::DateTime::MySQL;
use Obalky::BibInfo;
use DateTime;

use strict;
use Data::Dumper;
use locale;

sub abuse {
	my($pkg,$book,$cover,$client_ip,$referer,$note) = @_;
	if($book and $cover and $book->cover and 
		($book->cover->id eq $cover->id)) {
		$book->update({ cover => undef }); # zrus hned???
	}
	my $abuse = $pkg->create({
		client_ip => $client_ip,
		referer => $referer,
		cover => $cover,
		book => $book,
		note => $note
	});
	return $abuse;
}

#sub approve {
#	my($case,$
#}

1;

