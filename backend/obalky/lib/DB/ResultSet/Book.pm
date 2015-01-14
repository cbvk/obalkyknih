
package DB::ResultSet::Book;
use base 'DBIx::Class::ResultSet';
use Encode;

use Data::Dumper;

#__PACKAGE__->utf8_columns(qw/title authors/);

sub upload {
	my($pkg,$upload) = @_;

	my $bibinfo = new Obalky::BibInfo($upload);
	return unless $bibinfo;

    my $book = $pkg->find_by_bibinfo($bibinfo);
	$book = $pkg->create({}) unless($book);

	$book->authors($upload->authors) if($upload->authors);
	$book->title($upload->title)     if($upload->title);
	$book->year($upload->year)       if($upload->year);
	$bibinfo->save_to($book);

	# tohle by melo jit nekam do Object:: ...
	my $object = DB->resultset('Cover')->upload($book,$upload);
	$book->cover($object);
	$book->update;

	return wantarray ? ($book,$object) : $book;
}

sub find_by_isbn {
	my($pkg,$isbn) = @_;
    my @books = DB->resultset('Book')->search({ ean13 => 
					Obalky::BibInfo->isbn_to_ean13($isbn) });
	return wantarray ? @books : $books[0];
}
sub find_by_ean13 {
	my($pkg,$ean13) = @_;
    my @books = DB->resultset('Book')->search({ ean13 => $ean13 });
	return wantarray ? @books : $books[0];
}
sub find_by_bibinfo {
	my($pkg,$id) = @_;
	my @books;
	$id->{part_year} = undef unless(defined $id->{part_year});
	$id->{part_volume} = undef unless(defined $id->{part_volume});
	$id->{part_no} = undef unless(defined $id->{part_no});
	
	# dotazy na zaznam book (souborny zaznam)
	unless ($id->{part_no}) {
		$id->{part_year} = $id->{part_volume} = undef;
		push @books, $pkg->search({ ean13=>$id->{ean13}, part_year=>undef, part_volume=>undef, part_no=>undef }) if($id->{ean13});
   		return $books[0] if(@books and not wantarray);
   		push @books, $pkg->search({ oclc=>$id->{oclc}, part_year=>undef, part_volume=>undef, part_no=>undef }) if($id->{oclc});
  		return $books[0] if(@books and not wantarray);
   		push @books, $pkg->search({ nbn=>$id->{nbn}, part_year=>undef, part_volume=>undef, part_no=>undef }) if($id->{nbn});
		return $books[0] if(@books and not wantarray);
	}

	# dotaz na cislo periodika, nebo cast monografie
	if ($id->{part_no}) {
		@books = $pkg->search_book_part($id);
		if (@books) {
			map { # pro kazdy nalezeny zaznam (normalne cekame ze je jeden) zkontrolujeme, jestli ma vyplnenou kombinaci rok/rocnik
				my $part_year = $_->get_column('part_year');
				my $part_volume = $_->get_column('part_volume');
				if (($part_year && !$part_volume) || (!$part_year && $part_volume)) {
					my $bibinfo = $_->bibinfo;				
					$bibinfo = $bibinfo->find_missing_year_or_volume ;
					$bibinfo->save_to($_);
					$_->invalidate;
				}
			} @books;
   			return wantarray ? @books : $books[0];
		}
   		
   		# pokud nemame vsechny udaje pro rozeznani periodika (rok && rocnik) pokusime se dohledat chybejici rok/rocnik
   		# a dotaz na cislo periodika, nebo cast monografie provest jeste jednou
   		if ( ($id->{part_year} && !$id->{part_volume}) || (!$id->{part_year} && $id->{part_volume}) ) {
			$id = $id->find_missing_year_or_volume;
			# druhy pokus o vyhledani uz se vsemi info
			@books = $pkg->search_book_part($id);
   		}
	}

	# TODO: podle nazvu, autora, roku,... ?
	#push @books, DB->resultset('Book')->search({ title => $id->{title}, 
	#	authors => $id->{authors}, year => $id->{year}, part_year => $id->{part_year}, part_volume => $id->{part_volume}, part_no => $id->{part_no} }) if($id->{title});

	return wantarray ? @books : $books[0];
}
sub find_by_bibinfo_or_create {
	# nelze pouzit find_or_create, pac nehledame dle unique klice
	my($pkg,$bibinfo) = @_;
	warn "Looking for ".Dumper($bibinfo)."\n" if($ENV{DEBUG});
	my $book = $pkg->find_by_bibinfo($bibinfo);
	warn "Found book ".$book->id."\n" if($ENV{DEBUG} and $book);
	return $book if $book;
	
	# nezakladej zaznam pokud se dotazujeme pres /api/books na part_no; namisto toho vyhledej/zaloz souborny zaznam
	return undef if ($bibinfo->{part_no});
	
	# zaznam book nenalezen, budeme ukladat novy
	my $hash = {};
	$bibinfo->save_to_hash($hash);
	warn "Creating book... EAN ".$hash->{ean13}."\n" if($ENV{DEBUG});
	return $pkg->create($hash);
}

sub normalize_bibinfo {
	my($pkg,$bibinfo) = @_;
	if ($bibinfo->{part_year}) {
		$bibinfo->{part_year_orig} = $bibinfo->{part_year};
		#TODO: normalize year
	}
	if ($bibinfo->{part_volume}) {
		$bibinfo->{part_volume_orig} = $bibinfo->{part_volume};
		#TODO: normalize volume
	}
	if ($bibinfo->{part_no}) {
		$bibinfo->{part_no_orig} = $bibinfo->{part_no};
		#TODO: normalize no
	}
	$bibinfo->{part_note_orig} = $bibinfo->{part_note} if ($bibinfo->{part_note});
	return $bibinfo;
}

sub search_book_part {
	my ($pkg,$id) = @_;
	my @books;
	
	# cast periodika podle EAN/ISBN/ISSN
	push @books, $pkg->search({ ean13 => $id->{ean13}, part_year => $id->{part_year}, part_no => $id->{part_no} })
			if ($id->{ean13} and $id->{part_year} and $id->{part_no});
   	return @books if(@books);
   	push @books, $pkg->search({ ean13 => $id->{ean13}, part_volume => $id->{part_volume}, part_no => $id->{part_no} })
			if ($id->{ean13} and $id->{part_volume} and $id->{part_no});
   	return @books if(@books);
   	
   	# cast periodika podle OCLC
   	push @books, $pkg->search({ oclc => $id->{oclc}, part_year => $id->{part_year}, part_no => $id->{part_no} })
			if ($id->{oclc} and $id->{part_year} and $id->{part_no});
   	return @books if(@books);
   	push @books, $pkg->search({ oclc => $id->{oclc}, part_volume => $id->{part_volume}, part_no => $id->{part_no} })
			if ($id->{oclc} and $id->{part_volume} and $id->{part_no});
   	return @books if(@books);
   	
   	# cast periodika podle NBN
   	push @books, $pkg->search({ nbn => $id->{nbn}, part_year => $id->{part_year}, part_no => $id->{part_no} })
			if ($id->{nbn} and $id->{part_year} and $id->{part_no});
   	return @books if(@books);
   	push @books, $pkg->search({ nbn => $id->{nbn}, part_volume => $id->{part_volume}, part_no => $id->{part_no} })
			if ($id->{nbn} and $id->{part_volume} and $id->{part_no});
   	return @books if(@books);
   	
   	# cast monografie podle EAN/ISBN
	push @books, $pkg->search({ ean13 => $id->{ean13}, part_no => $id->{part_no}, part_type => 1 })
			if ($id->{ean13} and $id->{part_no});
   	return @books if(@books);
   	
   	# cast monografie podle OCLC
	push @books, $pkg->search({ oclc => $id->{oclc}, part_no => $id->{part_no}, part_type => 1 })
			if ($id->{oclc} and $id->{part_no});
   	return @books if(@books);
   	
   	# cast monografie podle NBN
	push @books, $pkg->search({ nbn => $id->{nbn}, part_no => $id->{part_no}, part_type => 1 })
			if ($id->{nbn} and $id->{part_no});
   	return @books;
}

1;
