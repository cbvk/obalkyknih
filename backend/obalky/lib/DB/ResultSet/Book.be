
package DB::ResultSet::Book;
use base 'DBIx::Class::ResultSet';
use Encode;
use String::Util qw(trim);

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
	unless ($id->{part_no} or $id->{part_name} or $id->{part_year} or $id->{part_volume}) {
		$id->{part_year} = $id->{part_volume} = undef;
		push @books, $pkg->search({ ean13=>$id->{ean13} }, { order_by=>\'(SELECT COUNT(*) FROM book WHERE id_parent = me.id) DESC, cover DESC' }) if($id->{ean13});
   		return $books[0] if(@books and not wantarray);
   		push @books, $pkg->search({ nbn=>$id->{nbn} }, { order_by=>\'(SELECT COUNT(*) FROM book WHERE id_parent = me.id) DESC, cover DESC' }) if($id->{nbn});
		return $books[0] if(@books and not wantarray);
   		push @books, $pkg->search({ oclc=>$id->{oclc} }, { order_by=>\'(SELECT COUNT(*) FROM book WHERE id_parent = me.id) DESC, cover DESC' }) if($id->{oclc});
  		return $books[0] if(@books and not wantarray);
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
	$str =~ s/zima-jaro/1-6/g if ($str =~ m/zima-jaro/g);
	$str =~ s/jaro-leto/4-9/g if ($str =~ m/jaro-leto/g);
	$str =~ s/leto-podzim/7-12/g if ($str =~ m/leto-podzim/g);
	$str =~ s/podzim-zima/10-15/g if ($str =~ m/podzim-zima/g);
	$str =~ s/jaro/4-6/g if ($str =~ m/jaro/g);
	$str =~ s/leto/7-9/g if ($str =~ m/leto/g);
	$str =~ s/podzim/10-12/g if ($str =~ m/podzim/g);
	$str =~ s/zima/1-3/g if ($str =~ m/zima/g);
	$str =~ s/jaro/1-12/g if ($str =~ m/jaro-zima/g);
    
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
	if ($str =~ m/(sv(\.{0,1})|svazek|svazky)/) {
		map {
			push @specialParts, $_ if (defined $_ and scalar @specialParts < 2 and ($_ ne 'sv' && $_ ne 'sv.' && $_ ne 'svazek' && $_ ne 'svazky'));
		} $str =~ m/([0-9\s\.\-]*(sv(\.{0,1})|svazek|svazky)[0-9\s]*)/g;
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
	$str_clr =~ s/(č(\.|$)|c(\.|$)|cislo|číslo|Č(\.|$)|Číslo|sv(\.|$)|svazek|díl|Díl|(\s|^)no(\.|$|\s)|(\s|^)nr(\.|$|\s)|měs(\.|$)|mes(\.|$))//g;
	
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
	if ($id->{part_year} or $id->{part_volume}) {
		my (@partYear,@partVolume,@partNo) = (undef,undef,undef);
		@partYear = @{$id->{part_year}} if ($id->{part_year});
		@partVolume = @{$id->{part_volume}} if ($id->{part_volume});
		@partNo = @{$id->{part_no}} if ($id->{part_no});
		push @partYear, $id->{part_year} if (ref $id->{part_year} ne 'ARRAY');
		push @partVolume, $id->{part_volume} if (ref $id->{part_volume} ne 'ARRAY');
		push @partNo, $id->{part_no} if (ref $id->{part_no} ne 'ARRAY');

		# cast periodika podle EAN/ISBN/ISSN
		push @books, $pkg->search_book_part_helper([ $pkg->search({ ean13 => $id->{ean13}, part_type => 2 }) ], \@partYear, \@partVolume, \@partNo)
				if ($id->{ean13});
		return @books if(@books);
	   	
	   	# cast periodika podle NBN
	   	push @books, $pkg->search_book_part_helper([ $pkg->search({ nbn => $id->{nbn}, part_type => 2 }) ], \@partYear, \@partVolume, \@partNo)
				if ($id->{nbn});
		return @books if(@books);
	   	
	   	# cast periodika podle OCLC
	   	push @books, $pkg->search_book_part_helper([ $pkg->search({ oclc => $id->{oclc}, part_type => 2 }) ], \@partYear, \@partVolume, \@partNo)
				if ($id->{oclc});
		return @books if(@books);
	}
	
	# MONOGRAFIE
	else {
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
	   	
	   	# souborne zaznamy podle OCLC
		push @books, $pkg->search({ oclc => $id->{oclc}, part_type => undef }, { order_by => \'cover DESC' })
				if ($id->{oclc});
	   	return @books if(@books);
	}
	
	return undef;
}

sub search_book_part_helper {
	my ($pkg,$items,$partYear,$partVolume,$partNo,) = @_;
	my @books;
	
	# dodatecne dohledame i podle slouceneho pole, separovaneho carkou
	push @$partYear, join(',', @{$partYear}) if (scalar @$partYear > 1);
	push @$partVolume, join(',', @{$partVolume}) if (scalar @$partVolume > 1);
	push @$partNo, join(',', @{$partNo}) if (scalar @$partNo > 1);
	
	map {
		for (my $i=0; $i<scalar @$partYear; $i++) {
			my $partYear = @$partYear[$i];
			for (my $j=0; $j<scalar @$partVolume; $j++) {
				my $partVolume = @$partVolume[$j];
				for (my $k=0; $k<scalar @$partNo; $k++) {
					my $partNo = @$partNo[$k];
					
					my ($partNoDb, $partVolumeDb, $partYearDb) = (undef, undef, undef);
					$partYearDb = $_->get_column("part_year") if ($_->get_column("part_year"));
					$partVolumeDb = $_->get_column("part_volume") if ($_->get_column("part_volume"));
					$partNoDb = $_->get_column("part_no") if ($_->get_column("part_no"));
					
					#my @partNoRange = $pkg->get_range($partNoDb);
					#$partNoDb = join(',',@partNoRange) if ($partNoDb and !($partNoDb =~ /[a-z]/i));
					#$partVolumeDb = join(',',@partVolumeRange) if ($partVolumeDb and !($partVolumeDb =~ /[a-z]/i));
					#$partYearDb = join(',',@partYearRange) if ($partYearDb and !($partYearDb =~ /[a-z]/i));
					
					# presna shoda rok + cislo
					if ($partYear and $partNo and $partYearDb and $partNoDb and 
					    $partYearDb eq $partYear and $partNoDb eq $partNo and
					    ($partVolume eq $partVolumeDb or undef $partVolume)
					)
					{
						push @books, $_;
						next;
					}
					
					# presna shoda rocnik + cislo
					if ($partVolume and $partNo and $partVolumeDb and $partNoDb and 
					    $partVolumeDb eq $partVolume and $partNoDb eq $partNo and
					    ($partNo eq $partNoDb or undef $partNo)
					)
					{
						push @books, $_;
						next;
					}

					# rok + cislo castecna shoda u rozsahu periodik
					# pokud hledame periodika v rozsahu 1-6 = 1,2,3,4,5,6 a zaznam ulozeny v db. je napr. dvoucislo 3,4
					if ($partYear and $partNo and $partYearDb and $partNoDb and 
					    $partYearDb eq $partYear and 
					    ($partVolume eq $partVolumeDb or undef $partVolume) and
					    $partNo=~/\,/ and $partNoDb=~/\,/ and $partNo=~$partNoDb)
					{
						push @books, $_;
						next;
					}
					
					# rocnik + cislo castecna shoda u rozsahu periodik
					# pokud hledame periodika v rozsahu 1-6 = 1,2,3,4,5,6 a zaznam ulozeny v db. je napr. dvoucislo 3,4
					if ($partVolume and $partNo and $partVolumeDb and $partNoDb and 
					    $partVolumeDb eq $partVolume and
					    ($partNo eq $partNoDb or undef $partNo) and
					    $partNo=~/\,/ and $partNoDb=~/\,/ and $partNo=~$partNoDb)
					{
						push @books, $_;
						next;
					}
					
					# oprava vstupu; pokud se na vstupu rok a rocnik shoduje, jeden z nich nebude potrebny
					if ($partYear and $partVolume and $partYear eq $partVolume)
					{
						$partVolume = undef if (length($partYear) == 4);
						$partYear = undef   if (length($partYear) != 4);
					}
					
					# presna shoda rok + rocnik, nebo castecna shoda pouze v roce, nebo rocniku
					# v takovemto pripade nesmi byt v DB vyplneno cislo periodika
					if (($partYear and $partVolume and $partYearDb eq $partYear and $partVolumeDb eq $partVolume and !$partNoDb) or
						($partYear and !$partVolume and $partYearDb eq $partYear and !$partNoDb) or
						(!$partYear and $partVolume and $partVolumeDb eq $partVolume and !$partNoDb))
					{
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
	my ($pkg,$book,$sort,$idf) = @_;
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
	return @books;
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

1;
