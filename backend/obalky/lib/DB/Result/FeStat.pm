use utf8;
package DB::Result::FeStat;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::FeStat

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

=head1 TABLE: C<fe_stats>

=cut

__PACKAGE__->table("fe_stats");

=head1 ACCESSORS

=head2 id_fe_stats

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 id_fe_list

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 id_library

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 library_code

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 timestamp

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 uptime

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=head2 timeout_count

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 etag_match

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 etag_toc_pdf_match

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 etag_toc_thumbnail_match

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 etag_file_match

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 file_requests

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 meta_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 meta_fetches

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 cover_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 cover_api_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 cover_fetches

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 cover_notfound

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 toc_thumbnail_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 toc_thumbnail_api_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 toc_thumbnail_fetches

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 toc_thumbnail_notfound

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 toc_pdf_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 toc_pdf_api_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 toc_pdf_notfound

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 meta_removes

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 cover_removes

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 toc_thumbnail_removes

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 apiruntime_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 unbound_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 operative_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_timeout_count

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_etag_match

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_etag_toc_pdf_match

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_etag_toc_thumbnail_match

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_etag_file_match

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_file_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_meta_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_meta_fetches

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_cover_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_cover_api_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_cover_fetches

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_cover_notfound

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_toc_thumbnail_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_toc_thumbnail_api_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_toc_thumbnail_fetches

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_toc_thumbnail_notfound

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_toc_pdf_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_toc_pdf_api_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_toc_pdf_notfound

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_meta_removes

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_cover_removes

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_toc_thumbnail_removes

  data_type: 'mediumint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_apiruntime_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_unbound_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_operative_requests

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_meta_count

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_cover_count

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_logs_count

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 flag_restarted

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id_fe_stats",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "id_fe_list",
  { data_type => "tinyint", extra => { unsigned => 1 }, is_nullable => 0 },
  "id_library",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "library_code",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "timestamp",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "uptime",
  { data_type => "varchar", is_nullable => 0, size => 128 },
  "timeout_count",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "etag_match",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "etag_toc_pdf_match",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "etag_toc_thumbnail_match",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "etag_file_match",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "file_requests",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "meta_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "meta_fetches",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "cover_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "cover_api_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "cover_fetches",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "cover_notfound",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "toc_thumbnail_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "toc_thumbnail_api_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "toc_thumbnail_fetches",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "toc_thumbnail_notfound",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "toc_pdf_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "toc_pdf_api_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "toc_pdf_notfound",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "meta_removes",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "cover_removes",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "toc_thumbnail_removes",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "apiruntime_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "unbound_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "operative_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_timeout_count",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_etag_match",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_etag_toc_pdf_match",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_etag_toc_thumbnail_match",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_etag_file_match",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_file_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_meta_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_meta_fetches",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_cover_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_cover_api_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_cover_fetches",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_cover_notfound",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_toc_thumbnail_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_toc_thumbnail_api_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_toc_thumbnail_fetches",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_toc_thumbnail_notfound",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_toc_pdf_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_toc_pdf_api_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_toc_pdf_notfound",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_meta_removes",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_cover_removes",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_toc_thumbnail_removes",
  { data_type => "mediumint", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_apiruntime_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_unbound_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_operative_requests",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_meta_count",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_cover_count",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "raw_logs_count",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "flag_restarted",
  {
    data_type => "tinyint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_fe_stats>

=back

=cut

__PACKAGE__->set_primary_key("id_fe_stats");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2018-08-10 03:39:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Og2z0AtTCLTnztOkImBxMA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

