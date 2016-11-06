

package Eshop::Zbozi;
use base 'Eshop::Mechanize';
use WWW::Mechanize;
use Data::Dumper;
use XML::Simple;
use Time::localtime;
use lib "../lib";
use strict;
use File::Path;# qw(make_path remove_tree);
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Encode;

use DB;
use strict;
use utf8;

__PACKAGE__->register(crawl => 1, license => 'licensed', czech => 0 );

sub download_toc {
	my($pkg,$tmp_dir,$item,$ean) = @_;

	my $firsttocfile;
	my $toc_file;

	if($item->{TOC}) {
		my $toc_dir = "$tmp_dir/$ean";
		system("rm -rf $toc_dir");
		mkdir $toc_dir or die;
		my $pages = $item->{TOC}->{PAGEURL} || [];
		foreach(my $i=0;$i<@$pages;$i++) {
			my $i4 = sprintf("%04d",$i); # budeme radit abecedne
			my $page = $pages->[$i];
			next unless($page);
			$firsttocfile = $page unless($firsttocfile);
#			warn "wget: $page\n";
			if(system("wget -q $page -O $toc_dir/$i4 >/dev/null")) {
				warn "$page: failed to wget!\n";
				return;
			}
		}
		$toc_file = "$tmp_dir/$ean.pdf";
		system("convert $toc_dir/* $toc_file");
		die "Konstrukce PDF z $toc_dir se nezdarila" unless(-s $toc_file);
		system("rm -rf $toc_dir");
	}
	return $toc_file;
}


sub process_shopitem {
	my($self,$tmp_dir,$item,$eshop) = @_;
	my $info;
	
	# custom elements
	my $custom_el_url = $eshop->get_column('xml_el_url');
	my $custom_el_isbn = $eshop->get_column('xml_el_isbn');
	my $custom_el_nbn = $eshop->get_column('xml_el_nbn');
	my $custom_el_title = $eshop->get_column('xml_el_title');
	my $custom_el_authors = $eshop->get_column('xml_el_authors');
	my $custom_el_description = $eshop->get_column('xml_el_description');
	my $custom_el_price_min = $eshop->get_column('xml_el_price_min');
	my $custom_el_price_max = $eshop->get_column('xml_el_price_max');
	my $custom_el_imgurl = $eshop->get_column('xml_el_imgurl');
	my $custom_el_year = $eshop->get_column('xml_el_year');
	my $custom_el_rating_count = $eshop->get_column('xml_el_rating_count');
	my $custom_el_rating_value = $eshop->get_column('xml_el_rating_value');
	my $custom_el_reviews_encap = $eshop->get_column('xml_el_reviews_encap');
	
	my ($custom_el_reviews_item,$custom_el_reviews_id,$custom_el_reviews_time,$custom_el_reviews_text,$custom_el_reviews_rating) = ('REVIEW','ID','TIME','SUMMARY','RATING');
	
	$custom_el_reviews_item = $eshop->get_column('xml_el_reviews_item') if ($eshop->get_column('xml_el_reviews_item'));
	$custom_el_reviews_id = $eshop->get_column('xml_el_reviews_id') if ($eshop->get_column('xml_el_reviews_id'));
	$custom_el_reviews_time = $eshop->get_column('xml_el_reviews_time') if ($eshop->get_column('xml_el_reviews_time'));
	$custom_el_reviews_text = $eshop->get_column('xml_el_reviews_text') if ($eshop->get_column('xml_el_reviews_text'));
	$custom_el_reviews_rating = $eshop->get_column('xml_el_reviews_rating') if ($eshop->get_column('xml_el_reviews_rating'));
	
	my ($custom_url,$custom_isbn,$custom_nbn,$custom_title,$custom_authors,$custom_description,$custom_price_min,$custom_price_max) = (undef,undef,undef,undef,undef,undef,undef,undef);
	my ($custom_imgurl,$custom_year,$custom_rating_count,$custom_rating_value,$custom_reviews_encap,$custom_reviews_item,$custom_reviews_id,$custom_reviews_time,$custom_reviews_text,$custom_reviews_rating) = (undef,undef,undef,undef,undef,undef,undef,undef,undef,undef);
	
	$custom_url = $item->{ $custom_el_url } if ($custom_el_url);
	$custom_isbn = $item->{ $custom_el_isbn } if ($custom_el_isbn);
	$custom_nbn = $item->{ $custom_el_nbn } if ($custom_el_nbn);
	$custom_title = $item->{ $custom_el_title } if ($custom_el_title);
	$custom_authors = $item->{ $custom_el_authors } if ($custom_el_authors);
	$custom_description = $item->{ $custom_el_description } if ($custom_el_description);
	$custom_price_min = $item->{ $custom_el_price_min } if ($custom_el_price_min);
	$custom_price_max = $item->{ $custom_el_price_max } if ($custom_el_price_max);
	$custom_imgurl = $item->{ $custom_el_imgurl } if ($custom_el_imgurl);
	$custom_year = $item->{ $custom_el_year } if ($custom_el_year);
	$custom_rating_count = $item->{ $custom_el_rating_count } if ($custom_el_rating_count);
	$custom_rating_value = $item->{ $custom_el_rating_value } if ($custom_el_rating_value);
	$custom_reviews_encap = $item->{ $custom_el_reviews_encap } if ($custom_el_reviews_encap);
	
	my $product_url = $item->{URL} || $item->{URL_PRODUCT} || $custom_url or return;
	my $authors = $item->{AUTHORS} || $custom_authors || '';
	$product_url =~ s/^\<//; $product_url =~ s/\>$//; # MLP fix
	$authors =~ s/^\<//; $authors =~ s/\>$//; # MLP fix

	# DESCRIPTION	
	my $description = $item->{DESCRIPTION} || $custom_description;
	
	# ISBN, EAN
	my $ean = $item->{ISBN} || $item->{EAN} || $item->{PRODUCTNO} || $item->{PN} || $custom_isbn;
	$ean = @{$ean}[0] if (ref($ean) eq 'ARRAY');
	$ean = $1 if(not $ean and $description and $description =~ /\D([\d\-]{12,})\D/);
	if ($ean and $ean =~ /\w/) {
		my @eans = split(' ', $ean);
		$ean = $eans[0];
	}
	
	# MULTIPLE EANS (Zbozi.cz)
	my @eans; my @params;
	if ($item->{eans} and ref $item->{eans}->{ean} eq 'ARRAY') {
		my @xml_eans = @{$item->{eans}->{ean}};
		foreach my $ean_tmp (@xml_eans) {
			$ean_tmp = Obalky::BibInfo->parse_code($ean_tmp);
			next if ($ean_tmp ~~ @eans or (defined $ean and $ean eq $ean_tmp));
			if (not defined $ean) {
				$ean = $ean_tmp;
			} else {
				push @eans, $ean_tmp;
				push @params, { 'ean13'=>$ean_tmp, 'nbn'=>undef, 'oclc'=>undef };
			}
		}
	}
	$ean = $item->{eans}->{ean} if ($item->{eans} and ref($item->{eans}->{ean}) eq '');
	
	# Flexibooks: ebook ISBN
	$ean = $item->{isbn_ebook} if ($eshop->get_column('id')==7027 and !$ean);
	
	# NBN
	my $nbn;
	$nbn = $item->{NBN} || $custom_nbn;
	
	unless($ean or $nbn) {
		warn "EAN or NBN not found for $product_url\n";
		return;
	}
	
	# vseobecna nastaveni
	my $rating_multi = 1;
	$rating_multi = $eshop->get_column('rating_multiplier') if ($eshop and $eshop->get_column('rating_multiplier'));
	my $author_separator = '';
	$author_separator = $eshop->get_column('author_separator') if ($eshop and $eshop->get_column('author_separator'));
	
	# podpora stahovani po castech (for i in 0 .. 1 ; do ZBOZI_PART=$i ...)
	return if(defined $ENV{ZBOZI_PART} and $ean !~ /$ENV{ZBOZI_PART}$/);
	
	# titul
	my $title = $item->{PRODUCTNAME} || $item->{PRODUCT} || $custom_title;
	
	# flexibooks maji podtitul oddeleny v extra polozce
	$title = $title.': '.$item->{subname} if ($eshop->get_column('id')==7027 and $item->{subname} and $item->{subname} ne '');
	
	# autor muze byt v titulu oddelen napr. znakem ":"
	if ($author_separator ne '' && $authors eq '') {
		my @title_parts = split /$author_separator/, $title;
		if (scalar @title_parts == 2) {
			$authors = $title_parts[0];
			$title = $title_parts[1];
		}
	}
	
	# pokud titul obsahuje tagy
	if (ref($title) eq 'HASH') {
	    $title = join(' ', $title->{content});
	}
	
	if (defined $title) {
		$title =~ s/ - SLEVA \d+\%//g;
		$title =~ s/^<\s*//g;
		$title =~ s/\s*>$//g;
		$title =~ s/"$//g;
		$title =~ s/^"//g;
	}
	
	$info->{price_vat} = $item->{PRICE_VAT} || $item->{PRICE_MIN} || $custom_price_min;
	$info->{price_max} = $item->{PRICE_MAX} || $custom_price_max || undef;
	$info->{price_cur} = 'CZK';
	
	# PRICES IN ARRAY (Seznam.cz)
	if ($item->{price} and ref $item->{price} eq 'HASH') {
		$info->{price_vat} = $item->{price}{from} if ($item->{price}{from});
		$info->{price_max} =  $item->{price}{to} if ($item->{price}{to});
	}
	
	# ANOTACE
	$info->{review_impact} = $Obalky::Media::REVIEW_ANNOTATION;
	$info->{review_html} = $item->{DESCRIPTION} || $custom_description;
	$info->{review_html} =~ s/"$//g;
	$info->{review_html} =~ s/^"//g;
	$info->{review_library} = $eshop->get_column('library') if ($eshop);
	
	# INFORMACE V ELEMENTU <PARAM>
	# v soucasnosti se tady hleda pouze autor
	my @param_items;
	my $param_items = $item->{PARAM} if ($item->{PARAM});
	@param_items = @{$param_items} if (ref $param_items eq 'ARRAY');
	push @param_items, $param_items if (ref $param_items eq 'HASH');
	if (scalar @param_items) {
		foreach my $param (@param_items) {
			$authors = $param->{VAL} if ($param->{PARAM_NAME} eq 'Autor');
		}
	}
	
	
	# COVER
	my $cover_url = $item->{IMGURL} || $item->{URL_IMG} || $custom_imgurl;
	my $process_cover = 1;
	$process_cover = 0 if ($eshop->get_column('process_cover') == 0);
	if($cover_url and $process_cover) {
	
		# knihy.abz.cz dava Zbozi.cz jen prtave nahledy, oprav na fullsize
		$cover_url =~ s/^(.*knihy.abz.cz.*)\_zbozi(.*)/$1_main$2/;
		warn "$ean: $cover_url\n" if($ENV{DEBUG});
		
		my $ext = $1 if($cover_url =~ /\.(jpe?g|pdf|txt|png|tiff?|gif)$/i);
		unless($ext) {
			warn "Neznama pripona v $cover_url\n";
			return;
		}
		my $temp_file = $ean || $nbn;
		my $temp = "$tmp_dir/$temp_file.$ext";
		system ("wget -q $cover_url -O $temp >/dev/null") and return;
		
		$info->{cover_url} = $cover_url;
		$info->{cover_tmpfile} = $temp;
	}
	
	# UNCOMMITED COVERS
	my @covers_uncommited;
	if ($item->{images} and ref $item->{images}->{image} eq 'ARRAY') {
		my @xml_covers = @{$item->{images}->{image}};
		map { push @covers_uncommited, $_; } @xml_covers;
	}
	push @covers_uncommited, $item->{images}->{image} if ($item->{images} and ref $item->{images}->{image} eq '');
	
	# zpracuj obsahy ve formatu MLP
	# $info->{tocpdf_url} = $firsttocfile; # to ma vest k nam na PDF
	$info->{tocpdf_tmpfile} = $self->download_toc($tmp_dir,$item,$ean);
	
	
	# HODNOCENI
	my $rating_count = $item->{RATING_COUNT} || $custom_rating_count;
	my $rating_value = $item->{RATING_VALUE} || $custom_rating_value;
	if($rating_count and $rating_value) {
		$rating_value = $rating_value * $rating_multi;
		$info->{rating_count} = $rating_count;
		$info->{rating_value} = $rating_value;
	}
	
	# HODNOCENI V POLI (Seznam.cz)
	if ($item->{rating} and ref $item->{rating} eq 'HASH') {
		$info->{rating_count} = $item->{rating}{count} if ($item->{rating}{count});
		$info->{rating_value} =  $item->{rating}{score} if ($item->{rating}{score});
		$info->{rating_value} =~ s/%//g;
	}
	
	# KOMENTARE
	my $reviews_encap = $item->{REVIEWS} || $custom_reviews_encap;
	if ($reviews_encap and $eshop) {
		$info->{review_library} = $eshop->get_column('library');
		my @reviews;
		my @reviews_array;
		my $review_item = $reviews_encap->{REVIEW} || $reviews_encap->{ $custom_el_reviews_item };
		@reviews_array = @{$review_item} if (ref $review_item eq 'ARRAY');
		push @reviews_array, $review_item if (ref $review_item eq 'HASH');
		
		foreach my $review (@reviews_array) {
			next unless ($review->{SUMMARY} or $review->{$custom_el_reviews_text});
			
			my $reviewText = $review->{SUMMARY} || $review->{$custom_el_reviews_text};
			
			my $reviewRating = $review->{RATING} || $review->{$custom_el_reviews_rating};
			$reviewRating =~ s/%//g;
			
			my $reviewTime = $review->{TIME} || $review->{$custom_el_reviews_time};
			if (defined $reviewTime and $reviewTime =~ /(\d+)\.(\d+)\.(\d+)/) {
				$reviewTime = $3 . '-' . $2 . '-' . $1;
			}
			
			my $reviewId;
			$reviewId = $review->{ID} || $review->{$custom_el_reviews_id};
			$reviewId = md5_hex(encode_utf8($ean . $reviewTime . $reviewText));
			
			push @reviews, {
				'id' => $reviewId,
				'time' => $reviewTime,
				'html_text' => $reviewText,
				'rating' => $reviewRating * $rating_multi
			};
		};
		$info->{reviews_list} = \@reviews;
	}
	
    my $bibinfo = Obalky::BibInfo->new_from_params({
		ean => $ean,
		nbn => $nbn,
		title => $title,
		authors=> $authors,
		year => $item->{ROKVYDANI} || $custom_year
    });
	my $media = Obalky::Media->new_from_info( $info );

	# rmdir "/tmp/cover.$$.$temp_file";
	return [ $bibinfo,$media,$product_url,\@covers_uncommited,\@params ];
}

sub crawl {
	my($self,$storable,$from,$to,$tmp_dir,$feed_url,$eshop) = @_;

	return [] unless($feed_url);
	
	#setup
	my $el_shopitem = 'SHOPITEM';
	$el_shopitem = $eshop->get_column('xml_el_shopitem') if ($eshop->get_column('xml_el_shopitem'));

	system("wget -q $feed_url -O $tmp_dir/feed.xml") and die "$tmp_dir: $!";
	warn "Got xml feed\n" if($ENV{DEBUG});
	
	my $max = 35000;
	$max = $ENV{OBALKY_ESHOP_ITEMS} if ($ENV{OBALKY_ESHOP_ITEMS});
	
	my $tm = localtime;
	my $date = $tm->mday."-".$tm->mon."-".$tm->year;

	# maji blbe psane kodovani
	#  $xml_content =~ s/windows-1250/utf-8/ if($feed_url =~ /fragment/); 
	#  $xml_content =~ s/iso-8859-2/utf-8/ if($feed_url =~ /knihy.abz.cz/);
	my $xml_content =~ s/windows-1250/utf-8/ if($feed_url =~ /mlp.cz/);

	my $xml = eval { XMLin("$tmp_dir/feed.xml",
		SuppressEmpty => 1, ForceArray => [$el_shopitem,"PAGEURL"], KeyAttr => []); };
	if($@) {
		warn "$feed_url: $@";
		return ();
	}

	my $demo = $ENV{DEBUG} ? 35000 : 3_000_000; # vsechno naraz..

	my $items = @{$xml->{$el_shopitem}};
	warn "$items SHOPITEMs\n" if($ENV{DEBUG});
	
	my @books;
	my @xml_items = @{$xml->{$el_shopitem}};
	warn 'XML contains '.(scalar @xml_items).' items' if($ENV{DEBUG} and $ENV{DEBUG} > 1);
	my $i = 0;
	foreach my $item (@xml_items) {

		# do $storable cache ukladej $md5 serializovaneho XML a timestamp
		my $md5 = md5_hex(encode_utf8(XMLout($item)));
		my $lastmonth = time-31*24*60*60; # znovu sklid starsi nez mesic
		next if($storable->{$md5} and $storable->{$md5} > $lastmonth);
		$storable->{$md5} = time;

		my $book = $self->process_shopitem($tmp_dir,$item,$eshop);
		warn Dumper($book) if($ENV{DEBUG} and $ENV{DEBUG} > 1);
		push @books, $book if($book);
		last unless($demo--);
		
		$i++;
		warn 'crawl #'.$i if ($i % 50 == 0 and $ENV{OBALKY_ESHOP});
		last if ($i >= $max);
	}
	return @books;
}


1;
