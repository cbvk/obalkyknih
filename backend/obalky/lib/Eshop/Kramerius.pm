package Eshop::Kramerius;
use base 'Eshop::Mechanize';
use DateTime::Format::ISO8601;
use DateTime;
use LWP::UserAgent;
use XML::Simple XMLin;
use Time::localtime;
use Data::Dumper;
use Obalky::BibInfo;
use DB;
use warnings;
use strict;
use POSIX qw/ceil/;
use Switch;
use JSON;
use File::Path;
use LWP::Simple;
use Eshop;
use DB;


my ($req,$url,$resp,$ua,$xml,$res,$numFound,$query_url,$OBJIdentifiers,$baseURL);
my $start = 0; 
__PACKAGE__->register(crawl => 1, license => 'licensed', czech => 0 );


sub crawl{
	my($self,$eshop,$from,$to,$tmp_dir,$feedURL) = @_;
	$baseURL = $feedURL . '/search/';
	#my @type = ("soundrecording","archive","graphic","sheetmusic","manuscript","monograph","periodicalitem");
#debug
my @type = ("monograph");
	my @list;
	foreach (@type){
		$start = 0;
		my @type_list = crawl_type($self,$eshop,$from,$to,$tmp_dir, $_);
		push (@list,@type_list) if (@type_list);
	}
	return @list;
}

sub crawl_type{
	my($self,$eshop,$from,$to,$tmp_dir,$method) = @_;
	my (@books,$root_pid);
	get_response($from,$to,$method);
	if ($resp->is_success) {
		$xml = eval { XMLin($resp->content,SuppressEmpty => 1, ForceArray =>['doc']) };
		$res = $xml->{'result'};
		$numFound = $res->{'numFound'};
		my $numberOfQueries = ceil($numFound / 10);
		warn "Zaznam: $method 		Pocet:  $numFound" if ($ENV{DEBUG});
		for (my $i=1;$i <= $numberOfQueries ;$i++){
			foreach my $xml_item (@{$res->{'doc'}}) {
				my ($PIDxml,$PID,$PIDurl,$PIDua,$PIDreq,$PIDresp,$content);
				$PID = $xml_item->{'str'}->{'content'};
#debug
$method = 'periodicalitem';
$baseURL = 'http://kramerius.mzk.cz/search/';
# objekt s TOC
$PID = 'uuid:64ef19d0-d0b8-11e6-8032-005056827e52';

				$PIDurl = $baseURL . 'api/v5.0/item/' . $PID .'/streams/BIBLIO_MODS';
				$PIDua = LWP::UserAgent->new;
				$PIDua->timeout(60);
				$PIDreq = HTTP::Request->new(GET => $PIDurl);
				$PIDreq->header('content-type' => 'application/xml');
				$PIDresp = $PIDua->request($PIDreq);
				if ($PIDresp->is_success) {
					$content = cut_content($PIDresp->content);
					
					$PIDxml = eval { XMLin($content,SuppressEmpty => 1, ForceArray => ['identifier','name','titleInfo','namePart','originInfo','dateIssued'])};
					my($root_pid,$rootbibinfo,$root_year,$root_title,$root_book_url,$root_product_url,$rootinfo,$rootmedia,$book_id);
					my ($bibinfo,$info,$media);
					my ($title,$year,$product_url,$book_url,$authors,$authorslist,$jsondata,$part_no,$part_year);
					switch ($method)
					{
						case /^(monograph|manuscript|sheetmusic|archive|maprecord|graphic|soundrecording)$/ {
							$title = $PIDxml->{'mods'}->{'titleInfo'}->[0]->{'title'};
							$year = $PIDxml->{'mods'}->{'originInfo'}->[0]->{'dateIssued'}->[0];
							$book_url = $baseURL . 'api/v5.0/item/' . $PID .'/children';
							$product_url = $baseURL . 'i.jsp?pid=' . $PID;
						    $OBJIdentifiers = $PIDxml->{'mods'}->{'identifier'};
						    $authorslist = $PIDxml->{'mods'}->{'name'};
							}
							
						case 'periodicalitem' {
							my ($PERjsonurl,$PERreq,$PERresp,$ROOTurl,$ROOTreq,$ROOTresp,$ROOTxml,$ROOTcontent);
												
							$PERjsonurl = $baseURL . 'api/v5.0/item/'. $PID;
							$PERreq = HTTP::Request->new(GET => $PERjsonurl);
							$PERreq->header('content-type' => 'application/json');
						    $PERresp = $PIDua->request($PERreq);
						    $jsondata= decode_json($PERresp->content);
						    #ziskani korenoveho periodika	
						    $root_pid = $jsondata->{'root_pid'};
					    	$ROOTurl = $baseURL . 'api/v5.0/item/' . $root_pid .'/streams/BIBLIO_MODS';
							$ROOTreq = HTTP::Request->new(GET => $ROOTurl);
							$ROOTreq->header('content-type' => 'application/xml');
							$ROOTresp = $PIDua->request($ROOTreq);
							$ROOTcontent = cut_content($ROOTresp->content);
							$ROOTxml = eval { XMLin($ROOTcontent,SuppressEmpty => 1, ForceArray => ['identifier','name','titleInfo','namePart','originInfo','dateIssued'])};
							$root_title = $ROOTxml->{'mods'}->{'titleInfo'}->[0]->{'title'};
							$root_year = $ROOTxml->{'mods'}->{'originInfo'}->[0]->{'dateIssued'}->[0];
							$root_book_url = $baseURL . 'api/v5.0/item/' . $root_pid .'/children';
							$root_product_url = $baseURL . 'i.jsp?pid=' . $root_pid;
							$OBJIdentifiers = $ROOTxml->{'mods'}->{'identifier'};
							$authorslist = $ROOTxml->{'mods'}->{'name'};
							if ($PIDxml->{'mods'}->{'part'}) {
								$title = $root_title || $jsondata ->{'title'} ;
								$part_no = $PIDxml->{'mods'}->{'part'}->{'detail'}->{'number'} || $jsondata->{'details'}>{'partNumber'};
								if ($PIDxml->{'mods'}->{'part'}->{'date'} ne '') {
									$part_year = $PIDxml->{'mods'}->{'part'}->{'date'};
								}
							} else {
								$title = $PIDxml->{'mods'}->{'titleInfo'}->[0]->{'title'} || $jsondata ->{'title'} ;
								$part_year = $PIDxml->{'mods'}->{'originInfo'}->[0]->{'dateIssued'}->[0] || $jsondata ->{'details'}>{'date'};
								$part_no = $PIDxml->{'mods'}->{'titleInfo'}->[0]->{'partNumber'} || $jsondata->{'details'}>{'partNumber'};
							}
							if (defined $part_year and $part_year ne '' and (substr $part_year, 5, 1) eq '.') {
								$part_year = substr $part_year, -4;
							}
warn Dumper($PIDxml->{'mods'});
warn Dumper($jsondata);
						} 			
					}
					
					#ziskani vsech autoru
					$authors='';
					foreach my $author (@{$authorslist}){
						my $tmpauth;
						if (ref $author->{'namePart'}[0] eq 'HASH' and $author->{'namePart'}[1]->{'content'}){
							foreach my $namePart (@{$author->{'namePart'}}){
								$tmpauth = $namePart->{'content'};
								last if ($namePart->{'type'} && $namePart->{'type'} eq 'given');
							}
						}
						else {
							$tmpauth = $author->{'namePart'}[0];
							#docasna uprava -- pravdepodobne zmena zo strany Krameria
							#$tmpauth = $author->{'namePart'}[0]->{'content'};
						}							
						
						$authors = $authors . $tmpauth.", "; #if (ref $author->{'namePart'}[0]->{'content'} eq 'HASH');
					}
					if ($authors eq ''){
						$authors = undef;
					}
					else {
						$authors = substr($authors, 0, -2);
					}
					
					my (@eans,@params);
					my ($ean,$oclc,$nbn,$sysno,$urnnbn);
	     			foreach my $identifier (@{$OBJIdentifiers}){
						foreach my $identifier_type ($identifier->{'type'}) {
							switch($identifier_type) {
								case 'issn' {
									if (!$identifier->{'invalid'}){											
										$ean = getEAN($identifier->{'content'});
										push(@eans,$ean);
									}
								}
								case 'isbn' {
									if (!$identifier->{'invalid'}){											
										$ean = getEAN($identifier->{'content'});
										push(@eans,$ean);
									}
								}
								case 'ccnb' {
									$nbn = $identifier->{'content'} if (!$identifier->{'invalid'});
								}
								case 'oclc' {
									$oclc = '(OCoLC)'.$identifier->{'content'} if (!$oclc && !$identifier->{'invalid'});
								}
								#case 'sysno'{
								#	$sysno = $identifier->{'content'} if (!$sysno && !$identifier->{'invalid'});
								#}
								#case 'urnnbn' {
								#	$urnnbn = $identifier->{'content'};
								#}
							}
						}
					}
					
					# zaznamy bez parametrov pouzitelnych i v inych knizniciach nebereme
#debug
warn Dumper($ean);
warn Dumper($nbn);
warn Dumper($oclc);
warn '---';
					next if (!$ean && !$oclc && !$nbn);
					
					#kdyz urnnbn je jediny identifikator
					$nbn = $sysno || $urnnbn if (!$oclc && !$nbn && !$ean);
					#Kdyz objekt obsahuje vice EAN
					if (@eans) {
						my $ean = shift(@eans);
						if (@eans > 0) {
							foreach my $param (@eans) {
								push @params, { 'ean13'=>$param, 'nbn'=>undef, 'oclc'=>undef } if ($param);
							}
						}
					}
					else {
						push(@eans,undef);
					}
					
					if ($method eq 'periodicalitem') {
						$rootbibinfo = Obalky::BibInfo->new_from_params({
							ean => $ean,
							nbn => $nbn,
							oclc => $oclc,
							title => $root_title,
							year => $root_year,
							authors => $authors,
							uuid => $root_pid
						});
						$rootinfo->{cover_url} = downloadcover_helper($baseURL, $PID);
						$rootmedia = Obalky::Media->new_from_info($rootinfo);
						$product_url = $baseURL . 'i.jsp?pid=' . $PID;

						$eshop->add_product($rootbibinfo,$rootmedia,$root_product_url,undef,@params);
						$book_id = DB->resultset('Book')->find_by_bibinfo($rootbibinfo);
					}
					$bibinfo = Obalky::BibInfo->new_from_params({
						ean => $ean,
						nbn => $nbn,
						oclc => $oclc,
						title => $title,
						year => $root_year || $year,
						authors => $authors,
						part_year => $part_year,
						part_no => $part_no,
						part_year_orig => $part_year,
						part_no_orig => $part_no,
						uuid => $PID
					});
					next if (!$bibinfo);
					$bibinfo->{id_parent} =$book_id->id if ($book_id);
					$bibinfo->{part_type} = '2' if ($book_id);
					my $custom_ean = $ean || $nbn;
					my $jdata;
					($jdata, $info->{tocpdf_tmpfile}, $info->{toc_firstpage}) = downloadtoc($PID,$PIDua,$tmp_dir,$custom_ean) if ($method eq 'periodicalitem' || $method eq 'monograph');
					$info->{cover_url} = downloadcover($baseURL, $PID, $jdata);
warn '^^^^^^^^^^^^^^^^';
warn Dumper($info);
warn '^^^^^^^^^^^^^^^^';
					$media = Obalky::Media->new_from_info($info);
					warn Dumper($bibinfo) if ($ENV{DEBUG});
					push(@books, [$bibinfo, $media, $product_url, undef, \@params ]);
				}
				
				else {
					print STDERR $resp->status_line, " - chyba pri dotaze na knihu\n";
				}
last; #debug
		    }
		    last if ($i == $numberOfQueries);
	        $start += 10;
	     	get_response($from,$to,$method);
	     	if ($resp->is_success) {
	     		$xml = eval { XMLin($resp->content,SuppressEmpty => 1, ForceArray =>['doc']) };
				$res = $xml->{'result'};	    					
			}
			else {
				print STDERR $resp->status_line, " - chyba pri dalsom dotaze na zaznam knih";
			}
last; #debug
		}
		return @books; 
	}
	else {
		print STDERR $resp->status_line, " - chyba pri dotaze na zoznam knih\n";
	}	
}

sub get_response {
	my($from,$to,$method) = @_;
	$method = "map" if ($method eq 'maprecord');
    $query_url = $baseURL . "api/v5.0/search?q=fedora.model:$method%20AND%20modified_date:[".$from."T00:00:00Z%20TO%20".$to."T23:59:59Z]&fl=PID&wt=xml&start=$start";
	warn "URL: $query_url" if ($ENV{DEBUG} == 2);
	$ua = LWP::UserAgent->new;
	$ua->timeout(60);
	$req = HTTP::Request->new(GET => $query_url);
	$req->header('content-type' => 'application/xml');	
	$resp = $ua->request($req);
}

sub getEAN{
	my $parsedIdentifier = $_[0];
	$parsedIdentifier =~ tr/-//d;
	$parsedIdentifier = Obalky::BibInfo->parse_code($parsedIdentifier);
	return $parsedIdentifier;	
}

sub downloadtoc {
	my ($PID,$PIDua,$tmp_dir,$ean) = @_;
	my $parent_uuid = $PID;
	$parent_uuid =~ s/uuid\://g;
	my $toc_dir = "$tmp_dir/$PID";
	my $PIDjsonurl = $baseURL . 'api/v5.0/item/'. $PID .'/children';
	my $PIDreq = HTTP::Request->new(GET => $PIDjsonurl);
	$PIDreq->header('content-type' => 'application/json');
    my $PIDresp = $PIDua->request($PIDreq);
    my $jsondata= decode_json($PIDresp->content);
    return if (!$jsondata);
    my $index = 0;
    my ($toc_page, $toc_file, $first_page) = (undef, undef, undef);
	foreach my $pagemodel (@{$jsondata}) {
		if (($pagemodel->{'details'}->{'type'}) && ($pagemodel->{'details'}->{'type'} eq 'TableOfContents')) {
			if ($index == 0) {
				system("rm -rf $toc_dir");
				mkdir ($toc_dir);
			}
			$toc_page = $pagemodel->{'pid'};
			my $tocurl = $baseURL . "api/v5.0/item/$toc_page/full";
			if(system("wget --no-check-certificate -q $tocurl -O $toc_dir/$index >/dev/null")) {
				warn "$tocurl: failed to wget!\n";
				return ($jsondata, undef);
			}
			# first page
			if ($index == 0) {
				system("wget --no-check-certificate -q $tocurl -O $tmp_dir/$parent_uuid >/dev/null")
			}
			$index++;
		}
	}
	if ($index != 0) {
		$toc_file = "$tmp_dir/$parent_uuid.pdf";
		$first_page = "$tmp_dir/$parent_uuid";
		system("convert $toc_dir/* $toc_file");
		system("rm -rf $toc_dir");
	}
	return ($jsondata, $toc_file, $first_page);	
}

sub downloadcover{
	my ($url, $childrenUUID, $jsondata) = @_;
	my $childrenURL . 'api/v5.0/item/' . $childrenUUID .'/children';
	
	if (!$jsondata){
		$ua = LWP::UserAgent->new;
		$ua->timeout(60);
		my $PIDreq = HTTP::Request->new(GET => $childrenURL);
		$PIDreq->header('content-type' => 'application/json');
    	my $PIDresp = $ua->request($PIDreq);
    	$jsondata = decode_json($PIDresp->content);
	}
	return if (!$jsondata);
	my ($uuid, $coverurl);
warn '------------------------';
	foreach my $pagemodel (@{$jsondata}){
		my $page = $pagemodel->{'details'}->{'type'};
		next if (!$page || (grep /^$page$/i, ("spine","hrbet")));
		$uuid = $pagemodel->{'pid'} if (!$uuid || $page eq 'FrontCover' || $page eq 'FrontJacket' || $page eq 'TitlePage');
warn $page;
		if ($uuid ne '') {
			$coverurl = downloadcover_helper($url, $uuid);
			last;
		}
	}
warn '------------------------';
	return $coverurl;
	
}

sub downloadcover_helper {
	my ($url, $uuid) = @_;
	my $urlReq;
	
	$urlReq = $url . "iiif/$uuid/full/,510/0/default.jpg";
	my $uaIiif = LWP::UserAgent->new;
	$uaIiif->timeout(10);
	my $response = $uaIiif->get($urlReq);
	if ($response->is_success) {
		return $urlReq;
	}

	$urlReq = $url . "api/v5.0/item/$uuid/full";
	my $uaFull = LWP::UserAgent->new;
	$uaFull->timeout(10);
	$response = $uaFull->get($urlReq);
	if ($response->is_success) {
		return $urlReq;
	}

	$urlReq = $url . "api/v5.0/item/$uuid/thumb";
	my $uaThumb = LWP::UserAgent->new;
	$uaThumb->timeout(10);
	$response = $uaThumb->get($urlReq);
	if ($response->is_success) {
		return $urlReq;
	}

	return '';
}

sub cut_content{
	my $content = $_[0];
	$content =~ s/<mods\:/</g;
	$content =~ s/<\/mods\:/<\//g;
	$content =~ s/<ns2\:/</g;			
	$content =~ s/<\/ns2\:/<\//g;
	return $content;
}