use utf8;
package DB::Result::BiblioSubtagText;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::BiblioSubtagText

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

=head1 TABLE: C<biblio_subtag_text>

=cut

__PACKAGE__->table("biblio_subtag_text");

=head1 ACCESSORS

=head2 id_biblio_subtag_text

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_biblio_rec

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 tag

  data_type: 'char'
  is_nullable: 0
  size: 3

=head2 subtag

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 i1

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 i2

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 val

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id_biblio_subtag_text",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "id_biblio_rec",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "tag",
  { data_type => "char", is_nullable => 0, size => 3 },
  "subtag",
  { data_type => "char", is_nullable => 1, size => 1 },
  "i1",
  { data_type => "char", is_nullable => 1, size => 1 },
  "i2",
  { data_type => "char", is_nullable => 1, size => 1 },
  "val",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_biblio_subtag_text>

=back

=cut

__PACKAGE__->set_primary_key("id_biblio_subtag_text");

=head1 RELATIONS

=head2 id_biblio_rec

Type: belongs_to

Related object: L<DB::Result::BiblioRec>

=cut

__PACKAGE__->belongs_to(
  "id_biblio_rec",
  "DB::Result::BiblioRec",
  { id_biblio_rec => "id_biblio_rec" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-12-17 01:30:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZCJNY5vRmIGpxL76hJIOMg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
