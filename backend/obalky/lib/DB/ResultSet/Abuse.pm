
package DB::ResultSet::Abuse;
use base 'DBIx::Class::ResultSet';

#use Class::DBI::Plugin::DateTime::MySQL;
use Obalky::BibInfo;
use DateTime;

use strict;
use Data::Dumper;
use locale;

sub abuse {
	my($pkg,$book,$cover,$toc,$client_ip,$referer,$note) = @_;
	if($book and $cover and $book->cover and 
		($book->cover->id eq $cover->id)) {
		$book->update({ cover => undef }); # odlinkuj obalku
	}
	if($book and $toc and $book->toc and 
		($book->toc->id eq $toc->id)) {
		$book->update({ toc => undef }); # odlinkuj toc
	}
	my $abuse = $pkg->create({
		client_ip => $client_ip,
		referer => $referer,
		cover => $cover,
		toc => $toc,
		book => $book,
		note => $note
	});
	
	# synchronizuj s frontend
	my $bibinfo = Obalky::BibInfo->new($book);
	DB->resultset('FeSync')->request_sync_remove($bibinfo);
	
	return $abuse;
}

#sub approve {
#	my($case,$
#}

1;

