
package DB::ResultSet::Book;
use base 'DBIx::Class::ResultSet';
use Encode;

use Data::Dumper;
use Obalky::Config;

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
	$id->{part_name} = undef unless(defined $id->{part_name});
	
	# dotazy na zaznam book (souborny zaznam)
	unless ($id->{part_no} or $id->{part_name}) {
		$id->{part_year} = $id->{part_volume} = undef;
		push @books, $pkg->search({ ean13=>$id->{ean13}, part_year=>undef, part_volume=>undef, part_no=>undef, part_name=>undef }) if($id->{ean13});
   		return $books[0] if(@books and not wantarray);
   		push @books, $pkg->search({ oclc=>$id->{oclc}, part_year=>undef, part_volume=>undef, part_no=>undef, part_name=>undef }) if($id->{oclc});
  		return $books[0] if(@books and not wantarray);
   		push @books, $pkg->search({ nbn=>$id->{nbn}, part_year=>undef, part_volume=>undef, part_no=>undef, part_name=>undef }) if($id->{nbn});
		return $books[0] if(@books and not wantarray);
	}
	
	# dotaz na cislo periodika, nebo cast monografie
	if ($id->{part_no} or $id->{part_name}) {
		@books = $pkg->search_book_part($id);
		if (@books) {
			map { # pro kazdy nalezeny zaznam (normalne cekame ze je jeden) zkontrolujeme, jestli ma vyplnenou kombinaci rok/rocnik
				if ($_->get_column('part_type') == 2) { # tyka se to periodik
					my $part_year = $_->get_column('part_year');
					my $part_volume = $_->get_column('part_volume');
					if (($part_year && !$part_volume) || (!$part_year && $part_volume)) {
						my $bibinfo = $_->bibinfo;				
						$bibinfo = $bibinfo->find_missing_year_or_volume ;
						$bibinfo->save_to($_);
						$_->invalidate;
					}
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
	return undef if ($bibinfo->{part_no} or $bibinfo->{part_name});
	
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
		$bibinfo->{part_year} = $pkg->normalize_year($bibinfo->{part_year});
	}
	if ($bibinfo->{part_volume}) {
		$bibinfo->{part_volume_orig} = $bibinfo->{part_volume};
		$bibinfo->{part_volume} = $pkg->normalize_volume($bibinfo->{part_volume});
	}
	if ($bibinfo->{part_no}) {
		$bibinfo->{part_no_orig} = $bibinfo->{part_no};
		$bibinfo->{part_no} = $pkg->normalize_part($bibinfo->{part_no});
	}
	if ($bibinfo->{part_name}) {
		$bibinfo->{part_name_orig} = $bibinfo->{part_name};
		$bibinfo->{part_name} = $pkg->normalize_part($bibinfo->{part_name});
	}
	$bibinfo->{part_note_orig} = $bibinfo->{part_note} if ($bibinfo->{part_note});
	return $bibinfo;
}

sub normalize_year {
	my($pkg,$str) = @_;
	$str =~ s/;/\,/;
	$str =~ s/[\s]*\-[\s]*/\-/; # normalize dash
	$str =~ s/[\s]*\,[\s]*/\,/; # normalize comma
	$str =~ s/[\(\[](.*)[\)\]]// if ($str !~ m/^\s*[\[\(](.*)[\]\)]\s*$/); # normalize brackets
	
	# pokud obsahuje pouze text, normalizovat text, pokud obsahuje cislo, vyber cislo
	my @tmp = $str =~ m/(\d{3,4}([\s\-\,\.\[\]\(\)\/a]*\d{2,4}[\]\)]*)*)/g;
	$str = @tmp ? $tmp[0] : $pkg->normalizePureText($str);
	$str =~ s/\s//; # remove space
	
	return $pkg->trimPart($str);
}

sub normalize_volume {
	my($pkg,$str) = @_;
	$str =~ s/[\s]*\-[\s]*/\-/; # normalize dash
	$str =~ s/[\s]*\,[\s]*/\,/; # normalize comma
	
	# pokud obsahuje pouze text, normalizovat text, pokud obsahuje cislo, vyber cislo
	my @tmp = $str =~ m/(\d{1,3}([\s\-\,\.\[\]\(\)\/a]*\d{1,3}[\]\)]*)*)/g;
	$str = @tmp ? $tmp[0] : $pkg->normalizePureText($str);
	$str =~ s/[\(\[](.*)[\)\]]// if ($str !~ m/^\s*[\[\(](.*)[\]\)]\s*$/); # normalize brackets
	$str =~ s/\s//; # remove space
	
	return $pkg->trimPart($str);
}

sub normalize_part {
	my($pkg,$str) = @_;
	$str = lc $str;
	$str =~ s/[\s]*\-[\s]*/\-/; # normalize dash
	$str =~ s/[\s]*\,[\s]*/\,/; # normalize comma
	
	# normalize punctation
	my $regex = join "|", keys %Obalky::Config::replace_punctation;
	$regex = qr/$regex/;
	$str =~ s/($regex)/$Obalky::Config::replace_punctation{$1}/g;
    
	# hledame vice urovnove oznaceni casti monografie (napr. "Ottuv slovnik naucny, 1.díl, 2.sv." se normalizuje na 1|2)
	# na vystupu bude vzdy v poradi dil|svazek i kdyz se informace na vstupu prohodi
	my @specialParts;
	# prvni v poradi je dil
	if ($str =~ m/(dil(\s|$|\,)|dily)/) {
		map {
			push @specialParts, $_ if (defined $_ and scalar @specialParts < 1 and ($_ ne '' or $_ ne 'dil' or $_ ne 'dily'));
		} $str =~ m/([0-9\s\.\-]*(dil|dily)[0-9\s]*)/g;
	}
	
	#warn Dumper(@specialParts);
	# svazek je druhy v poradi
	if ($str =~ m/(sv(\.{0,1})|svazek|svazky)/) {
		map {
			push @specialParts, $_ if (defined $_ and scalar @specialParts < 2 and ($_ ne 'sv' && $_ ne 'sv.' && $_ ne 'svazek' && $_ ne 'svazky'));
		} $str =~ m/([0-9\s\.\-]*(sv(\.{0,1})|svazek|svazky)[0-9\s]*)/g;
	}
	warn Dumper(@specialParts);
	# ulozeni do spravneho poradi dil-svazek
	# pole uz mame takto serazene, staci spojit
	if (scalar @specialParts == 2) {
		my @out;
		map {
			push @out, $_ if (defined $_ and $_ ne '');
		} join('|', @specialParts) =~ m/([\d]*)/g;
		return join('|', @out);
	}
	
	# pokud obsahuje pouze text, normalizovat text, pokud obsahuje cislo, vyber cislo
	my @tmp = $str =~ m/(\d{1,3}([\s\-\,\.\[\]\(\)\/a]*\d{1,3}[\]\)]*)*)/g;
	$str = @tmp ? $tmp[0] : $pkg->normalizePureText($str);
	
	return $pkg->trimPart($str);
}

sub trimPart {
	my($pkg,$str) = @_;
	$str =~ s/^\s+|\s+$//g; # trim
	return '' if ($str eq '' || $str =~ m/^[\s\[\]\(\)\.\,\-\;\\\/_]$/);
	my $startAt = 0;
	my $endAt = length($str);
	    
	# najdi od zacatku, kde zacina rozumna informace
	for (my $p=0; $p<length($str)-1; $p++) {
		last if (substr($str, $p, 1) !~ m/^[\s\[\]\(\)\.\,\-\;\\\/_]$/);
		$startAt = $p++;
	}
	
	# najdi od konce, kde zacina rozumna informace
	for (my $p = length($str)-1; $p>=0; $p--) {
		last if (substr($str, $p, 1) !~ m/^[\s\[\]\(\)\.\,\-\;\\\/_]$/);
		$endAt = $p;
	}
	
	# provede ocisteni = orezani retezce podle drive vymezenych mezi od-do
	$str = substr($str, $startAt, $endAt) if ($startAt>0 || $endAt<length($str));
	
	# zamena teckovych zbytecnosti napr. 1.,2 = 1,2 nebo 2.-4 = 2-4
	$str =~ s/ a /\,/;
	$str =~ s/\.\,/\,/; $str =~ s/\.\-/\-/;
	$str =~ s/\]\-/\-/; $str =~ s/\-\[/\-/;
	$str =~ s/\)\-/\-/; $str =~ s/\-\(/\-/;
	$str =~ s/\/\-/\-/; $str =~ s/\-\//\-/;
	$str =~ s/\,_/_/;   $str =~ s/\._/_/;
	
	return $str;
}

sub normalizePureText {
	my($pkg,$str) = @_;
	
	# replace punctation
	my $regex = join "|", keys %Obalky::Config::replace_punctation;
	$regex = qr/$regex/;
	$str =~ s/($regex)/$Obalky::Config::replace_punctation{$1}/g;
	
	# replace month names by month numbers
	$regex = join "|", keys %Obalky::Config::replace_months;
	$regex = qr/$regex/;
	$str =~ s/($regex)/$Obalky::Config::replace_months{$1}/g;
	
	$str =~ s/spec\./special/;
	$str =~ s/\s/_/g;
	return $str;
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
   	
   	# zamezeni tomu, aby se nalezl zaznam na zaklade shody prazdneho vstupu jednoho s poli s prazdnym obsahem stejneho pole v DB
   	my ($part_no, $part_name) = (' ',' ');
   	$part_no = $id->{part_no} if ($id->{part_no});
   	$part_name = $id->{part_name} if ($id->{part_name});
   	
   	# cast monografie podle EAN/ISBN
	push @books, $pkg->search({ ean13 => $id->{ean13}, part_type => 1, -or=>{part_no => $part_no, part_name => $part_name} })
			if ($id->{ean13} and ($id->{part_no} or $id->{part_name}));
   	return @books if(@books);
   	
   	# cast monografie podle OCLC
	push @books, $pkg->search({ oclc => $id->{oclc}, part_type => 1, -or=>{part_no => $part_no, part_name => $part_name} })
			if ($id->{oclc} and ($id->{part_no} or $id->{part_name}));
   	return @books if(@books);
   	
   	# cast monografie podle NBN
	push @books, $pkg->search({ nbn => $id->{nbn}, part_type => 1, -or=>{part_no => $part_no, part_name => $part_name} })
			if ($id->{nbn} and ($id->{part_no} or $id->{part_name}));
   	return @books;
}

1;
