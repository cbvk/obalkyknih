use utf8;
package DB::Result::AuthObjType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::AuthObjType

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

=head1 TABLE: C<auth_obj_type>

=cut

__PACKAGE__->table("auth_obj_type");

=head1 ACCESSORS

=head2 id

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 description

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
  "name",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "description",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<UQ_auth_obj_type_name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("UQ_auth_obj_type_name", ["name"]);

=head1 RELATIONS

=head2 auth_objs

Type: has_many

Related object: L<DB::Result::AuthObj>

=cut

__PACKAGE__->has_many(
  "auth_objs",
  "DB::Result::AuthObj",
  { "foreign.obj_type" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-03-04 18:19:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:W/aLo+D6hn/Z4jEjSQpNgA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
