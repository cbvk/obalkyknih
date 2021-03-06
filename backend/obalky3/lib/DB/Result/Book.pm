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

=head2 bib

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

=head2 citation_source

  data_type: 'integer'
  is_nullable: 1

=head2 citation_time

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 metadata_checksum

  data_type: 'char'
  is_nullable: 1
  size: 32

=head2 metadata_change

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 ismn

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 doc_type

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 pomocna

  data_type: 'integer'
  is_nullable: 1

=head2 edition

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 other_relation_text

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
  { data_type => "tinyint", extra => { unsigned => 1 }, is_nullable => 1 },
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
  "bib",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "cached_rating_sum",
  { data_type => "integer", is_nullable => 1 },
  "cached_rating_count",
  { data_type => "integer", is_nullable => 1 },
  "review",
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
  "citation_source",
  { data_type => "integer", is_nullable => 1 },
  "citation_time",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "metadata_checksum",
  { data_type => "char", is_nullable => 1, size => 32 },
  "metadata_change",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "ismn",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "doc_type",
  { data_type => "tinyint", extra => { unsigned => 1 }, is_nullable => 1 },
  "pomocna",
  { data_type => "integer", is_nullable => 1 },
  "edition",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "other_relation_text",
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

=head2 bib

Type: belongs_to

Related object: L<DB::Result::Bib>

=cut

__PACKAGE__->belongs_to(
  "bib",
  "DB::Result::Bib",
  { id => "bib" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 book_relation_book_parents

Type: has_many

Related object: L<DB::Result::BookRelation>

=cut

__PACKAGE__->has_many(
  "book_relation_book_parents",
  "DB::Result::BookRelation",
  { "foreign.book_parent" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 book_relation_book_relations

Type: has_many

Related object: L<DB::Result::BookRelation>

=cut

__PACKAGE__->has_many(
  "book_relation_book_relations",
  "DB::Result::BookRelation",
  { "foreign.book_relation" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 book_relation_suggestions

Type: has_many

Related object: L<DB::Result::BookRelationSuggestion>

=cut

__PACKAGE__->has_many(
  "book_relation_suggestions",
  "DB::Result::BookRelationSuggestion",
  { "foreign.id" => "self.id" },
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

=head2 cover_uncommiteds

Type: has_many

Related object: L<DB::Result::CoverUncommited>

=cut

__PACKAGE__->has_many(
  "cover_uncommiteds",
  "DB::Result::CoverUncommited",
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

=head2 product_params

Type: has_many

Related object: L<DB::Result::ProductParam>

=cut

__PACKAGE__->has_many(
  "product_params",
  "DB::Result::ProductParam",
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


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-03-10 20:27:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nae+PHOaHCSmLdycK1UZ5w

use Obalky::Media;
use Data::Dumper;
use DB;
use List::Util qw( max );
use Encode qw(decode encode);
use Number::Convert::Roman;

sub displayable_products {
	my($book) = @_;
	my @displayable;
	foreach my $product ($book->products) {
		next if ($product->eshop->get_column('type') eq 'kramerius');
		my $factory = $product->eshop->factory;
		push @displayable, $product if($factory->{display});
	}
	return @displayable;
}

sub displayable_dig_obj {
	my($book) = @_;
	my @displayable;
	
	my $products = DB->resultset('Product')->search({ book => $book->id }, { order_by => {-desc=>'ispublic'} });
	foreach my $product ($products->all) {
		my $eshop = $product->eshop;
		push @displayable, $product if($eshop->type eq 'kramerius');
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
}

sub get_toc {
	my($book) = @_;
	my $toc = $book->toc;
	return $toc if($toc); 
}

sub get_bib {
	my($book) = @_;
	my $bib = $book->bib;
	return $bib if($bib); 
}

sub recalc_review {
	my($book) = @_;
	my $best;
	foreach($book->reviews) { # WHERE rating NOT NULL ?
		# zahod ty, ktere nepochazi z knihovny
		next if (not defined $_->library or not defined $_->library_id_review);
		next if (defined $_->status && $_->status == 2);
		# vyber komentare s vyssim impact
		$best = $_ if($_->impact eq $Obalky::Media::REVIEW_ANNOTATION);
		$best = $_ if($_->impact eq $Obalky::Media::REVIEW_REVIEW 
							and not $best);
	}
	my $resBook = DB->resultset('Book')->find($book->id);
	$book->update({ review => $best }) if ($resBook);
}

sub invalidate { # nutno volat po kazde zmene knizky
	my($book,$forced) = @_;
	DB->resultset('FeSync')->book_sync_remove($book->id, undef, $forced);
}

sub recalc_rating {
	my($book) = @_;

	my($rs,$rc,$ers,$erc) = (0,0,0,0);
	foreach($book->reviews) {
		# zahod ty, ktere nepochazi z knihovny
		next if (not defined $_->library or not defined $_->library_id_review);
		next if (defined $_->status && $_->status == 2);
		# napocitej rating
		if(defined $_->rating) {
			if ($_->rating > 0) {
				my $ratingCnt = 1;
				$ratingCnt = $_->cnt if ($_->cnt);
				if($_->product) { $ers += $_->rating; $erc += $ratingCnt; }
						   else { $rs  += $_->rating; $rc += $ratingCnt; }
			}
		}
	}
	# puvodni logika: produktove ma 6 hlasu, pak bude postupne prevazeno
	#if($erc) { $rs += int(6*$ers/$erc); $rc += 6; }
	$rs += $ers;
	$rc += $erc;

	$rc = undef unless($rc);
	$rs = undef unless($rs);
	my $resBook = DB->resultset('Book')->find($book->id);
	$book->update({ cached_rating_sum => $rs, cached_rating_count => $rc }) if ($resBook);
	# $book->invalidate(); # musi volat volajici!
}


sub get_rating {
	my($book) = @_;
	my($rs,$rc) = (0,0);
	$rs += $book->cached_rating_sum || 0;
	$rc += $book->cached_rating_count || 0;
	return ($rs,$rc);
}

sub get_reviews {
	my($book) = @_;
	my $reviews = DB->resultset('Review')->search({ book=>$book->id, impact=>9 }, {
		order_by => { '-desc' => 'created' },
		limit => 200
	});
	my @reviews;
	foreach ($reviews->all) {
		my ($status,$id_review) = ('','');
		$status = $_->get_column('status') if (defined $_->get_column('status')); 
		push @reviews, $_ if ($_->get_column('library_id_review') && $status ne '2' || $status eq '1');
	}
	return @reviews;
}

sub get_annotation {
	my($book) = @_;
	my $reviews = DB->resultset('Review')->search({ book=>$book->id, impact=>0 }, {
		order_by => { '-asc' => 'id' }
	});
	foreach ($reviews->all) {
		my ($status,$id_review) = ('','');
		$status = $_->get_column('status') if (defined $_->get_column('status')); 
		return $_ if ($_->get_column('library_id_review') && $status ne '2' || $status eq '1');
	}
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
	return sprintf("%1.1f",$avg/20);
}
sub is_library_rating { # pouzito ve view
	my($book,$library) = @_;
	my $res = DB->resultset('Review')->search({ book=>$book->id, library=>$library, impact=>8 });
	return $res->next ? 1 : 0;
}

sub get_obalkyknih_url {
	my($book,$secure) = @_;
	my $bibinfo = $book->bibinfo;
	my $idPart;
	$idPart = $book->get_column('id') if ($book->{_column_data}{id_parent});
	return $bibinfo ? $bibinfo->get_obalkyknih_url($secure,$idPart) : undef;
}

sub get_ebook_list {
	my ($book) = @_;
	my @ebook;
	
	# vlastni eknihy
	my $resEbook = $book->get_ebook_list_helper($book->id);
	# pokud se nenajdou vlastni, tak pohledame svazane eknihy
	unless ($resEbook->count()) {
		my $resEbookRelation = DB->resultset('BookRelation')->search({ relation_type=>2, -or=>[{ book_parent=>$book->id }, { book_relation=>$book->id }] });
		my @list_ebook;
		foreach ($resEbookRelation->all) {
			push @list_ebook, $_->get_column('book_parent') if ($book->id != $_->get_column('book_parent'));
			push @list_ebook, $_->get_column('book_relation') if ($book->id != $_->get_column('book_relation'));
		}
		$resEbook = $book->get_ebook_list_helper(@list_ebook);
	}
	if ($resEbook->count()) {
		foreach ($resEbook->all) {
			push @ebook, { type => $_->get_column('param_type'), url => $_->get_column('other_param_value')};
		}
	}
	foreach my $product ($book->products) {
		my $eshop = $product->eshop;
		if(($eshop->type or '') eq 'kramerius' and ($product->ispublic or 0) == 1) {
			push @ebook, { type => 'Digitalizovaný dokument', url => $product->product_url };
			last;
		}
	}
	return \@ebook if (scalar @ebook);
	return undef;
}

sub get_ebook_list_helper {
	my ($book,$id) = @_;
	my $resEbook = DB->resultset('ProductParams')->search({
		book => $id,
		'other_param_type.flag_ebook' => 1
	}, {
		join => ['other_param_type'],
		+select => ['other_param_type.type','me.other_param_value'],
		+as => ['param_type','other_param_value']
	});
	return $resEbook;
}

sub actualize_by_product {
	my($book,$product,$forced) = @_;
	my $invalidate = 0;
	
	# pokud se neco zmenilo, je potreba zaznam zneplatnit a pozadat taky FE o zneplatneni
	$invalidate = ($book->cover->id!=$product->cover->id) ? 1 : 0 if ($book->cover and $product->cover);
	$invalidate = ($book->toc->id!=$product->toc->id) ? 1 : $invalidate if ($book->toc and $product->toc);
	$invalidate = ($book->bib->id!=$product->bib->id) ? 1 : $invalidate if ($book->bib and $product->bib);
	
	my ($oldPriority,$newPriority,$oldDim,$newDim) = (0,0,0,1); #init
	my $eshopId = $product->eshop->get_column('id');
	if ($book && $book->cover && $product && $product->cover) {
		my $resOldP = DB->resultset('Product')->search({ book=>$book->id, cover=>$book->cover->id });
		my $retOldP = $resOldP->next;
		$oldPriority = $retOldP->eshop->get_column('priority') if ($retOldP);
		$newPriority = $product->eshop->get_column('priority');
		$newPriority = 9999 if ($ENV{IGNOREQUALITY});
		$oldDim = $retOldP->cover->get_column('orig_width') * $retOldP->cover->get_column('orig_height') if ($retOldP);
		$newDim = $product->cover->get_column('orig_width') * $product->cover->get_column('orig_height');
	}
	# RIZENI PRIORITY (PRIORITA AKTIVNI OBALKY)
	# Zmena aktivni obalky produktu (kniha muze mit vice produktu, a kazdy produkt svoji obalku, ale pouze jedna aktivni)
	# 1) ma zdroj vyssiu prioritu
	# 2) ma stejnu prioritu, ale vyssi rozliseni
	if (($newPriority > $oldPriority) || (($newPriority == $oldPriority) && ($newDim > $oldDim))) {
		warn 'ZMENA AKTIVNI OBALKY NA ZAKLADE PRIORITY ...' if ($ENV{DEBUG});		
		$book->update({ cover => $product->cover })   if($product->cover);
		$book->update({ toc => $product->toc })       if($product->toc);
		$book->update({ bib => $product->bib })       if($product->bib);
	} else {
		warn 'AKTIVNI OBALKA BEZE ZMENY ...' if ($ENV{DEBUG});
	}
#	$book->update({ review => $product->review }) if($product->review);

	$book->recalc_rating;
	$book->invalidate($forced) if ($invalidate or $forced);

#	my($sum,$count) = @_;
#	$book->update({ external_sum => $product->review }) if($product->review);
}

sub add_review {
	my($book,$library,$visitor,$info) = @_;
	die unless($visitor);
    my $review = DB->resultset('Review')->create({
			book => $book->id, rating => $info->{rating},
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

sub get_editions {
	my ($book) = @_;
	my $numconv = Number::Convert::Roman->new;
	my $ed = {}; # hash edici
	my $edPosibleNum = {}; # hash s vyskytem cisla
	my $noNumPlaceholder = 9000; # cislo, ktere bude pouzito pro serazeni, pokud se nenajde v retezci zadne
	my @relBooks;
	
	# seznam unikatnich book id
	my $rel = DB->resultset('BookRelation')->search({ -or=>[{ book_parent=>$book->id }, { book_relation=>$book->id }] });
	foreach ($rel->all) {
		next if ($_->get_column('relation_type') != 3);
		my $id = $_->get_column('book_parent');
		push @relBooks, $id unless ($id == $book->id or $id ~~ @relBooks);
		$id = $_->get_column('book_relation');
		push @relBooks, $id unless ($id == $book->id or $id ~~ @relBooks);
	}
	
	# vysledne pole edici
	foreach (@relBooks) {
		my $relBook = DB->resultset('Book')->find($_);
		next unless($relBook);
		my $edText = $relBook->get_column('edition');
		next if (not defined $edText or $edText eq '');
		# prevod latinskych cisel na arabske
		my $edTextNormalizedRoman = $edText;
		foreach my $arabicNumber (reverse 1 .. 100) {
			next if ($arabicNumber == 10 or $arabicNumber == 5);
			my $romanNumber = $numconv->roman($arabicNumber);
			$edTextNormalizedRoman =~ s/$romanNumber/$arabicNumber/;
		}
		$edTextNormalizedRoman =~ s/X/10/; $edTextNormalizedRoman =~ s/V/5/;
		my $edNormalized = DB->resultset('Book')->normalize_part($edTextNormalizedRoman);
		if (defined $ed->{$edNormalized}) {
			push @{$ed->{$edNormalized}->{'other'}}, $relBook->id;
		} else {
			$ed->{$edNormalized} = {
				'book' => $relBook,
				'text' => $edText,
				'other' => []
			};
			my ($num) = $edNormalized =~ /(\d+)/;
			# nasli jsme cislo
			if (defined $num) {
				$num = substr('0000'.$num, -4);
				$edPosibleNum->{$num} = $edNormalized;
			} else {
				$edPosibleNum->{$noNumPlaceholder} = $edNormalized;
				$noNumPlaceholder++;
			}
		}
	}
	
	# serad podle vyskytu cisel v retezci
	my @edSorted;
	foreach (sort keys %{$edPosibleNum}) {
		my $key = $edPosibleNum->{$_};
		push @edSorted, $ed->{$key};
	}
	
	return \@edSorted if (scalar @edSorted);
	return undef;
}

sub get_other_relations {
	my ($book) = @_;
	my $numconv = Number::Convert::Roman->new;
	my $rel = {}; # hash edici
	my $relPosibleNum = {}; # hash s vyskytem cisla
	my $noNumPlaceholder = 9000; # cislo, ktere bude pouzito pro serazeni, pokud se nenajde v retezci zadne
	my @relBooks;
	
	# vyhledame koren stromu zavislosti
	# ale pouze pro typ = 9 (jine casti dila)
	my $resRelRoot = DB->resultset('BookRelation')->search({ book_relation=>$book->id, relation_type=>9 });
	my $retRelRoot = $resRelRoot->next;
	# vyhledame dokumenty na ktere ma vazbu + dalsi se stejnym parentem 
	my $resRel;
	if ($retRelRoot) {
		$resRel = DB->resultset('BookRelation')->search({ -or => [{ book_parent=>[$book->id, $retRelRoot->get_column('book_parent')]}, { book_relation=>$book->id }] });
	} else {
		$resRel = DB->resultset('BookRelation')->search({ -or => [{ book_parent=>$book->id }, { book_relation=>$book->id }] });
	}
	foreach ($resRel->all) {
		next if ($_->get_column('relation_type') != 4 and $_->get_column('relation_type') != 9);
		my $id = $_->get_column('book_parent');
		push @relBooks, $id unless ($id == $book->id or $id ~~ @relBooks);
		$id = $_->get_column('book_relation');
		push @relBooks, $id unless ($id == $book->id or $id ~~ @relBooks);
	}

	# vysledne pole relaci
	foreach (@relBooks) {
		my $relBook = DB->resultset('Book')->find($_);
		next unless($relBook);
		my $edText = $relBook->get_column('other_relation_text');
		$edText = $relBook->get_column('part_note') if (not defined $edText or $edText eq '');
		next if (not defined $edText or $edText eq '');
		# prevod latinskych cisel na arabske
		my $edTextNormalizedRoman = $edText;
		# priprava, odstraneni nerimskych slov
		$edTextNormalizedRoman =~ s/[[:punct:]]/ /g;
		my @words = split(' ', $edTextNormalizedRoman);
		foreach my $word (@words) {
			# word bude puvodni slovo, wordWoRoman budeme upravovat
			my $wordWoRoman = $word;
			# odstranit rimske znaky
			$wordWoRoman =~ s/[cdilmvx]//ig;
			# pokud zustal jeste nejaky 
			$edTextNormalizedRoman =~ s/$word//g if $wordWoRoman =~ /[a-z]/ig;
		}
		foreach my $arabicNumber (reverse 1 .. 100) {
			next if ($arabicNumber == 10 or $arabicNumber == 5);
			my $romanNumber = $numconv->roman($arabicNumber);
			$edTextNormalizedRoman =~ s/$romanNumber/$arabicNumber/;
		}
		$edTextNormalizedRoman =~ s/X/10/; $edTextNormalizedRoman =~ s/V/5/;
		my $relNormalized = DB->resultset('Book')->normalize_part($edTextNormalizedRoman);
		$relNormalized = $edText unless($relNormalized); # pokud neni podle ceho ciselne seradit
		if (defined $rel->{$relNormalized}) {
			push @{$rel->{$relNormalized}->{'other'}}, $relBook->id;
		} else {
			$rel->{$relNormalized} = {
				'book' => $relBook,
				'text' => $edText,
				'other' => []
			};
			my ($num) = $relNormalized =~ /(\d+)/;
			# nasli jsme cislo
			if (defined $num) {
				$num = substr('0000'.$num, -4);
				$relPosibleNum->{$num} = $relNormalized;
			} else {
				$relPosibleNum->{$noNumPlaceholder} = $relNormalized;
				$noNumPlaceholder++;
			}
		}
	}
	
	# serad podle vyskytu cisel v retezci
	my @relSorted;
	foreach (sort keys %{$relPosibleNum}) {
		my $key = $relPosibleNum->{$_};
		push @relSorted, $rel->{$key};
		# jine tituly, ktere normalizovalo na stejne cislo
		if (scalar $rel->{$key}->{other}) {
			foreach (@{$rel->{$key}->{other}}) {
				my $relBook = DB->resultset('Book')->find($_);
				my $edText = $relBook->get_column('other_relation_text');
				$edText = $relBook->get_column('part_note') if (not defined $edText or $edText eq '');
				next if (not defined $edText or $edText eq '');
				push @relSorted, {
					'book' => $relBook,
					'text' => $edText,
					'other' => []
				};
			}
		}
	}
	
	return \@relSorted if (scalar @relSorted);
	return undef;
}

sub get_most_recent {
	my($book) = @_;
	return $book unless ($book->id);
	return $book if ($book->id eq $book->get_column('id_parent'));
	
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
			next if ($cur_year > $year+1900+1); # stavaji se preklepy a ze skenovaciho klienta prijde rok vyssi nez aktualni, takove zaznamy ignorovat
			$max_year = $cur_year unless($max_year);
			$max_volume = $cur_volume unless($max_volume);
			if ($cur_year && $cur_volume && !$eq_year) { # nalezly jsme zaznam s parem rok/rocnik
				$eq_year = $cur_year;
				$eq_volume = $cur_volume;
			}
			$max_volume = $max_volume<$cur_volume ? $cur_volume : $max_volume if ($max_volume and $cur_volume);
			
			# uloz hodnotu part_no (pozdeji se bude podle toho vyhledavat aktualni cislo)
			$cur_no = 0 unless ($cur_no);
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
			# zneplatnit nejnovejsi obalku podle rocniku, pokud vime, ze existuji cisla s vyssim rokem vydani
			$max_part_no_by_volume = 0 if ($eq_year == $vol_to_year and $eq_year < $max_year);
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
	my($book,$info,$library,$bibinfo,$secure,$params) = @_;
	
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
		$flag_get_most_recent = 0 if ($child_book->part_type==1 && ($book->cover || $book->toc || $book->bib)); # souborny zaznam monografie pokud nema vlastni obalku
	}
	
	# vyhledani nejnovejsiho cisla k soubornemu zaznamu, pokud je nutne
	my $book_most_recent = undef;
	warn 'THIS IS UNION RECORD. Latest book part will be searched for.' if ($ENV{DEBUG} and $flag_get_most_recent);
	$book_most_recent = $book->get_most_recent if ($flag_get_most_recent);
	warn 'Found most recent child '.$book->id.' of requested book '.$book_most_recent->id."\n" if ($ENV{DEBUG} and $book_most_recent and $book->id!=$book_most_recent->id);
	
	# aktualizuj book bibinfo (OCLC, title,...)
	my $book_bibinfo = $book->bibinfo;
	my $tmp_bibinfo = $book->bibinfo;
	if(!$child_book and $book_bibinfo->merge($bibinfo)) {
		$tmp_bibinfo->{part_year} = undef; $tmp_bibinfo->{part_volume} = undef; $tmp_bibinfo->{part_no} = undef;
		$tmp_bibinfo->save_to($book);
		$book->invalidate;
	}

	$info->{book_id} = $book->id;
	$info->{ean} = $book_bibinfo->ean13 if $book_bibinfo->ean13;
	$info->{nbn} = $book_bibinfo->nbn if $book_bibinfo->nbn;
	$info->{ismn} = $book_bibinfo->ismn if $book_bibinfo->ismn;
	$info->{oclc} = $book_bibinfo->oclc if $book_bibinfo->oclc;
	$info->{part_year} = $book_bibinfo->{part_year}     if ($book_bibinfo->{part_year} and $book->get_column('part_year'));
	$info->{part_volume} = $book_bibinfo->{part_volume} if ($book_bibinfo->{part_volume} and $book->get_column('part_volume'));
	$info->{part_no} = $book_bibinfo->{part_no}         if ($book_bibinfo->{part_no} and $book->get_column('part_no'));
	$info->{part_name} = $book_bibinfo->{part_name}     if ($book_bibinfo->{part_name} and $book->get_column('part_name'));
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
		$part_info->{nbn} = $bibinfo_most_recent->nbn if $bibinfo_most_recent->nbn;
		$part_info->{ismn} = $bibinfo_most_recent->ismn if $bibinfo_most_recent->ismn;
		$part_info->{oclc} = $bibinfo_most_recent->oclc if $bibinfo_most_recent->oclc;
		$part_info->{part_year} = $bibinfo_most_recent->{part_year} if $bibinfo_most_recent->{part_year};
		$part_info->{part_volume} = $bibinfo_most_recent->{part_volume} if $bibinfo_most_recent->{part_volume};
		$part_info->{part_no} = $bibinfo_most_recent->{part_no} if $bibinfo_most_recent->{part_no};
		$part_info->{part_name} = $bibinfo_most_recent->{part_name} if $bibinfo_most_recent->{part_name};
		$info->{part_info} = $part_info;
	}
	# pokud ma zaznam rodice, pripojime extra identifikatory
	my $idf_backlink;
	my @book_range_ids;
	if ($book->get_column('id_parent')) {
		$info->{book_id_parent} = $book->get_column('id_parent');
		my $book_parent = DB->resultset('Book')->find($book->get_column('id_parent'));
		if ($book_parent) {
			# inicializace kodu rodice (pokud neexistuji a nalezeny dil ma dany identifikator, stale muze byt jako part_standalone)
			my ($bookParentEan13, $bookParentNbn, $bookParentIsmn, $bookParentOclc) = ('','','','');
			# naplneni identifikatoru rodice, pokud existuji
			$bookParentEan13 = $book_parent->ean13 if ($book_parent->ean13);
			$bookParentNbn   = $book_parent->nbn if ($book_parent->nbn);
			$bookParentIsmn  = $book_parent->ismn if ($book_parent->ismn);
			$bookParentOclc  = $book_parent->oclc if ($book_parent->oclc);
			$info->{part_ean_standalone} = $book_parent->ean13 ne $book->ean13 ? 1 : 0 if ($book->ean13);
			$info->{part_nbn_standalone} = $book_parent->nbn ne $book->nbn ? 1 : 0 if ($book->nbn);
			$info->{part_ismn_standalone} = $book_parent->ismn ne $book->ismn ? 1 : 0 if ($book->ismn);
			$info->{part_oclc_standalone} = $book_parent->oclc ne $book->oclc ? 1 : 0 if ($book->oclc);
			# byl vyhledan rozsah; vytvorime odkaz, ktery zobrazi pouze vyhledane zaznamy
			if ($book->{_column_data}{book_range_ids} && ($info->{part_year} || $info->{part_volume} || $info->{part_no})) {
				$idf_backlink = 'http://www.obalkyknih.cz/view?book_id='.$book_parent->id.'&sort_by=date&idf=' . join(',', @{$book->get_column('book_range_ids')});
				@book_range_ids = @{$book->get_column('book_range_ids')};
			}
		}
	}

	# 1. Najdi cover
	my $cover = $flag_get_most_recent ? $book_most_recent->get_cover : $book->get_cover;
	# $this->{cover} = { url, width, height, [data (ie7+)?] }
	# $this->{thumbnail} = { url, width, height }
	# $this->{generic_thumbnail} = { url, width, height }
	#   DB->resultset('Cover')->find_generic($library,$format) unless($cover);
	if($cover) {
		$info->{cover_thumbnail_url} = $cover->get_thumbnail_url($secure);
		$info->{cover_medium_url}    = $cover->get_cover_url($secure);
		$info->{cover_icon_url}      = $cover->get_icon_url($secure);
		# publikovat originalni rozmery obrazku
		if ($cover->orig_width and $cover->orig_height) {
			$info->{orig_width}      = $cover->orig_width;
			$info->{orig_height}     = $cover->orig_height;
		}
		$info->{cover_preview510_url}= $cover->get_preview510_url($secure);
	}

	# 2a. Najdi TOC
	my $toc = $flag_get_most_recent ? $book_most_recent->get_toc : $book->get_toc;
	if($toc) {
		$info->{toc_pdf_url}       = $toc->get_pdf_url($secure) unless ($idf_backlink);
		$info->{toc_pdf_url}       = $idf_backlink if ($idf_backlink);
		$info->{toc_thumbnail_url} = $toc->get_thumbnail_url($secure);
	}
	my $toc_own = $flag_get_most_recent ? undef : $toc;
	$toc_own = $book->get_toc if (!$toc_own and $book->get_toc);
	if ($toc_own and !$flag_get_most_recent) {
		$info->{toc_text_url}      = $toc_own->get_text_url($secure) if $toc_own->get_column('full_text');
	}
	
	# 2b. Najdi BIB
	my $bib = $flag_get_most_recent ? $book_most_recent->get_bib : $book->get_bib;
	if($bib) {
		$info->{bib_pdf_url}       = $bib->get_pdf_url($secure) unless ($idf_backlink);
		$info->{bib_pdf_url}       = $idf_backlink if ($idf_backlink);
		$info->{bib_thumbnail_url} = $bib->get_thumbnail_url($secure);
	}
	my $bib_own = $flag_get_most_recent ? undef : $bib;
	$bib_own = $book->get_bib if (!$bib_own and $book->get_bib);
	if ($bib_own and !$flag_get_most_recent) {
		$info->{bib_text_url}      = $bib_own->get_text_url($secure) if $bib_own->get_column('full_text');
	}

	# 3. Backlink
	if($cover) {
		$info->{backlink_url}  = $book->get_obalkyknih_url($secure) unless ($idf_backlink);
		$info->{backlink_url}  = $idf_backlink if ($idf_backlink);
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
	if ($params->{review}) { # $params->{review} je priznak z URL dotazu
		my @reviews = $book->get_reviews;
		map {
			my $review = $_->to_info;
			push @{$info->{reviews}}, $review if($review);
		} @reviews;
	}
	
	# 6a. TOC fulltext
	if ($params->{toc_full_text} and !$book->{_column_data}{book_range_ids} and !$flag_get_most_recent) {
		my $toc_full_text = $book->toc->get_column('full_text') if ($book->toc);
		$info->{toc_full_text} = $toc_full_text if (defined $toc_full_text);
	}
	# byl vyhledan rozsah; spojime TOC fulltext ze vsech vyhledanych casti
	if ($params->{toc_full_text} and $book->{_column_data}{book_range_ids}) {
		my $range_full_text;
		map {
			$range_full_text .= " ".$_->toc->get_column('full_text') if ($_->toc and $_->toc->get_column('full_text'));
		} DB->resultset('Book')->search({ id => $book->get_column('book_range_ids') });
		$info->{toc_full_text} = $range_full_text;
	}
	
	# 6b. BIB fulltext
	if ($params->{toc_full_text} and !$book->{_column_data}{book_range_ids} and !$flag_get_most_recent) {
		my $bib_full_text = $book->bib->get_column('full_text') if ($book->bib);
		$info->{bib_full_text} = $bib_full_text if (defined $bib_full_text);
	}
	# byl vyhledan rozsah; spojime TOC fulltext ze vsech vyhledanych casti
	if ($params->{toc_full_text} and $book->{_column_data}{book_range_ids}) {
		my $range_full_text;
		map {
			$range_full_text .= " ".$_->bib->get_column('full_text') if ($_->bib and $_->bib->get_column('full_text'));
		} DB->resultset('Book')->search({ id => $book->get_column('book_range_ids') });
		$info->{bib_full_text} = $range_full_text;
	}
	
	# 7. Priznak holeho zaznamu
	$info->{flag_bare_record} = ($cover or $toc or $bib or $r_count or (scalar @{$info->{reviews}} > 0)) ? 0 : 1;
	
	# 8. Anotace
	if ($params->{review}) { # $params->{review} je priznak z URL dotazu
		my @annotations = $book->get_annotation;
		$info->{annotation} = $annotations[0]->to_annotation_info if ($annotations[0]);
	}
	
	# 9. Bibliograficke data
	$info->{bib_title} = $book->get_column('title') if ($book->get_column('title'));
	$info->{bib_author} = $book->get_column('authors') if ($book->get_column('authors'));
	$info->{bib_year} = $book->get_column('year') if ($book->get_column('year'));
	
	# 10. UUID (Kramerius); UUID existuje u produktu, do zaznamu knihy se musi poslat pole UUID
	my $resUUID = DB->resultset('Product')->search({ book => $book->id });
	my @uuid; my $uuidLib;
	while (my $rowUUID = $resUUID->next) {
		if ($rowUUID->get_column('uuid')) {
			my $uuid = $rowUUID->get_column('uuid');
			push @uuid, $uuid if (not grep(/^$uuid$/, @uuid));
			if ($rowUUID->eshop and $rowUUID->eshop->library) {
				my $libsigla = $rowUUID->eshop->library->get_column('code');
				$uuidLib->{$libsigla}->{uuid} = $uuid;
				$uuidLib->{$libsigla}->{public} = $rowUUID->get_column('ispublic') || 0;
				$uuidLib->{$libsigla}->{url} = $rowUUID->get_column('product_url');
				$uuidLib->{$libsigla}->{library} = $rowUUID->eshop->get_column('fullname');
				$uuidLib->{$libsigla}->{logo} = $rowUUID->eshop->get_column('logo_url');
			}
		}
	}
	$info->{uuid} = \@uuid if (@uuid);
	$info->{dig_obj} = $uuidLib if ($uuidLib);
	
	# 11. Citace CSN ISO 690
	if ($book->get_column('citation_source') and $book->get_column('citation_time') and $book->get_column('citation') and $book->get_column('citation') ne '' and $book->get_column('citation_source') ne '') {
		my $dt = $book->get_column('citation_time');
		$info->{csn_iso_690} = $book->get_column('citation');
		#$info->{csn_iso_690_source} = $book->citation_source->get_column('fullname').' '.substr($dt,8,2).'.'.substr($dt,5,2).'.'.substr($dt,0,4);
		$info->{csn_iso_690_source} = substr($dt,8,2).'.'.substr($dt,5,2).'.'.substr($dt,0,4);
	}
	
	# 12. spolupracujeme s
	$info->{cooperating_with} = 'https://www.cbdb.cz|CBDB.cz' if ($book->is_library_rating(51214));
	
	# 13. pocet podrizenych zaznamu s obalkou, toc a bib
	my $succ_books_statement;
	if (@book_range_ids) {
		$succ_books_statement = { id => \@book_range_ids };
	} else {
		$succ_books_statement = { id_parent => $book->id };
	}
	my $resSucc = DB->resultset('Book')->search($succ_books_statement, {
		'+select' => [ \'COUNT(DISTINCT cover)', \'COUNT(DISTINCT toc)', \'COUNT(DISTINCT bib)'],
		'+as' => [ 'cover', 'toc', 'bib' ]
	})->next;
	my ($cnt_succ_cover, $cnt_succ_toc, $cnt_succ_bib) = (0, 0, 0);
	$cnt_succ_cover = $resSucc->get_column('cover') if ($resSucc);
	$cnt_succ_toc = $resSucc->get_column('toc') if ($resSucc);
	$cnt_succ_bib = $resSucc->get_column('bib') if ($resSucc);
	$info->{succ_cover_count} = $cnt_succ_cover;
	$info->{succ_toc_count} = $cnt_succ_toc;
	$info->{succ_bib_count} = $cnt_succ_bib;
	
	# 14. vazby e-book
	my $ebook = $book->get_ebook_list;
	$info->{ebook} = $ebook if (defined $ebook);
	
	# 15. ostatni parametry EAN, NBN, OCLC - PRODUCT PARAMS
	my $retParams = DB->resultset('ProductParams')->search({ book => $book->id });
	$info->{ean_other} = [];
	$info->{nbn_other} = [];
	$info->{oclc_other} = [];
	my $parValue;
	while (my $otherParams = $retParams->next) {
		# EAN_OTHER
		if ($otherParams->get_column('ean13')) {
			$parValue = $otherParams->get_column('ean13');
			if (not grep(/^$parValue$/, @{$info->{ean_other}} ) ) {
				push @{$info->{ean_other}}, $parValue;
			}
		}
		# NBN_OTHER
		if ($otherParams->get_column('nbn')) {
			$parValue = $otherParams->get_column('nbn');
			if (not grep(/^$parValue$/, @{$info->{nbn_other}} ) ) {
				push @{$info->{nbn_other}}, $parValue;
			}
		}
		# OCLC_OTHER
		if ($otherParams->get_column('oclc')) {
			$parValue = $otherParams->get_column('oclc');
			if (not grep(/^$parValue$/, @{$info->{oclc_other}} ) ) {
				push @{$info->{oclc_other}}, $parValue;
			}
		}
	}
	
	# 16. ostatni parametry EAN, NBN, OCLC - IDENT
	$retParams = DB->resultset('Ident')->search({ book => $book->id });
	while (my $otherParams = $retParams->next) {
		# EAN_OTHER
		if ($otherParams->get_column('type') == 1) {
			$parValue = $otherParams->get_column('val');
			if (not grep(/^$parValue$/, @{$info->{ean_other}} ) ) {
				push @{$info->{ean_other}}, $parValue;
			}
		}
		# NBN_OTHER
		if ($otherParams->get_column('type') == 3) {
			$parValue = $otherParams->get_column('val');
			if (not grep(/^$parValue$/, @{$info->{nbn_other}} ) ) {
				push @{$info->{nbn_other}}, $parValue;
			}
		}
		# OCLC_OTHER
		if ($otherParams->get_column('type') == 2) {
			$parValue = $otherParams->get_column('val');
			if (not grep(/^$parValue$/, @{$info->{oclc_other}} ) ) {
				push @{$info->{oclc_other}}, $parValue;
			}
		}
	}
	
	# 17. dalsi vydani
	if (defined $book) {
		my $ed = $book->get_editions();
		my @edRes;
		foreach my $item (@{$ed}) {
			my $edBook = $item->{'book'};
			my $edItem = {
				'edition' => $item->{'text'},
				'book_id' => $edBook->id
			};
			$edItem->{'ean'} = $edBook->get_column('ean13') if $edBook->get_column('ean13');
			$edItem->{'nbn'} = $edBook->get_column('nbn') if $edBook->get_column('nbn');
			$edItem->{'oclc'} = $edBook->get_column('oclc') if $edBook->get_column('oclc');
			push @edRes, $edItem;
		}
		$info->{other_editions} = \@edRes if (@edRes);
	}
	
	# 18. ostatni relace
	if (defined $book) {
		my $otherRel = $book->get_other_relations();
		my @otherRelRes;
		foreach my $item (@{$otherRel}) {
			my $otherRelBook = $item->{'book'};
			my $otherRelItem = {
				'edition' => $item->{'text'},
				'book_id' => $otherRelBook->id
			};
			$otherRelItem->{'ean'} = $otherRelBook->get_column('ean13') if $otherRelBook->get_column('ean13');
			$otherRelItem->{'nbn'} = $otherRelBook->get_column('nbn') if $otherRelBook->get_column('nbn');
			$otherRelItem->{'oclc'} = $otherRelBook->get_column('oclc') if $otherRelBook->get_column('oclc');
			push @otherRelRes, $otherRelItem;
		}
		$info->{other_relations} = \@otherRelRes if (@otherRelRes);
	}
	
	return $info;
}

sub get_ident {
	my ($book) = @_;
	my %resValid;
	my %resInvalid;
	# identifikatory z tabulky ident
	my $resIdent = DB->resultset('Ident')->search({ book => $book->id });
	while (my $row = $resIdent->next) {
		my $type = $row->get_column('type');
		my $val = $row->get_column('val');
		if ($row->get_column('deny') == 0) {
			push @{$resValid{$type}}, $val;
		} else {
			push @{$resInvalid{$type}}, $val;
		}
	}
	return (%resValid, %resInvalid);
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
