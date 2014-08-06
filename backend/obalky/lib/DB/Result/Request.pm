use utf8;
package DB::Result::Request;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Request

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

=head1 TABLE: C<request>

=cut

__PACKAGE__->table("request");

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

=head2 library

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 client_ip

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 visitor_id

  data_type: 'integer'
  is_nullable: 0

=head2 seance_id

  data_type: 'integer'
  is_nullable: 0

=head2 method

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 returning

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 ean13

  data_type: 'char'
  is_nullable: 1
  size: 13

=head2 oclc

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 nbn

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 authors

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 year

  data_type: 'integer'
  is_nullable: 1

=head2 format

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 cover

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 result

  data_type: 'varchar'
  is_nullable: 0
  size: 64

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
  "library",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "client_ip",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "visitor_id",
  { data_type => "integer", is_nullable => 0 },
  "seance_id",
  { data_type => "integer", is_nullable => 0 },
  "method",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "returning",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "ean13",
  { data_type => "char", is_nullable => 1, size => 13 },
  "oclc",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "nbn",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "authors",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "year",
  { data_type => "integer", is_nullable => 1 },
  "format",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "cover",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "result",
  { data_type => "varchar", is_nullable => 0, size => 64 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cover

Type: belongs_to

Related object: L<DB::Result::Cover>

=cut

__PACKAGE__->belongs_to(
  "cover",
  "DB::Result::Cover",
  { id => "cover" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 library

Type: belongs_to

Related object: L<DB::Result::Library>

=cut

__PACKAGE__->belongs_to(
  "library",
  "DB::Result::Library",
  { id => "library" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-08-01 15:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uK+bm6z1POSi1lcLEcGE6g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
