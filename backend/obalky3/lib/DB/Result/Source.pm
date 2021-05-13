use utf8;
package DB::Result::Source;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Source

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

=head1 TABLE: C<source>

=cut

__PACKAGE__->table("source");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 logo_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 source_url

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 fullname

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "logo_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "source_url",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "fullname",
  { data_type => "varchar", is_nullable => 1, size => 64 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<source_url>

=over 4

=item * L</source_url>

=back

=cut

__PACKAGE__->add_unique_constraint("source_url", ["source_url"]);

=head1 RELATIONS

=head2 auth_objs

Type: has_many

Related object: L<DB::Result::AuthObj>

=cut

__PACKAGE__->has_many(
  "auth_objs",
  "DB::Result::AuthObj",
  { "foreign.source" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-03-04 18:45:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FPbEQj6nJn/MlAmH71r3/A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
