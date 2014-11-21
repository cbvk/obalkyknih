use utf8;
package DB::Result::FeSyncParam;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::FeSyncParam - Params for sync event

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

=head1 TABLE: C<fe_sync_param>

=cut

__PACKAGE__->table("fe_sync_param");

=head1 ACCESSORS

=head2 id

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 param_name

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 param_value

  data_type: 'varchar'
  is_nullable: 1
  size: 1000

=head2 post_data

  data_type: 'text'
  is_nullable: 1

=head2 flag_post_data

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "mediumint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "param_name",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "param_value",
  { data_type => "varchar", is_nullable => 1, size => 1000 },
  "post_data",
  { data_type => "text", is_nullable => 1 },
  "flag_post_data",
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

=head2 fe_sync2params

Type: has_many

Related object: L<DB::Result::FeSync2param>

=cut

__PACKAGE__->has_many(
  "fe_sync2params",
  "DB::Result::FeSync2param",
  { "foreign.id_sync_param" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 id_syncs

Type: many_to_many

Composing rels: L</fe_sync2params> -> id_sync

=cut

__PACKAGE__->many_to_many("id_syncs", "fe_sync2params", "id_sync");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-08-08 15:08:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7I12hq2jLDWxXe3ChkTnzQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
