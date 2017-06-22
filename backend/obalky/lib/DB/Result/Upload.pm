use utf8;
package DB::Result::Upload;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Upload

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

=head1 TABLE: C<upload>

=cut

__PACKAGE__->table("upload");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 product

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 batch

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 origname

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=head2 orig_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 filename

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 checksum

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
  size: 32

=head2 auth_id

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 ismn

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "product",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "batch",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "origname",
  { data_type => "varchar", is_nullable => 0, size => 128 },
  "orig_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "filename",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "checksum",
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
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "auth_id",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "ismn",
  { data_type => "varchar", is_nullable => 1, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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

=head2 user

Type: belongs_to

Related object: L<DB::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "DB::Result::User",
  { id => "user" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2017-05-02 11:09:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:I9tFBKAHhMcycmja5h5yzg


use Data::Dumper;
use File::Copy;
use MD5;

use LWP::UserAgent;
use Business::ISBN;

sub cover_url {
	my($upload) = @_;
	return $Obalky::Config::WWW_URL.$upload->file_url;
}
sub cover_tmpfile {
	my($upload) = @_;
	return $Obalky::Config::WWW_DIR.$upload->file_url;
}

sub file_url {
	my($upload) = @_;
	return "/upload/".$upload->batch."/".$upload->filename;
}

sub checked {
	my($upload) = @_;
#	return 0 unless($upload->isbn);
#	return 0 unless($upload->check_isbn_format($upload->isbn));
#	return 0 if($upload->check_duplicit_isbn);
	return 0 if($upload->check_duplicit_book);
	return 0 if($upload->check_duplicit_file);
	return 1;
}

sub check_duplicit_isbn {
	my($upload) = @_;
	return $upload->{cache_isbn} if(defined $upload->{cache_isbn});
	# nebo volat find_by_isbn ? v array contextu vracet pole?
	return undef unless($upload->ean13);
	my @books = DB->resultset('Book')->find_by_ean13($upload->ean13);
	return undef unless(@books);
	return $upload->{cache_isbn} = join(" ",map $_->to_isbn, @books);
}

sub check_duplicit_file {
	my($upload) = @_;
	return $upload->{cache_file} if(defined $upload->{cache_file});
	my @objects = DB->resultset('Cover')->search({
					checksum => $upload->checksum });
	return undef unless(@objects);
	## predpokladame, ze je duplicitni jen s jednou dalsi
	return $upload->{cache_file} = join(" ",map $_->id, @objects);
}

sub check_duplicit_book {
	my($upload) = @_;
	my $book;
	my $bibinfo = Obalky::BibInfo->new_from_params({
		ean13 => $upload->get_column('ean13'),
		nbn => $upload->get_column('nbn'),
		oclc => $upload->get_column('oclc')
	});
	$book = DB->resultset('Book')->find_by_bibinfo($bibinfo) if ($bibinfo);
	return 0 unless ($book);
	return 0 unless ($book->cover);
	return $book;
}

sub check_isbn_format { # aktualne vzdy vraci OK
	my($upload) = @_;
	my $bibinfo = Obalky::BibInfo->new($upload);
	return $bibinfo ? 1 : 0;
}

sub thumbfile {
	my($upload) = @_;
	return "/upload/".$upload->batch."/".$upload->filename;
}

sub bibinfo { Obalky::BibInfo->new(shift) }

sub to_isbn { shift->bibinfo->to_isbn }

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
