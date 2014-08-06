use utf8;
package DB::Result::Cache;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Cache

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

=head1 TABLE: C<cache>

=cut

__PACKAGE__->table("cache");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 bookid

  data_type: 'integer'
  is_nullable: 1

=head2 request

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 response

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "bookid",
  { data_type => "integer", is_nullable => 1 },
  "request",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "response",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cache_request>

=over 4

=item * L</request>

=back

=cut

__PACKAGE__->add_unique_constraint("cache_request", ["request"]);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-04-25 16:11:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YQgq+06fh/oL5ePlIgBJ5A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
