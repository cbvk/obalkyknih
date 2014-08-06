use utf8;
package DB::Result::Lastrequest;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Lastrequest

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

=head1 TABLE: C<lastrequests>

=cut

__PACKAGE__->table("lastrequests");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 library

  data_type: 'integer'
  is_nullable: 0

=head2 book

  data_type: 'integer'
  is_nullable: 0

=head2 visitor

  data_type: 'integer'
  is_nullable: 0

=head2 marc

  data_type: 'integer'
  is_nullable: 0

=head2 session_info

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "library",
  { data_type => "integer", is_nullable => 0 },
  "book",
  { data_type => "integer", is_nullable => 0 },
  "visitor",
  { data_type => "integer", is_nullable => 0 },
  "marc",
  { data_type => "integer", is_nullable => 0 },
  "session_info",
  { data_type => "char", is_nullable => 1, size => 40 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-04-25 16:11:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5Fl648sp6MSEYZhr9CdkWA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
