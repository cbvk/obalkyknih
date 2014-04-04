package DB::Result::Toc;

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

DB::Result::Toc

=cut

__PACKAGE__->table("toc");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 product

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 book

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
  "book",
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
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("toc_product", ["product"]);

=head1 RELATIONS

=head2 books

Type: has_many

Related object: L<DB::Result::Book>

=cut

__PACKAGE__->has_many(
  "books",
  "DB::Result::Book",
  { "foreign.toc" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 products

Type: has_many

Related object: L<DB::Result::Product>

=cut

__PACKAGE__->has_many(
  "products",
  "DB::Result::Product",
  { "foreign.toc" => "self.id" },
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
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
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


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-11-27 06:34:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9VASlHBr4rgc5UfhGkgQjQ

use Obalky::Config;
use Obalky::Tools;
use utf8;

sub set_pdf {
	my($toc,$url,$content,$tmpfile,$firstpage) = @_;
	$toc->update({ pdf_url => $url, pdf_file => $content });
	$toc->make_thumbnail($content,$tmpfile,$firstpage);
}

sub to_xml {
	my($toc) = @_;
	my $text = $toc->full_text;
	return "" unless($text);
	unless($toc->product) {
		warn $toc->id." no product\n";
		return "";
	}
#	my $book = $toc->book;
	my $book = $toc->product->book;
	unless($book) {
		warn $toc->id." no book ".$toc->book."\n";
		return "";
	}
	my $bibinfo = Obalky::BibInfo->new($book);
	return "\t<book>\n".$bibinfo->to_xml.
			"\t\t<toc>".HTML::Tiny->entity_encode($text).
			"</toc>\n"."\t</book>\n";
}

sub make_thumbnail {
	my($toc,$content,$pdf,$firstpage) = @_;
	unless($pdf) {
		$pdf = "/tmp/toc_make_thumbnail.pdf";
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
		die "Weird dimensions of $pdf TOC...";
	}
	my $xoff = 1+int(($max_width-$wN)/2);
	my $yoff = 1+int(($max_height-$hN)/2);
	my $result = "/tmp/.toc-$$-result.png";
	system("composite -compose atop -geometry +$xoff+$yoff $obsahN ".
			$Obalky::Config::FRAME_IMG." ".$result) and 
		warn $toc->id.": Failed to thumbnail TOC from $pdf\n";
	$toc->update({ pdf_thumbnail => Obalky::Tools->slurp($result) })
		if(-f $result);
	unlink $obsah0, $obsah1, $result;
}

sub get_relative_url {
    my($toc,$method) = @_;
    return "/file/toc/".$toc->id."/".$method;
}
sub get_absolute_url {
    my($toc,$method,$secure) = @_;
    return Obalky::Config->url($secure).$toc->get_relative_url($method);
}
sub get_pdf_url       { 
    my($toc,$secure) = @_;
    shift->get_absolute_url('pdf',$secure) 
}
sub get_thumbnail_url { 
    my($toc,$secure) = @_;
       shift->get_absolute_url('thumbnail',$secure) 
}
sub get_text_url      { 
    my($toc,$secure) = @_;
    shift->get_absolute_url('text',$secure) 
}

sub get_file {
	my($toc,$method) = @_;
	return ("image/png",$toc->pdf_thumbnail,"jpeg") if($method eq 'thumbnail');
	return ("application/pdf",$toc->pdf_file,"pdf") if($method eq 'pdf');
	return ("text/plain",$toc->full_text,"txt")     if($method eq 'text');
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
