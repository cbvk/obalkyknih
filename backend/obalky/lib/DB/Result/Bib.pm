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

=head2 abuses

Type: has_many

Related object: L<DB::Result::Abuse>

=cut

__PACKAGE__->has_many(
  "abuses",
  "DB::Result::Abuse",
  { "foreign.bib" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 books

Type: has_many

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->has_many(
  "books",
  "DB::Result::Book",
  { "foreign.bib" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

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

=head2 products

Type: has_many

Related object: L<DB::Result::Product>

=cut

__PACKAGE__->has_many(
  "products",
  "DB::Result::Product",
  { "foreign.bib" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2018-11-13 16:40:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VsSWiU8Dd9CFvFBEcldCTA

use Obalky::Config;
use Obalky::Tools;

sub set_pdf {
	my($bib,$url,$content,$tmpfile,$firstpage) = @_;
	$bib->update({ pdf_url => $url, pdf_file => undef });
	$bib->make_thumbnail($content,$tmpfile,$firstpage);
	#PDF files are grouped in dir
	my $dirGroupName = int($bib->get_column('id')/10000+1)*10000;
	mkdir($Obalky::Config::BIB_DIR.'/'.$dirGroupName) unless (-d $Obalky::Config::BIB_DIR.'/'.$dirGroupName);
	#place PDF onto file system
	open(OUTFILE, ">".$Obalky::Config::BIB_DIR.'/'.$dirGroupName.'/'.$bib->get_column('id').'.pdf');
	print OUTFILE $content;
	close(OUTFILE);
}

sub make_thumbnail {
	my($bib,$content,$pdf,$firstpage) = @_;
	unless($pdf) {
		$pdf = "/tmp/bib_make_thumbnail.pdf";
		open(PDF,">",$pdf) or die;
		print PDF $content; close(PDF) or die;
	}
	warn "firstpage=$firstpage\n";
	$pdf = $firstpage if($firstpage);
	my $max_height = $Obalky::Config::MEDIUM_HEIGHT-4; # 236
	my $max_width  = $Obalky::Config::MEDIUM_WIDTH-4;  # 166
	my $obsah0 = "/tmp/.obsah-$$-0.png";
	my $obsah1 = "/tmp/.obsah-$$-1.png";
	system("convert ".$pdf."[0] -resize x".$max_height." $obsah0");
	system("convert ".$pdf."[0] -resize ".$max_width."x $obsah1");
	my($w0,$h0) = Obalky::Tools->image_size($obsah0);
	my($w1,$h1) = Obalky::Tools->image_size($obsah1);
	my($wN,$hN,$obsahN);
	if($w0 <= $max_width and $h0 <= $max_height) {
		($wN,$hN,$obsahN) = ($w0,$h0,$obsah0);
	} elsif($w1 <= $max_width and $h1 <= $max_height) {
		($wN,$hN,$obsahN) = ($w1,$h1,$obsah1);
	} else {
		die "Weird dimensions of $pdf BIB...";
	}
	my $xoff = 1+int(($max_width-$wN)/2);
	my $yoff = 1+int(($max_height-$hN)/2);
	my $result = "/tmp/.bib-$$-result.png";
	system("composite -compose atop -geometry +$xoff+$yoff $obsahN ".
			$Obalky::Config::FRAME_IMG." ".$result) and 
		warn $bib->id.": Failed to thumbnail BIB from $pdf\n";
	$bib->update({ pdf_thumbnail => Obalky::Tools->slurp($result) })
		if(-f $result);
	unlink $obsah0, $obsah1, $result;
}

sub get_relative_url {
    my($bib,$method) = @_;
    return "/file/bib/".$bib->id."/".$method;
}
sub get_absolute_url {
    my($bib,$method,$secure) = @_;
    return Obalky::Config->url($secure).$bib->get_relative_url($method);
}
sub get_pdf_url       { 
    my($bib,$secure) = @_;
    shift->get_absolute_url('pdf',$secure) 
}
sub get_thumbnail_url { 
    my($bib,$secure) = @_;
       shift->get_absolute_url('thumbnail',$secure) 
}
sub get_text_url      { 
    my($bib,$secure) = @_;
    shift->get_absolute_url('text',$secure) 
}

sub get_file {
	my($bib,$method) = @_;
	return ("image/png",$bib->pdf_thumbnail,"jpeg") if($method eq 'thumbnail');
	return ("text/plain",$bib->full_text,"txt")     if($method eq 'text');
	# cele PDF ze souboroveho systemu, nebo DB jako odpoved /file/bib/#/pdf
	if($method eq 'pdf') {
		# z DB
		return ("application/pdf",$bib->pdf_file,"pdf") if($bib->pdf_file);
		# ze souboroveho systemu
		my $dirGroupName = int($bib->get_column('id')/10000+1)*10000;
		open(PDF, $Obalky::Config::BIB_DIR.'/'.$dirGroupName.'/'.$bib->get_column('id').'.pdf') or die "could not open PDF [$!]";
		binmode PDF;
		my $pdf_file = do { local $/; <PDF> };
		close(PDF);
		return ("application/pdf",$pdf_file,"pdf");
	}
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
