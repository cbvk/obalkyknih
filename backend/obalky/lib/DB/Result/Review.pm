package DB::Result::Review;

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

DB::Result::Review

=cut

__PACKAGE__->table("review");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
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

=head2 impact

  data_type: 'integer'
  is_nullable: 0

=head2 product

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 library

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 visitor

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 visitor_name

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 visitor_ip

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 approved

  data_type: 'integer'
  is_nullable: 1

=head2 rating

  data_type: 'integer'
  is_nullable: 1

=head2 html_text

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "book",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "impact",
  { data_type => "integer", is_nullable => 0 },
  "product",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "library",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "visitor",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "visitor_name",
  { data_type => "char", is_nullable => 1, size => 16 },
  "visitor_ip",
  { data_type => "char", is_nullable => 1, size => 16 },
  "approved",
  { data_type => "integer", is_nullable => 1 },
  "rating",
  { data_type => "integer", is_nullable => 1 },
  "html_text",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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

=head2 book

Type: belongs_to

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->belongs_to(
  "book",
  "DB::Result::Book",
  { id => "book" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
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
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
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
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 visitor

Type: belongs_to

Related object: L<DB::Result::Visitor>

=cut

__PACKAGE__->belongs_to(
  "visitor",
  "DB::Result::Visitor",
  { id => "visitor" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-11-27 06:34:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h8LiCH8u0k+HE8XmlFPYXg

use utf8;

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
    return {
#       visitor_ip => $review->visitor_blurred_ip,
#       visitor_name => $review->visitor_name,
        impact => $review->impact,
        html_text => $review->html_text,
        rating => $review->rating,
    };
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
