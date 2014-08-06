use utf8;
package DB::Result::FeSync;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::FeSync - Front-end sync event to specifict FE instance

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

=head1 TABLE: C<fe_sync>

=cut

__PACKAGE__->table("fe_sync");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 fe_instance

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 fe_sync_type

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 flag_synced

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 retry_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 retry_count

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "fe_instance",
  {
    data_type => "tinyint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "fe_sync_type",
  {
    data_type => "tinyint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "flag_synced",
  {
    data_type => "tinyint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "retry_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "retry_count",
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

=head2 fe_instance

Type: belongs_to

Related object: L<DB::Result::FeList>

=cut

__PACKAGE__->belongs_to(
  "fe_instance",
  "DB::Result::FeList",
  { id => "fe_instance" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 fe_sync2params

Type: has_many

Related object: L<DB::Result::FeSync2param>

=cut

__PACKAGE__->has_many(
  "fe_sync2params",
  "DB::Result::FeSync2param",
  { "foreign.id_sync" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 fe_sync_type

Type: belongs_to

Related object: L<DB::Result::FeSyncType>

=cut

__PACKAGE__->belongs_to(
  "fe_sync_type",
  "DB::Result::FeSyncType",
  { id => "fe_sync_type" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 id_sync_params

Type: many_to_many

Composing rels: L</fe_sync2params> -> id_sync_param

=cut

__PACKAGE__->many_to_many("id_sync_params", "fe_sync2params", "id_sync_param");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-04-25 16:11:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EFYnL9+v5ukD2MxNRvUj0w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
