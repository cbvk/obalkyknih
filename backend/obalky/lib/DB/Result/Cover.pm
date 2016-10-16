use utf8;
package DB::Result::Cover;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Cover

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

=head1 TABLE: C<cover>

=cut

__PACKAGE__->table("cover");

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

=head2 product

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 book

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 file_thumb

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 file_medium

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 file_icon

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 file_orig

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 orig_width

  data_type: 'integer'
  is_nullable: 1

=head2 orig_height

  data_type: 'integer'
  is_nullable: 1

=head2 checksum

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 orig_url

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 used_last

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 used_count

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 auth

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 1
  size: 50

=head2 auth_source

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
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
  "product",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "book",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "file_thumb",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "file_medium",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "file_icon",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "file_orig",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "orig_width",
  { data_type => "integer", is_nullable => 1 },
  "orig_height",
  { data_type => "integer", is_nullable => 1 },
  "checksum",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "orig_url",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "used_last",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "used_count",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "auth",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 1, size => 50 },
  "auth_source",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cover_auth_source>

=over 4

=item * L</auth_source>

=back

=cut

__PACKAGE__->add_unique_constraint("cover_auth_source", ["auth_source"]);

=head2 C<cover_checksum>

=over 4

=item * L</checksum>

=back

=cut

__PACKAGE__->add_unique_constraint("cover_checksum", ["checksum"]);

=head2 C<cover_product>

=over 4

=item * L</product>

=back

=cut

__PACKAGE__->add_unique_constraint("cover_product", ["product"]);

=head1 RELATIONS

=head2 abuses

Type: has_many

Related object: L<DB::Result::Abuse>

=cut

__PACKAGE__->has_many(
  "abuses",
  "DB::Result::Abuse",
  { "foreign.cover" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 auth

Type: belongs_to

Related object: L<DB::Result::Auth>

=cut

__PACKAGE__->belongs_to(
  "auth",
  "DB::Result::Auth",
  { id => "auth" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 auth_source

Type: belongs_to

Related object: L<DB::Result::AuthSource>

=cut

__PACKAGE__->belongs_to(
  "auth_source",
  "DB::Result::AuthSource",
  { id => "auth_source" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 auth_sources

Type: has_many

Related object: L<DB::Result::AuthSource>

=cut

__PACKAGE__->has_many(
  "auth_sources",
  "DB::Result::AuthSource",
  { "foreign.cover" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 auths

Type: has_many

Related object: L<DB::Result::Auth>

=cut

__PACKAGE__->has_many(
  "auths",
  "DB::Result::Auth",
  { "foreign.cover" => "self.id" },
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
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 books

Type: has_many

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->has_many(
  "books",
  "DB::Result::Book",
  { "foreign.cover" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 file_icon

Type: belongs_to

Related object: L<DB::Result::Fileblob>

=cut

__PACKAGE__->belongs_to(
  "file_icon",
  "DB::Result::Fileblob",
  { id => "file_icon" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 file_medium

Type: belongs_to

Related object: L<DB::Result::Fileblob>

=cut

__PACKAGE__->belongs_to(
  "file_medium",
  "DB::Result::Fileblob",
  { id => "file_medium" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 file_orig

Type: belongs_to

Related object: L<DB::Result::Fileblob>

=cut

__PACKAGE__->belongs_to(
  "file_orig",
  "DB::Result::Fileblob",
  { id => "file_orig" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 file_thumb

Type: belongs_to

Related object: L<DB::Result::Fileblob>

=cut

__PACKAGE__->belongs_to(
  "file_thumb",
  "DB::Result::Fileblob",
  { id => "file_thumb" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
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
  { "foreign.cover" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 requests

Type: has_many

Related object: L<DB::Result::Request>

=cut

__PACKAGE__->has_many(
  "requests",
  "DB::Result::Request",
  { "foreign.cover" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-08-07 00:32:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:K+1Lbp06bVcf3wf2XpTHSA

use Data::Dumper;
use Image::Info qw(image_info dim);
use DB;

sub is_generic { shift->id < 1_000_000 ? 1 : 0 }

sub js_callback {
	my($cover,$call_function,$call_argv,$secure) = @_;
	my $var;
	my($ow,$oh) = ($cover->orig_width,$cover->orig_height);
    my($cw,$ch) = Obalky::Tools->resize(180,240,$ow,$oh);
	my($tw,$th) = Obalky::Tools->resize(27,36,$ow,$oh);
	$call_function ||= 'obalky_callback';
	my %var = (
		id => $cover->id,
		thumbnail_width => $tw,
		thumbnail_height => $th,
		thumbnail_url => $cover->get_thumbnail_url($secure),
		cover_width => $cw,
		cover_height => $ch,
		cover_url => $cover->get_cover_url($secure),
		image_alt => '',
		backlink_url => $cover->book->get_obalkyknih_url($secure),
	);
	my @var;
	foreach(qw/id cover_width cover_height cover_url thumbnail_width 
				thumbnail_height thumbnail_url image_alt backlink_url/) {
		push @var, $_.":". ($_=~/(_width|_height)$/?
							($var{$_}||''):'"'.($var{$_}||'').'"');
	}
	$var = "{".join(",\n",@var)."}";

	return $call_argv ? "$call_function($var,\"$call_argv\")" 
					  : "$call_function($var)";
}

sub get_relative_url {
	my($cover,$method) = @_;
	return "/file/cover/".$cover->id."/".$method;
}
sub get_absolute_url {
	my($cover,$method,$secure) = @_;
	return Obalky::Config->url($secure).$cover->get_relative_url($method);
}
sub get_cover_url     { 
	my($cover,$secure) = @_;
    $cover->get_absolute_url('medium',$secure) 
}
sub get_thumbnail_url { 
	my($cover,$secure) = @_;
    $cover->get_absolute_url('thumbnail',$secure) 
}
sub get_icon_url { 
	my($cover,$secure) = @_;
    $cover->get_absolute_url('icon',$secure) 
}

sub get_preview510_url { 
	my($cover,$secure) = @_;
    $cover->get_absolute_url('preview510',$secure) 
}

# spacer: image/gif, [71,73,70,56,57,97,1,0,1,0,128,0,0,0,0,0,0,0,0,33,
#                     249,4,1,0,0,0,0,44,0,0,0,0,1,0,1,0,0,2,2,68,1,0,59]
sub get_file {
	my($cover,$method) = @_;
	return $cover->get_master() if ($method eq 'master');
	return $cover->get_preview($method) if ($method eq 'preview510');
    my $blob = $method eq 'medium' ? $cover->file_medium :
               $method eq 'thumbnail' ? $cover->file_thumb :
               $method eq 'thumb' ? $cover->file_thumb :
               $method eq 'icon' ? $cover->file_icon :
               $method eq 'original' ? $cover->file_orig : 
               $method eq 'orig' ? $cover->file_orig : $cover->file_thumb;
	my $content = $blob->content;
	my $ext = 'jpeg';
	$ext = 'png' if ($content and $content =~ /^.PNG/);
	return $blob ? ("image/$ext", $blob->content, $ext) : ();
}

sub get_master {
	my($cover) = @_;
	my $id = $cover->file_orig->id;
	my $dirGroupName = int($id/100000+1)*100000;
	my $img_filename = $Obalky::Config::FILEBLOB_DIR.'/'.$dirGroupName.'/'.$id;
	return () unless (-e $img_filename);
	
	my $info = image_info($img_filename);
	open FILE, $img_filename;
	my $file_contents = do { local $/; <FILE> };
	close (FILE);
	return ($info->{file_media_type}, $file_contents, $info->{file_ext});
}

sub get_preview {
	my($cover,$method) = @_;
	my $id = $cover->file_orig->id;
	my $dirGroupName = int($id/100000+1)*100000;
	my $orig_filename = $Obalky::Config::FILEBLOB_DIR.'/'.$dirGroupName.'/'.$id;
	return () unless (-e $orig_filename);
	
	# rozliseni a cache adresar
	my $width_wanted = 510;
	my $resampled_filename = $Obalky::Config::PREVIEW510_DIR.'/'.$dirGroupName.'/'.$id.'.png';
	my $width = $width_wanted;
	
	# kontrola existence uz resamplovaneho obrazku
	if (-e $resampled_filename) {
		open FILE, $resampled_filename;
		my $file_contents = do { local $/; <FILE> };
		close (FILE);
		return ('image/png', $file_contents, 'png');
	}
	
	# kontrola rozliseni; pokud je nizke nebude se resamplovat
	my $info = image_info($orig_filename);
	$width = $info->{width} if ($info->{width} <= $width and $info->{width} > 170);
	$width = 170 if ($info->{width} < 170);
	
	# resamplovani a ulozeni nahledu do cache adresare
	system('mkdir '.$Obalky::Config::PREVIEW510_DIR.'/'.$dirGroupName) unless (-e $Obalky::Config::PREVIEW510_DIR.'/'.$dirGroupName);
	system "convert -resize $width -dither FloydSteinberg $orig_filename png8:$resampled_filename" if ($width == $width_wanted);
	system "convert -resize $width $orig_filename png24:$resampled_filename" unless ($width == $width_wanted);
	
	# zaslani resamplovane verze z cache adresare
	return () unless (-e $resampled_filename);
	open FILE, $resampled_filename;
	my $file_contents = do { local $/; <FILE> };
	close (FILE);
	return ('image/png', $file_contents, 'png');
}	

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
