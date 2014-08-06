use utf8;
package DB::Result::FileblobOrig20140314a;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::FileblobOrig20140314a

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

=head1 TABLE: C<fileblob_orig_20140314a>

=cut

__PACKAGE__->table("fileblob_orig_20140314a");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 mime

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 medium

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 content

  data_type: 'mediumblob'
  is_nullable: 0

=head2 cover

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "mime",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "medium",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "content",
  { data_type => "mediumblob", is_nullable => 0 },
  "cover",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-07-01 15:51:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3zFDWmgFa+wBBWnfCHK/Qg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
