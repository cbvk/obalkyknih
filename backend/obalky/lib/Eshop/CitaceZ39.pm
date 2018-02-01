package Eshop::CitaceZ39;

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
#warn Dumper($bibinfo);
	
	my ($nbn,$ean13) = ($bibinfo->nbn,$bibinfo->ean13);
	my ($ean,$index_id);
	my ($query_or,$query_ean,$query_nbn) = ("","","");
	return if (substr($ean13,0,5) eq 'ARRAY');
	
	#zpracovani identifikatoru - tvorba dotazu
#$ean13 = '978-80-249-3417-4';
	if ($ean13 || $nbn){
#		if ($ean13 && $nbn){
#			$query_or = "\@or ";
#		}
		if ($ean13){
			($ean,$index_id) = modify_identifier($ean13);
			if (length($ean) == 8) {
			    $ean = substr($ean,0,4)."-".substr($ean,4,4);
			}
			$query_ean = '@attr '. "1=$index_id "."'$ean'";
			
		}
		if ($nbn){
			$query_nbn = '@attr '. "1=48 "."'$nbn'";
		}
	}	
	else {
		warn 'no-identifier';
		return;
	}
	
#warn '*1';
	my $conn = new ZOOM::Connection(
		'aleph.nkp.cz', 9991, databaseName => 'SKC-UTF', preferredRecordSyntax => 'USMARC');
	
#warn '*2';
	if ($conn->errcode() != 0){
		warn 'Chyba pri pripajeni na server';
		return;
	}
	
#warn "$query_or"."$query_ean"."$query_nbn";
#die;
	warn "$query_or"."$query_ean"."$query_nbn";
	$rs = $conn->search_pqf("$query_or"."$query_ean"."$query_nbn");
	warn $rs->size();
	return if ($rs->size() == 0);
	my ($record,$marc) = (undef,undef);
	my $size = $rs->size();
	my $found = 0;
	for (my $i=0; $i<$size; $i++) {
		$record = $rs->record($i);
		$marc = new_from_usmarc MARC::Record($record->raw());
		print "\nTITUL OKCZ ZAZNAMU >>> " . $bibinfo->{title};
		print "\nTITUL Z39 ZAZNAMU  >>> " . $marc->title() . "\n\n";
		$found = 1 if (index($marc->title(), $bibinfo->{title}) gt -1 and index($marc->title(), $bibinfo->{title}) lt 20);
	}
	$found = 1 if ($rs->size() eq 1);
	return unless($found);
	
	my %bib;
	$bib = { 'Fields'=>{}, 'Type'=>substr($marc->leader(),6,2), 'Sysno'=>$marc->field('001')->data(), 'Sigla'=>'ABA001' };
	my $fld = $bib->{'Fields'};
	
	foreach $tag (@{$marc->{_fields}}) {
		my $tagNo = $tag->{_tag};
		next if ($tagNo < 10);
		my $i1 = $tag->{_ind1};
		my $i2 = $tag->{_ind2};
		
		if (defined $tag->{_subfields}) {
			$fld->{$tagNo} = [] unless ($fld->{$tagNo});
			my $bibTag = { 'Subtags'=>{}, 'Ind1'=>$i1, 'Ind2'=>$i2 };
			my $subtags = $bibTag->{'Subtags'};
			my $subtagName;
			foreach $subtag (@{$tag->{_subfields}}) {
				unless ($subtagName) {
					$subtagName = $subtag;
					next;
				}
				$subtags->{$subtagName} = [] unless ();
				push @{$subtags->{$subtagName}}, $subtag;
				$subtagName = undef;
			}
			push @{$fld->{$tagNo}}, $bibTag;
		}
	}
	
	return $bib;
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

1