use utf8;
package DB::Result::AuthDuplicate;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::AuthDuplicate

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

=head1 TABLE: C<auth_duplicate>

=cut

__PACKAGE__->table("auth_duplicate");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 auth_id

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 50

=head2 media_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 wiki_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "auth_id",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 50 },
  "media_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "wiki_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 auth

Type: belongs_to

Related object: L<DB::Result::Auth>

=cut

__PACKAGE__->belongs_to(
  "auth",
  "DB::Result::Auth",
  { id => "auth_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-08-08 12:05:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:K7gaElTb34YMWqKzOb50kg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
