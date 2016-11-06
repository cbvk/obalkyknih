#!/usr/bin/perl -w

# Script je spousten pravidelne kazdy den a aktualizuje 
# agregovana data komentaru a hodnoceni. Je to potrebne zejmena
# kvuli externim zasahum do DB napr. scriptem pro schvalovani v CBVK.

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use DBI;
use Data::Dumper;
use DateTime::Format::MySQL;

use Fcntl qw(:flock);
#Vylucny beh
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Waiting";
  	sleep 3600;
	last;
}

my $dbh = DBI->connect("DBI:mysql:database=obalky","obalky","visk2009");

my $query = 'SELECT b.id
  FROM (SELECT COUNT(*) AS cnt
			  ,SUM(rating) AS sum
			  ,book AS book
		  FROM review
         WHERE impact IN (0, 8, 9)
           AND IFNULL(rating,0) != 0
           AND IFNULL(library,0) != 0
           AND library_id_review IS NOT NULL
		   AND IFNULL(`status`, 0) != 2
		 GROUP BY book) AS r
         INNER JOIN book AS b ON b.id = r.book AND (IFNULL(b.cached_rating_sum,0)!=r.sum OR IFNULL(b.cached_rating_count,0)!=r.cnt)';

my $book_sth = $dbh->prepare($query);
$book_sth->execute();

my $i = 1;
while( my @row = $book_sth->fetchrow_array ) {
	my($id) = @row;
	$book = DB->resultset('Book')->find($id);
	$book->recalc_rating;
	$book->recalc_review;
	$book->invalidate;
	warn $i.' ['.$id.']';
	$i++;
}

