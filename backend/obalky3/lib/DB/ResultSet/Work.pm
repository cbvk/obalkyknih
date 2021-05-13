
package DB::ResultSet::Work;
use base 'DBIx::Class::ResultSet';

sub create_work {
	my $pkg = shift;
	my @books = @_;
	my $work = $pkg->create({});
	$_->assign_to_work($work) foreach(@books);
	return $work;
}

1;
