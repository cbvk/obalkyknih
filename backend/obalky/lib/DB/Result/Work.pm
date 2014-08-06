use utf8;
package DB::Result::Work;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Work

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

=head1 TABLE: C<work>

=cut

__PACKAGE__->table("work");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 review

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "review",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 books

Type: has_many

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->has_many(
  "books",
  "DB::Result::Book",
  { "foreign.work" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 review

Type: belongs_to

Related object: L<DB::Result::Review>

=cut

__PACKAGE__->belongs_to(
  "review",
  "DB::Result::Review",
  { id => "review" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-04-25 16:11:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vsmM0KG30le5PjATutXzXA


sub get_cover {
    my($work) = @_;
    foreach my $book ($work->books) {
        return $book->cover if($book->cover);
    }
    return;
}
sub get_toc {
    my($work) = @_;
    foreach my $book ($work->books) {
        return $book->toc if($book->toc);
    }
    return;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
