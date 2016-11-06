package Eshop::Dbpedia;
use base 'AuthSource';
use utf8;

use Data::Dumper;

use Obalky::AuthInfo;
use Obalky::Media;
use Obalky::Tools;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Data::Dumper;
use DB;

use Encode;
use URI::Encode qw(uri_encode);
use HTML::Entities qw(decode_entities);
use Text::Diff;

__PACKAGE__->register(harvest => 1,	title => 'Dbpedia');

# Vrati SPARQL dotaz pre cesku verziu dbpedie
sub get_cs_query {
	my ($csEntity, $authId, $givenName, $surname, $birthDate, $deathDate) = @_;
	
	#return 'SELECT DISTINCT ?url ?depiction ?abstract
	#		WHERE {
	#			dbpedia-cs:'.uri_encode($csEntity).' a dbpedia-owl:Person ;
	#			foaf:depiction ?depiction ;
	#			dbpedia-owl:abstract ?abstract ;
	#			foaf:isPrimaryTopicOf ?url .	
	#		}' if $csEntity;
	
	return 'SELECT DISTINCT ?url ?abstract ?depiction
            WHERE {
              <http://cs.dbpedia.org/resource/'.uri_encode($csEntity).'> foaf:isPrimaryTopicOf ?url .
              OPTIONAL{
                <http://cs.dbpedia.org/resource/'.uri_encode($csEntity).'> foaf:depiction ?depiction
              } .
              OPTIONAL{
                <http://cs.dbpedia.org/resource/'.uri_encode($csEntity).'> dbpedia-owl:abstract ?abstract
              } .
            }' if $csEntity;
	
	return if ($birthDate eq '' and $deathDate eq '');
	
	my $birthFilter = $birthDate ne '' ? 'filter (strends(str(?n), "Kategorie:Narozen%C3%AD_'.$birthDate.'"))' : '';
	my $deathFilter = $deathDate ne '' ? 'filter (strends(str(?u), "%C3%9Amrt%C3%AD_'.$deathDate.'"))' : '';
	
	return 'SELECT DISTINCT ?url ?depiction ?abstract 
			WHERE {
				{
					{
					?p prop-cs:jm├ęno "'.$givenName.' '.$surname.'"@cs .
					}
					UNION
					{
					?p prop-cs:popisek "'.$givenName.' '.$surname.'"@cs .
					}
					UNION
					{
					?p rdfs:label "'.$givenName.' '.$surname.'"@cs .
					}
					UNION
					{
					?p foaf:name "'.$givenName.' '.$surname.'"@cs .
					}
						
					?p dbpedia-owl:wikiPageWikiLink ?n, ?u .'
					
					.$birthFilter
					.$deathFilter.'
				}
				UNION
				{ 
				?p prop-cs:nk "'.$authId.'"@cs . 
				}
					
				?p a dbpedia-owl:Person ;
				foaf:depiction ?depiction ;
				dbpedia-owl:abstract ?abstract ;
				foaf:isPrimaryTopicOf ?url .
			}';
}

# Vrati SPARQL dotaz pre anglicku verziu dbpedie
sub get_en_query {
	my ($enEntity, $authId, $givenName, $surname, $fullName, $birthDate, $deathDate) = @_;

	#return 'SELECT DISTINCT ?url ?depiction ?abstract
	#		WHERE {
	#			dbr:'.$enEntity.' a dbo:Person ;
	#			foaf:depiction ?depiction ;
	#			dbo:abstract ?abstract ;
	#			foaf:isPrimaryTopicOf ?url .
	#			
	#			filter(langMatches(lang(?abstract),"en"))
	#		}' if $enEntity;
	
	return 'SELECT DISTINCT ?url ?abstract ?depiction
            WHERE {
              <http://dbpedia.org/resource/'.uri_encode($enEntity).'> foaf:isPrimaryTopicOf ?url .
              OPTIONAL{
                <http://dbpedia.org/resource/'.uri_encode($enEntity).'> foaf:depiction ?depiction
              } .
              OPTIONAL{
                <http://dbpedia.org/resource/'.uri_encode($enEntity).'> dbo:abstract ?abstract
              } .
              
              filter(langMatches(lang(?abstract),"en"))
            }' if $enEntity;
	
	return if ($birthDate eq '' and $deathDate eq '');
	
	my $birthFilter = $birthDate ne '' ? 'filter(year(?birthDate) = '.$birthDate.')' : '';
	my $deathFilter = $deathDate ne '' ? 'filter(year(?deathDate) = '.$deathDate.')' : '';
	
	return 'SELECT DISTINCT ?url ?depiction ?abstract
			WHERE {
				{
				?p foaf:name "'.$givenName.' '.$surname.'"@en .
				}
				UNION   
				{
				?p foaf:name "'.$fullName.'"@en .
				}
				UNION
				{
				?p foaf:givenName "'.$givenName.'"@en ;
				foaf:surname "'.$surname.'"@en .
				}
				
				?p a dbo:Person ;
				foaf:depiction ?depiction ;
				dbo:abstract ?abstract ;
				foaf:isPrimaryTopicOf ?url ;
				dbo:birthDate ?birthDate ;
				dbo:deathDate ?deathDate .'			
				.$birthFilter
				.$deathFilter
				.'filter(langMatches(lang(?abstract),"en"))	
			}';
}

sub send_request{
	$url = $_[0];
	
	my $ua = LWP::UserAgent->new();
	$ua->timeout(10);
	$req = HTTP::Request->new(GET => Encode::encode_utf8($url));
	$response = $ua->request($req);
	
	return $response;
}

# Posle get request na dbpedia server a vrati vysledok v danom formate (defaultne XML)
sub send_dbpedia_request {
	my ($url, $query, $format) = @_;
	
	$format = 'application/sparql-results+xml' unless $format;
	return send_request($url . '?default-graph-uri=&query='.$query.'&format='.$format.'&CXML_redir_for_subjs=121&CXML_redir_for_hrefs=&timeout=30000');
}

sub send_viaf_request {
	$authId = $_[0];

	$url = 'http://www.viaf.org/viaf/search?query=cql.any+=+"NKC|'.$authId.'"&maximumRecords=1&httpAccept=application/json';

	$response = send_request($url);
	
	return $response->{_content};
}

# Vrati true ked vo vysledku je aspon 1 entita
sub is_result_success {
	$result = $_[0];
	
	return $result =~ /<results.*?>
  <result>/s;
}

sub harvest {
	my($self, $authinfo,$dir) = @_;
	my($authId,$date,$fullName) = ($authinfo->{auth_id},$authinfo->{auth_date},$authinfo->{auth_name});
	
	"a" =~ /a/; #reset regex capture
	$date =~ '(\d+).*?-.*?(\d+)|(\d+).*?-|[nN]ar\..*?(\d+)|-.*?(\d+)|[zZ]em\x{159}\..*?(\d+)';
	$birthDate = $1 ? $1 : $3 ? $3 : $4 ? $4 : '';
	$deathDate = $2 ? $2 : $5 ? $5 : $6 ? $6 : '';

	"a" =~ /a/; #reset regex capture
	my $author = DB->resultset("Auth")->find($authId);
	$fullName =~ '(.*?), ([^,]*)|([^,]*),?';
	my $givenName;
	my $surname;
	
	if ($1) {
		$givenName = $2;
		$surname = $1;
	} else {
		$givenName = $3;
		$surname = '';
	}

	my $urlCs = 'http://cs.dbpedia.org/sparql';
	my $urlEn = 'http://dbpedia.org/sparql'; 
	my $query;
	my $result;
	my $success = '0';
	
	my $csEntity; 
	my $enEntity; 
	
	"a" =~ /a/; #reset regex capture
warn "\n\n--------------------------------------------\n\n".$authId;
	$viafResponse = send_viaf_request($authId);
	$viafResponse =~ /"viafID": "(.*?)"/s;

	#pokusi sa najst viafID, popripade podla neho najde wiki zaznam v DBpedii
	if ($1){
		$viafID = $1;
		$author->update({ viafID => $viafID });

		"a" =~ /a/; #reset regex capture
		$viafResponse =~ /cs\.wikipedia\.org\/wiki\/(.*?)"/s;
		$csEntity = decode_utf8($1) if $1;

		"a" =~ /a/; #reset regex capture
		$viafResponse =~ /en\.wikipedia\.org\/wiki\/(.*?)"/s;
		$enEntity = decode_utf8($1) if $1;
warn '>>> VIAF CS' if ($csEntity);
warn '>>> VIAF EN' if ($enEntity);
	} 
	
	$query = get_cs_query($csEntity, $authId, $givenName, $surname, $birthDate, $deathDate);
	$resp = send_dbpedia_request($urlCs, $query);
	$success = $resp->is_success;
	
	if ($success) {
		$result = $resp->content;
		$success = is_result_success($result);
	}
	
warn '>>> CS wiki' if ($success);
	
	# Ked sa udaje nenasli na ceskej dbpedii
	if (!$success) {
		$query = get_en_query($enEntity, $authId, $givenName, $surname, $fullName, $birthDate, $deathDate);
		$resp = send_dbpedia_request($urlEn, $query);
		$success = $resp->is_success;

		if ($success) {
			$result = $resp->content;
			$success = is_result_success($result);
		}
	}

warn '>>> EN wiki' if ($success);

	# Ked sa nasli aspon na jednej z nich
	if ($success) {
		my @authors;
	
		#while($result =~ /<result>.*?<binding name="url"><uri>(.*?)<\/uri><\/binding>.*?<binding name="depiction"><uri>(.*?)<\/uri><\/binding>.*?<binding name="abstract"><.*?>(.*?)<\/literal><\/binding>.*?<\/result>/sg) {
		my ($el,$elUrl,$elDepiction,$elAbstract) = (undef,undef,undef,undef);
		while($result =~ /<result>(.*?)<\/result>/sg) {
			 ($el,$elUrl,$elDepiction,$elAbstract) = (undef,undef,undef,undef);
			 $el=$1;
			 while ($el =~ /<binding name="url"><uri>(.*?)<\/uri><\/binding>/sg) {
			 	$elUrl=$1;
			 }
			 while ($el =~ /<binding name="depiction"><uri>(.*?)<\/uri><\/binding>/sg) {
			 	$elDepiction=$1;
			 }
			 while ($el =~ /<binding name="abstract"><.*?>(.*?)<\/literal><\/binding>/sg) {
			 	$elAbstract=$1;
			 }
			 push( @authors, 
			 		{
				 		Url  	  => $elUrl,
			    		Depiction => $elDepiction,
			    		Abstract  => $elAbstract
		    		});
		}
		
		if (scalar(@authors) > 1) {
			$resultSetDuplicates = DB->resultset('AuthDuplicate');
			
			foreach $author(@authors) {
				$resultSetDuplicates->create({
					auth_id => $authId,
					media_url => $author->{Depiction},
					wiki_url => $author->{Url}
				});
			}
			
			# nevrati tic, pretoze naslo viac vysledkov
			# duplikaty ulozi do tabulky AuthDuplicate
			return (undef, undef);
		}
	
		$res = $authors[0];
		my $media_info;
		$media_info->{cover_url} = decode_entities($res->{Depiction});
		$media_info->{annotation} = $res->{Abstract};
		$media_info->{wiki_url} = $res->{Url};

		my $media = Obalky::Media->new_from_info( $media_info );

		$url = $res->{Url};
	
		return ($media,$url);
	
	} else {
		return (undef, undef);
	}
}

1;