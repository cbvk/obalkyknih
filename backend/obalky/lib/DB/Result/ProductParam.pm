use utf8;
package DB::Result::ProductParam;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::ProductParam

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

=head1 TABLE: C<product_params>

=cut

__PACKAGE__->table("product_params");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 book

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 product

  data_type: 'integer'
  is_foreign_key: 1
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

=head2 other_param_type

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

=head2 other_param_value

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "book",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "product",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "ean13",
  { data_type => "char", is_nullable => 1, size => 13 },
  "oclc",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "nbn",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "other_param_type",
  {
    data_type => "tinyint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  "other_param_value",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 book

Type: belongs_to

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->belongs_to(
  "book",
  "DB::Result::Book",
  { id => "book" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 other_param_type

Type: belongs_to

Related object: L<DB::Result::ProductParamsType>

=cut

__PACKAGE__->belongs_to(
  "other_param_type",
  "DB::Result::ProductParamsType",
  { id => "other_param_type" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 product

Type: belongs_to

Related object: L<DB::Result::Product>

=cut

__PACKAGE__->belongs_to(
  "product",
  "DB::Result::Product",
  { id => "product" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2017-06-23 17:45:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:O1XJZGEDgB56pFg3DmVohA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
