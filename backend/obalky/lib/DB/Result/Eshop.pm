use utf8;
package DB::Result::Eshop;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Eshop

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

=head1 TABLE: C<eshop>

=cut

__PACKAGE__->table("eshop");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 type

  data_type: 'enum'
  default_value: 'cover'
  extra: {list => ["cover","auth","citace","ebook","kramerius"]}
  is_nullable: 0

=head2 try_count

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 hit_count

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 xmlfeed_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 logo_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 web_url

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 fullname

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 priority

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 process_cover

  data_type: 'tinyint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 process_toc

  data_type: 'tinyint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 process_annotation

  data_type: 'tinyint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 process_rating

  data_type: 'tinyint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 process_review

  data_type: 'tinyint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 rating_multiplier

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 xml_el_shopitem

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_url

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_title

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_authors

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_isbn

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_nbn

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_description

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_price_min

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_price_max

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_imgurl

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_year

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_rating_count

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_rating_value

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_reviews_encap

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_reviews_item

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_reviews_id

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_reviews_time

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_reviews_text

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 xml_el_reviews_rating

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 author_separator

  data_type: 'varchar'
  is_nullable: 1
  size: 5

=head2 library

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "type",
  {
    data_type => "enum",
    default_value => "cover",
    extra => { list => ["cover", "auth", "citace", "ebook", "kramerius"] },
    is_nullable => 0,
  },
  "try_count",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "hit_count",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "xmlfeed_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "logo_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "web_url",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "fullname",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "priority",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "process_cover",
  {
    data_type => "tinyint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "process_toc",
  {
    data_type => "tinyint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "process_annotation",
  {
    data_type => "tinyint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "process_rating",
  {
    data_type => "tinyint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "process_review",
  {
    data_type => "tinyint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "rating_multiplier",
  { data_type => "tinyint", extra => { unsigned => 1 }, is_nullable => 1 },
  "xml_el_shopitem",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_url",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_title",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_authors",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_isbn",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_nbn",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_description",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_price_min",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_price_max",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_imgurl",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_year",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_rating_count",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_rating_value",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_reviews_encap",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_reviews_item",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_reviews_id",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_reviews_time",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_reviews_text",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "xml_el_reviews_rating",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "author_separator",
  { data_type => "varchar", is_nullable => 1, size => 5 },
  "library",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 auth_sources

Type: has_many

Related object: L<DB::Result::AuthSource>

=cut

__PACKAGE__->has_many(
  "auth_sources",
  "DB::Result::AuthSource",
  { "foreign.eshop" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 book_relation_suggestions

Type: has_many

Related object: L<DB::Result::BookRelationSuggestion>

=cut

__PACKAGE__->has_many(
  "book_relation_suggestions",
  "DB::Result::BookRelationSuggestion",
  { "foreign.eshop" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 books

Type: has_many

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->has_many(
  "books",
  "DB::Result::Book",
  { "foreign.citation_source" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library

Type: belongs_to

Related object: L<DB::Result::Library>

=cut

__PACKAGE__->belongs_to(
  "library",
  "DB::Result::Library",
  { id => "library" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

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


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2017-08-08 11:51:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KrPnJeYZK+fYskx1sUIhpA


use Data::Dumper;

our $ESHOP_UPLOAD = 109;

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
	my($eshop,$bibinfo,$media,$product_url,$covers_uncommited,$params) = @_;

	# najdi nebo vytvor odpovidajici book
	warn "Looking for ".Dumper($bibinfo)."\n" if($ENV{DEBUG});
	my @params = @{$params} if ($params);
	my $book = DB->resultset('Book')->find_by_bibinfo($bibinfo,1);
	# bylo zadanych vice isbn
#	if (!$book and @params) {
#warn Dumper(@params);
#		foreach (@params){
#			($_->{ean13}, $bibinfo->{ean13}) = ($bibinfo->{ean13}, $_->{ean13});
#			$book = DB->resultset('Book')->find_by_bibinfo($bibinfo,1);
#			last if ($book);
#		}
	
#		($params[0], $bibinfo->{ean13}) = ($bibinfo->{ean13}, $params[0])if (!$book); #vrati puvodni EAN do bibinfa
#	}

	warn "BOOK EXISTUJE ... ".$book->id  if ($book and $ENV{DEBUG});
	
	# zaznam book neexistuje, vytvarime
	unless ($book) {
		my $hash = {};
		$bibinfo->save_to_hash($hash);
		warn "Creating book... EAN ".$hash->{ean13}."\n" if($ENV{DEBUG});
		$book = DB->resultset('Book')->create($hash);
	};

	$bibinfo->save_to($book); # aktualizuj dle produktu -- jen docasne pro opravu TOC!

	# dle #book a #eshop najdi nebo vytvor product (s permalk)
	my $product = DB->resultset('Product')->find($product_url, 
						{ key => 'product_product_url' });
	warn "add_product($product_url): ".($product?$product->id:'-')."\n"
				if($ENV{DEBUG});
	$product = DB->resultset('Product')->find_or_create(
		{ eshop => $eshop->id, book => $book, product_url => $product_url },
		{ key => 'product_eshop_book' } ) unless($product);
	$product->update({ modified => DateTime->now() });
	$product->update({ product_url => $product_url }) if (defined $product_url and defined $product->get_column('product_url') and $product_url ne $product->get_column('product_url'));
	warn "add_product($product_url): updated ".($product?$product->id:'-')."\n"
				if($ENV{DEBUG});

	# vicero ISBN se ulozi do product params
	if (@params){
		foreach my $param (@params){
			my $ppToSearch = { book => $book->id, product => $product->id };
			$ppToSearch->{nbn} = $bibinfo->{nbn} if (defined $bibinfo);
			$ppToSearch->{oclc} = $bibinfo->{oclc} if (defined $bibinfo);
			DB->resultset('ProductParams')->find_or_create($ppToSearch);
		}
	}
   	# uloz bibinfo do productu
	$bibinfo->save_to($product);
	# podle bibinfo zakutalizovat book?
	$media->save_to($product) if ($media);

	my $book_bibinfo = $book->bibinfo;
	$book_bibinfo->save_to($book) if($book_bibinfo->merge($bibinfo));

	# podle media zaktualizovat book!!! book->prepocitej_media..
	$book->actualize_by_product($product,1);
	
	# nepotvrzene obrazky
	if (defined $covers_uncommited) {
		map {
			my $saveUncommitedCover = 0;
			# kniha nema obrazek vubec
			$saveUncommitedCover = 1 if (not defined $book->cover);
			if (defined $book->cover and $_ =~ /(\d+)x(\d+)/) {
				# kniha ma obrazek s mensim rozlisenim
				$saveUncommitedCover = 1 if ($1*$2 > $book->cover->orig_width*$book->cover->orig_height);
			}
			DB->resultset('CoverUncommited')->find_or_create({ 'book'=>$book, 'product'=>$product, 'img'=>$_ }) if ($saveUncommitedCover);
		} @$covers_uncommited;
	}

	return $product;
}

sub add_auth_source {
	my($eshop,$authinfo,$media,$source_url) = @_;
	
	my $auth = DB->resultset('Auth')->find_by_authinfo($authinfo);
	
	my $exists = DB->resultset('AuthSource')->find({ source_url => $source_url });
	
	my $source = DB->resultset('AuthSource')->update_or_create(
		{ eshop => $eshop->id, auth => $auth, modified => DateTime->now(), source_url => $source_url },
		{ key => 'auth_source_eshop_auth' } );
	#$source->update({ modified => DateTime->now() });
	#$source->update({ source_url => $source_url }) if (defined $source_url and defined $source->get_column('source_url') and $source_url ne $source->get_column('source_url'));
	
	warn "add_auth_source($source_url): updated ".($source?$source->id:'-')."\n"
				if($ENV{DEBUG});
	
	my $downloadSuccess = $media->save_to($source);
	
	unless ($downloadSuccess) { #zlyhal download media
		if ($exists) { #treba vymazat zaznam ked pred tym neexistoval
			$exists->delete();
		}
		return;
	};
	
	$authinfo->save_to($source);
	
	$source->update({
		source_url => $source_url
	});
	
	my $auth_authinfo = $auth->authinfo;
	$auth_authinfo->save_to($auth) if($auth_authinfo->merge($authinfo));
	
	$auth->actualize_by_source($source,1);
	
	return $source;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
