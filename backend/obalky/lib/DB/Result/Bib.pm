use utf8;
package DB::Result::Bib;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Bib

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

=head1 TABLE: C<bib>

=cut

__PACKAGE__->table("bib");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 product

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 pdf_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 pdf_file

  data_type: 'mediumblob'
  is_nullable: 1

=head2 pdf_thumbnail

  data_type: 'mediumblob'
  is_nullable: 1

=head2 full_text

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "product",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "pdf_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "pdf_file",
  { data_type => "mediumblob", is_nullable => 1 },
  "pdf_thumbnail",
  { data_type => "mediumblob", is_nullable => 1 },
  "full_text",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<bib_product>

=over 4

=item * L</product>

=back

=cut

__PACKAGE__->add_unique_constraint("bib_product", ["product"]);

=head1 RELATIONS

=head2 product

Type: belongs_to

Related object: L<DB::Result::Product>

=cut

__PACKAGE__->belongs_to(
  "product",
  "DB::Result::Product",
  { id => "product" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2018-11-13 11:34:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bmQ9Y7h+vMQUX3ISz0+lIg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
