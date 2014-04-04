package DB::Result::Eshop;

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

DB::Result::Eshop

=cut

__PACKAGE__->table("eshop");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 16

=head2 fullname

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 try_count

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 hit_count

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 logo_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 xmlfeed_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 web_url

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 16 },
  "fullname",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "try_count",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "hit_count",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "logo_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "xmlfeed_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "web_url",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("eshop_weburl", ["web_url"]);

=head1 RELATIONS

=head2 products

Type: has_many

Related object: L<DB::Result::Product>

=cut

__PACKAGE__->has_many(
  "products",
  "DB::Result::Product",
  { "foreign.eshop" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users

Type: has_many

Related object: L<DB::Result::User>

=cut

__PACKAGE__->has_many(
  "users",
  "DB::Result::User",
  { "foreign.eshop" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-11-27 11:45:33
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:plGnAw/KILkwPOk8SEGvFA

use Data::Dumper;
use utf8;

sub product_count {
	my($eshop) = @_;
	return DB->resultset('Product')->count({ eshop => $eshop->id });
}

sub is_internal {
	my($eshop) = @_;
	return  ($eshop->name eq 'Legacy') or
			($eshop->name eq 'Static') or
			($eshop->name eq 'Upload') or
			($eshop->name eq 'Amazon') or
			($eshop->id == 111); # zbozi
}

sub factory { 
	my($eshop) = @_;
	my $class = $eshop->name || 'Zbozi';
	warn "DEPRECATED / NON-FUNCTIONAL call to Eshop->factory($class)\n";
	return Eshop->get_eshop($class);
}

sub add_product {
	my($eshop,$bibinfo,$media,$product_url) = @_;

	# najdi nebo vytvor odpovidajici book
	# warn "Looking for ".Dumper($bibinfo)."\n" if($ENV{DEBUG});
	my $book = DB->resultset('Book')->find_by_bibinfo_or_create($bibinfo);
	$bibinfo->save_to($book); # aktualizuj dle produktu -- jen docasne pro opravu TOC!

	# dle #book a #eshop najdi nebo vytvor product (s permalinkem)
	my $product = DB->resultset('Product')->find($product_url, 
						{ key => 'product_product_url' });
	warn "add_product($product_url): ".($product?$product->id:'-')."\n"
				if($ENV{DEBUG});
	$product = DB->resultset('Product')->find_or_create(
		{ eshop => $eshop->id, book => $book, product_url => $product_url },
		{ key => 'product_eshop_book' } ) unless($product);
	$product->update({ modified => DateTime->now() });
	warn "add_product($product_url): updated ".($product?$product->id:'-')."\n"
				if($ENV{DEBUG});

   	# uloz bibinfo do productu
	$bibinfo->save_to($product);
	# podle bibinfo zakutalizovat book?
	$media->save_to($product);

	my $book_bibinfo = $book->bibinfo;
	$book_bibinfo->save_to($book) if($book_bibinfo->merge($bibinfo));

	# podle media zaktualizovat book!!! book->prepocitej_media..
	$book->actualize_by_product($product);

	return $product;
}

1;

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
