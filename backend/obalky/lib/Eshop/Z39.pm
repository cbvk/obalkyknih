package Eshop::Z39;

#!/usr/bin/perl -w
use ZOOM;
use MARC::Record;
use base 'Eshop';
use MARC::Charset 'utf8_to_marc8';
use Data::Dumper;

MARC::Charset->ignore_errors(1);
MARC::Charset->assume_encoding('UTF-8');

__PACKAGE__->register(harvest => 1, license => 'licensed', czech => 0 );

sub harvest{
	my ($self,$bibinfo)=@_;
	my ($nbn,$ean13) = ($bibinfo->nbn,$bibinfo->ean13);
	my ($ean,$index_id);
	my ($query_or,$query_ean,$query_nbn) = ("","","");
	
	#zpracovani identifikatoru - tvorba dotazu
	if ($ean13 || $nbn){
		if ($ean13 && $nbn){
			$query_or = "\@or ";
		}
		if ($ean13){
			($ean,$index_id) = modify_identifier($ean13);
			$query_ean = '@attr '. "1=$index_id "."'$ean' ";
			
		}
		if ($nbn){
			$query_nbn = '@attr '. "1=2544 "."'$nbn'";
		}
	}	
	else {
		warn 'no-identifier';
		return;
	}	
	my $conn = new ZOOM::Connection(
		'katalog.cbvk.cz',8888 ,databaseName => 'cbvk_us_cat', preferredRecordSyntax => 'USMARC');
		
	#znovu se pokusit pripojit
	if ($conn->errcode() != 0) {
		$conn = new ZOOM::Connection(
		'katalog.cbvk.cz',8888 ,databaseName => 'cbvk_us_cat', preferredRecordSyntax => 'USMARC');
	} 
	if ($conn->errcode() != 0){
		warn 'Chyba pri pripajeni na server';
		return;
	} 
	
	$rs = $conn->search_pqf("$query_or"."$query_ean"."$query_nbn");
	return if ($rs->size() == 0);	
	my $record = $rs->record(0);	
	my $size = $rs->size();
	my $marc = new_from_usmarc MARC::Record($record->raw());
	my $leader = $marc->leader();
	my $record_type = substr($leader,6,1);
	my $bib_level = substr($leader,7,1);
	
	#TODO : periodika - chybaju informacie o citacnych pravidlach
	next unless ($marc && $record_type eq 'a' && ($bib_level eq 'm' || $bib_level eq 's') );
	my ($r_issn,$r_isbn);
	my %rec;
	$rec = {};
	$rec->{'identifier_cnb'} = $marc->subfield('015', 'a');
	$rec->{'identifier_oclc'} = $marc->subfield('035', 'a');
	$r_isbn = cut_identifier($marc->subfield('020', 'a')) if ($marc->subfield('020', 'a'));
	$r_issn = cut_identifier($marc->subfield('022', 'a')) if ($marc->subfield('022', 'a'));	
	$rec->{'identifier'} = $r_issn || $r_isbn;
	$rec->{'author'} = $marc->subfield('100', 'a');
	$rec->{'sigla'} = $marc->subfield('910', 'a');
	$rec->{'title'} = $marc->subfield('245', 'a');
	$rec->{'title_sub'} = $marc->subfield('245', 'b');
	$rec->{'pub'} = $marc->subfield('250', 'a');
	$rec->{'pub_place'} = $marc->subfield('260', 'a');
	$rec->{'label'} = $marc->subfield('260', 'b');
	$rec->{'date'} = $marc->subfield('260', 'c');	
	$rec->{'pages'} = $marc->subfield('300', 'a');	
	$rec->{'subedition'} = $marc->subfield('490', 'a');	
	$rec->{'edition'} = $marc->subfield('490', 'v');	
	$rec->{'avaiability'} = $marc->subfield('856', 'a');
	$rec->{'notes'} = $marc->subfield('500', 'a');
	$rec->{'url'} = $marc->subfield('856', 'u') && $marc->subfield('910', 'w');
	$rec->{'volume'} = $marc->subfield('915', 'a');
	$rec->{'corporation'} = $marc->subfield('110', 'a');
	$rec->{'leader'} = $record_type.$bib_level;
	
	#vicero autoru
	if ($marc->subfield('700','a')){
		my $authors = '';
		foreach $author ($marc->field('700')){
			$author = $author->subfield('a');
			chop ($author) if ($author =~ /,\z/);
			$authors = $authors . $author.", ";
		}
		$authors= substr($authors, 0, -2);
		$rec->{'subauthors'} = $authors;
	}
	return $rec;
}

sub modify_identifier{
	my ($ean) = @_;
	my $index_id;
	if (length($ean) == 13){
		if (substr($ean,0,3) eq '977'){
			$index_id = '8';
			$ean = (substr($ean,3,7)).(substr($ean,12,1));
			$ean = Business::ISSN->new($ean);
			$ean->fix_checksum;
			return ($ean->{issn},$index_id);
		}
		if (substr($ean,0,3) eq '978'){
			$index_id = '7';
			$ean = Business::ISBN->new($ean);
			$ean->fix_checksum;
			return ($ean->as_isbn10->isbn,$index_id);
		}
		else {
			$index_id = '7';
			return ($ean,$index_id);
		}
	}
	$index_id = '7';
 	return ($ean,$index_id);
}

#field s identifikatormi obsahuje nadbytecne udaje
sub cut_identifier{
	my ($identifier) = @_;
    $identifier =~ s/(?=^0-9_)[^Xx][^0-9_]//g;
    $identifier =~ s/ .*$//g;
    $identifier =~ s/(?=\D)[^Xx-]//g;
	return $identifier;
}


1