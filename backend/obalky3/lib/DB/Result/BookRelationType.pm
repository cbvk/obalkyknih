use utf8;
package DB::Result::BookRelationType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::BookRelationType

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

=head1 TABLE: C<book_relation_type>

=cut

__PACKAGE__->table("book_relation_type");

=head1 ACCESSORS

=head2 id_book_relation_type

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 relation_code

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 relation_description

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id_book_relation_type",
  {
    data_type => "tinyint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "relation_code",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "relation_description",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_book_relation_type>

=back

=cut

__PACKAGE__->set_primary_key("id_book_relation_type");

=head1 UNIQUE CONSTRAINTS

=head2 C<relation_code>

=over 4

=item * L</relation_code>

=back

=cut

__PACKAGE__->add_unique_constraint("relation_code", ["relation_code"]);

=head1 RELATIONS

=head2 book_relations

Type: has_many

Related object: L<DB::Result::BookRelation>

=cut

__PACKAGE__->has_many(
  "book_relations",
  "DB::Result::BookRelation",
  { "foreign.relation_type" => "self.id_book_relation_type" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-12-09 19:11:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hSRjXgkOlhIrVzjQXsEzIA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
