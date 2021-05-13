use utf8;
package DB::Result::Library;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Library

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

=head1 TABLE: C<library>

=cut

__PACKAGE__->table("library");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 code

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 webopac

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 address

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 city

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 emailboss

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 emailads

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 skipmember

  data_type: 'tinyint'
  is_nullable: 1

=head2 flag_active

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 purpose_description

  data_type: 'mediumtext'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "code",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "webopac",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "address",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "city",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "emailboss",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "emailads",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "skipmember",
  { data_type => "tinyint", is_nullable => 1 },
  "flag_active",
  {
    data_type => "tinyint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "purpose_description",
  { data_type => "mediumtext", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<library_code>

=over 4

=item * L</code>

=back

=cut

__PACKAGE__->add_unique_constraint("library_code", ["code"]);

=head1 RELATIONS

=head2 eshops

Type: has_many

Related object: L<DB::Result::Eshop>

=cut

__PACKAGE__->has_many(
  "eshops",
  "DB::Result::Eshop",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_perms

Type: has_many

Related object: L<DB::Result::LibraryPerm>

=cut

__PACKAGE__->has_many(
  "library_perms",
  "DB::Result::LibraryPerm",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_settings_citaces

Type: has_many

Related object: L<DB::Result::LibrarySettingsCitace>

=cut

__PACKAGE__->has_many(
  "library_settings_citaces",
  "DB::Result::LibrarySettingsCitace",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_settings_doporucs

Type: has_many

Related object: L<DB::Result::LibrarySettingsDoporuc>

=cut

__PACKAGE__->has_many(
  "library_settings_doporucs",
  "DB::Result::LibrarySettingsDoporuc",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_settings_pushes

Type: has_many

Related object: L<DB::Result::LibrarySettingsPush>

=cut

__PACKAGE__->has_many(
  "library_settings_pushes",
  "DB::Result::LibrarySettingsPush",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 requests

Type: has_many

Related object: L<DB::Result::Request>

=cut

__PACKAGE__->has_many(
  "requests",
  "DB::Result::Request",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 reviews

Type: has_many

Related object: L<DB::Result::Review>

=cut

__PACKAGE__->has_many(
  "reviews",
  "DB::Result::Review",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users

Type: has_many

Related object: L<DB::Result::User>

=cut

__PACKAGE__->has_many(
  "users",
  "DB::Result::User",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 visitors

Type: has_many

Related object: L<DB::Result::Visitor>

=cut

__PACKAGE__->has_many(
  "visitors",
  "DB::Result::Visitor",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-11-01 15:36:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JCoQvBFN3dM/rdDzoUJVww


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
