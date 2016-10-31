use utf8;
package DB::Result::LibrarySettingsCitace;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::LibrarySettingsCitace

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

=head1 TABLE: C<library_settings_citace>

=cut

__PACKAGE__->table("library_settings_citace");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 library

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 type

  data_type: 'enum'
  default_value: 'marcxml'
  extra: {list => ["marcxml","z3950"]}
  is_nullable: 0

=head2 url

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 z_port

  data_type: 'integer'
  is_nullable: 1

=head2 z_database

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 z_encoding

  data_type: 'enum'
  extra: {list => ["UTF-8","CP-1250","Marc-8"]}
  is_nullable: 1

=head2 z_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 z_password

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 z_index_sysno

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "library",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "type",
  {
    data_type => "enum",
    default_value => "marcxml",
    extra => { list => ["marcxml", "z3950"] },
    is_nullable => 0,
  },
  "url",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "z_port",
  { data_type => "integer", is_nullable => 1 },
  "z_database",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "z_encoding",
  {
    data_type => "enum",
    extra => { list => ["UTF-8", "CP-1250", "Marc-8"] },
    is_nullable => 1,
  },
  "z_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "z_password",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "z_index_sysno",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 library

Type: belongs_to

Related object: L<DB::Result::Library>

=cut

__PACKAGE__->belongs_to(
  "library",
  "DB::Result::Library",
  { id => "library" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-09-07 17:14:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5XKiScxRoHDrMO7shO7kdA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
