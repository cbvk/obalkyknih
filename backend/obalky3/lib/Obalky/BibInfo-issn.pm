
package Obalky::BibInfo;

use Business::Barcode::EAN13 qw/valid_barcode check_digit issuer_ccode/;
use Business::ISBN;
use Business::ISSN;
use Data::Dumper;
use HTML::Tiny;

use Obalky::Config;

=head1 NAME

Obalky::BibInfo - zpracovani (zejmena) identifikatoru knizky

=head1 SYNOPSIS

    use Obalky::BibInfo
#    my $object = My::Module->new();
#    print $object->as_string;

=head1 DESCRIPTION

Identifikator (jmeno vstupniho souboru)

ID ::= EAN | ISBN | IDS | EAN13
IDS ::= NSID | NSID . "_" . IDS
NSID ::= "oclc" SEP OCLC | "isbn" SEP ISBN  |
         "ean" SEP EAN   | PREFIX SEP LOCAL | "nbn" SEP NBN
SEP ::= ("_" | ":" : "=" )
OCLC ::= .+
PREFIX ::= [a-z]+
LOCAL ::= .+
NBN ::= .+
EAN ::= [0-9]{12}[0-9X] /* pripadne s pomlckami */
ISBN ::= [0-9]{9}[0-9X] /* pripadne s pomlckami */

isbn_1234, ean_123, oclc_123, nbn_123, isbn1234_nbn123

978123456789X
978-123-4-56789-X
123456789X
123-4-56789-X

=head2 Methods

=over 12

=cut


my @keys = qw/ean13 oclc nbn title authors year/;

sub new {
	my($pkg,$object) = @_;
	my $bibinfo = bless {}, $pkg;

	$bibinfo->{ean13} = $object->ean13 if(defined $object->ean13);
	$bibinfo->{oclc} = $object->oclc   if(defined $object->oclc);
	$bibinfo->{nbn}  = $object->nbn    if(defined $object->nbn);

	$bibinfo->{title} = $object->title if(defined $object->title);
	my $authors = $object->authors;
	$bibinfo->{authors} = [split(/\;/,$authors)] if(defined $authors);
	$bibinfo->{year} = $object->year if(defined $object->year);

	return $bibinfo;
}

sub merge {
	my($old,$new) = @_;
	my $changes = 0;
	foreach my $key (@keys) {
		if(defined $new->{$key} and not defined $old->{$key}) {
			$old->{$key} = $new->{$key};
			$changes++;
		}
	}
	return $changes;
}

=item C<is_same>

Porovna dva bibinfo objekty, vrati undef, kdyz neumi rozhodnout, 
zda jsou stejne

=cut
sub differs {
	my($a,$b) = @_;
	return $a->ean13 ne $b->ean13 if($a->ean13 and $b->ean13);
	return $a->oclc  ne $b->occl  if($a->oclc  and $b->oclc );
	return $a->nbn   ne $b->nbn   if($a->nbn   and $b->nbn  );
	return undef; # nevime..
}

sub nbn {
	my($id,$value) = @_;
	$id->{nbn} = $value if(defined $value);
	return $id->{nbn};
}
sub oclc {
	my($id,$value) = @_;
	$id->{oclc} = $value if(defined $value);
	return $id->{oclc};
}
sub ean13 {
	my($id,$value) = @_;
	$id->{ean13} = $value if(defined $value);
	return $id->{ean13};
}
sub isbn {
	my($id,$isbn) = @_;
	return $id->ean($isbn);
}
sub issn {
	my($id,$issn) = @_;
	return $id->ean($issn);
}
sub ean {
	my($id,$ean) = @_;
	if($ean) { # 8, 10, 12 or 13
		$ean =~ s/\-//g; 
		if(length($ean) == 8) {
        	my $obj = Business::ISSN->new($ean);
        	my $format = $obj->as_string;
        	$id->{ean13} = $id->isbn_to_ean13($format);
			return $id->{ean13};
		} elsif(length($ean) == 10) {
        	$obj = Business::ISBN->new($ean);
        	my $format = $obj->as_string;
        	$id->{ean13} = $id->isbn_to_ean13($format);
			return $id->{ean13};
		} elsif(length($ean) == 12 or length($ean) == 13) {
			$ean .= check_digit($ean) if(length($ean) == 12);
			$id->{ean13} = $ean;
			return $id->to_isbn;
		}
	}
	return $id->to_isbn;
}

sub new_from_ean {
	my($pkg,$ean) = @_;
	return $pkg->new_from_params({ ean => $ean});
}

sub new_from_string {
	my($pkg,$string) = @_;
	my($ean,$oclc,$nbn);

	$string = '' unless($string); # should not happen

	$string =~ s/\..+$//; # strip filename extension??
	my $eanvalue = $string; $eanvalue =~ s/\-//g;
	$ean   = ($2||"").$3 if($eanvalue =~ 
				/^(isbn|issn|ean)?\_?(97.)?(\d{8,9}[0-9X])$/i);
	$oclc  = $1    if($string =~ /^oclc\_?(.+)$/i);
	$nbn   = $1    if($string =~ /^nbn\_?(.+)$/i);

#	warn "string=$string, ean=$ean\n";
	unless($ean or $oclc or $nbn) {
		foreach(split(/\_/,$string)) {
			my($key,$value) = ($1,$2) if(/^([a-z]+)[\_\:\=]?(.+)$/);
			unless($value) {
				#warn __PACKAGE__."::new_from_string(\"$string\"): ".
				#			"parse error\n";
				return;
			}
			if($key eq 'isbn' or $key eq 'ean' or $key eq 'issn') {
				$ean = $value;
			} elsif($key eq 'oclc') {
				$oclc = $value;
			} elsif($key eq 'nbn') {
				$nbn = $value;
			}
		}
	}
	return $pkg->new_from_params({ oclc => $oclc, nbn => $nbn, ean => $ean});
}

sub new_from_params {
	my($pkg,$param) = @_;
	my $ean = $param->{ean} || $param->{isbn};
	my $ean13;
	$ean13 = $pkg->isbn_to_ean13($ean) if($ean);
	$ean13 = $param->{ean13} if($param->{ean13});
	my $year = ($param->{year} and $param->{year} =~ /(\d{4})/) ? $1 : undef;

#	warn "new_from_params($ean)\n";
	# aspon neco z EAN, OCLC, NBN nebo Title musi byt vyplneno!
	return unless($ean13 or $param->{oclc} or 
				  $param->{nbn} or $param->{title}); 

	# todo: normalize oclc, nbn
	return bless {
		ean13 => $ean13,
		oclc => $param->{oclc},
		nbn => $param->{nbn},
		title => $param->{title},
		authors => $param->{authors}, # ujistit se, ze to je pole?
		# isbns => ?
		year => $year,
	}, $pkg;
}

sub save_to {
	my($id,$object) = @_;
	$object->update($id->save_to_hash());
}
sub save_to_hash {
	my($id,$hash) = @_;
	$hash ||= {};
	map $hash->{$_} = $id->{$_}, grep $id->{$_}, qw/ean13 oclc nbn title year/;
	$hash->{authors} = join(";",@{$id->{authors}}) if($id->{authors});
	return $hash;
}

sub isbn_to_ean13 {
    my($pkg,$isbn) = @_;
	my $in = $isbn;
    return unless($isbn);
	# FIX: zkontrolovat checksum!!!
	$isbn =~ s/^isbn\s*\&nbsp\;//i; 
    $isbn =~ s/\-//g; $isbn =~ s/^\s*//; $isbn =~ s/\s.*//;
    $isbn =~ s/^(.+)\&nbsp\;.*/$1/;
    $isbn =~ s/^.*?([0-9]{9,12}[0-9X]).*/$1/;
	return if(length($isbn) < 9);
#	warn "isbn_to_ean13($isbn)\n";
	return $isbn if((not $obj or not $obj->is_valid) and ($isbn =~ /^977/) and (length($isbn) == 13));
	my $obj = Business::ISBN->new($isbn);
	$obj = Business::ISSN->new($isbn) unless($obj and $obj->is_valid);
	return unless($obj and $obj->is_valid);
	my $ean13 = $obj->as_isbn13->as_string;
	$ean13 =~ s/\-//g;
#	warn "$in -> $isbn -> $ean13\n";
	return $ean13;
}

sub to_isbn {
	my($id) = @_;
	return undef unless($id->{ean13});
	return $id->{ean13};
#    my $isbn = Business::ISBN->new($id->{ean13}) or return;
#	return $isbn->as_isbn13->as_string;
}

sub to_params {
	my($id) = @_;
	my @out;
	foreach(qw/ean13 oclc nbn/) {
		push @out, $_."=".$id->{$_} if($id->{$_});
	}
	return join("&",@out);
}

sub to_some_param {
	my($id) = @_;
	return $id->{ean13} ? "isbn=".$id->to_isbn : $id->to_params;
}
sub to_some_id {
	my($id) = @_;
	my $isbn = $id->to_isbn;
	return $isbn if($isbn);
	return $id->oclc ? $id->oclc : "NULL";
}

sub to_string {
	my($id) = @_;
	my %ids = %$id;
	if($ids{ean13}) {
		$ids{isbn} = $id->to_isbn;
		delete $ids{ean13};
	}
	my @out;
	foreach(sort keys %ids) {
		push @out, $_.":".$ids{$_} if($ids{$_});
	}
	return join(" ",@out);
}

sub to_human_title {
	my($id) = @_;
	return $id->{title} if($id->{title});
	return "ISBN ".$id->to_isbn if($id->{ean13});
	return "OCLC ".$id->oclc if($id->oclc);
	return $id->to_some_param; # failback...
}

sub to_human_string {
	my($id) = @_;
	my %ids = %$id;
	if($ids{ean13}) {
		$ids{isbn} = $id->to_isbn;
		delete $ids{ean13};
	}
	my @out;
	foreach(sort keys %ids) {
		push @out, uc($_)." ".$ids{$_} if($ids{$_});
	}
	return join(", ",@out);
}

sub to_xml {
	my($id) = @_;
	my($isbn,$ean) = $id->isbn_forms;
	my $info = { isbn => $isbn, ean => $ean, 
				 oclc => $id->oclc, nbn => $id->nbn };
	my @ids;
#	my $h = new HTML::Tiny;
	foreach my $key (sort keys %$info) {
		my $value = $info->{$key} or next;
		push @ids, "\t\t\t<$key>".
			HTML::Tiny->entity_encode($value)."</$key>\n";
	}
	return "\t\t<bibinfo>\n".join("",@ids)."\t\t</bibinfo>\n";
}

sub identifiers {
	my($id) = @_;
	my @ids;
	push @ids, {"name"=>"ISBN","value"=>$id->isbn} if($id->isbn);
	push @ids, {"name"=>"ISBN","value"=>$id->issn} if($id->issn);
	push @ids, {"name"=>"OCLC Number","value"=>$id->oclc} if($id->oclc);
	push @ids, {"name"=>"NKP-NBN","value"=>$id->nbn} if($id->nbn);
	return \@ids;
}

# je tato knizka ceska? undef -- nelze rict
sub is_czech { 
    my($id) = @_;
	my $ean13 = $id->ean13 or return;
    my $obj13;
    eval { $obj13 = Business::ISBN->new($ean13); };
    return undef unless($obj13);
    return $obj13->group_code eq '80' ? 1 : 0;
}

sub isbn_forms {
    my($bibinfo) = @_;
	my $ean13 = $bibinfo->ean13;
    return wantarray ? () : undef unless $ean13;
	
	# FIX: terminologie: ean (13), isbn10 (10+pomlcky), isbn13 (13+pomlcky)
    #      "ean13" zrusit

    my($isbn,$ean,$isbn10,$isbn13);
    my $obj13;
    eval {
        $obj13 = Business::ISBN->new($ean13);
        $isbn13 = $ean = $obj13->as_string; $isbn13 =~ s/\-//g;
    };
    ##die "Error in EAN13 <$ean13>???\n".Dumper($bibinfo) unless($isbn13);
    eval { # prevod na ISBN10 se nemusi podarit (pro DVD,...)
        my $obj10 = $obj13->as_isbn10;
        $isbn10 = $isbn = $obj10->as_string; $isbn10 =~ s/\-//g;
    };
    return wantarray ? ($isbn,$ean,$isbn10,$isbn13,$ean13) : $ean;
}

sub get_obalkyknih_url {
    my($bibinfo,$secure) = @_;
    return Obalky::Config->url($secure)."/view?".$bibinfo->to_some_param;
}

sub authors_human {
    my($bibinfo) = @_;
	return "" unless $bibinfo->{authors};
	my $last = pop @{$bibinfo->{authors}};
	return $last || '' unless($bibinfo->{authors});
	my $first = join(", ",@{$bibinfo->{authors}});
	return $first ? "$first a $last" : $last;
}


=back 

=head1 AUTHOR

Martin Sarfy - L<mailto:martin@sarfy.cz>

=cut



1;
