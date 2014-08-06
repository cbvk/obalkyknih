use utf8;
package DB::Result::CoverChecksum;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::CoverChecksum - Axuliary table used by sync script. BE to FE sync.

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

=head1 TABLE: C<cover_checksum>

=cut

__PACKAGE__->table("cover_checksum");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 book

  data_type: 'integer'
  is_nullable: 0

=head2 checksum

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "book",
  { data_type => "integer", is_nullable => 0 },
  "checksum",
  { data_type => "varchar", is_nullable => 0, size => 32 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=item * L</checksum>

=back

=cut

__PACKAGE__->set_primary_key("id", "checksum");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-07-01 15:51:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uJgMWWwt5TLVbfh/R9toYg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
