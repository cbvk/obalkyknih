use utf8;
package DB::Result::FeList;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::FeList - List of all frontend servers

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

=head1 TABLE: C<fe_list>

=cut

__PACKAGE__->table("fe_list");

=head1 ACCESSORS

=head2 id

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 fe_group

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 hostname

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 ip_addr

  data_type: 'varchar'
  is_nullable: 0
  size: 15

=head2 port

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 flag_active

  data_type: 'tinyint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "tinyint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "fe_group",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "hostname",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "ip_addr",
  { data_type => "varchar", is_nullable => 0, size => 15 },
  "port",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 0 },
  "flag_active",
  {
    data_type => "tinyint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<hostname>

=over 4

=item * L</hostname>

=back

=cut

__PACKAGE__->add_unique_constraint("hostname", ["hostname"]);

=head1 RELATIONS

=head2 fe_syncs

Type: has_many

Related object: L<DB::Result::FeSync>

=cut

__PACKAGE__->has_many(
  "fe_syncs",
  "DB::Result::FeSync",
  { "foreign.fe_instance" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-09-09 01:56:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cj6T5M0+xYLVn4Ix8z7K+w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
