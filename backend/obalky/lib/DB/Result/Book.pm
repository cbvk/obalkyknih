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

  data_type: 'integer'
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

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
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
  { data_type => "integer", is_nullable => 1 },
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


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-08-01 15:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:H26Xl3otuCr2AxfHRgdhtA

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
		$best = $_ if($_->impact eq $Obalky::Media::REVIEW_ANNOTATION);
		$best = $_ if($_->impact eq $Obalky::Media::REVIEW_REVIEW 
							and not $best);
	}
	$book->update({ review => $best });
	# $book->invalidate(); # musi volat volajici!
}

sub invalidate { # nutno volat po kazde zmene knizky
	my($book) = @_;
	DB->resultset('Cache')->invalidate($book);
}

sub recalc_rating {
	my($book) = @_;

	my($rs,$rc,$ers,$erc) = (0,0,0,0);
	foreach($book->reviews) { # WHERE rating NOT NULL ?
		if(defined $_->rating) {
			if ($_->rating > 0) {
				if($_->product) { $ers += $_->rating; $erc++ }
						   else { $rs  += $_->rating; $rc++ }
			}
		}
	}
	# logika: produktove ma 6 hlasu, pak bude postupne prevazeno
	if($erc) { $rs += int(6*$ers/$erc); $rc += 6; }

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
	my $reviews = DB->resultset('Review')->search({ book=>@book_ids }, {
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
	my($book,$product) = @_;
	$book->update({ cover => $product->cover })   if($product->cover);
	$book->update({ toc => $product->toc })       if($product->toc);
#	$book->update({ review => $product->review }) if($product->review);

	$book->recalc_rating;
	$book->invalidate();

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

# --------------------------------------------------------------

sub enrich {
	my($book,$info,$library,$permalink,$bibinfo,$secure,$params) = @_;

	# aktualizuj book bibinfo (OCLC, title,...) (strcit to do Marc::..?)
	my $book_bibinfo = $book->bibinfo;
	if($book_bibinfo->merge($bibinfo)) {
		$book_bibinfo->save_to($book);
		$book->invalidate;
	}
#	$bibinfo->save_to($book);

	$info->{book_id} = $book->id;
	$info->{ean} = $book_bibinfo->ean13 if $book_bibinfo->ean13;
	$info->{nbn}  = $book_bibinfo->nbn if $book_bibinfo->nbn;
	$info->{oclc} = $book_bibinfo->oclc if $book_bibinfo->oclc;

	# 1. Najdi cover
	my $cover = $book->get_cover; # pripadne najde work->cover
	# $this->{cover} = { url, width, height, [data (ie7+)?] }
	# $this->{thumbnail} = { url, width, height }
	# $this->{generic_thumbnail} = { url, width, height }
	#   DB->resultset('Cover')->find_generic($library,$format) unless($cover);
	if($cover) {
		$info->{cover_thumbnail_url} = $cover->get_thumbnail_url($secure);
		$info->{cover_medium_url}    = $cover->get_cover_url($secure);
		$info->{cover_icon_url}      = $cover->get_icon_url($secure);
		# jeste rozmery
	}

	# 2. Najdi TOC
	my $toc = $book->get_toc; # pripadne najde work->cover
	if($toc) {
		$info->{toc_pdf_url}       = $toc->get_pdf_url($secure);
		$info->{toc_thumbnail_url} = $toc->get_thumbnail_url($secure);
		$info->{toc_text_url}      = $toc->get_text_url($secure) if $toc->get_column('full_text');
		# jeste rozmery
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
		$info->{toc_full_text} = '';
		$info->{toc_full_text} = $book->toc->get_column('full_text') if ($book->toc);
	}

	return $info;
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
