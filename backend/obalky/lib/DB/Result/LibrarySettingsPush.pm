use utf8;
package DB::Result::LibrarySettingsPush;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::LibrarySettingsPush

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

=head1 TABLE: C<library_settings_push>

=cut

__PACKAGE__->table("library_settings_push");

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

=head2 url

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 fe

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

=head2 full_container

  data_type: 'tinyint'
  is_nullable: 0

=head2 frequency

  data_type: 'integer'
  is_nullable: 0

=head2 item_count

  data_type: 'integer'
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
  "library",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "url",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "fe",
  {
    data_type => "tinyint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  "full_container",
  { data_type => "tinyint", is_nullable => 0 },
  "frequency",
  { data_type => "integer", is_nullable => 0 },
  "item_count",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 fe

Type: belongs_to

Related object: L<DB::Result::FeList>

=cut

__PACKAGE__->belongs_to(
  "fe",
  "DB::Result::FeList",
  { id => "fe" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

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


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-12-14 01:36:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:g5fcWVIXZrOnqK6cMgMd0g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
