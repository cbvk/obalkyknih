use utf8;
package DB::Result::Book;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Book

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
use List::Util qw( max );
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<book>

=cut

__PACKAGE__->table("book");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_parent

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 ean13

  data_type: 'char'
  is_nullable: 1
  size: 13

=head2 oclc

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 nbn

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 authors

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 year

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 part_year

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 part_volume

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 part_no

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 part_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 part_note

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 part_type

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

=head2 search_count

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 harvest_max_eshop

  data_type: 'integer'
  is_nullable: 1

=head2 harvest_last_time

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 cover

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 toc

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 cached_rating_sum

  data_type: 'integer'
  is_nullable: 1

=head2 cached_rating_count

  data_type: 'integer'
  is_nullable: 1

=head2 review

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 work

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 citation

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 tips

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 part_year_orig

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 part_volume_orig

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 part_no_orig

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 part_name_orig

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 part_note_orig

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "id_parent",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "ean13",
  { data_type => "char", is_nullable => 1, size => 13 },
  "oclc",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "nbn",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "authors",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "year",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "part_year",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "part_volume",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "part_no",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "part_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "part_note",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "part_type",
  {
    data_type => "tinyint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  "search_count",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "harvest_max_eshop",
  { data_type => "integer", is_nullable => 1 },
  "harvest_last_time",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "cover",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "toc",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "cached_rating_sum",
  { data_type => "integer", is_nullable => 1 },
  "cached_rating_count",
  { data_type => "integer", is_nullable => 1 },
  "review",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "work",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "citation",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "tips",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "part_year_orig",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "part_volume_orig",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "part_no_orig",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "part_name_orig",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "part_note_orig",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 abuses

Type: has_many

Related object: L<DB::Result::Abuse>

=cut

__PACKAGE__->has_many(
  "abuses",
  "DB::Result::Abuse",
  { "foreign.book" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 books

Type: has_many

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->has_many(
  "books",
  "DB::Result::Book",
  { "foreign.id_parent" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cover

Type: belongs_to

Related object: L<DB::Result::Cover>

=cut

__PACKAGE__->belongs_to(
  "cover",
  "DB::Result::Cover",
  { id => "cover" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 covers

Type: has_many

Related object: L<DB::Result::Cover>

=cut

__PACKAGE__->has_many(
  "covers",
  "DB::Result::Cover",
  { "foreign.book" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 id_parent

Type: belongs_to

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->belongs_to(
  "id_parent",
  "DB::Result::Book",
  { id => "id_parent" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 marcs

Type: has_many

Related object: L<DB::Result::Marc>

=cut

__PACKAGE__->has_many(
  "marcs",
  "DB::Result::Marc",
  { "foreign.book" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 part_type

Type: belongs_to

Related object: L<DB::Result::CPartType>

=cut

__PACKAGE__->belongs_to(
  "part_type",
  "DB::Result::CPartType",
  { id => "part_type" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 products

Type: has_many

Related object: L<DB::Result::Product>

=cut

__PACKAGE__->has_many(
  "products",
  "DB::Result::Product",
  { "foreign.book" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 review

Type: belongs_to

Related object: L<DB::Result::Review>

=cut

__PACKAGE__->belongs_to(
  "review",
  "DB::Result::Review",
  { id => "review" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 review_2

Type: belongs_to

Related object: L<DB::Result::Review>

=cut

__PACKAGE__->belongs_to(
  "review_2",
  "DB::Result::Review",
  { id => "review" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 review_3

Type: belongs_to

Related object: L<DB::Result::Review>

=cut

__PACKAGE__->belongs_to(
  "review_3",
  "DB::Result::Review",
  { id => "review" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 review_4

Type: belongs_to

Related object: L<DB::Result::Review>

=cut

__PACKAGE__->belongs_to(
  "review_4",
  "DB::Result::Review",
  { id => "review" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 reviews

Type: has_many

Related object: L<DB::Result::Review>

=cut

__PACKAGE__->has_many(
  "reviews",
  "DB::Result::Review",
  { "foreign.book" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tags

Type: has_many

Related object: L<DB::Result::Tag>

=cut

__PACKAGE__->has_many(
  "tags",
  "DB::Result::Tag",
  { "foreign.book" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tip_book1s

Type: has_many

Related object: L<DB::Result::Tip>

=cut

__PACKAGE__->has_many(
  "tip_book1s",
  "DB::Result::Tip",
  { "foreign.book1" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tip_book2s

Type: has_many

Related object: L<DB::Result::Tip>

=cut

__PACKAGE__->has_many(
  "tip_book2s",
  "DB::Result::Tip",
  { "foreign.book2" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 toc

Type: belongs_to

Related object: L<DB::Result::Toc>

=cut

__PACKAGE__->belongs_to(
  "toc",
  "DB::Result::Toc",
  { id => "toc" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 toc_2

Type: belongs_to

Related object: L<DB::Result::Toc>

=cut

__PACKAGE__->belongs_to(
  "toc_2",
  "DB::Result::Toc",
  { id => "toc" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 tocs

Type: has_many

Related object: L<DB::Result::Toc>

=cut

__PACKAGE__->has_many(
  "tocs",
  "DB::Result::Toc",
  { "foreign.book" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 work

Type: belongs_to

Related object: L<DB::Result::Work>

=cut

__PACKAGE__->belongs_to(
  "work",
  "DB::Result::Work",
  { id => "work" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-01-26 13:21:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nAl9XxlelluDyaMGUf3cWg

use Obalky::Media;
use Data::Dumper;
use DB;

sub displayable_products {
	my($book) = @_;
	my @displayable;
	foreach my $product ($book->products) {
		my $factory = $product->eshop->factory;
		push @displayable, $product if($factory->{display});
	}
	return @displayable;
}

sub bibinfo {
	my($book) = @_;
	return new Obalky::BibInfo($book);
}
sub media {
	my($book) = @_;
	return new Obalky::MediaInfo($book);
}
sub to_string {
    my($book) = @_;
    my $id = new Obalky::BibInfo($book);
    return $id->to_string;
}
sub to_isbn {
    my($book) = @_;
    return $book->bibinfo->to_isbn;
}

sub get_cover {
	my($book) = @_;
	my $cover = $book->cover;
	return $cover if($cover);
	my $work = $book->work;
	return unless $work;
	# aspon nejakou obalku, klidne obalku dila
	# (nemelo by se to ale pouzivat na strance s vypisem knih dila)
	return $work->get_cover; 
}

sub get_toc {
	my($book) = @_;
	my $toc = $book->toc;
	return $toc if($toc);
	my $work = $book->work;
	return unless $work;
	# aspon nejakou obalku, klidne obalku dila
	# (nemelo by se to ale pouzivat na strance s vypisem knih dila)
	return $work->get_toc; 
}

sub work_books {
	my($book) = @_;
	my $work = $book->work;
	# $work->
	return $work ? $work->books : ($book);
}

sub recalc_review {
	my($book) = @_;
	my $best;
	foreach($book->reviews) { # WHERE rating NOT NULL ?
		# zahod ty, ktere nepochazi z knihovny
		next if (not defined $_->library or not defined $_->library_id_review);
		# vyber komentare s vyssim impact
		$best = $_ if($_->impact eq $Obalky::Media::REVIEW_ANNOTATION);
		$best = $_ if($_->impact eq $Obalky::Media::REVIEW_REVIEW 
							and not $best);
	}
	$book->update({ review => $best });
}

sub invalidate { # nutno volat po kazde zmene knizky
	my($book,$forced) = @_;
	DB->resultset('Cache')->invalidate($book);
	DB->resultset('FeSync')->book_sync_remove($book->id, undef, $forced);
}

sub recalc_rating {
	my($book) = @_;

	my($rs,$rc,$ers,$erc) = (0,0,0,0);
	foreach($book->reviews) {
		# zahod ty, ktere nepochazi z knihovny
		next if (not defined $_->library or not defined $_->library_id_review);
		# napocitej rating
		if(defined $_->rating) {
			if ($_->rating > 0) {
				if($_->product) { $ers += $_->rating; $erc++ }
						   else { $rs  += $_->rating; $rc++ }
			}
		}
	}
	# puvodni logika: produktove ma 6 hlasu, pak bude postupne prevazeno
	#if($erc) { $rs += int(6*$ers/$erc); $rc += 6; }
	$rs += $ers;
	$rc += $erc;

	$rc = undef unless($rc);
	$rs = undef unless($rs);
	$book->update({ cached_rating_sum => $rs, cached_rating_count => $rc });
	# $book->invalidate(); # musi volat volajici!
}


sub get_rating {
	my($book) = @_;
	my($rs,$rc) = (0,0);
	my @books = $book->work_books; # pres vsechna dila..
	foreach(@books) {
		$rs += $_->cached_rating_sum || 0;
		$rc += $_->cached_rating_count || 0;
	}
	return ($rs,$rc);
}

sub get_reviews {
	my($book) = @_;
	my @book_ids;
	my @books = $book->work_books; # pres vsechna dila..
	map { push @book_ids, $_->id } @books;
	my $reviews = DB->resultset('Review')->search({ book=>@book_ids, library=>{ -not => undef }, library_id_review=>{ -not => undef } }, {
		order_by => { '-desc' => 'created' },
		limit => 200
	});
	return $reviews->all;
}

sub get_rating_count { # nutne asi jen kvuli view
	my($book) = @_;
	my($rs,$rc) = $book->get_rating;
	return $rc;
}
sub get_rating_avg100 { # nutne asi jen kvuli view
	my($book) = @_;
	my($rs,$rc) = $book->get_rating;
	return $rc ? $rs/$rc : undef;
}
sub get_rating_avg5 { # nutne asi jen kvuli view
	my($book) = @_;
	my($rs,$rc) = $book->get_rating;
	return undef unless $rc;
	my $avg = $rs/$rc;
	return $avg/20 unless($avg % 20);
	return sprintf("%1.1f",$book->get_rating_avg100/20);
}

sub get_obalkyknih_url {
	my($book,$secure) = @_;
	my $bibinfo = $book->bibinfo;
	return $bibinfo ? $bibinfo->get_obalkyknih_url($secure) : undef;
}

sub actualize_by_product {
	my($book,$product,$forced) = @_;
	my $invalidate = 0;
	
	# pokud se neco zmenilo, je potreba zaznam zneplatnit a pozadat FE o zneplatneni
	$invalidate = ($book->cover->id!=$product->cover->id) ? 1 : 0 if ($book->cover and $product->cover);
	$invalidate = ($book->toc->id!=$product->toc->id) ? 1 : $invalidate if ($book->toc and $product->toc);
	
	$book->update({ cover => $product->cover })   if($product->cover);
	$book->update({ toc => $product->toc })       if($product->toc);
#	$book->update({ review => $product->review }) if($product->review);

	$book->recalc_rating;
	$book->invalidate($forced) if ($invalidate or $forced);

#	my($sum,$count) = @_;
#	$book->update({ external_sum => $product->review }) if($product->review);
}

sub assign_to_work {
	my($book,$work) = @_;
	$book->update({ work => $work });
	$book->recalc_rating;
	$book->invalidate();
}

sub add_review {
	my($book,$library,$visitor,$info) = @_;
	die unless($visitor);
    my $review = DB->resultset('Review')->create({
			book => $book, rating => $info->{rating},
			visitor_name => $info->{visitor_name}, 
			visitor_ip => $info->{visitor_ip}, 
			html_text => $info->{html_text},
			visitor => $visitor, 
			library => $library->get_column('id'),
			library_id_review => $info->{id},
			impact => $info->{impact},
	});
	$visitor->update({ name => $info->{name} }) if($info->{name});
	$book->recalc_rating;
	$book->recalc_review;
	$book->invalidate;
	return $review;
}

sub edit_review {
	my($book,$review,$library,$visitor,$info) = @_;
	die unless($visitor || $review || $library);
	die unless($info->{sigla} eq $library->get_column('code'));
	my $flag_change = 0;
	
	# zmena ciselneho honoceni
	my $old_rating = $review->get_column('rating');
	my $new_rating = $info->{rating};
	# pokud mazeme ciselne hodnoceni je nutne odpocitat v zazname book
	# protoze pokud mazeme posledni ciselne hodnoceni neaktualizuje se book, protoze vsechny reviews budou NULL (a NULL se v prepocitavani hodnoceni ignoruje)
	if ($old_rating && !$new_rating) {
		my $cached_rating_sum = $book->get_column('cached_rating_sum') - $old_rating;
		my $cached_rating_count = $book->get_column('cached_rating_count') - 1;
		$cached_rating_sum = undef unless ($cached_rating_sum);
		$cached_rating_count = undef unless ($cached_rating_count);
		$book->update({ cached_rating_sum => $cached_rating_sum, cached_rating_count => $cached_rating_count });
	}
	
	# zmena textoveho komentare
	my $new_comment = $info->{html_text};
	
	# zmena impactu
	my $impact = 0;
	$impact = $Obalky::Media::REVIEW_VOTE if ($new_rating);
	$impact = $Obalky::Media::REVIEW_COMMENT if ($new_comment);
	
    $review->update({
		rating => $new_rating,
		visitor_name => $info->{visitor_name},
		visitor_ip => $info->{visitor_ip},
		html_text => $new_comment,
		visitor => $visitor,
		impact => $impact,
	});
	$book->recalc_rating;
	$book->recalc_review;
	$book->invalidate;
	return $review;
}

sub del_review {
	my($book,$review,$library,$visitor,$info) = @_;
	die unless($visitor || $review || $library);
	die unless($info->{sigla} eq $library->get_column('code'));
	
    $review->delete;
	$book->recalc_rating;
	$book->recalc_review;
	$book->invalidate;
	return $review;
}

sub get_most_recent {
	my($book) = @_;
	return $book unless ($book->id);
	
	my ($max_year,$max_volume,$eq_year,$eq_volume) = (undef,undef,undef,undef);
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
	my %max_by_year;
	my %max_by_volume;
	
	my $parts = DB->resultset('Book')->search({ id_parent => $book->id }, { order_by => {-desc=>[qw/part_year part_volume/]} });
	if ($parts->count) {
		# vyhledani nejnovejsiho zaznamu podle roku
		foreach ($parts->all) {
			# v pripade vicesvazkove monografie vracime prvni nalezeny zaznam (prvni naskenovany, protoze se seradi podle primarniho klice)
			return $_ if ($_->get_column('part_type') == 1);
			
			# pokud se jedna o periodikum pokracujeme v hledani nejnovejsiho; v pripade monografie to neni potrebne
			my $cur_year = $_->get_column('part_year');
			my $cur_volume = $_->get_column('part_volume');
			my $cur_no = $_->get_column('part_no');
			next if ($cur_year > $year+1900); # stavaji se preklepy a ze skenovaciho klienta prijde rok vyssi nez aktualni, takove zaznamy ignorovat
			$max_year = $cur_year unless($max_year);
			$max_volume = $cur_volume unless($max_volume);
			if ($cur_year && $cur_volume && !$eq_year) { # nalezly jsme zaznam s parem rok/rocnik
				$eq_year = $cur_year;
				$eq_volume = $cur_volume;
			}
			$max_volume = $max_volume<$cur_volume ? $cur_volume : $max_volume if ($max_volume and $cur_volume);
			
			# uloz hodnotu part_no (pozdeji se bude podle toho vyhledavat aktualni cislo)
			$max_by_year{$cur_year}{$cur_no} = $_->id if ($cur_year);
			$max_by_volume{$cur_volume}{$cur_no} = $_->id if ($cur_volume);
		}
		
		# nemame se ceho chytit, rok znamy, rocnik neznamy, tj. vyhledame nejnovejsi podle roku
		if (($max_year && !$max_volume) || ()) {
			my $recent_book_id = $max_by_year{$max_year}{ max keys %{$max_by_year{$max_year}} };
			return DB->resultset('Book')->find( $recent_book_id );
		}
		# nemame se ceho chytit, rocnik znamy, rok neznamy, tj. vyhledame nejnovejsi podle rocniku
		if (!$max_year && $max_volume) {
			my $recent_book_id = $max_by_volume{$max_volume}{ max keys %{$max_by_volume{$max_volume}} };
			return DB->resultset('Book')->find( $recent_book_id );
		}
		# oba parametry jsou zname, ale nemame k cemu prirovnat (nemame zaznam co obsahuje rok i rocnik zaroven), uprednostnime rok
		if (!$eq_year) {
			my $recent_book_id = $max_by_year{$max_year}{ max keys %{$max_by_year{$max_year}} };
			return DB->resultset('Book')->find( $recent_book_id );
		}
		# zname vsechno (nejnovejsi rok, nejnovejsi rocnik a vime je k sobe srovnat)
		if ($eq_year && $eq_volume) {
			my $vol_diff = $max_volume - $eq_volume;
			my $vol_to_year = $eq_year + $vol_diff;
			my $max_year_calculated = $max_year>=$vol_to_year ? $max_year : $vol_to_year;
			$max_year_calculated = $max_year if ($max_year_calculated > $max_year);
			$max_volume = $max_volume + ($max_year_calculated - $max_year);
			
			my $recent_book_id;
			my $max_part_no_by_year = max keys %{$max_by_year{$max_year_calculated}};
			my $max_part_no_by_volume = max keys %{$max_by_volume{$max_volume}};
			if ($max_part_no_by_year >= $max_part_no_by_volume) {
				# maximum se naslo podle roku
				$recent_book_id = $max_by_year{$max_year_calculated}{ $max_part_no_by_year };
			} else {
				# maximum se naslo podle rocniku
				$recent_book_id = $max_by_volume{$max_volume}{ $max_part_no_by_volume };
			}
			return DB->resultset('Book')->find( $recent_book_id );
		}
	}
	return $book;
}

# --------------------------------------------------------------

sub enrich {
	my($book,$info,$library,$permalink,$bibinfo,$secure,$params) = @_;
	
	# vyzadujeme/nevyzadujeme, aby se vyhledaval zaznam s presnou shodou
	# strict_match = 1  nebude se vyhledavat novejsi cislo periodika/cast monografie (pokud se jedna o souborny zaznam)
	# strict_match = 0  v pripade souborneho zaznamu periodika/monografie je povoleno vyhledavani novejsich casti/cisel
	my $strict_match = 0;
	$strict_match = ($params->{strict_match} eq 'true' or $params->{strict_match} eq '1') ? 1 : 0 if ($params->{strict_match});
	
	# rozhodovani, jestli je nutne vyhledat nejnovejsi cislo k soubornemu zaznamu
	# 1) vyhledat pokud se jedna o souborny zaznam periodika (i v pripade, ze periodikum ma oskenovanou vlastni obalku)
	# 2) vyhledat pokud se jedna o souborny zaznam monografie, ale pouze pokud nema oskenovanou vlastni obalku
	my $child_book = DB->resultset('Book')->search({ id_parent => $book->id }, { limit=>1 })->next;
	my $flag_get_most_recent = 0;
	if ($child_book and !$strict_match) {
		$flag_get_most_recent = 1; # souborny zaznam periodika vzdy
		$flag_get_most_recent = 0 if ($child_book->part_type==1 && ($book->cover || $book->toc)); # souborny zaznam monografie pokud nema vlastni obalku
	}
	
	# vyhledani nejnovejsiho cisla k soubornemu zaznamu, pokud je nutne
	my $book_most_recent = undef;
	warn 'THIS IS UNION RECORD. Latest book part will be searched for.' if ($ENV{DEBUG} and $flag_get_most_recent);
	$book_most_recent = $book->get_most_recent if ($flag_get_most_recent);
	warn 'Found most recent child '.$book->id.' of requested book '.$book_most_recent->id."\n" if ($ENV{DEBUG} and $book_most_recent and $book->id!=$book_most_recent->id);
	
	# aktualizuj book bibinfo (OCLC, title,...) (strcit to do Marc::..?)
	my $book_bibinfo = $book->bibinfo;
	if(!$child_book and $book_bibinfo->merge($bibinfo)) {
		$book_bibinfo->save_to($book);
		$book->invalidate;
	}
#	$bibinfo->save_to($book);

	$info->{book_id} = $book->id;
	$info->{ean} = $book_bibinfo->ean13 if $book_bibinfo->ean13;
	$info->{nbn}  = $book_bibinfo->nbn if $book_bibinfo->nbn;
	$info->{oclc} = $book_bibinfo->oclc if $book_bibinfo->oclc;
	$info->{part_year} = $book_bibinfo->{part_year} if $book_bibinfo->{part_year};
	$info->{part_volume} = $book_bibinfo->{part_volume} if $book_bibinfo->{part_volume};
	$info->{part_no} = $book_bibinfo->{part_no} if $book_bibinfo->{part_no};
	$info->{part_name} = $book_bibinfo->{part_name} if $book_bibinfo->{part_name};
	$info->{part_root} = $book->get_column('id_parent') ? 0 : 1;
	# vyhledavame souborny zaznam a k tomuto soubornemu zaznamu byla prilozena obalka/obsah novejsiho cisla periodika/casti monografie
	# posleme taky identifikatory zaznamu, z ktereho pochazi prilozena obalka a obsah tj. prilozime part_info s identifikatory zaznamu, kteremu patri obalka/obsah
	# to plati i kdyz hledame zaznam z rozsahu tj. pripojime identifikatory zaznamu a posleme v objektu part_info
	if (($book_most_recent and $book_most_recent->id != $book->id) or $book->{book_id_origin}) {
		my $part_info = undef;
		$book_most_recent = DB->resultset('Book')->find($book->{book_id_origin}) if ($book->{book_id_origin});
		my $bibinfo_most_recent = $book_most_recent->bibinfo;
		$part_info->{book_id} = $book_most_recent->id;
		$part_info->{ean} = $bibinfo_most_recent->ean13 if $bibinfo_most_recent->ean13;
		$part_info->{nbn}  = $bibinfo_most_recent->nbn if $bibinfo_most_recent->nbn;
		$part_info->{oclc} = $bibinfo_most_recent->oclc if $bibinfo_most_recent->oclc;
		$part_info->{part_year} = $bibinfo_most_recent->{part_year} if $bibinfo_most_recent->{part_year};
		$part_info->{part_volume} = $bibinfo_most_recent->{part_volume} if $bibinfo_most_recent->{part_volume};
		$part_info->{part_no} = $bibinfo_most_recent->{part_no} if $bibinfo_most_recent->{part_no};
		$part_info->{part_name} = $bibinfo_most_recent->{part_name} if $bibinfo_most_recent->{part_name};
		$info->{part_info} = $part_info;
	}
	# pokud ma zaznam rodice, pripojime extra identifikatory
	if ($book->get_column('id_parent')) {
		$info->{book_id_parent} = $book->get_column('id_parent');
		my $book_parent = DB->resultset('Book')->find($book->get_column('id_parent'));
		$info->{part_ean_standalone} = $book_parent->ean13 ne $book->ean13 ? 1 : 0;
		$info->{part_nbn_standalone} = $book_parent->nbn ne $book->nbn ? 1 : 0;
		$info->{part_oclc_standalone} = $book_parent->oclc ne $book->oclc ? 1 : 0;
	}

	# 1. Najdi cover
	my $cover = $flag_get_most_recent ? $book_most_recent->get_cover : $book->get_cover; # pripadne najde work->cover
	# $this->{cover} = { url, width, height, [data (ie7+)?] }
	# $this->{thumbnail} = { url, width, height }
	# $this->{generic_thumbnail} = { url, width, height }
	#   DB->resultset('Cover')->find_generic($library,$format) unless($cover);
	if($cover) {
		$info->{cover_thumbnail_url} = $cover->get_thumbnail_url($secure);
		$info->{cover_medium_url}    = $cover->get_cover_url($secure);
		$info->{cover_icon_url}      = $cover->get_icon_url($secure);
	}

	# 2. Najdi TOC
	my $toc = $flag_get_most_recent ? $book_most_recent->get_toc : $book->get_toc; # pripadne najde work->cover
	if($toc) {
		$info->{toc_pdf_url}       = $toc->get_pdf_url($secure);
		$info->{toc_thumbnail_url} = $toc->get_thumbnail_url($secure);
	}
	my $toc_own = $flag_get_most_recent ? undef : $toc;
	$toc_own = $book->get_toc if (!$toc_own and $book->get_toc);
	if ($toc_own) {
		$info->{toc_text_url}      = $toc_own->get_text_url($secure) if $toc_own->get_column('full_text');
	}

	# 3. Backlink
	if($cover) { # or $toc or $review or $neco...) { # jinak nelinkuj..
		$info->{backlink_url}  = $book->get_obalkyknih_url($secure);
	}

	# 4. Hodnoceni
	my($r_sum,$r_count) = $book->get_rating;
	$info->{rating_sum}   = $r_sum;
	$info->{rating_count} = $r_count;
	if($r_count) {
		my $avg = $r_sum / $r_count;
		$info->{rating_avg100} = sprintf("%2.0f",$avg);
		$info->{rating_avg5} = ($avg % 20) ?
				sprintf("%1.1f",$avg/20) : int($avg/20);
		$info->{rating_url} = Obalky::Config->url($secure).'/stars?value='.sprintf("%2.0f",$avg);
	}

	# 5. Recenze
	$info->{reviews} = [];
	if ($params->{review}) {
		my @reviews = $book->get_reviews;
		map {
			my $review = $_->to_info;
			push @{$info->{reviews}}, $review if($review);
		} @reviews;
	}
	
	# 6. Toc fulltext
	if ($params->{toc_full_text}) {
		my $toc_full_text = $book->toc->get_column('full_text') if ($book->toc);
		$info->{toc_full_text} = $toc_full_text if (defined $toc_full_text);
	}
	
	# 7. Priznak holeho zaznamu
	$info->{flag_bare_record} = ($cover or $toc or $r_count or (scalar @{$info->{reviews}} > 0)) ? 0 : 1;

	return $info;
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
