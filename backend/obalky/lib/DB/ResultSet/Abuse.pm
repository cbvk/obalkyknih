
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
	DB->resultset('FeSync')->book_sync_remove($book->id);
	
	return $abuse;
}

sub abuse_auth {
	my($pkg,$auth,$cover,$client_ip,$referer,$note,$isAdmin) = @_;
	
	my $abuse = $pkg->create({
		client_ip => $client_ip,
		referer => $referer,
		cover => $cover,
		toc => undef,
		auth => $auth,
		note => $note
	});
	my $auth_id = $auth->get_column('id');
	
	if ($isAdmin) {
		if($auth and $cover and $auth->cover and 
			($auth->cover->id eq $cover->id)) {
			$auth->update({ cover => undef }); # odlinkuj obalku
		}
		
		# synchronizuj s frontend
		DB->resultset('FeSync')->auth_sync_remove($auth->id);
	}
	unless ($isAdmin) {
		my $email = 'info@obalkyknih.cz';
		open(MUTT,"| mutt -s 'obalkyknih.cz - Zadost o opravu foto autority' '$email'");
		print MUTT <<EOF;

Zadost o opravu foto autority:
http://www.obalkyknih.cz/view_auth?auth_id=$auth_id

$note

EOF
		close(MUTT);
	}
	
	return $abuse;
}

#sub approve {
#	my($case,$
#}

1;

