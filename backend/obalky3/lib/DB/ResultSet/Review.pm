
package DB::ResultSet::Review;
use base 'DBIx::Class::ResultSet';

use Obalky::Tools;
use Obalky::BibInfo;

use Carp;

use DateTime;
use File::Path;
use File::Copy;

use strict;
use warnings;
use Data::Dumper;

sub all_public {
	my($pkg,$month) = @_;
	#$pkg->search({ visitor_ip => { "!=" => undef } });
	$pkg->search({ -and => [
		visitor_ip => { "!=" => undef },
		\[ 'MONTH(created) = ?', [ plain_value => $month ] ]
	] });
}

sub remove_review {
	my($pkg,$id) = @_;
	my @errors;
	
	push @errors, "Neplatný identifikátor komentáře.\n"
		unless ($id =~ /^\d+$/);
	
	my $review = DB->resultset('Review')->find($id);
	push @errors, "Komentář neexistuje.\n"
		unless $review;
	
	unless (@errors) {
		my $book_id = $review->get_column('book');
		my $book = DB->resultset('Book')->find($book_id);
		my $cached_rating_sum = $book->get_column('cached_rating_sum') - $review->get_column('rating');
		my $cached_rating_count = $book->get_column('cached_rating_count') - 1;
		$cached_rating_sum = undef if ($cached_rating_sum < 0);
		$cached_rating_count = undef if ($cached_rating_count < 0);
		DB->resultset('FeSync')->book_sync_remove($book->id);
		$book->update({ cached_rating_sum=>$cached_rating_sum, cached_rating_count=>$cached_rating_count });
		$review->delete;	
	} else {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return 1;
}

1;
