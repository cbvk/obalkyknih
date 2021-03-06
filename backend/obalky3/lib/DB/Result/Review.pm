use utf8;
package DB::Result::Review;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Review

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

=head1 TABLE: C<review>

=cut

__PACKAGE__->table("review");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 product

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 impact

  data_type: 'integer'
  is_nullable: 0

=head2 html_text

  data_type: 'text'
  is_nullable: 0

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 book

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 library

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 visitor

  data_type: 'integer'
  is_nullable: 1

=head2 visitor_name

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 visitor_ip

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 rating

  data_type: 'integer'
  is_nullable: 1

=head2 cnt

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 approved

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 library_id_review

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 status

  data_type: 'tinyint'
  is_nullable: 1

=head2 pomocna

  data_type: 'integer'
  is_nullable: 0

=head2 user

  data_type: 'integer'
  is_nullable: 1

=head2 datetime

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "product",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "impact",
  { data_type => "integer", is_nullable => 0 },
  "html_text",
  { data_type => "text", is_nullable => 0 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "book",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "library",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "visitor",
  { data_type => "integer", is_nullable => 1 },
  "visitor_name",
  { data_type => "char", is_nullable => 1, size => 16 },
  "visitor_ip",
  { data_type => "char", is_nullable => 1, size => 16 },
  "rating",
  { data_type => "integer", is_nullable => 1 },
  "cnt",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "approved",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "library_id_review",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "status",
  { data_type => "tinyint", is_nullable => 1 },
  "pomocna",
  { data_type => "integer", is_nullable => 0 },
  "user",
  { data_type => "integer", is_nullable => 1 },
  "datetime",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<library>

=over 4

=item * L</library>

=item * L</library_id_review>

=back

=cut

__PACKAGE__->add_unique_constraint("library", ["library", "library_id_review"]);

=head1 RELATIONS

=head2 book

Type: belongs_to

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->belongs_to(
  "book",
  "DB::Result::Book",
  { id => "book" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 books

Type: has_many

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->has_many(
  "books",
  "DB::Result::Book",
  { "foreign.review" => "self.id" },
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

=head2 product

Type: belongs_to

Related object: L<DB::Result::Product>

=cut

__PACKAGE__->belongs_to(
  "product",
  "DB::Result::Product",
  { id => "product" },
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
  { "foreign.review" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-03-09 01:34:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:epfsvz8I1diyX/v/3J/YyQ

use Data::Dumper;
use HTML::StripTags qw(strip_tags);

sub visitor_blurred_ip {
    my($review) = @_;
    my $ip = $review->visitor_ip;
    return unless($ip);
    $ip =~ s/\.\d+$/.../;
    return $ip;
}

sub to_info {
    my($review) = @_;
    return unless($review->html_text);
    my $dt = DateTime::Format::ISO8601->parse_datetime($review->created);
    my %res = (
     	'created', $dt->datetime,
        'html_text', $review->html_text,
        #'impact', $review->impact,
    );
    $res{rating} = $review->rating if ($review->rating);
    if ($review->library) {
    	$res{sigla} = $review->library->get_column('code') if ($review->library->get_column('code') ne '');
    	$res{library_name} = $review->library->get_column('name') if ($review->library->get_column('name') ne '');
    	$res{id} = $review->library_id_review if ($review->library_id_review && $review->library->get_column('code') ne '');
    	$res{id} = $review->id unless (defined $review->library_id_review);
    }
    #$res{visitor_name} = $review->visitor_name if ($review->visitor_name);
    #$res{visitor_ip} = $review->visitor_blurred_ip if ($review->visitor_name);
    
    return \%res;
}

sub to_annotation_info {
    my($review) = @_;
    return unless($review->html_text);
    my $html = $review->html_text;
    $html = strip_tags($html);
    #$html =~ s/<br>/ /g; $html =~ s/<br\/>/ /g; $html =~ s/<br \/>/ /g;
    #return if($html =~ /<\//); # nechceme texty s tagy
    
    my %res = (
    	'html', $html
    );
    if ($review->library) {
    	$res{source} = $review->library->get_column('name') if ($review->library->get_column('name') ne '');
    	$res{id} = $review->library_id_review if ($review->library_id_review && $review->library->get_column('code') ne '');
    } else {
    	$res{source} = 'Web obalkyknih.cz';
    }
    
    return \%res;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
