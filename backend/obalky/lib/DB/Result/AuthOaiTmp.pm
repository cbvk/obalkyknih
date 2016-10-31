use utf8;
package DB::Result::AuthOaiTmp;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::AuthOaiTmp

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

=head1 TABLE: C<auth_oai_tmp>

=cut

__PACKAGE__->table("auth_oai_tmp");

=head1 ACCESSORS

=head2 PK

  accessor: 'pk'
  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id

  data_type: 'varchar'
  is_nullable: 0
  size: 50

001

=head2 oai_identifier

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 oai_datestamp

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 auth_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

100$$a

=head2 auth_date

  data_type: 'varchar'
  is_nullable: 1
  size: 100

100$$d

=head2 auth_activity

  data_type: 'varchar'
  is_nullable: 1
  size: 255

372$$a

=head2 auth_occupation

  data_type: 'varchar'
  is_nullable: 1
  size: 255

374$$a

=head2 auth_biography

  data_type: 'text'
  is_nullable: 1

678$$a

=head2 auth_datestamp

  data_type: 'varchar'
  is_nullable: 1
  size: 20

005

=head2 nkp_aut_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

998a

=head2 ts

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "PK",
  {
    accessor          => "pk",
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
  },
  "id",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "oai_identifier",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "oai_datestamp",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "auth_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "auth_date",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "auth_activity",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "auth_occupation",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "auth_biography",
  { data_type => "text", is_nullable => 1 },
  "auth_datestamp",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "nkp_aut_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "ts",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</PK>

=back

=cut

__PACKAGE__->set_primary_key("PK");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-10-07 14:24:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QlmaqnU9SItNo+bGmpTVCw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
