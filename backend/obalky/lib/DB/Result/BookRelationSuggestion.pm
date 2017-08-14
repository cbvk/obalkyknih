use utf8;
package DB::Result::BookRelationSuggestion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::BookRelationSuggestion

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

=head1 TABLE: C<book_relation_suggestion>

=cut

__PACKAGE__->table("book_relation_suggestion");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 suggestion_id

  data_type: 'varchar'
  is_nullable: 0
  size: 32

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

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 flag

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 source

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 source_url

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 eshop

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "suggestion_id",
  { data_type => "varchar", is_nullable => 0, size => 32 },
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
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "flag",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "source",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "source_url",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "eshop",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=item * L</suggestion_id>

=item * L</source>

=back

=cut

__PACKAGE__->set_primary_key("id", "suggestion_id", "source");

=head1 RELATIONS

=head2 eshop

Type: belongs_to

Related object: L<DB::Result::Eshop>

=cut

__PACKAGE__->belongs_to(
  "eshop",
  "DB::Result::Eshop",
  { id => "eshop" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 id

Type: belongs_to

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->belongs_to(
  "id",
  "DB::Result::Book",
  { id => "id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2017-08-08 11:51:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tlePsLAIb5RFX+BxRo1olQ
use strict;
use warnings;
use Data::Dumper;
use DB;

sub approve_suggestion{
	my ($suggestion) = @_;
	my $success;
	my ($relation_id);
	 
	
	if ($suggestion->source eq 'internal'){
		$relation_id = $suggestion->id;
	}
	else{
		my $bibinfo = Obalky::BibInfo->new_from_params({
			title => $suggestion->title,
			authors => $suggestion->authors,
			year => $suggestion->year,
			ean => $suggestion->ean13,
			nbn => $suggestion->nbn,
			oclc => $suggestion->oclc
		});

		my $eshop = $suggestion->eshop;
		$relation_id = $eshop->add_product($bibinfo, undef, $suggestion->get_column('source_url'));
		$relation_id = $relation_id->book->get_column('id');
	}
	$suggestion->update({flag => 1});
	DB->resultset('BookRelation')->find_or_create({book_parent => $suggestion->id, book_relation => $relation_id, relation_type => 2});
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
