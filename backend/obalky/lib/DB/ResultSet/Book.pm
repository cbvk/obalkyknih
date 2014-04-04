
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
    push @books, DB->resultset('Book')->search(
        { ean13 => $id->{ean13} }) if($id->{ean13});
    return $books[0] if(@books and not wantarray);
    push @books, DB->resultset('Book')->search(
        { oclc => $id->{oclc} }) if($id->{oclc});
    return $books[0] if(@books and not wantarray);
    push @books, DB->resultset('Book')->search(
        { nbn => $id->{nbn} }) if($id->{nbn});
    return $books[0] if(@books and not wantarray);

	# TODO: podle nazvu, autora, roku,... ?
	push @books, DB->resultset('Book')->search({ title => $id->{title}, 
		authors => $id->{authors}, year => $id->{year} }) if($id->{title});

	return wantarray ? @books : $books[0];
}
sub find_by_bibinfo_or_create {
	# nelze pouzit find_or_create, pac nehledame dle unique contrain
	my($pkg,$bibinfo) = @_;
	warn "Looking for ".Dumper($bibinfo)."\n" if($ENV{DEBUG});
	my $book = $pkg->find_by_bibinfo($bibinfo);
	warn "Found book ".$book->id."\n" if($ENV{DEBUG} and $book);
	return $book if $book;
	my $hash = {};
	$bibinfo->save_to_hash($hash);
	warn "Creating book... EAN ".$hash->{ean13}."\n" if($ENV{DEBUG});
	return $pkg->create($hash);
}

1;
