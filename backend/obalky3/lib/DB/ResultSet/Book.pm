
package DB::ResultSet::Book;
use base 'DBIx::Class::ResultSet';
use Encode;
use String::Util qw(trim);

use Data::Dumper;
use Obalky::Config;

use MARC::Record;
use MARC::Charset 'utf8_to_marc8';
MARC::Charset->ignore_errors(1);
MARC::Charset->assume_encoding('UTF-8');

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
	my($pkg,$id,$creating) = @_;
	my @books;
	
	$creating = 0 unless($creating);
	$id->{part_year} = undef unless(defined $id->{part_year});
	$id->{part_volume} = undef unless(defined $id->{part_volume});
	$id->{part_no} = undef unless(defined $id->{part_no});
	$id->{part_name} = undef unless(defined $id->{part_name});
	
	# pokud se v dotazu vyskytuje uuid, vyhledej prioritne podle nej
	if (defined $id->{uuid}) {
		my $res = DB->resultset('Product')->search({ uuid => $id->{uuid} });
		while (my $row = $res->next) {
			push @books, $row->book;
		}
		return wantarray ? @books : $books[0] if (scalar @books);
	}
	
	# dotaz na cislo periodika, nebo cast monografie
	if ($id->{part_no} or $id->{part_name} or $id->{part_year} or $id->{part_volume}) {
		@books = $pkg->search_book_part($id);
		if (${@books}) {
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
		
   		# rozhodovani se jestli vyhledat rozmezi roku/rocniku/cisel
   		my ($found_part_no_range, $found_part_year_range, $found_part_volume_range) = (0,0,0);
   		$found_part_no_range = 1 if ($id->{part_no} and $id->{part_no} =~ /[\,\-]/);
   		$found_part_volume_range = 1 if ($id->{part_volume} and $id->{part_volume} =~ /[\,\-]/);
   		$found_part_year_range = 1 if ($id->{part_year} and $id->{part_year} =~ /[\,\-]/);
   		# vyhledani rozmezi roku/rocniku/cisel
   		if (!$books[0] and ($found_part_no_range or $found_part_volume_range or $found_part_year_range)) {
   			@books = $pkg->search_book_by_range($id);
   			return undef if (!$books[0]);
   			my @book_ids;
   			map { push @book_ids, $_->id; } @books;
   			$books[0]->{_column_data}{book_range_ids} = \@book_ids;
   		}
   		#nepokracujeme, hledame cislo periodika, ne souborny zaznam
   		return wantarray ? @books : $books[0];
	}
	
	# dotazy na zaznam book (souborny zaznam)
	unless (defined $books[0]) {
		return undef if ($creating and ($id->{part_no} or $id->{part_name} or $id->{part_year} or $id->{part_volume}));
		
		push @books, $pkg->search({ ean13=>$id->{ean13} }, { order_by=>\'(SELECT COUNT(*) FROM book WHERE id_parent = me.id) DESC, cover DESC' }) if($id->{ean13});
		my ($acceptable,$i,$part_type,$first_row) = (1,0,undef,undef);
		foreach (@books) {
			next unless (defined $_);
			$part_type = $_->get_column('part_type');
			next if ($part_type);
			$first_row = $_ unless ($i);
			$i++;
			last;
		}
		$acceptable = 0 if ($part_type); # hledame pouze monografie (i kdyz do dotazu zadame parametry periodika)
   		return $first_row if(@books and not wantarray and $acceptable);
   		
   		push @books, $pkg->search({ nbn=>$id->{nbn} }, { order_by=>\'(SELECT COUNT(*) FROM book WHERE id_parent = me.id) DESC, cover DESC' }) if($id->{nbn});
		$acceptable=1; $i=0; $part_type=undef; $first_row=undef;
		foreach (@books) {
			next unless (defined $_);
			$part_type = $_->get_column('part_type');
			next if ($part_type);
			$first_row = $_ unless ($i);			
			$i++;
			last;
		}
		$acceptable = 0 if ($part_type);
   		return $first_row if(@books and not wantarray and $acceptable);
   		
   		push @books, $pkg->search({ ismn=>$id->{ismn} }, { order_by=>\'(SELECT COUNT(*) FROM book WHERE id_parent = me.id) DESC, cover DESC' }) if($id->{ismn});
		$acceptable=1; $i=0; $part_type=undef; $first_row=undef;
		foreach (@books) {
			next unless (defined $_);
			$part_type = $_->get_column('part_type');
			next if ($part_type);
			$first_row = $_ unless ($i);			
			$i++;
			last;
		}
		$acceptable = 0 if ($part_type);
   		return $first_row if(@books and not wantarray and $acceptable);
   		
   		push @books, $pkg->search({ oclc=>$id->{oclc} }, { order_by=>\'(SELECT COUNT(*) FROM book WHERE id_parent = me.id) DESC, cover DESC' }) if($id->{oclc});
   		$acceptable=1; $i=0; $part_type=undef; $first_row=undef;
		foreach (@books) {
			next unless (defined $_);
			$part_type = $_->get_column('part_type');
			$first_row = $_ unless ($i);			
			$i++;
			last;
		}
		$acceptable = 0 if ($part_type);
		return $first_row if(@books and not wantarray and $acceptable);
		
		### VYHLEDAVANI V DALSICH PARAMETRECH - PRODUCT PARAMS ###
		
		if (defined $id->{ean13} or defined $id->{nbn} or defined $id->{oclc}) {
			my $nextParamsQuery;
			$nextParamsQuery->{'-or'} = [];
			push @{$nextParamsQuery->{'-or'}}, { 'ean13' => $id->{ean13} } if defined $id->{ean13};
			push @{$nextParamsQuery->{'-or'}}, { 'nbn' => $id->{nbn} } if defined $id->{nbn};
			push @{$nextParamsQuery->{'-or'}}, { 'oclc' => $id->{oclc} } if defined $id->{oclc};
			my $bookRes = DB->resultset('ProductParams')->search($nextParamsQuery);
			$acceptable=1; $i=0; $part_type=undef; $first_row=undef;
			if ($bookRes) {
				while (my $params = $bookRes->next) {
					my $book = DB->resultset('Book')->find($params->get_column('book'));
					next unless (defined $book);
					$part_type = $book->get_column('part_type');
					my $parent = $book->get_column('id_parent');
					if ($part_type and $parent) {
						$book = DB->resultset('Book')->find($parent);
						$part_type = $book->get_column('part_type');
					}
					push @books, $book;
					$first_row = $book unless ($i);
					$i++;
					last;
				}
				$acceptable = 0 if ($part_type);
		   		return $first_row if(@books and not wantarray and $acceptable);
			}
  		}
  		
  		### VYHLEDAVANI V DALSICH PARAMETRECH - IDENT ###
		
		if (defined $id->{ean13} or defined $id->{nbn} or defined $id->{oclc}) {
			my $nextParamsQuery;
			$nextParamsQuery->{'-or'} = [];
			push @{$nextParamsQuery->{'-or'}}, { 'type' => 1, 'val' => $id->{ean13} } if defined $id->{ean13};
			push @{$nextParamsQuery->{'-or'}}, { 'type' => 2, 'val' => $id->{oclc} } if defined $id->{oclc};
			push @{$nextParamsQuery->{'-or'}}, { 'type' => 3, 'val' => $id->{nbn} } if defined $id->{nbn};
			my $bookRes = DB->resultset('Ident')->search($nextParamsQuery);
			$acceptable=1; $i=0; $part_type=undef; $first_row=undef;
			if ($bookRes) {
				while (my $params = $bookRes->next) {
					my $book = DB->resultset('Book')->find($params->get_column('book'));
					next unless (defined $book);
					$part_type = $book->get_column('part_type');
					my $parent = $book->get_column('id_parent');
					if ($part_type and $parent) {
						$book = DB->resultset('Book')->find($parent);
						$part_type = $book->get_column('part_type');
					}
					push @books, $book;
					$first_row = $book unless ($i);
					$i++;
					last;
				}
				$acceptable = 0 if ($part_type);
		   		return $first_row if(@books and not wantarray and $acceptable);
			}
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
	return undef if ($bibinfo->{part_no} or $bibinfo->{part_name} or $bibinfo->{part_year} or $bibinfo->{part_volume});
	
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
	$str =~ s/\.\-/-/;
	$str =~ s/spec\./special/;
	
	# najdi posledny vyskyt znaku +
	my $lastPlus = rindex($str, '+');
	$str = substr($str, 0, $lastPlus-1) if ($lastPlus > -1);
	
	# normalize punctation
	my $regex = join "|", keys %Obalky::Config::replace_punctation;
	$regex = qr/$regex/;
	$str =~ s/($regex)/$Obalky::Config::replace_punctation{$1}/g;
	
	# replace month names by month numbers
	$regex = join "|", keys %Obalky::Config::replace_months;
	$regex = qr/$regex/;
	$str =~ s/cervenec/7/g if ($str =~ m/cervenec(\-|\s|$)/g);
	$str =~ s/($regex)/$Obalky::Config::replace_months{$1}/g;
	
	# rocni obdobi
	# budou se tridit abecedne, nebudou se normalizovat
	#$str =~ s/zima-jaro/1-6/g if ($str =~ m/zima-jaro/g);
	#$str =~ s/jaro-leto/4-9/g if ($str =~ m/jaro-leto/g);
	#$str =~ s/leto-podzim/7-12/g if ($str =~ m/leto-podzim/g);
	#$str =~ s/podzim-zima/10-15/g if ($str =~ m/podzim-zima/g);
	#$str =~ s/jaro/4-6/g if ($str =~ m/jaro/g);
	#$str =~ s/leto/7-9/g if ($str =~ m/leto/g);
	#$str =~ s/podzim/10-12/g if ($str =~ m/podzim/g);
	#$str =~ s/zima/1-3/g if ($str =~ m/zima/g);
	#$str =~ s/jaro/1-12/g if ($str =~ m/jaro-zima/g);
    
	# hledame vice urovnove oznaceni casti monografie (napr. "Ottuv slovnik naucny, 1.díl, 2.sv." se normalizuje na 1|2)
	# na vystupu bude vzdy v poradi dil|svazek i kdyz se informace na vstupu prohodi
	my @specialParts;
	# prvni v poradi je dil
	if ($str =~ m/(dil(\s|$|\,)|dily)/) {
		map {
			push @specialParts, $_ if (defined $_ and scalar @specialParts < 1 and ($_ ne '' or $_ ne 'dil' or $_ ne 'dily'));
		} $str =~ m/([0-9\s\.\-]*(dil|dily)[0-9\s]*)/g;
	}
	
	# svazek je druhy v poradi
	if ($str =~ m/(sv\.|svazek|svazky)/) {
		map {
			push @specialParts, $_ if (defined $_ and scalar @specialParts < 2 and ($_ ne 'sv' && $_ ne 'sv.' && $_ ne 'svazek' && $_ ne 'svazky'));
		} $str =~ m/([0-9\s\.\-]*(sv\.|svazek|svazky)[0-9\s]*)/g;
	}
	
	# ulozeni do spravneho poradi dil-svazek
	# pole uz mame takto serazene, staci spojit
	if (scalar @specialParts == 2) {
		my @out;
		map {
			push @out, $_ if (defined $_ and $_ ne '');
		} join('|', @specialParts) =~ m/([\d]*)/g;
		return join('|', @out);
	}
	
	# odstraneni casto pouzivanych "predpon"
	my $str_clr = $str;
	$str_clr =~ s/(č(\.|$)|c(\.|$)|cislo|číslo|Č(\.|$)|Číslo|sv(\.|$)|svazek|díl|Díl|dil|(\s|^)no(\.|$|\s)|(\s|^)nr(\.|$|\s)|měs(\.|$)|mes(\.|$))//g;
	
	# identifikace jestli cast obsahuje pismena
	my @tmp;
	@tmp = $str_clr =~ m/(\d{1,3}([\s\-\,]*\d{1,3})*)/g  unless ($str_clr =~ m/[a-z]/i);
	# pokud ano normalizuj text, pokud ne vyber cisla oddelene carkou a polckami
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
		last if (substr($str, $p, 1) !~ m/^[\s\[\]\(\)\.\,\-\;\\\/_\+]$/);
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
	$str =~ s/\-_/\-/;  $str =~ s/_\-/\-/;
	$str =~ s/\,_/_/;   $str =~ s/\._/_/;
	
	return $str;
}

sub normalizePureText {
	my($pkg,$str) = @_;
	
	# odstraneni interpunkce
	my $regex = join "|", keys %Obalky::Config::replace_punctation;
	$regex = qr/$regex/;
	$str =~ s/($regex)/$Obalky::Config::replace_punctation{$1}/g;
	
	# zmena mesice na cislo
	$regex = join "|", keys %Obalky::Config::replace_months;
	$regex = qr/$regex/;
	$str =~ s/cervenec/7/g if ($str =~ m/cervenec(\-|\s|$)/g);
	$str =~ s/($regex)/$Obalky::Config::replace_months{$1}/g;
	
	# normalizace jinych nez alpha-num. znaku
	$str =~ s/[^a-zA-Z\d\-\,]/_/g;
	$str =~ s/([_]){2,}/_/g;
	$str = substr($str, 1) if ($str && substr($str,0,1) eq '_');
	$str = substr($str, 0, -1) if ($str && substr($str,-1) eq '_');	
	$str =~ s/spec\./special/;
	$str =~ s/\s/_/g;
	return $str;
}

sub search_book_part {
	my ($pkg,$id) = @_;
	my @books;
	
	# PERIODIKUM
#warn $id->{part_year};   #debug
#warn $id->{part_volume}; #debug
#warn $id->{part_no};     #debug
#warn $id->{part_name};     #debug
	if ($id->{part_year} or $id->{part_volume}) {
#warn 'PERIODIKUM';       #debug
		my (@partYear,@partVolume,@partNo) = (undef,undef,undef);
		@partYear = @{$id->{part_year}} if ($id->{part_year});
		@partVolume = @{$id->{part_volume}} if ($id->{part_volume});
		@partNo = @{$id->{part_no}} if ($id->{part_no});
		push @partYear, $id->{part_year} if (ref $id->{part_year} ne 'ARRAY');
		push @partVolume, $id->{part_volume} if (ref $id->{part_volume} ne 'ARRAY');
		push @partNo, $id->{part_no} if (ref $id->{part_no} ne 'ARRAY');

		# cast periodika podle EAN/ISBN/ISSN
#warn '# cast periodika podle EAN/ISBN/ISSN';
		push @books, $pkg->search_book_part_helper([ $pkg->search({ ean13 => $id->{ean13}, part_type => 2 }) ], \@partYear, \@partVolume, \@partNo)
				if ($id->{ean13});
		return @books if(@books);
	   	
	   	# cast periodika podle NBN
#warn '# cast periodika podle NBN';
	   	push @books, $pkg->search_book_part_helper([ $pkg->search({ nbn => $id->{nbn}, part_type => 2 }) ], \@partYear, \@partVolume, \@partNo)
				if ($id->{nbn});
		return @books if(@books);
		
		# cast periodika podle ISMN
#warn '# cast periodika podle ISMN';
	   	push @books, $pkg->search_book_part_helper([ $pkg->search({ ismn => $id->{ismn}, part_type => 2 }) ], \@partYear, \@partVolume, \@partNo)
				if ($id->{ismn});
		return @books if(@books);
	   	
	   	# cast periodika podle OCLC
#warn '# cast periodika podle OCLC';
	   	push @books, $pkg->search_book_part_helper([ $pkg->search({ oclc => $id->{oclc}, part_type => 2 }) ], \@partYear, \@partVolume, \@partNo)
				if ($id->{oclc});
		return @books if(@books);
		
		### VYHLEDAVANI V DALSICH PARAMETRECH ###
#warn '# VYHLEDAVANI V DALSICH PARAMETRECH ###';
  		if (defined $id->{ean13}) {
	  		my $bookRes = DB->resultset('ProductParams')->search({ ean13 => $id->{ean13}});
			if ($bookRes) {
				while (my $params = $bookRes->next) {
					my $book = DB->resultset('Book')->find($params->get_column('book'));
					next unless (defined $book);
					my $part_type = $book->get_column('part_type');
					next if ($part_type ne 2);
					push @books, $pkg->search_book_part_helper([ $pkg->search({ ean13 => $book->get_column('ean13'), part_type => 2 }) ], \@partYear, \@partVolume, \@partNo);
					return @books if(@books);
				}
			}
  		}
	}
	
	# MONOGRAFIE
	else {
#warn 'MONOGRAFIE';       #debug
	   	# zamezeni tomu, aby se nalezl zaznam na zaklade shody prazdneho vstupu jednoho s poli s prazdnym obsahem stejneho pole v DB
	   	my ($part_no, $part_name) = (' ',' ');
	   	$part_no = $id->{part_no} if ($id->{part_no});
	   	$part_name = $id->{part_name} if ($id->{part_name});
	   	
	   	# cast monografie podle EAN/ISBN
		push @books, $pkg->search({ ean13 => $id->{ean13}, part_type => 1, -or=>{part_no => $part_no, part_name => $part_name} })
				if ($id->{ean13} and ($id->{part_no} or $id->{part_name}));
	   	return @books if(@books);
	   	
	   	# cast monografie podle NBN
		push @books, $pkg->search({ nbn => $id->{nbn}, part_type => 1, -or=>{part_no => $part_no, part_name => $part_name} })
				if ($id->{nbn} and ($id->{part_no} or $id->{part_name}));
	   	return @books if (@books);
	   	
	   	# cast monografie podle ISMN
		push @books, $pkg->search({ ismn => $id->{ismn}, part_type => 1, -or=>{part_no => $part_no, part_name => $part_name} })
				if ($id->{ismn} and ($id->{part_no} or $id->{part_name}));
	   	return @books if (@books);
	   	
	   	# cast monografie podle OCLC
		push @books, $pkg->search({ oclc => $id->{oclc}, part_type => 1, -or=>{part_no => $part_no, part_name => $part_name} })
				if ($id->{oclc} and ($id->{part_no} or $id->{part_name}));
	   	return @books if(@books);
	   	
	   	# souborne zaznamy podle EAN/ISBN
		push @books, $pkg->search({ ean13 => $id->{ean13}, part_type => undef }, { order_by => \'cover DESC' })
				if ($id->{ean13});
	   	return @books if(@books);
	   	
	   	# souborne zaznamy podle NBN
		push @books, $pkg->search({ nbn => $id->{nbn}, part_type => undef }, { order_by => \'cover DESC' })
				if ($id->{nbn});
	   	return @books if(@books);
	   	
	   	# souborne zaznamy podle ISMN
		push @books, $pkg->search({ ismn => $id->{ismn}, part_type => undef }, { order_by => \'cover DESC' })
				if ($id->{ismn});
	   	return @books if(@books);
	   	
	   	# souborne zaznamy podle OCLC
		push @books, $pkg->search({ oclc => $id->{oclc}, part_type => undef }, { order_by => \'cover DESC' })
				if ($id->{oclc});
	   	return @books if(@books);
	}
	
	return undef;
}

sub search_book_part_helper {
	my ($pkg,$items,$partYearReq,$partVolumeReq,$partNoReq) = @_;
	my @books;
	
	# dodatecne dohledame i podle slouceneho pole, separovaneho carkou
	push @$partYearReq, join(',', @{$partYearReq}) if (scalar @$partYearReq > 1);
	push @$partVolumeReq, join(',', @{$partVolumeReq}) if (scalar @$partVolumeReq > 1);
	push @$partNoReq, join(',', @{$partNoReq}) if (scalar @$partNoReq > 1);
	
	map {
		for (my $i=0; $i<scalar @$partYearReq; $i++) {
			my $partYear = @$partYearReq[$i];
			for (my $j=0; $j<scalar @$partVolumeReq; $j++) {
				my $partVolume = @$partVolumeReq[$j];
				for (my $k=0; $k<scalar @$partNoReq; $k++) {
					my $partNo = @$partNoReq[$k];
					
					my ($partNoDb, $partVolumeDb, $partYearDb) = (undef, undef, undef);
					$partYearDb = $_->get_column("part_year") if ($_->get_column("part_year"));
					$partVolumeDb = $_->get_column("part_volume") if ($_->get_column("part_volume"));
					$partNoDb = $_->get_column("part_no") if ($_->get_column("part_no"));
					
					#my @partNoRange = $pkg->get_range($partNoDb);
					#$partNoDb = join(',',@partNoRange) if ($partNoDb and !($partNoDb =~ /[a-z]/i));
					#$partVolumeDb = join(',',@partVolumeRange) if ($partVolumeDb and !($partVolumeDb =~ /[a-z]/i));
					#$partYearDb = join(',',@partYearRange) if ($partYearDb and !($partYearDb =~ /[a-z]/i));
					
#warn Dumper('partYear:'.$partYear.'/'.$partYearDb.' ; partVolume:'.$partVolume.'/'.$partVolumeDb.' ; partNo:'.$partNo.'/'.$partNoDb); #debug

					# presna shoda rok + cislo
					if ($partYear and $partNo and $partYearDb and $partNoDb and 
					    $partYearDb eq $partYear and $partNoDb eq $partNo and
					    ($partVolume eq $partVolumeDb or not $partVolume or not $partVolumeDb)
					)
					{
						#warn '*1'; #debug
						push @books, $_;
						next;
					}
					
					# presna shoda rocnik + cislo
					if ($partVolume and $partNo and $partVolumeDb and $partNoDb and 
					    $partVolumeDb eq $partVolume and $partNoDb eq $partNo and
					    ($partYear eq $partYearDb or not $partYear or not $partYearDb)
					)
					{
						#warn '*2'; #debug
						push @books, $_;
						next;
					}

					# rok + cislo castecna shoda u rozsahu periodik
					# pokud hledame periodika v rozsahu 1-6 = 1,2,3,4,5,6 a zaznam ulozeny v db. je napr. dvoucislo 3,4
					if ($partYear and $partNo and $partYearDb and $partNoDb and 
					    $partYearDb eq $partYear and 
					    (not $partVolume or $partVolume eq $partVolumeDb) and
					    $partNo=~/\,/ and $partNoDb=~/\,/ and 
					    ($partNo=~$partNoDb or $partNoDb=~$partNo))
					{
						#warn '*3'; #debug
						push @books, $_;
						next;
					}
					
					# rocnik + cislo castecna shoda u rozsahu periodik
					# pokud hledame periodika v rozsahu 1-6 = 1,2,3,4,5,6 a zaznam ulozeny v db. je napr. dvoucislo 3,4
					if ($partVolume and $partNo and $partVolumeDb and $partNoDb and 
					    $partVolumeDb eq $partVolume and
					    ($partNo eq $partNoDb or not $partNo) and
					    $partNo=~/\,/ and $partNoDb=~/\,/ and 
					    ($partNo=~$partNoDb or $partNoDb=~$partNo))
					{
						#warn '*4'; #debug
						push @books, $_;
						next;
					}
					
					# oprava vstupu; pokud se na vstupu rok a rocnik shoduje, jeden z nich nebude potrebny
					if ($partYear and $partVolume and $partYear eq $partVolume)
					{
						#warn '*5'; #debug
						$partVolume = undef if (length($partYear) == 4);
						$partYear = undef   if (length($partYear) != 4);
					}
					
					# presna shoda rok + rocnik, nebo castecna shoda pouze v roce, nebo rocniku
					# v takovemto pripade nesmi byt v DB vyplneno cislo periodika
					if (($partYear and $partVolume and $partYearDb eq $partYear and $partVolumeDb eq $partVolume and !$partNoDb) or
						($partYear and !$partVolume and $partYearDb eq $partYear and !$partNoDb) or
						(!$partYear and $partVolume and $partVolumeDb eq $partVolume and !$partNoDb))
					{
						#warn '*6'; #debug
						push @books, $_;
						next;
					}
				}
			}
		}
		
	} @$items;
	
	return @books;
}

sub get_parts {
	my ($pkg,$book,$sort,$idf,$page) = @_;
	return unless($book);
	my @books;
	my $id_parent = $book->id;
	
	my $srchQuery = { id_parent => $id_parent };
	$srchQuery = { id_parent => $id_parent, id => $idf } if (scalar @{$idf});
	
	if ($sort eq 'date') {
		# serazeni podle aktualnosti
		push @books, $pkg->search($srchQuery, { order_by => \'CAST(part_year AS unsigned) DESC, CAST(part_no AS unsigned) DESC' } );
	} else {
		# serazeni od posledne pridaneho
		push @books, $pkg->search($srchQuery, { order_by => \'id DESC' } );
	}
	
	# strankovani vyple = o strankovani se stara controller Root
	# toto potrebujeme kvuli vystupu vsech zaznamu casti periodika, kvuli zaskatulkovani do roku/rocnik a rozpadu ve stylu tree view
	# pouziva se u periodik serazenych podle data a razeni + strankovani ridi controller; z teto metody ocekava pouze select vsech dat
	return (\@books, undef) if (not $page);
	
	# strankovani
	my ($page_start, $page_end, $no_more_pages);	
	$page_start = ($page == 1) ? 0 : ((($page - 1) * 30));	
	if (($page * 30) >= scalar @books){
		$no_more_pages = 1;
		$page_end = (scalar @books) - 1;
	}
	else {
		$no_more_pages = 0;
		$page_end = ($page * 30) - 1;
	}
	
	my @books_filtered = @books[$page_start .. $page_end];
	
	return (\@books_filtered, $no_more_pages);
}

sub search_book_by_range {
	my ($pkg,$id) = @_;
	
	warn "SEARCHING BOOK BY RANGE\n part_no: ".Dumper($id->{part_no}).' part_volume: '.Dumper($id->{part_volume}).' part_year: '.Dumper($id->{part_year}) if($ENV{DEBUG});
	
	# odlozime puvodni pozadavek
	# pokud nalezneme zaznamy pomoci rozsahu hodnot, ocitne se na vystupu prvni z nalezenych zaznamu, tj. jedno cislo (pokud nebyl explicitne odskenovan dany rozsah; v tom pripade by tato funkce search_book_by_range nebyla ani volana)
	# po uspesnem vyhledani rozsahu budou part parametry no/volume/year nahrazeny za ty z pozadavku; cache server pri dalsim pozadavku pouzije stejny zaznam
	my ($part_no_req, $part_volume_req, $part_year_req) = ($id->{part_no}, $id->{part_volume}, $id->{part_year});
	
	# sestav radu cisel z posloupnosti definovane v PART_NO
	if ($id->{part_no} and !($id->{part_no} =~ /[a-z]/i)) {
		my @book_part_no;
		my @part_no_separated = split /,/, $id->{part_no};
		# carka oddeluje hodnoty/rozsahy hodnot
		foreach (@part_no_separated) {
			my @part_no = split /-/, $_;
			# neni rozsahem, obsahuje jednu hodnotu
			if (scalar @part_no == 1) {
				push(@book_part_no, trim($part_no[0]));
				next;
			}
			# muze byt rozsahem
			next if (scalar @part_no < 2);
			my $cycleFrom = trim($part_no[0]);
			my $cycleTo = trim($part_no[1]);
			next if (!($cycleFrom =~ /^\d*$/));
			next if (!($cycleTo =~ /^\d*$/));
			next if ($cycleFrom > $cycleTo); # rozsah musi byt dopredny
			for (my $i=$cycleFrom; $i<=$cycleTo; $i++) {
				push(@book_part_no, $i);
			}
		}
		$id->{part_no} = \@book_part_no if (scalar @book_part_no > 0);
	}
	
	
	# sestav radu cisel z posloupnosti definovane v PART_VOLUME
	if ($id->{part_volume} and !($id->{part_volume} =~ /[a-z]/i)) {
		my @book_part_volume;
		my @part_volume_separated = split /,/, $id->{part_volume};
		# carka oddeluje hodnoty/rozsahy hodnot
		foreach (@part_volume_separated) {
			my @part_volume = split /-/, $_;
			# neni rozsahem, obsahuje jednu hodnotu
			if (scalar @part_volume == 1) {
				push(@book_part_volume, trim($part_volume[0]));
				next;
			}
			# muze byt rozsahem
			next if (scalar @part_volume < 2);
			my $cycleFrom = trim($part_volume[0]);
			my $cycleTo = trim($part_volume[1]);
			next if (!($cycleFrom =~ /^\d*$/));
			next if (!($cycleTo =~ /^\d*$/));
			next if ($cycleFrom > $cycleTo); # rozsah musi byt dopredny
			for (my $i=$cycleFrom; $i<=$cycleTo; $i++) {
				push(@book_part_volume, $i);
			}
		}
		$id->{part_volume} = \@book_part_volume if (scalar @book_part_volume > 0);
	}
	
	# sestav radu cisel z posloupnosti definovane v PART_YEAR
	if ($id->{part_year} and !($id->{part_year} =~ /[a-z]/i)) {
		my @book_part_year;
		my $last_valid_year;
		my @part_year_separated = split /,/, $id->{part_year};
		# carka oddeluje hodnoty/rozsahy hodnot
		foreach (@part_year_separated) {
			my @part_year = split /-/, $_;
			# doplneni plne formy zapisu let
			for (my $i=0; $i<=1; $i++) {
				next if (!$part_year[$i]);
				my $rVal = trim($part_year[$i]);
				my $rValLength = length($rVal);
				$last_valid_year = $rVal if ($rValLength>2); # nova hodnota jako vzor pro doplnovani nekompletnich let
				next if ($rValLength>2); # hodnota ma uz dobrou formu (3-4 mistne cislo)
				next unless ($last_valid_year); # pro doplneni zkracene formy roku potrebujeme kompletni zapis
				my $pValPost = substr($last_valid_year, -$rValLength); # cast kompletniho zapisu roku shodne delky jako je nekompletni rok
				my $pValPre = substr($last_valid_year, 0, $rValLength); # cast kompletniho zapisu roku shodne delky jako je nekompletni rok
				if ($pValPost < $rVal) {
					# budeme doplnovat stejne desetileti/stoleti jako kompletni rok
					# priklad 1950-56 = 1950-1956
					$part_year[$i] = $pValPre.$rVal;
				} else {
					# bude potrebny presun do dalsiho desetileti/stoleti
					# priklad 1998-02 = 1998-2002
					$part_year[$i] = ($pValPre+1).$rVal;
				}
			}
			# neni rozsahem, obsahuje jednu hodnotu
			if (scalar @part_year == 1) {
				push(@book_part_year, trim($part_year[0]));
				next;
			}
			# muze byt rozsahem
			next if (scalar @part_year < 2);
			my $cycleFrom = trim($part_year[0]);
			my $cycleTo = trim($part_year[1]);
			next if (!($cycleFrom =~ /^\d*$/));
			next if (!($cycleTo =~ /^\d*$/));
			next if ($cycleFrom > $cycleTo); # rozsah musi byt dopredny
			for (my $i=$cycleFrom; $i<=$cycleTo; $i++) {
				push(@book_part_year, $i);
			}
		}
		$id->{part_year} = \@book_part_year if (scalar @book_part_year > 0);
	}
	
	# dotaz na rozsah
	warn "PARTS AFTER TRANSFORMATION\n part_no: ".Dumper($id->{part_no}).' part_volume: '.Dumper($id->{part_volume}).' part_year: '.Dumper($id->{part_year}) if($ENV{DEBUG});
	my @books = $pkg->search_book_part($id);
	
	# pokud byl uspesny potrebujeme vratit puvodni identifikatory part_no/part_volume/part_year
	for (my $i=0; $i<scalar @books; $i++) {
		if ($books[$i]) {
			$books[$i]->{book_id_origin} = $books[$i]->id;
			$books[$i]->{_column_data}{part_no} = $part_no_req if ($part_no_req);
			$books[$i]->{_column_data}{part_volume} = $part_volume_req if ($part_volume_req);
			$books[$i]->{_column_data}{part_year} = $part_year_req if ($part_year_req);
		}
	}
	
	return @books;
}

sub get_range {
	my ($pkg,$str) = @_;
	
	my @book_part_no;
	my @part_no_separated = split /,/, $str;
	# carka oddeluje hodnoty/rozsahy hodnot
	foreach (@part_no_separated) {
		my @part_no = split /-/, $_;
		# neni rozsahem, obsahuje jednu hodnotu
		if (scalar @part_no == 1) {
			push(@book_part_no, trim($part_no[0]));
			next;
		}
		# muze byt rozsahem
		next if (scalar @part_no < 2);
		my $cycleFrom = trim($part_no[0]);
		my $cycleTo = trim($part_no[1]);
		next if (!($cycleFrom =~ /^\d*$/));
		next if (!($cycleTo =~ /^\d*$/));
		next if ($cycleFrom > $cycleTo); # rozsah musi byt dopredny
		for (my $i=$cycleFrom; $i<=$cycleTo; $i++) {
			push(@book_part_no, $i);
		}
	}
	
	return @book_part_no;
}

#vyhladavanie vazieb pomocou z39.50
sub search_z39{
	my ($pkg, $search_value, $limit_amount) = @_;
	my $dbname = "SKC-UTF";
	my $conn = new ZOOM::Connection('aleph.nkp.cz', '9991', databaseName => $dbname);
	return if ($conn->errcode());	
	#tvorba pqf dotazu
	my ($title, $identifiers) = ("","");
	
	#odstranenie whitespace od konca retazca - niekedy sposobovalo chybove hlasenia
	$search_value =~ s/\s+$//;
	
	my $search_identifier = Obalky::BibInfo->parse_code($search_value);	
	$title ='@attr 1=4 "'.$search_value.'"';
	$identifiers = '@or @or @attr 1=7 "'.$search_identifier.'" @attr 1=8 "'.$search_identifier.'"' if ($search_identifier && (!$search_identifier =~ /^\d+/));
	my $query = $identifiers.$title;

	my $rs = z39_search_by_query($conn, $query);
	return if (!$rs);	
	my $size = $rs->size();
	warn $size." results." if ($ENV{DEBUG});
	return if ($size eq 0);
	
	# MAX_AMOUNT = maximane mnozstvo knih, ktore sa z
	my $MAX_AMOUNT = ($size > $limit_amount) ? $limit_amount : $size;
	my @books;
	for (my $i = 0; $i < $MAX_AMOUNT; ++$i){	
		last if ($i >= $size);
		my $record = $rs->record($i);
		my ($bibinfo, $sysno, $local_id) = z39_convert_record_to_bibinfo($record);
		
		#preskoci v hladani zaznamu chybaju identifikatory
		#ak zaznam existuje v DB, uz bol ulozeny v predchadzajucom vyhladavani -- preskocit
		if ((!$bibinfo->{'ean13'} and !$bibinfo->{'nbn'} and !$bibinfo->{'oclc'}) || DB->resultset('Book')->find_by_bibinfo($bibinfo)){
			$MAX_AMOUNT++;
			next;
		}		
		$bibinfo->{'id'} = '[Z39]'.$sysno;
		$bibinfo->{'url'} = 'http://aleph.nkp.cz/F/?func=direct&doc_number='.$sysno.'&local_base='.$dbname;
		push (@books, $bibinfo);
						
	}
	return @books;
}


sub z39_search_by_query{
	my ($conn, $query) = @_;
	my $rs;
	eval {
		$rs = $conn->search_pqf($query);
	};
	# zachytenie chyby pri zlom formate dotazu
	if ($@){
		warn $@ if ($ENV{DEBUG});
		return undef;
	}
	else {
		return $rs;
	}
}

sub z39_find_record_by_id_and_create_bibinfo{
	my ($conn, $id) = @_;
	my $query = '@attr 1=1032 "'.$id.'"';
	my $rs = z39_search_by_query($conn, $query);
	return undef if ($rs->size() eq 0);
	my ($bibinfo, $sysno)= z39_convert_record_to_bibinfo($rs->record(0));
	return ($bibinfo, $sysno);
}

#spracuje raw zaznam a vytvori bibinfo
sub z39_convert_record_to_bibinfo{
	my ($record) = @_;
	my ($title_proper, $title_sub);
	my $marc = new_from_usmarc MARC::Record($record->raw());
	my $sysno = $marc->subfield('998','a');
	my $local_id = $marc->field('001')->data();
	my $bib = {};
	$bib->{'nbn'} = $marc->subfield('015', "a");
	$bib->{'oclc'} = $marc->subfield('035', "a");
	$bib->{'oclc'} =~ s/\(.*\)//g if ($bib->{'oclc'});
	$title_proper = $marc->title_proper();
	$title_proper =~ s/\s*\/\s*$// if ($title_proper);
	$title_sub = $marc->subfield('245', 'b') || '';
	$bib->{'title'} = $title_proper;
	$bib->{'authors'} = $marc->subfield('100', 'a');
	$bib->{'authors'} =~ s/,$// if $bib->{'authors'};
	$bib->{'year'} = $marc->subfield('264','c');
	my (@eanfield, $bibinfo, $has_eans, $cnt);
	my ($suggestion_id, $source_db, $source_url, $found);
	push @eanfield, ($marc->field('020'),$marc->field('022'),$marc->field('024'),$marc->field('902'));
	
	$has_eans =  0;
	foreach my $field (@eanfield){
		my $ean = $field->subfield("a");
		next if (!$ean);
		#mozu existovat prazdne polia, kde chyba subfield 'a'
		$has_eans = 1 if (!$has_eans);
		$ean =~ tr/-//d;
		$ean = Obalky::BibInfo->parse_code($ean);
		$bib->{'ean'} = $ean;
		$bibinfo = Obalky::BibInfo->new_from_params($bib);
		last if ($found);
		
	}

	if (!@eanfield or !$has_eans){
		$bibinfo = Obalky::BibInfo->new_from_params($bib);
	}
	$bibinfo->{title} = $title_proper.$title_sub;
	$bibinfo->{title} =~ s/\s*\/\s*$// if ($title_sub);
	return ($bibinfo, $sysno, $local_id);
}

# najde knihu podla local number, prida ju do DB, vrati book ID
sub add_book_from_z39{
	my ($pkg, $conn, $id) = @_;
	my ($bibinfo, $sysno) = z39_find_record_by_id_and_create_bibinfo($conn, $id);
	return if (!$bibinfo); # osetrenie pre istotu, nemalo by nastat, jedine v pripade, ze sa zmeni system vyhladavania
	my $product_url = 'http://aleph.nkp.cz/F/?func=direct&doc_number='.$sysno.'&local_base=SKC-UTF';
	my $eshop = DB->resultset('Eshop')->find(7136);
	my $product = $eshop->add_product($bibinfo, undef, $product_url);
	return $product->book->id;
}
1;
