use utf8;
package DB::Result::ProductParamsType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::ProductParamsType

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

=head1 TABLE: C<product_params_type>

=cut

__PACKAGE__->table("product_params_type");

=head1 ACCESSORS

=head2 id

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 type

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 description

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 flag_ebook

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "tinyint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "type",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "description",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "flag_ebook",
  {
    data_type => "tinyint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 product_params

Type: has_many

Related object: L<DB::Result::ProductParam>

=cut

__PACKAGE__->has_many(
  "product_params",
  "DB::Result::ProductParam",
  { "foreign.other_param_type" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2017-06-23 17:45:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6dZ/NPFpuVQXO3UKu3EM6w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
