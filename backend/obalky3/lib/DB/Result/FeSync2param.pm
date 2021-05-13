use utf8;
package DB::Result::FeSync2param;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::FeSync2param - Relational table. Params assigned to defined sync

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

=head1 TABLE: C<fe_sync2param>

=cut

__PACKAGE__->table("fe_sync2param");

=head1 ACCESSORS

=head2 id_sync

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sync_param

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id_sync",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "id_sync_param",
  {
    data_type => "mediumint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_sync>

=item * L</id_sync_param>

=back

=cut

__PACKAGE__->set_primary_key("id_sync", "id_sync_param");

=head1 RELATIONS

=head2 id_sync

Type: belongs_to

Related object: L<DB::Result::FeSync>

=cut

__PACKAGE__->belongs_to(
  "id_sync",
  "DB::Result::FeSync",
  { id => "id_sync" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 id_sync_param

Type: belongs_to

Related object: L<DB::Result::FeSyncParam>

=cut

__PACKAGE__->belongs_to(
  "id_sync_param",
  "DB::Result::FeSyncParam",
  { id => "id_sync_param" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-09-09 01:56:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rgc46pL3sw195feTYa9Qzw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
