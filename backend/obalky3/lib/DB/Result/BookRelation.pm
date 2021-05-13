use utf8;
package DB::Result::BookRelation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::BookRelation

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

=head1 TABLE: C<book_relation>

=cut

__PACKAGE__->table("book_relation");

=head1 ACCESSORS

=head2 book_parent

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 book_relation

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 relation_type

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 flag_auto_generated

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "book_parent",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "book_relation",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "relation_type",
  {
    data_type => "tinyint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "flag_auto_generated",
  {
    data_type => "tinyint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</book_parent>

=item * L</book_relation>

=item * L</relation_type>

=back

=cut

__PACKAGE__->set_primary_key("book_parent", "book_relation", "relation_type");

=head1 RELATIONS

=head2 book_parent

Type: belongs_to

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->belongs_to(
  "book_parent",
  "DB::Result::Book",
  { id => "book_parent" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 book_relation

Type: belongs_to

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->belongs_to(
  "book_relation",
  "DB::Result::Book",
  { id => "book_relation" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 relation_type

Type: belongs_to

Related object: L<DB::Result::BookRelationType>

=cut

__PACKAGE__->belongs_to(
  "relation_type",
  "DB::Result::BookRelationType",
  { id_book_relation_type => "relation_type" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2018-12-30 16:10:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MQRRMsg04EjmZeFQWzgK8A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
