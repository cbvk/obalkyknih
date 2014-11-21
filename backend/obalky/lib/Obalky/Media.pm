
package Obalky::Media;

use Data::Dumper;
use Obalky::Tools;
use LWP::UserAgent;
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
	my $feSynced = 0;
	die ref $product unless((ref $product) =~ /Product/);

	my $book = $product->book;

	# 1. Cover
	# vytvor cover jen pokud je novy/lisi-se
	my $cover_url = $media->{cover_url};
	if($cover_url) {
		my $tmp = $media->{cover_tmpfile};
		unless($tmp) {
			my $TMP_DIR = "/tmp/.obalky-media"; mkdir $TMP_DIR;
			my $filename = "$TMP_DIR/cover-".$product->id;
			$tmp = Obalky::Tools->wget_to_file(
						$cover_url, $filename);
			
			unless (-e $filename) {
				my $browser = LWP::UserAgent->new;
				my @headers = (
					'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
					'Accept-Encoding' => 'gzip, deflate',
					'Accept-Language' => 'cs,en-us;q=0.7,en;q=0.3',
					'Referer' => 'http://www.obalkyknih.cz/',
					'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:32.0) Gecko/20100101 Firefox/32.0',
				);
				my $response = $browser->get($cover_url, @headers);
				if($response->is_success) {
					@IMG = $response->content;
					open(W,">$filename");
					binmode(W);
					print W @IMG;
					close(W);
					$tmp = $filename;
				}
			}
		}
		my $checksum_old = $book->cover ? $book->cover->checksum : undef;
		$cover = DB->resultset('Cover')->create_from_file($book,$product,$tmp);
		my $checksum_new = $cover->checksum;
		$cover->update({ orig_url => $cover_url }) if($cover);
		$product->update({ cover => $cover });
		
		# vyvolej synchronizacni udalost pokud obalka existuje
		if ($checksum_old ne $checksum_new) {
			my $bibinfo = Obalky::BibInfo->new($product);
			DB->resultset('FeSync')->request_sync_remove($bibinfo);
			$feSynced = 1;
		}
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
		
		# vyvolej synchronizacni udalost pri kazdem uploadu TOC
		if (!$feSynced) {
			my $bibinfo = Obalky::BibInfo->new($product);
			DB->resultset('FeSync')->request_sync_remove($bibinfo);
		}
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
