use utf8;
package DB::Result::Auth;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Auth

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

=head1 TABLE: C<auth>

=cut

__PACKAGE__->table("auth");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  is_nullable: 0
  size: 50

001

=head2 oai_identifier

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 oai_datestamp

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 auth_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

100$$a

=head2 auth_date

  data_type: 'varchar'
  is_nullable: 1
  size: 100

100$$d

=head2 auth_activity

  data_type: 'varchar'
  is_nullable: 1
  size: 255

372$$a

=head2 auth_occupation

  data_type: 'varchar'
  is_nullable: 1
  size: 255

374$$a

=head2 auth_biography

  data_type: 'text'
  is_nullable: 1

678$$a

=head2 auth_datestamp

  data_type: 'varchar'
  is_nullable: 1
  size: 20

005

=head2 nkp_aut_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

998a

=head2 cover

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 ts

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 harvest_max_eshop

  data_type: 'integer'
  is_nullable: 0

=head2 harvest_last_time

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 viafID

  accessor: 'viaf_id'
  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "oai_identifier",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "oai_datestamp",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "auth_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "auth_date",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "auth_activity",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "auth_occupation",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "auth_biography",
  { data_type => "text", is_nullable => 1 },
  "auth_datestamp",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "nkp_aut_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "cover",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "ts",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "harvest_max_eshop",
  { data_type => "integer", is_nullable => 0 },
  "harvest_last_time",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "viafID",
  { accessor => "viaf_id", data_type => "varchar", is_nullable => 1, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 abuses

Type: has_many

Related object: L<DB::Result::Abuse>

=cut

__PACKAGE__->has_many(
  "abuses",
  "DB::Result::Abuse",
  { "foreign.auth" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 auth_duplicates

Type: has_many

Related object: L<DB::Result::AuthDuplicate>

=cut

__PACKAGE__->has_many(
  "auth_duplicates",
  "DB::Result::AuthDuplicate",
  { "foreign.auth_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 auth_objs

Type: has_many

Related object: L<DB::Result::AuthObj>

=cut

__PACKAGE__->has_many(
  "auth_objs",
  "DB::Result::AuthObj",
  { "foreign.auth" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 auth_sources

Type: has_many

Related object: L<DB::Result::AuthSource>

=cut

__PACKAGE__->has_many(
  "auth_sources",
  "DB::Result::AuthSource",
  { "foreign.auth" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cover

Type: belongs_to

Related object: L<DB::Result::Cover>

=cut

__PACKAGE__->belongs_to(
  "cover",
  "DB::Result::Cover",
  { id => "cover" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 covers

Type: has_many

Related object: L<DB::Result::Cover>

=cut

__PACKAGE__->has_many(
  "covers",
  "DB::Result::Cover",
  { "foreign.auth" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2016-09-07 12:22:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1xJx9hLK0HX8/hvotCRu6g

use Data::Dumper;
use DB;
use File::Copy;
use Obalky::Config;
use Obalky::AuthInfo;

sub get_cover {
	my($auth) = @_;
	my $cover = $auth->cover;
	return $cover if($cover);
}

sub get_links {
	my($auth) = @_;
	my $links = DB->resultset('AuthObj')->search({ auth=>$auth->id, obj_type=>1 },{ limit=>20 });
	my @links;
	foreach ($links->all) {
		my $value = '';
		$value = $_->get_column('val') if (defined $_->get_column('val'));
		next if ($value eq ''); 
		push @links, $_;
	}
	return @links;
}

sub get_annotation {
	my($auth) = @_;
	my $ret = DB->resultset('AuthObj')->search({ auth=>$auth->id, obj_type=>2 },{ limit=>1 })->next;
	
	my $annotation;
	$annotation = $ret->get_column('val') if ($ret);
	
	return $annotation;
}

sub add_cover {
	my($auth,$media) = @_;
	
	# checksum - checksum originalu
	my $orig_file = $media->{cover_tmpfile};
    my $checksum = `md5sum $orig_file | head -c 32`;
	
	my $file = "/tmp/cover-cropped-". $auth->id .".png";
	# auto-crop, postup z http://www.imagemagick.org/Usage/crop/
	system("convert -bordercolor white -border 1x1 -fuzz '3%' -trim +repage '$orig_file' '$file'");

	my($width,$height) = Obalky::Tools->image_size($file);
	return unless($height);
	
	# zjisteni jestli uz obalka ma nejaky fileblob, nebo se bude zakladat novy
	my ($current_file_icon,$current_file_medium,$current_file_thumb,$current_file_orig) = (undef,undef,undef,undef);
	if (defined $auth->cover) {
		$current_file_icon = $auth->cover->file_icon;
		$current_file_medium = $auth->cover->file_medium;
		$current_file_thumb = $auth->cover->file_thumb;
		$current_file_orig = $auth->cover->file_orig;
	}

	my $file_icon = DB->resultset('Cover')->create_image_blob(
		$file,"cover-icon",$width,$height,
		$Obalky::Config::ICON_WIDTH,$Obalky::Config::ICON_HEIGHT,
		$current_file_icon);

	my $file_cover = DB->resultset('Cover')->create_image_blob(
		$file,"cover-medium",$width,$height,
		$Obalky::Config::MEDIUM_WIDTH,$Obalky::Config::MEDIUM_HEIGHT,
		$current_file_medium);

	my $file_thumb = DB->resultset('Cover')->create_image_blob(
		$file,"cover-thumb",$width,$height,
		$Obalky::Config::THUMB_WIDTH,$Obalky::Config::THUMB_HEIGHT,
		$current_file_thumb);

	my $file_orig = DB->resultset('Fileblob')->new_from_file("cover-orig",$orig_file,$current_file_orig);
	my $dirGroupName = int($file_orig/100000+1)*100000;
	my $orig_filename = $Obalky::Config::FILEBLOB_DIR.'/'.$dirGroupName.'/'.$file_orig;
	copy($orig_file, $Obalky::Config::FILEBLOB_DIR.'/'.$dirGroupName.'/'.$file_orig->id);

	my $cover = DB->resultset('Cover')->update_or_create({
		auth => $auth->id, checksum => $checksum,
		file_medium => $file_cover, file_thumb => $file_thumb,
		file_orig => $file_orig, file_icon => $file_icon, 
		orig_width => $width,    orig_height => $height,
		orig_url => $media->{cover_url}
    });
    
    # nemenit obrazek, pokud byl v minulosti nahlasen jako vadny
    my $abuse = DB->resultset('Abuse')->search({ auth=>$auth->id, cover=>$cover->id });
    
    $auth->update({ cover => $cover->id }) unless($abuse->next);
}

sub enrich {
	my($auth,$info,$authinfo,$secure,$params) = @_;
	
	$info->{auth_id} = $auth->id;
	
	# 1. Najdi cover
	my $cover = $auth->get_cover;
	if($cover) {
		$info->{cover_thumbnail_url} = $cover->get_thumbnail_url($secure);
		$info->{cover_medium_url}    = $cover->get_cover_url($secure);
		$info->{cover_icon_url}      = $cover->get_icon_url($secure);
		$info->{backlink_url}        = 'http://www.obalkyknih.cz/view_auth?auth_id='.$info->{auth_id};
		# publikovat originalni rozmery obrazku
		if ($cover->orig_width and $cover->orig_height) {
			$info->{orig_width}      = $cover->orig_width;
			$info->{orig_height}     = $cover->orig_height;
		}
	}
	
	# 2. Bibliograficka data
	my $author = '';
	$author = $auth->get_column('auth_name') if ($auth->get_column('auth_name'));
	$info->{auth_name} = (substr($author,-1) eq ',') ? substr($author,0,-1) : $author;
	$info->{auth_year} = $auth->get_column('auth_date') if ($auth->get_column('auth_date'));
	
	# 3. Odkazy
	$info->{links} = [];
	my @links = $auth->get_links;
	map {
		my $link = $_->link_to_info;
		push @{$info->{links}}, $link if($link);
	} @links;
	
	return $info;
}

sub authinfo {
	my($auth) = @_;
	return new Obalky::AuthInfo($auth);
}

sub actualize_by_source {
	my($auth,$source,$forced) = @_;
	my $invalidate = 0;
	
	# pokud se neco zmenilo, je potreba zaznam zneplatnit a pozadat taky FE o zneplatneni
	$invalidate = ($auth->cover->id!=$source->cover->id) ? 1 : 0 if ($auth->cover and $source->cover);
	$invalidate = ($auth->toc->id!=$source->toc->id) ? 1 : $invalidate if ($auth->toc and $source->toc);
	
	my ($oldPriority,$newPriority,$oldDim,$newDim) = (0,0,0,1); #init
	my $eshopId = $source->eshop->get_column('id');
	if ($auth && $auth->cover && $source && $source->cover) {
		my $resOldP = DB->resultset('AuthSource')->search({ auth=>$auth->id, cover=>$auth->cover->id });
		my $retOldP = $resOldP->next;
		$oldPriority = $retOldP->eshop->get_column('priority') if ($retOldP);
		$newPriority = $source->eshop->get_column('priority');
		$oldDim = $retOldP->cover->get_column('orig_width') * $retOldP->cover->get_column('orig_height') if ($retOldP);
		$newDim = $source->cover->get_column('orig_width') * $source->cover->get_column('orig_height');
	}
	
	if (($newPriority > $oldPriority) || (($newPriority == $oldPriority) && ($newDim > $oldDim))) {
		$auth->update({ cover => $source->cover })   if($source->cover);
	}
	
	$auth->invalidate($forced) if ($invalidate or $forced);
}

sub invalidate { # nutno volat po kazde zmene autora
	my($auth,$forced) = @_;
	DB->resultset('FeSync')->auth_sync_remove($auth->id, undef, $forced);
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
