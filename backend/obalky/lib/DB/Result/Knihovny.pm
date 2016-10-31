use utf8;
package DB::Result::Knihovny;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Knihovny

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

=head1 TABLE: C<knihovny>

=cut

__PACKAGE__->table("knihovny");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 sigla

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 code

  data_type: 'integer'
  is_nullable: 1

=head2 city

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 street

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 zip

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "sigla",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "code",
  { data_type => "integer", is_nullable => 1 },
  "city",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "street",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "zip",
  { data_type => "varchar", is_nullable => 1, size => 10 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-04-15 12:32:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Qi2XypQ6w52NtB2tB2WDDA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
