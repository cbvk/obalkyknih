
package Obalky::Media;

use Data::Dumper;
use Obalky::Tools;
use Carp;
use utf8;

# TODO: presunout #file do #cover

our $REVIEW_ANNOTATION = 0;
our $REVIEW_REVIEW     = 1;
our $REVIEW_VOTE       = 8;
our $REVIEW_COMMENT    = 9;

my @keys = qw/cover_url cover_tmpfile tocpdf_url tocpdf_tmpfile toctext 
			  toc_firstpage
			  price_vat price_cur review_html review_impact review_rating/;

sub new {
	my($pkg,$object) = @_;
	my $media = bless {}, $pkg;
	$media->{price_vat} = $object->price_vat;
	$media->{price_cur} = $object->price_cur;
#	$media->{rating}    = $object->rating;

	# TODO.. cover, toc, ...
	# die "Not implemented!";
	return $media;
}

sub new_from_info {
	my($pkg,$info) = @_;
	# return bless $info, $pkg; # ?
	my $media = bless {}, $pkg;
		#year => $param->{year},
	map $media->{$_} = $info->{$_}, grep defined $info->{$_}, @keys;
	return $media;
}

sub save_to {
	my($media,$product) = @_; # jen product? nema teda byt v productu?
	warn "media->save_to(product) saving ".$media->{cover_url}." to ".$product->id."\n";
	die ref $product unless((ref $product) =~ /Product/);

	my $book = $product->book;

	# 1. Cover
	# vytvor cover jen pokud je novy/lisi-se
	my $cover_url = $media->{cover_url};
	if($cover_url) {
		my $tmp = $media->{cover_tmpfile};
		unless($tmp) {
			my $TMP_DIR = "/tmp/.obalky-media"; mkdir $TMP_DIR;
			$tmp = Obalky::Tools->wget_to_file(
						$cover_url, "$TMP_DIR/cover-".$product->id);
		}
		$cover = DB->resultset('Cover')->create_from_file($book,$product,$tmp);
		$cover->update({ orig_url => $cover_url }) if($cover);
		$product->update({ cover => $cover });
	}

	# 2. TOC
	my $toc_text = $media->{toctext};
	my $toc_url  = $media->{tocpdf_url};
	my $toc_tmp  = $media->{tocpdf_tmpfile};
	my $toc_firstpage = $media->{toc_firstpage}; # toto je hack
	warn "save_to: toc_firstpage=$toc_firstpage\n";
	if($toc_text or $toc_url or $toc_tmp) {
		$toc = DB->resultset('Toc')->find_or_create(
			{ product => $product, book => $book },{ key => 'toc_product' });
		if($toc_url or $toc_tmp) {
			my $content = $toc_tmp ? 
				Obalky::Tools->slurp($toc_tmp) : Obalky::Tools->wget($toc_url);
			$toc->set_pdf($toc_url,$content,$toc_tmp,$toc_firstpage);
		}
		if($toc_text) {
			$toc->update({ full_text => $toc_text });
		}
		$product->update({ toc => $toc });
		$book->update({ toc => $toc });
	}

	# 3. Review
	if($media->{review_html} or $media->{review_rating}) {
		die unless(defined $media->{review_impact});
#		$review = DB->resultset('Review')->find_or_create(
#			{ product => $product },{ key => 'review_product' });
		my $review = eval { DB->resultset('Review')->create({ 
			book => $book, product => $product,
			html_text => $media->{review_html},
			rating => $media->{review_rating},
			impact => $media->{review_impact} 
		}) };
		$book->recalc_rating;
		$book->recalc_review;
	}

	# 4. Price
	if($media->{price_vat}) {
		die unless($media->{price_cur});
		$product->update({ price_vat => $media->{price_vat},
						   price_cur => $media->{price_cur} });
	}

}

sub price_human {
	my($media) = @_;
	my($vat,$cur) = ($media->{price_vat}, $media->{price_cur});
	return "" unless $vat;
	return '$'.$vat   if($cur eq 'USD');
	return $vat." Kč"  if($cur eq 'CZK'); # jeste , misto .
	return '€ '.$vat   if($cur eq 'EUR');
	return $cur." ".$vat;
}

1;
