package DB::Result::Product;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

DB::Result::Product

=cut

__PACKAGE__->table("product");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 eshop

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 book

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 modified

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
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
  size: 32

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

=head2 price_vat

  data_type: 'decimal'
  is_nullable: 1
  size: [5,2]

=head2 price_cur

  data_type: 'char'
  is_nullable: 1
  size: 3

=head2 cover

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 cover_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 toc

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 product_url

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "eshop",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "book",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "modified",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "ean13",
  { data_type => "char", is_nullable => 1, size => 13 },
  "oclc",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "nbn",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "authors",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "year",
  { data_type => "integer", is_nullable => 1 },
  "price_vat",
  { data_type => "decimal", is_nullable => 1, size => [5, 2] },
  "price_cur",
  { data_type => "char", is_nullable => 1, size => 3 },
  "cover",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "cover_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "toc",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "product_url",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("product_eshop_book", ["eshop", "book"]);
__PACKAGE__->add_unique_constraint("product_product_url", ["product_url"]);

=head1 RELATIONS

=head2 cover

Type: might_have

Related object: L<DB::Result::Cover>

=cut

__PACKAGE__->might_have(
  "cover",
  "DB::Result::Cover",
  { "foreign.product" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 eshop

Type: belongs_to

Related object: L<DB::Result::Eshop>

=cut

__PACKAGE__->belongs_to(
  "eshop",
  "DB::Result::Eshop",
  { id => "eshop" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 book

Type: belongs_to

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->belongs_to(
  "book",
  "DB::Result::Book",
  { id => "book" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
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
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
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
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 reviews

Type: has_many

Related object: L<DB::Result::Review>

=cut

__PACKAGE__->has_many(
  "reviews",
  "DB::Result::Review",
  { "foreign.product" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 toc

Type: might_have

Related object: L<DB::Result::Toc>

=cut

__PACKAGE__->might_have(
  "toc",
  "DB::Result::Toc",
  { "foreign.product" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 uploads

Type: has_many

Related object: L<DB::Result::Upload>

=cut

__PACKAGE__->has_many(
  "uploads",
  "DB::Result::Upload",
  { "foreign.product" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-11-27 06:34:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1FRFhvUvdBZP03NnEXaPCQ

use utf8;

sub media { Obalky::Media->new(shift) }

sub price_human { shift->media->price_human }


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
