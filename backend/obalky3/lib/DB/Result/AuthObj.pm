use utf8;
package DB::Result::AuthObj;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::AuthObj

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

=head1 TABLE: C<auth_obj>

=cut

__PACKAGE__->table("auth_obj");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 auth

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 50

=head2 obj_type

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 val

  data_type: 'text'
  is_nullable: 1

Value

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Value name

=head2 source

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 pos

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Position

=head2 rel

  data_type: 'integer'
  is_nullable: 1

Relation

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "auth",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 50 },
  "obj_type",
  {
    data_type => "tinyint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "val",
  { data_type => "text", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "source",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "pos",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "rel",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 auth

Type: belongs_to

Related object: L<DB::Result::Auth>

=cut

__PACKAGE__->belongs_to(
  "auth",
  "DB::Result::Auth",
  { id => "auth" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 obj_type

Type: belongs_to

Related object: L<DB::Result::AuthObjType>

=cut

__PACKAGE__->belongs_to(
  "obj_type",
  "DB::Result::AuthObjType",
  { id => "obj_type" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 source

Type: belongs_to

Related object: L<DB::Result::Source>

=cut

__PACKAGE__->belongs_to(
  "source",
  "DB::Result::Source",
  { id => "source" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-03-04 18:19:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IZ+x1m8sL+nejdmXSsBXeQ

sub link_to_info {
    my($link) = @_;
    return unless($link->val);
    my %res = (
     	'link', $link->get_column('val')
    );
    $res{title} = $link->get_column('name') if ($link->get_column('name'));
    $res{source_name} = $link->source->get_column('name') if ($link->source);
    
    return \%res;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
