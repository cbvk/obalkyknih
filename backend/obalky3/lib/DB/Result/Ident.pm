use utf8;
package DB::Result::Ident;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Ident

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

=head1 TABLE: C<ident>

=cut

__PACKAGE__->table("ident");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 book

  data_type: 'integer'
  is_nullable: 1

=head2 product

  data_type: 'integer'
  is_nullable: 1

=head2 val

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 type

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 deny

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 info

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "book",
  { data_type => "integer", is_nullable => 1 },
  "product",
  { data_type => "integer", is_nullable => 1 },
  "val",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "type",
  { data_type => "tinyint", extra => { unsigned => 1 }, is_nullable => 0 },
  "deny",
  {
    data_type => "tinyint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "info",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-05-11 13:09:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:i1eMo6i3gG3Kx2Ueldnq2A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
