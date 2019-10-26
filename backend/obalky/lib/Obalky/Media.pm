
package Obalky::Media;

use Data::Dumper;
use Obalky::Tools;
use LWP::UserAgent;
use Carp;
use utf8;
use POSIX qw(ceil);

# TODO: presunout #file do #cover

our $REVIEW_ANNOTATION = 0;
our $REVIEW_REVIEW     = 1;
our $REVIEW_VOTE       = 8;
our $REVIEW_COMMENT    = 9;

my @keys = qw/cover_url cover_tmpfile tocpdf_url tocpdf_tmpfile toctext bibpdf_url bibpdf_tmpfile bibtext
			  toc_firstpage bib_firstpage
			  price_vat price_max price_cur
			  rating_count rating_value
			  review_html review_impact review_rating review_library reviews_list
			  wiki_url
			  annotation/; # reviews_list je seznam vicerych komentaru

sub new {
	my($pkg,$object) = @_;
	my $media = bless {}, $pkg;
	$media->{price_vat} = $object->price_vat;
	$media->{price_cur} = $object->price_cur;
	$media->{price_max} = $object->price_max if ($object->price_max);
#	$media->{rating}    = $object->rating;
	
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

sub save_to_source{
	my($media,$source,$downloadSuccess) = @_;

	my $auth = $source->auth;

	my $cover_url = $media->{cover_url};
	my $annotation = $media->{annotation};
	my $wiki_url = $media->{wiki_url};
	
	if($cover_url) {
		warn "media->save_to_source(product) saving ".$media->{cover_url}." to ".$source->id."\n";
		
		my $tmp = $media->{cover_tmpfile};
		unless($tmp) {
			my $TMP_DIR = "/tmp/.obalky-media"; mkdir $TMP_DIR;
			my $filename = "$TMP_DIR/cover-".$source->id;
			$tmp = Obalky::Tools->wget_to_file(
						$cover_url, $filename);
			
			unless (-e $filename) {
				my $browser = LWP::UserAgent->new;
				$browser->ssl_opts(verify_hostname => 0, SSL_verify_mode => 0x00);
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
		# checksum puvodni obalky
		my $checksum_old = $source->cover ? $source->cover->checksum : "";
		# checksum nove obalky
		if (!$tmp) {#obrazok na danej URL neexistuje
			warn 'Image does not exist'."\n";
			return '0';
		}
	
		my $checksum_new = `md5sum $tmp | head -c 32`;
		
		# RIZENI PRIORITY (PRIORITA ROZLISENI)
		my ($id_eshop,$id_eshop_current,$old_width,$old_height,$new_width,$new_height) = (0,0,0,0,1,1);
		$id_eshop = $id_eshop_current = $source->eshop->get_column('id') if ($source->eshop);
		$id_eshop_current = $auth->cover->auth_source->eshop->get_column('id') if ($auth->cover and $auth->cover->auth_source);
		$old_width = $source->cover->get_column('orig_width') if ($source->cover);
		$old_height = $source->cover->get_column('orig_height') if ($source->cover);
		($new_width,$new_height) = Obalky::Tools->image_size($tmp) if (-e $tmp);
		my $old_dim = $old_width * $old_height;
		my $new_dim = $new_width * $new_height;
		
		warn 'KONTROLNI SOUCET SE SHODUJE ...' if ($ENV{DEBUG} && $checksum_old eq $checksum_new);
		
		# Nahravame pokud
		# 1) se zmenil obrazek a zaroven
		# 2) je vyssi rozliseni, nebo se jedna o upload sken. klientem + webem
		if ( $checksum_old ne $checksum_new
		     && (($new_dim > $old_dim and $id_eshop_current != $DB::Result::Eshop::ESHOP_UPLOAD) || $id_eshop == $DB::Result::Eshop::ESHOP_UPLOAD) )
		{
			warn 'PREHRAVAM OBRAZEK PRODUKTU NA ZAKLADE PRIORITY ROZLISENI ...' if ($ENV{DEBUG});
			my ($cover_old_icon,$cover_old_thumb,$cover_old_medium,$cover_old_orig) = (undef,undef,undef,undef);
			if ($source->cover) {
				$cover_old_icon = $source->cover->get_column('file_icon');
				$cover_old_thumb = $source->cover->get_column('file_thumb');
				$cover_old_medium = $source->cover->get_column('file_medium');
				$cover_old_orig = $source->cover->get_column('file_orig');
			}
			
			$cover = DB->resultset('Cover')->create_from_file($auth,$source,$tmp);
			
			$cover->update({ orig_url => $cover_url, auth_source => $source }) if($cover);
			$source->update({ cover => $cover, cover_url => $cover_url });
			$auth->update({ cover => $cover });
			
			# smazat nahrazene obrazky, pokud se uz nikde nepouziva
			if ($cover_old_orig && !DB->resultset('Cover')->search({ file_orig => $cover_old_orig })->count) {
				DB->resultset('Fileblob')->find($cover_old_icon)->delete if ($cover_old_icon);
				DB->resultset('Fileblob')->find($cover_old_thumb)->delete if ($cover_old_thumb);
				DB->resultset('Fileblob')->find($cover_old_medium)->delete if ($cover_old_medium);
				DB->resultset('Fileblob')->find($cover_old_orig)->delete if ($cover_old_orig);
				my $dirGroupName = int($cover_old_orig/100000+1)*100000;
				my $filenameOrig = $Obalky::Config::FILEBLOB_DIR.'/'.$dirGroupName.'/'.$cover_old_orig;
				unlink($filenameOrig) if (-e $filenameOrig);
			}
			
			# vyvolej synchronizacni udalost
			DB->resultset('FeSync')->auth_sync_remove($auth->id);
			$feSynced = 1;
		} else {
			warn 'OBRAZEK PRODUKTU NENI NUTNE PREHRAT ...' if ($ENV{DEBUG});
		}
	}

	#nahra anotaciu
	if ($annotation) {
		DB->resultset('AuthObj')->update_or_create({
			auth => $auth,
			obj_type => 2,
			val => $annotation,
			name => $auth->authinfo->get_fullname(),
			source => 1,
			pos => 1
		});
	}
	
	#nahra WIKI URL
	if ($wiki_url) {
		my $resAuthObj = DB->resultset('AuthObj')->search({ auth => $auth->id, obj_type => 1 });
		my $pos = $resAuthObj->count + 1;
		my $authObj = DB->resultset('AuthObj')->update_or_create({
			auth => $auth,
			obj_type => 1,
			val => $wiki_url,
			name => $auth->authinfo->get_fullname(),
			source => 1
		});
		$authObj->update({ pos => $pos }) unless ($authObj->get_column('pos'));
	}
	
	return '1';
}

sub save_to {
	my($media,$product) = @_; # jen product? nema teda byt v productu?
	my $feSynced = 0;
	
	#AuthSource
	return save_to_source(@_) if ((ref $product) =~ /AuthSource/);
	
	die ref $product unless((ref $product) =~ /Product/);
	
	my $book = $product->book;
	
	my ($process_cover,$process_toc,$process_bib,$process_annotation,$process_rating,$process_review) = (1,1,1,1,1);
	$process_cover = 0 if ($product->eshop->get_column('process_cover') == 0);
	$process_toc = 0 if ($product->eshop->get_column('process_toc') == 0);
	$process_bib = 0 if ($product->eshop->get_column('process_bib') == 0);
	$process_annotation = 0 if ($product->eshop->get_column('process_annotation') == 0);
	$process_rating = 0 if ($product->eshop->get_column('process_rating') == 0);
	$process_review = 0 if ($product->eshop->get_column('process_review') == 0);
	
	# nevkladej obalku a obsah z Krameria, pokud uz zaznam obalku/obsah obsahuje
	# pravdepodobne to bude to same a taky kvuli zaplneni db a storage (9.8.2018)
	if ($product->eshop->type eq 'kramerius' and $product->eshop->id != 7096) {
		my $neigProducts = DB->resultset('Product')->search({ book => $book->id });
		foreach ($neigProducts->all) {
			$process_cover = 0 if ($_->get_column('cover'));
			$process_toc = 0 if ($_->get_column('toc'));
			$process_bib = 0 if ($_->get_column('bib'));
		}
	}
	
	# 1. Cover
	# vytvor cover jen pokud je novy/lisi-se
	$media->{cover_url} = undef unless ($process_cover);
	my $cover_url = $media->{cover_url};
	if($cover_url) {
		warn "media->save_to(product) saving ".$media->{cover_url}." to ".$product->id."\n";
		
		my $tmp = $media->{cover_tmpfile};
		unless($tmp) {
			my $TMP_DIR = "/tmp/.obalky-media"; mkdir $TMP_DIR;
			my $filename = "$TMP_DIR/cover-".$product->id;
			$tmp = Obalky::Tools->wget_to_file(
						$cover_url, $filename);
			
			# Kramerius obalky resampluj, neni potreba extra kvalitni obrazek, originaly jsou v Krameriovi
			if ($coverurl) {
				if (-e $filename) {
					warn 'KRAMERIUS RESAMPLE ...' if ($ENV{DEBUG});
					my ($width,$height) = Obalky::Tools->image_size($filename);
					if ($height > 510) {
						my($iw,$ih) = Obalky::Tools->resize(9999,510,$width,$height);
						if ($iw) {
							system("convert","-resize", $iw."x".$ih, $filename, $filename);
						}
					}
				}
			}
			
			unless (-e $filename) {
				my $browser = LWP::UserAgent->new;
				$browser->ssl_opts(verify_hostname => 0, SSL_verify_mode => 0x00);
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
		# checksum puvodni obalky
		my $checksum_old = $product->cover ? $product->cover->checksum : "";
		# checksum nove obalky
		my $checksum_new = `md5sum $tmp | head -c 32`;
		
		# RIZENI PRIORITY (PRIORITA ROZLISENI)
		my ($id_eshop,$old_width,$old_height,$new_width,$new_height) = (0,0,0,1,1);
		$id_eshop = $product->eshop->get_column('id') if ($product->eshop);
		$old_width = $product->cover->get_column('orig_width') if ($product->cover);
		$old_height = $product->cover->get_column('orig_height') if ($product->cover);
		($new_width,$new_height) = Obalky::Tools->image_size($tmp) if (-e $tmp);
		my $old_dim = $old_width * $old_height;
		my $new_dim = $new_width * $new_height;
		
		warn 'KONTROLNI SOUCET SE SHODUJE ...' if ($ENV{DEBUG} && $checksum_old eq $checksum_new);
		
		# Nahravame pokud
		# 1) se zmenil obrazek a zaroven
		# 2) je vyssi rozliseni, nebo se jedna o upload sken. klientem + webem
		if ( $checksum_old ne $checksum_new
		     && ($new_dim > $old_dim || $id_eshop == $DB::Result::Eshop::ESHOP_UPLOAD) )
		{
			warn 'PREHRAVAM OBRAZEK PRODUKTU NA ZAKLADE PRIORITY ROZLISENI ...' if ($ENV{DEBUG});
			my ($cover_old_icon,$cover_old_thumb,$cover_old_medium,$cover_old_orig) = (undef,undef,undef,undef);
			if ($product->cover) {
				$cover_old_icon = $product->cover->get_column('file_icon');
				$cover_old_thumb = $product->cover->get_column('file_thumb');
				$cover_old_medium = $product->cover->get_column('file_medium');
				$cover_old_orig = $product->cover->get_column('file_orig');
			}
			
			$cover = DB->resultset('Cover')->create_from_file($book,$product,$tmp);
			$cover->update({ orig_url => $cover_url }) if($cover);
			$product->update({ cover => $cover });
			
			# smazat nahrazene obrazky, pokud se uz nikde nepouziva
			if ($cover_old_orig && !DB->resultset('Cover')->search({ file_orig => $cover_old_orig })->count) {
				DB->resultset('Fileblob')->find($cover_old_icon)->delete if ($cover_old_icon);
				DB->resultset('Fileblob')->find($cover_old_thumb)->delete if ($cover_old_thumb);
				DB->resultset('Fileblob')->find($cover_old_medium)->delete if ($cover_old_medium);
				DB->resultset('Fileblob')->find($cover_old_orig)->delete if ($cover_old_orig);
				my $dirGroupName = int($cover_old_orig/100000+1)*100000;
				my $filenameOrig = $Obalky::Config::FILEBLOB_DIR.'/'.$dirGroupName.'/'.$cover_old_orig;
				unlink($filenameOrig) if (-e $filenameOrig);
			}
			
			# vyvolej synchronizacni udalost
			DB->resultset('FeSync')->book_sync_remove($book->id);
			$feSynced = 1;
		} else {
			warn 'OBRAZEK PRODUKTU NENI NUTNE PREHRAT ...' if ($ENV{DEBUG});
		}
	}

	# 2a. TOC
	if ($process_toc) {
		my $toc_text = $media->{toctext};
		my $toc_url  = $media->{tocpdf_url};
		my $toc_tmp  = $media->{tocpdf_tmpfile};
		my $toc_firstpage = $media->{toc_firstpage}; # toto je hack
		warn "save_to: toc_firstpage=$toc_firstpage\n" if ($toc_firstpage);
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
#				$toc->update({ toctext_not_in_pdf => 1 });
			}
			$product->update({ toc => $toc });
			$book->update({ toc => $toc });
			
			# vyvolej synchronizacni udalost pri kazdem uploadu TOC
			if (!$feSynced) {
				DB->resultset('FeSync')->book_sync_remove($book->id);
			}
		}
	}
	
	# 2b. BIB
	if ($process_bib) {
		my $bib_text = $media->{bibtext};
		my $bib_url  = $media->{bibpdf_url};
		my $bib_tmp  = $media->{bibpdf_tmpfile};
		my $bib_firstpage = $media->{bib_firstpage}; # toto je hack
		warn "save_to: bib_firstpage=$bib_firstpage\n" if ($bib_firstpage);
		if($bib_text or $bib_url or $bib_tmp) {
			$bib = DB->resultset('Bib')->find_or_create(
				{ product => $product },{ key => 'bib_product' });
			if($bib_url or $bib_tmp) {
				my $content = $bib_tmp ? 
					Obalky::Tools->slurp($bib_tmp) : Obalky::Tools->wget($bib_url);
				$bib->set_pdf($bib_url,$content,$bib_tmp,$bib_firstpage);
			}
			if($bib_text) {
				$bib->update({ full_text => $bib_text });
			}
			$product->update({ bib => $bib });
			$book->update({ bib => $bib });
			
			# vyvolej synchronizacni udalost pri kazdem uploadu BIB
			if (!$feSynced) {
				DB->resultset('FeSync')->book_sync_remove($book->id);
			}
		}
	}
	
	# 3. Annotation
	if ($process_annotation and $media->{review_html}) {
		die unless(defined $media->{review_impact});
		
		my $annotation_changed = 1;
		my $annotation = DB->resultset('Review')->search({ product => $product->id, impact => $REVIEW_ANNOTATION })->next;
		if ($annotation) {
			
			my($db_html_text,$new_html_text,$db_rating,$new_rating) = ('','','','');
			$db_html_text = $annotation->get_column('html_text')  if ($annotation->get_column('html_text'));
			$new_html_text = $media->{review_html}                if ($media->{review_html});
			$annotation_changed = 0 if ($db_html_text eq $new_html_text);
			$annotation->update({
				html_text => $new_html_text
			});
			
		} else {
			
			my $annotation_data = {
				book => $book, product => $product,
				html_text => $media->{review_html},
				impact => $media->{review_impact},
				status => $annotation_status
			};
			
			# najdi pripadne existujici anotace, stejneho eshopu (uz drive nahrane rucne, ale nenapojene na produkt)
			my $annotation_status = undef; # v zakladnim stavu budou nove vznikajici anotace nepotvrzene
			if ($media->{review_library}) {
				
				$annotation_data->{library} = $media->{review_library};
				
				# vyhledat anotace stejne knihy se stejnym textem (prvnich 50 znaku textu)
				my $annotation_join = DB->resultset('Review')->search({
					book => $book->id,
					library => $media->{review_library},
					product => undef,
					impact => $media->{review_impact},
					html_text => { -like => substr($media->{review_html}, 0, 50).'%' }
				});
				foreach ($annotation_join->all) {
					# pouzit stav a text existujiciho zaznamu
					if ($_->get_column('status')) {
						$annotation_status = $_->get_column('status');
						$media->{review_html} = $_->get_column('html_text');
					}
					# smazat existujici zaznamy (anotace byva pouze jedna)
					$_->delete();
				}
			}
			
			my $annotation_res = eval { DB->resultset('Review')->create( $annotation_data ) };
			
		}
		if ($annotation_changed) {
			$book->recalc_rating;
			$book->recalc_review;
			$book->invalidate();
		}
	}
	
	# 4. Price
	if($media->{price_vat}) {
		die unless($media->{price_cur});
		$product->update({ price_vat => $media->{price_vat},
						   price_cur => $media->{price_cur} });
		$product->update({ price_max => $media->{price_max} }) if ($media->{price_max});
	}
	
	# 5. Rating
	if($process_rating and $media->{rating_count} and $media->{rating_value}) {
		my $rating_count = 1;
		$rating_count = $media->{rating_count} if ($media->{rating_count});
		
		my $rating_value = $media->{rating_value};
		$rating_value = ceil($rating_value * $rating_count);
		
		my $rating_changed = 1;
		my $rating = DB->resultset('Review')->search({ product => $product->id, impact => $REVIEW_VOTE })->next;
		if ($rating) {
			
			my($db_cnt,$new_cnt,$db_rating,$new_rating) = ('','','','');
			$db_cnt = $rating->get_column('cnt')        if ($rating->get_column('cnt'));
			$db_rating = $rating->get_column('rating')  if ($rating->get_column('rating'));
			$rating_changed = 0 if ($db_cnt eq $rating_count and $db_rating eq $rating_value);
			$rating->update({
				cnt => $rating_count,
				rating => $rating_value
			});
			
		} else {
			
			my $id_library = undef;
			$id_library = $media->{review_library} if ($media->{review_library});
			
			$review = DB->resultset('Review')->create({
				product => $product,
				book => $book,
				impact => $REVIEW_VOTE,
				cnt => $rating_count,
				rating => $rating_value,
				library => $id_library
			});
			
			$review->update({ library_id_review => $review->get_column('id') }) if ($id_library); # doplneni ID, aby se hodnoceni spocetlo
			
		}
		if ($rating_changed) {
			$book->recalc_rating;
			$book->recalc_review;
			$book->invalidate();
		}
	}
	
	# 6. Review
	if ($process_review) {
		foreach my $review (@{$media->{reviews_list}}) {
			my $review_exists = DB->resultset('Review')->search({
				library => $media->{review_library},
				library_id_review => $review->{id}
			})->next;
			next if ($review_exists);
			next unless ($review->{html_text});
			
			DB->resultset('Review')->create({
				library => $media->{review_library},
				library_id_review => $review->{id},
				html_text => $review->{html_text},
				rating => $review->{rating},
				created => $review->{time},
				impact => $REVIEW_COMMENT,
				product => $product,
				book => $book,
				status => 0
			});
		}
		if (scalar @{$media->{reviews_list}}) {
			$book->recalc_rating;
			$book->recalc_review;
			$book->invalidate();
		}
	}
	
	# 7. Relation
	if ($media->{relation}) {
		my $relation = $media->{relation};
		my $bibinfoParams = {
			ean13 => $relation->{parent_ean13},
			nbn => $relation->{parent_nbn},
			ismn => $relation->{parent_ismn},
			oclc => $relation->{parent_oclc}
		};
		my $bibinfoRelParent = Obalky::BibInfo->new_from_params($bibinfoParams);
		my $bookRelParent = DB->resultset('Book')->find_by_bibinfo($bibinfoRelParent);
		#relace jeste neni, pridej
		if (defined $bookRelParent) {
			my $resRelation = DB->resultset('BookRelation')->search({ -or => [{ book_parent=>$bookRelParent->id, book_relation=>$book->id }, { book_parent=>$book->id, book_relation=>$bookRelParent->id }] });
			DB->resultset('BookRelation')->create({ book_parent=>$bookRelParent->id, book_relation=>$book->id, relation_type=>1 }) unless ($resRelation->count);
		}
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
