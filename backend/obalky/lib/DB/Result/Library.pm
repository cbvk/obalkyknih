package DB::Result::Library;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

DB::Result::Library

=cut

__PACKAGE__->table("library");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 code

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 address

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 city

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 emailboss

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 emailads

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 skipmember

  data_type: 'tinyint'
  is_nullable: 1

=head2 webopac

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "code",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "address",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "city",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "emailboss",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "emailads",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "skipmember",
  { data_type => "tinyint", is_nullable => 1 },
  "webopac",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("library_code", ["code"]);

=head1 RELATIONS

=head2 marcs

Type: has_many

Related object: L<DB::Result::Marc>

=cut

__PACKAGE__->has_many(
  "marcs",
  "DB::Result::Marc",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 requests

Type: has_many

Related object: L<DB::Result::Request>

=cut

__PACKAGE__->has_many(
  "requests",
  "DB::Result::Request",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 reviews

Type: has_many

Related object: L<DB::Result::Review>

=cut

__PACKAGE__->has_many(
  "reviews",
  "DB::Result::Review",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 seances

Type: has_many

Related object: L<DB::Result::Seance>

=cut

__PACKAGE__->has_many(
  "seances",
  "DB::Result::Seance",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 seanses

Type: has_many

Related object: L<DB::Result::Seanse>

=cut

__PACKAGE__->has_many(
  "seanses",
  "DB::Result::Seanse",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users

Type: has_many

Related object: L<DB::Result::User>

=cut

__PACKAGE__->has_many(
  "users",
  "DB::Result::User",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 visitors

Type: has_many

Related object: L<DB::Result::Visitor>

=cut

__PACKAGE__->has_many(
  "visitors",
  "DB::Result::Visitor",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-11-27 06:34:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JOwY0Tc/GAgFkarXVAa6Sw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
