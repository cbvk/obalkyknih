use utf8;
package DB::Result::AuthSource;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::AuthSource

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

=head1 TABLE: C<auth_source>

=cut

__PACKAGE__->table("auth_source");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 eshop

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 auth

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 50

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 modified

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 year

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 cover

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 cover_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 source_url

  data_type: 'varchar'
  is_nullable: 0
  size: 500

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "eshop",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "auth",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 50 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "modified",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "year",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "cover",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "cover_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "source_url",
  { data_type => "varchar", is_nullable => 0, size => 500 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<auth_source_eshop_auth>

=over 4

=item * L</eshop>

=item * L</auth>

=back

=cut

__PACKAGE__->add_unique_constraint("auth_source_eshop_auth", ["eshop", "auth"]);

=head1 RELATIONS

=head2 auth

Type: belongs_to

Related object: L<DB::Result::Auth>

=cut

__PACKAGE__->belongs_to(
  "auth",
  "DB::Result::Auth",
  { id => "auth" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

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

=head2 covers

Type: has_many

Related object: L<DB::Result::Cover>

=cut

__PACKAGE__->has_many(
  "covers",
  "DB::Result::Cover",
  { "foreign.auth_source" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 eshop

Type: belongs_to

Related object: L<DB::Result::Eshop>

=cut

__PACKAGE__->belongs_to(
  "eshop",
  "DB::Result::Eshop",
  { id => "eshop" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2017-04-16 01:10:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0s/oJkKVkJIbi5NSTro24g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
