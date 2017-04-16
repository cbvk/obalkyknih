use utf8;
package DB::Result::BiblioRec;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::BiblioRec

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

=head1 TABLE: C<biblio_rec>

=cut

__PACKAGE__->table("biblio_rec");

=head1 ACCESSORS

=head2 id_biblio_rec

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 t000

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 t001

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 t005

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 t008

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 dt_change

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id_biblio_rec",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "t000",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "t001",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "t005",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "t008",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "dt_change",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_biblio_rec>

=back

=cut

__PACKAGE__->set_primary_key("id_biblio_rec");

=head1 UNIQUE CONSTRAINTS

=head2 C<t001>

=over 4

=item * L</t001>

=back

=cut

__PACKAGE__->add_unique_constraint("t001", ["t001"]);

=head1 RELATIONS

=head2 biblio_subtag_texts

Type: has_many

Related object: L<DB::Result::BiblioSubtagText>

=cut

__PACKAGE__->has_many(
  "biblio_subtag_texts",
  "DB::Result::BiblioSubtagText",
  { "foreign.id_biblio_rec" => "self.id_biblio_rec" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biblio_subtags

Type: has_many

Related object: L<DB::Result::BiblioSubtag>

=cut

__PACKAGE__->has_many(
  "biblio_subtags",
  "DB::Result::BiblioSubtag",
  { "foreign.id_biblio_rec" => "self.id_biblio_rec" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-12-16 17:49:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7+nMjVKj/mza6vj/kyjgkQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
