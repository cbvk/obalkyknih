use utf8;
package DB::Result::FeSyncType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::FeSyncType

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

=head1 TABLE: C<fe_sync_type>

=cut

__PACKAGE__->table("fe_sync_type");

=head1 ACCESSORS

=head2 id

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 sync_type_code

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 sync_type_description

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "tinyint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "sync_type_code",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "sync_type_description",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<sync_type_code>

=over 4

=item * L</sync_type_code>

=back

=cut

__PACKAGE__->add_unique_constraint("sync_type_code", ["sync_type_code"]);

=head1 RELATIONS

=head2 fe_syncs

Type: has_many

Related object: L<DB::Result::FeSync>

=cut

__PACKAGE__->has_many(
  "fe_syncs",
  "DB::Result::FeSync",
  { "foreign.fe_sync_type" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-09-09 01:56:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9Q7Wao3kT+g+9Nrr7mWm8Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
