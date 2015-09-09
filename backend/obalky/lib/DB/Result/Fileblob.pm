use utf8;
package DB::Result::Fileblob;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Fileblob

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

=head1 TABLE: C<fileblob>

=cut

__PACKAGE__->table("fileblob");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 mime

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 medium

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 content

  data_type: 'mediumblob'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "mime",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "medium",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "content",
  { data_type => "mediumblob", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cover_file_icons

Type: has_many

Related object: L<DB::Result::Cover>

=cut

__PACKAGE__->has_many(
  "cover_file_icons",
  "DB::Result::Cover",
  { "foreign.file_icon" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cover_file_mediums

Type: has_many

Related object: L<DB::Result::Cover>

=cut

__PACKAGE__->has_many(
  "cover_file_mediums",
  "DB::Result::Cover",
  { "foreign.file_medium" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cover_file_origs

Type: has_many

Related object: L<DB::Result::Cover>

=cut

__PACKAGE__->has_many(
  "cover_file_origs",
  "DB::Result::Cover",
  { "foreign.file_orig" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cover_file_thumbs

Type: has_many

Related object: L<DB::Result::Cover>

=cut

__PACKAGE__->has_many(
  "cover_file_thumbs",
  "DB::Result::Cover",
  { "foreign.file_thumb" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-09-09 01:56:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:toWRgHTSeNu/D7dlvKM0+w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
