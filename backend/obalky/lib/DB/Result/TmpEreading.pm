use utf8;
package DB::Result::TmpEreading;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::TmpEreading

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

=head1 TABLE: C<tmp_ereading>

=cut

__PACKAGE__->table("tmp_ereading");

=head1 ACCESSORS

=head2 product

  data_type: 'integer'
  is_nullable: 0

=head2 book

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "product",
  { data_type => "integer", is_nullable => 0 },
  "book",
  { data_type => "integer", is_nullable => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2018-08-09 15:56:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oiC76M1rM1GUyWIVnKjwbw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
