package Eshop::MarcXML;
use XML::Simple XMLin;
use LWP::Simple;
use Data::Dumper;
use MARC::Record;
use MARC::Charset 'utf8_to_marc8';
use MARC::File::XML;
use POSIX qw/ceil/;
use base 'Eshop';

my ($query_from,$query_to) = (1,10);
my ($resp);

__PACKAGE__->register(harvest => 1, license => 'licensed', czech => 0 );

sub harvest{
	my ($self,$bibinfo)=@_;
	my ($nbn,$ean13) = ($bibinfo->nbn,$bibinfo->ean13);
	my ($query_url,$ean,$index_id);
	my ($query_or,$query_ean,$query_nbn) = ("","","");
	
	#spracovanie identifikatorov - tvorba dotazu
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
		
		$query_url = "https://ipac.kvkli.cz/i2/i2.ws.cls?db=LiUsCat&method=search&options=&pfmt=xml&query="."$query_or"."$query_ean"."$query_nbn"."&fmt=CITACE_MARCXML&content_type=0";
	}
	else {
		return;
	}
	$resp = get_response($query_url);
	my ($hits) = $resp->content =~ /<hits>(.*)<\/hits>/;
	#zle formatovana odpoved, treba ju upravit na vhodny format pre XML konverziu
	my $content = cut_response($resp->content);
	if ($hits){
		next if (!$content);
		my $list =  XMLin($content, ForceArray =>['marc:subfield','marc:record']);
		foreach my $record (@{$list->{'marc:record'}}){			
			my $leader = $record->{'marc:leader'};
			my $record_type = substr($leader,6,1);
			my $bib_level = substr($leader,7,1);
			## TODO : periodika - chybaju informacie o citacnych pravidlach
			next unless (($record_type eq 'a') && ($bib_level eq 'm' || $bib_level eq 's'));
			my %rec;
			$rec = {};
			my ($r_isbn,$r_issn);
			my $authors = '';
			my $datafield = $record->{'marc:datafield'};
			foreach my $field (@{$datafield}){
		        foreach $subfield (@{$field->{'marc:subfield'}}){
		        	$rec->{'date'} = $subfield->{'content'} if ($subfield->{'code'} eq 'c' and  $field->{'tag'} eq '260' and !$rec->{'date'});
		        	$rec->{'name'} = $subfield->{'content'} if ($subfield->{'code'} eq 'a' and $field->{'tag'} eq '100' and !$rec->{'name'});
	        		$r_isbn = cut_identifier($subfield->{'content'}) if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '020' and !$r_isbn);
	        		$r_issn = cut_identifier($subfield->{'content'}) if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '022' and !$r_issn);
	        		$rec->{'identifier'} = $r_issn || $r_isbn;
	        		$rec->{'identifier_cnb'} = $subfield->{'content'} if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '015' and !$rec->{'identifier_cnb'});
	        		$rec->{'identifier_oclc'} =  $subfield->{'content'} if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '035' and !$rec->{'identifier_oclc'});
	        		$rec->{'title'} = $subfield->{'content'} if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '245' and !$rec->{'title'});
	        		$rec->{'title_sub'} = $subfield->{'content'} if ($subfield->{'code'} eq 'b' and  $field->{'tag'} eq '245' and !$rec->{'title_sub'});
	        		$rec->{'pub_place'} = $subfield->{'content'} if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '260' and !$rec->{'pub_place'});
	        		$rec->{'label'} = $subfield->{'content'} if ($subfield->{'code'} eq 'b' and  $field->{'tag'} eq '260' and !$rec->{'label'});
	        		$rec->{'pages'} = $subfield->{'content'} if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '300' and !$rec->{'pages'});
	        		$rec->{'edition'} = $subfield->{'content'} if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '490' and !$rec->{'edition'});
	        		$rec->{'subedition'} = $subfield->{'content'} if ($subfield->{'code'} eq 'v' and  $field->{'tag'} eq '490' and !$rec->{'subedition'});
	        		$rec->{'avaiability'} = $subfield->{'content'} if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '856' and !$rec->{'avaiability'});
	        		$rec->{'notes'} = $subfield->{'content'} if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '500' and !$rec->{'notes'});
					$rec->{'sigla'} = $subfield->{'content'} if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '910' and !$rec->{'sigla'});
					$rec->{'url'} = $subfield->{'content'} if ($subfield->{'code'} eq 'u' and  $field->{'tag'} eq '856' and !$rec->{'url'});
					$rec->{'url'} = $subfield->{'content'} if ($subfield->{'code'} eq 'w' and  $field->{'tag'} eq '910' and !$rec->{'url'});
					$rec->{'volume'} = $subfield->{'content'} if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '915' and !$rec->{'volume'});
					$rec->{'corporation'} = $subfield->{'content'} if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '110' and !$rec->{'corporation'});
					#vicero autoru
					if ($subfield->{'code'} eq 'a' and  $field->{'tag'} eq '700'){
						my $author = $subfield->{'content'};
						chop ($author) if ($author =~ /,\z/);
						$authors = $authors . $author.", ";
					}
		        }		   			        		
			}
			$authors= substr($authors, 0, -2) if ($authors ne '');
			$rec->{'subauthors'} = $authors if ($authors ne '');
			$rec->{'leader'} = $record_type.$bib_level;
	    	last;    
		}
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

sub get_response{
	my ($query_url) = @_;
	my ($ua,$req,$response);
	$query_url = $query_url . "&from=$query_from"."&to=$query_to";
	$ua  = LWP::UserAgent->new( ssl_opts => { verify_hostname => 0, } );
	$req = HTTP::Request->new(GET => $query_url);
	$req->header('content-type' => 'application/marc21');	
	$response = $ua->request($req);
	
	return $response;
}

sub cut_response{
	my ($content) = @_;
	$content =~ s/(.*)(<\/pqf_orig>)//s;
	$content =~ s/^[^\<?xml]*(?=<\?xml)//; 
	$content =~ s/<\/ws1>.*$//;
	return $content;
}
1