use utf8;
package DB::Result::AuthTmp;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::AuthTmp

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

=head1 TABLE: C<auth_tmp>

=cut

__PACKAGE__->table("auth_tmp");

=head1 ACCESSORS

=head2 datum

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 img

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 nazev

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 pageUrl

  accessor: 'page_url'
  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 mlpID

  accessor: 'mlp_id'
  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 status

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 authID

  accessor: 'auth_id'
  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 okczUrl

  accessor: 'okcz_url'
  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 cover

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "datum",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "img",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "nazev",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "pageUrl",
  {
    accessor => "page_url",
    data_type => "varchar",
    is_nullable => 1,
    size => 255,
  },
  "mlpID",
  { accessor => "mlp_id", data_type => "varchar", is_nullable => 1, size => 255 },
  "status",
  {
    data_type => "tinyint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "authID",
  { accessor => "auth_id", data_type => "varchar", is_nullable => 1, size => 50 },
  "okczUrl",
  {
    accessor => "okcz_url",
    data_type => "varchar",
    is_nullable => 1,
    size => 255,
  },
  "cover",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</img>

=back

=cut

__PACKAGE__->set_primary_key("img");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-03-09 14:13:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/4nxGErxlnsqtqk4OWBSmg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
