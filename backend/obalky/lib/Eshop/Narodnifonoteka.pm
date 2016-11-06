

package Eshop::Narodnifonoteka;
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
use Switch;

use DB;
use strict;
use utf8;

__PACKAGE__->register(crawl => 1, license => 'licensed', czech => 0 );


sub process_shopitem {
	my($self,$tmp_dir,$item,$eshop,$marc) = @_;
	my $info;
	
	my $product_url = 'https://www.narodnifonoteka.cz/Record/vnf_sup.'.$marc->{part_id};
	my $id = $item->{ID}[0];
	
	# KatCislo, UPC, EAN
	my $ean = $item->{EAN} || $item->{UPC};
	$ean = @{$ean}[0] if (ref($ean) eq 'ARRAY');
	my $katCislo = $item->{KatCislo};
	$katCislo =~ s/ /_/;
	
	# NBN
	my ($nbn,$format) = (undef,undef);
	switch ($marc->{format}) {
		case '$avnf_vinyl'	{ $format = 'vinyl'; }
		case '$avnf_shellac'	{ $format = 'shellac'; }
		case '$avnf_CD'	{ $format = 'cd'; }
		case '$avnf_SoundCassette'	{ $format = 'mc'; }
		case '$avnf_data'	{ $format = 'data'; }
		else { $format = 'other'; }
	}	
	$nbn = 'urn:okcz:'.$format.':'.$katCislo;
	
	unless($katCislo and $id) {
		warn "KatCislo or ID not found for $product_url\n";
		return;
	}
	
	# titul
	my $title = $item->{Nazev};
	$info->{price_vat} = '0';
	$info->{price_cur} = 'CZK';
	
	# rok vydani
	my $rok_vydani = $item->{Vydano};
	$rok_vydani = substr($rok_vydani,0,4) if ($rok_vydani);
	
	# TOC INIT
	my $toctext = '';
	
	# AUTORI
	my $authors;
	my @author_items;
	my $author_items = $item->{StezejniAutori};
	if ($author_items) {
		
		$author_items = $author_items->{Osoby}->{Osoba};
		@author_items = @{$author_items} if (ref $author_items eq 'ARRAY');
		push @author_items, $author_items if (ref $author_items eq 'HASH');
		if (scalar @author_items) {
			
			$toctext = "Autoři:\n";
			
			foreach my $author (@author_items) {
				next unless ($author->{Prijmeni} and $author->{Jmeno});
				$authors = $author->{Prijmeni}.', '.$author->{Jmeno} if (!$authors); # hlavni autor
				$toctext .= $author->{Prijmeni}.', '.$author->{Jmeno}."\n"; # vsichni autori
			}
		}
	}
	
	# COVER
	my $cover_url = 'supraphon';
	for (my $i=0; $i<=length($id)-2; $i+=2) {
		$cover_url .= '/'.substr($id,$i,2);
	}
	$cover_url .= "/$id-large.jpg";
	
	if (-e "/opt/obalky/www/$cover_url") {
		$cover_url = "http://www.obalkyknih.cz/$cover_url";
		warn "$nbn : $cover_url\n" if($ENV{DEBUG});
				
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
	
	# TOC
	my @toc_items;
	my $toc_items = $item->{StezejniInterpreti};
	if ($toc_items) {		
		$toc_items = $toc_items->{Osoby}->{Osoba};
		@toc_items = @{$toc_items} if (ref $toc_items eq 'ARRAY');
		push @toc_items, $toc_items if (ref $toc_items eq 'HASH');
		if (scalar @toc_items) {		
			$toctext .= "\nInterpreti:\n";
			foreach my $author (@toc_items) {
				$toctext .= $author->{Nazev}."\n" if ($author->{Nazev});
				$toctext .= $author->{Prijmeni}.', '.$author->{Jmeno}."\n" if ($author->{Prijmeni});
			}
		}
	}
	
	$toc_items = $item->{StezejniHudebniTelesa};
	if ($toc_items) {		
		$toc_items = $toc_items->{HudebniTeleso};
		@toc_items = @{$toc_items} if (ref $toc_items eq 'ARRAY');
		push @toc_items, $toc_items if (ref $toc_items eq 'HASH');
		if (scalar @toc_items) {		
			$toctext .= "\nHudební telesa:\n";
			foreach my $author (@toc_items) {
				$toctext .= $author->{Nazev}."\n" if ($author->{Nazev});
				$toctext .= $author->{Prijmeni}.', '.$author->{Jmeno}."\n" if ($author->{Prijmeni});
			}
		}
	}
	
	$toc_items = $item->{Dalsi};
	if ($toc_items) {		
		$toc_items = $toc_items->{Osoby}->{Osoba};
		@toc_items = @{$toc_items} if (ref $toc_items eq 'ARRAY');
		push @toc_items, $toc_items if (ref $toc_items eq 'HASH');
		if (scalar @toc_items) {		
			$toctext .= "\nDalší osoby:\n";
			foreach my $author (@toc_items) {
				$toctext .= $author->{Nazev}."\n" if ($author->{Nazev});
				$toctext .= $author->{Prijmeni} if ($author->{Prijmeni});
				$toctext .= ', '.$author->{Jmeno}."\n" if ($author->{Jmeno});
			}
		}
	}
	
	$toc_items = $item->{Skladby};
	my $toc_cast;
	my @toc_cast;
	if ($toc_items) {		
		$toc_items = $toc_items->{Skladba};
		@toc_items = @{$toc_items} if (ref $toc_items eq 'ARRAY');
		push @toc_items, $toc_items if (ref $toc_items eq 'HASH');
		if (scalar @toc_items) {
			$toctext .= "\nSkladby:\n";
			foreach my $skladba (@toc_items) {
				next unless ($skladba->{Nazev});
				$toctext .= "\n".$skladba->{Nazev}."\n";
				
				## Skladba
				$toc_cast = $skladba->{Casti}->{Cast};
				@toc_cast = @{$toc_cast} if (ref $toc_cast eq 'ARRAY');
				push @toc_cast, $toc_cast if (ref $toc_cast eq 'HASH');
				if (scalar @toc_cast) {
					$toctext .= "Části skladby:\n";
					foreach my $cast (@toc_cast) {
						next unless ($cast->{Nazev});
						$toctext .= $cast->{Nazev}."\n";
					}
				}
				## Autorske dilo
				next unless ($skladba->{AutorskeDilo});
				$toc_cast = $skladba->{AutorskeDilo}->{Osoby}->{Osoba};
				@toc_cast = @{$toc_cast} if (ref $toc_cast eq 'ARRAY');
				push @toc_cast, $toc_cast if (ref $toc_cast eq 'HASH');
				if (scalar @toc_cast) {
					$toctext .= "\n";
					foreach my $cast (@toc_cast) {
						next unless($cast->{Prijmeni} and $cast->{Jmeno});
						$toctext .= $cast->{Prijmeni}.', '.$cast->{Jmeno}."\n";
					}
				}
				## Telesa
				next unless ($skladba->{HudebniTelesa});
				$toc_cast = $skladba->{HudebniTelesa}->{HudebniTeleso};
				@toc_cast = @{$toc_cast} if (ref $toc_cast eq 'ARRAY');
				push @toc_cast, $toc_cast if (ref $toc_cast eq 'HASH');
				if (scalar @toc_cast) {
					$toctext .= "\n";
					foreach my $cast (@toc_cast) {
						next unless($cast->{Nazev});
						$toctext .= $cast->{Nazev}."\n";
					}
				}
			}
		}
	}
	
	$info->{toctext} = $toctext;
	
	
    my $bibinfo = Obalky::BibInfo->new_from_params({
		ean => $ean,
		nbn => $nbn,
		title => $title,
		authors=> $authors,
		year => $rok_vydani
    });
    my $media = Obalky::Media->new_from_info( $info );

	# rmdir "/tmp/cover.$$.$temp_file";
	return [ $bibinfo,$media,$product_url ];
}

sub crawl {
	my($self,$storable,$from,$to,$tmp_dir,$feed_url,$eshop) = @_;

	return [] unless($feed_url);
	
	my $el_shopitem = 'Item';
	
	my $feed_mrc = $feed_url;
	$feed_mrc =~ s/\.xml/\.mrc/;
	warn "wget -q $feed_mrc -O $tmp_dir/feed.mrc";
	system("wget -q $feed_mrc -O $tmp_dir/feed.mrc") and die "$tmp_dir: $!";
	warn "Got MARC feed\n" if($ENV{DEBUG});
	
	open(my $fh, '<:encoding(UTF-8)', "$tmp_dir/feed.mrc") or die "Could not open file '$tmp_dir/feed.mrc' $!";
	
	my ($count,$found_ldr,$found_part,$t001,$part_id,$format) = (0,0,0,undef,undef,undef);
	my $marc = {};
	while (my $row = <$fh>) {
		$count = $count + 1;
		
		my @words = split /  /, $row;
		
		if ($words[0] eq 'LDR') {
			# hlavicka zvukoveho dokumentu
			if ($words[1] eq "-----njm-a22-----2ua4500\n") {
				$found_ldr = 1;
				($found_part,$t001,$part_id,$format) = (0,undef,undef,undef);
			}
			
			# hlavicka pisne
			if ($words[1] eq "-----njm-a22-----2uc4500\n") {
				$found_part = 1;
			}
		}
		
		next if ($part_id);
		
		# ID zvukoveho dokumentu v narodni fonotece
		if ($words[0] eq "001" and $found_ldr) {
			$found_ldr = 0;
			$t001 = substr($words[1],0,-1);
		}
		
		# fyzicky popis nosice
		$format = substr($words[1],0,-1) if ($words[0] eq "FCT" and !$format);
		
		# part_id = cast URL zvukoveho dokumentu
		if ($words[0] eq "001" and $found_part) {
			$found_part = 0;
			$part_id = substr($words[1],0,-1);
			
			# vysledek
			$marc->{$t001} = {
				part_id => $part_id,
				format => $format
			};
		}
	}
	
	warn "wget -q $feed_url -O $tmp_dir/feed.xml";
	system("wget -q $feed_url -O $tmp_dir/feed.xml") and die "$tmp_dir: $!";
	warn "Got xml feed\n" if($ENV{DEBUG});
	
	my $tm = localtime;
	my $date = $tm->mday."-".$tm->mon."-".$tm->year;
	
	my $xml = eval { XMLin("$tmp_dir/feed.xml", SuppressEmpty => 1, ForceArray => [$el_shopitem]); };
	if($@) {
		warn "$feed_url: $@";
		return ();
	}
	
	my $demo = $ENV{DEBUG} ? 300 : 3_000_000; # vsechno naraz..
	
	my $items = @{$xml->{$el_shopitem}};
	warn "$items <Item>\n" if($ENV{DEBUG});
	
	my @books;
	my @xml_items = @{$xml->{$el_shopitem}};
	warn 'XML contains '.(scalar @xml_items).' items';
	my $i = 0;
	foreach my $item (@xml_items) {
		my $foreign_id = sprintf "%09d", $item->{ID}[0];
		my $marc_row = $marc->{$foreign_id};
		next unless ($marc_row->{format} and $marc_row->{part_id});
		
		# do $storable cache ukladej $md5 serializovaneho XML a timestamp
		my $md5 = md5_hex(encode_utf8(XMLout($item)));
		my $lastmonth = time-31*24*60; # znovu sklid starsi nez mesic
		next if($storable->{$md5} and $storable->{$md5} > $lastmonth);
		$storable->{$md5} = time;
		
		my $book = $self->process_shopitem($tmp_dir,$item,$eshop,$marc_row);
		warn Dumper($book) if($ENV{DEBUG} and $ENV{DEBUG} > 1);
		push @books, $book if($book);
		last unless($demo--);
		
		$i++;
		warn 'crawl #'.$i if ($i % 50 == 0 and $ENV{OBALKY_ESHOP});
	}
	return @books;
}


1;
