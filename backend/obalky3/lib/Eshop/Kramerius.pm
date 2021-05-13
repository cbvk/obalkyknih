package Eshop::Kramerius;
use base 'Eshop::Mechanize';
use DateTime;
use DateTime::Format::ISO8601;
use DateTime::Format::Strptime;
use LWP::UserAgent;
use XML::Simple XMLin;
use Time::localtime;
use Data::Dumper;
use Obalky::BibInfo;
use warnings;
use strict;
use POSIX qw(ceil);
use URI::Encode qw(uri_encode);
use Switch;
use JSON;
use File::Path;
use LWP::Simple;
use Try::Tiny;
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
#debug
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
	my $key='';
	
	get_response($from,$to,$method);
	if ($resp->is_success) {
		$xml = eval { XMLin($resp->content,SuppressEmpty => 1, ForceArray =>['doc']) };
		$res = $xml->{'result'};
		$numFound = $res->{'numFound'};
		my $numberOfQueries = ceil($numFound / 10);
		warn "Zaznam: $method 		Pocet:  $numFound" if ($ENV{DEBUG});
		for (my $i=1;$i <= $numberOfQueries ;$i++){
			foreach my $xml_item (@{$res->{'doc'}}) {
print "\n______________________________________________________________________";
print "\n$i / $numberOfQueries";
				my ($PIDxml,$PID,$PIDurl,$PIDua,$PIDreq,$PIDresp,$content);
				$PID = $xml_item->{'str'}->{'content'};
				$PIDua = LWP::UserAgent->new;
				$PIDua->timeout(60);
				$PIDua->ssl_opts( verify_hostname => 0 ,SSL_verify_mode => 0x00);
#debug
#$baseURL = 'http://kramerius.mzk.cz/search/';
#$method = 'monograph';
#$PID = 'uuid:99440e40-1753-11ea-a20e-005056827e51';

				# zaznam dig. objektu
				my ($OBJjsonurl,$OBJreq,$OBJresp,$jsondata);
				$OBJjsonurl = $baseURL . 'api/v5.0/item/'. $PID;
				$OBJreq = HTTP::Request->new(GET => $OBJjsonurl);
				$OBJreq->header('content-type' => 'application/json');
				$OBJresp = $PIDua->request($OBJreq);
				$jsondata= decode_json($OBJresp->content);

				# bibliograficky zaznam
				$PIDurl = $baseURL . 'api/v5.0/item/' . $PID .'/streams/BIBLIO_MODS';
				$PIDreq = HTTP::Request->new(GET => $PIDurl);
				$PIDreq->header('content-type' => 'application/xml');
				$PIDresp = $PIDua->request($PIDreq);
				if ($PIDresp->is_success) {
					$content = cut_content($PIDresp->content);
					
					$PIDxml = eval { XMLin($content,SuppressEmpty => 1, ForceArray => ['identifier','name','titleInfo','namePart','originInfo','dateIssued'])};
					my($root_pid,$rootbibinfo,$root_year,$root_title,$root_book_url,$root_product_url,$rootinfo,$rootmedia,$book_id);
					my ($bibinfo,$info,$media);
					my ($title,$year,$product_url,$book_url,$authors,$authorslist,$part_no,$part_year);
					switch ($method)
					{
						case /^(monograph|manuscript|sheetmusic|archive|maprecord|graphic|soundrecording)$/ {
							$title = $PIDxml->{'mods'}->{'titleInfo'}->[0]->{'title'};
							$title = $title.': '.$PIDxml->{'mods'}->{'titleInfo'}->[0]->{'subTitle'} if $PIDxml->{'mods'}->{'titleInfo'}->[0]->{'subTitle'};
							$year = $PIDxml->{'mods'}->{'originInfo'}->[0]->{'dateIssued'}->[0];
							$book_url = $baseURL . 'api/v5.0/item/' . $PID .'/children';
							$product_url = $baseURL . 'i.jsp?pid=' . $PID;
						    $OBJIdentifiers = $PIDxml->{'mods'}->{'identifier'};
						    $authorslist = $PIDxml->{'mods'}->{'name'};
							}
							
						case 'periodicalitem' {
							my ($ROOTurl,$ROOTreq,$ROOTresp,$ROOTxml,$ROOTcontent);
							
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
							if (defined $part_year and $part_year ne '') {
								#datum cesky zapis
								my $strp_cz = DateTime::Format::Strptime->new(
									pattern   => '%d.%m.%Y',
									locale    => 'cs_CZ'
								);
								my $dt_cz = $strp_cz->parse_datetime($part_year);
								if ($dt_cz) {
									my $parse_cz = $strp_cz->format_datetime($dt_cz);
									$part_year = $dt_cz->{'local_c'}->{'year'};
								}

								#datum ISO zapis
								unless ($dt_cz) {
									my $strp_iso = DateTime::Format::Strptime->new(
										pattern   => '%Y-%m-%d',
										locale    => 'en_US'
									);
									my $dt_iso = $strp_iso->parse_datetime($part_year);
									if ($dt_iso) {
										my $parse_iso = $strp_iso->format_datetime($dt_iso);
										$part_year = $dt_iso->{'local_c'}->{'year'};
									}
								}
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
	     				next if (ref($identifier) ne 'HASH');
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
print "\n";
print "EAN: $ean  " if ($ean);
print "NBN: $nbn  " if ($nbn);
print "OCLC: $oclc" if ($oclc);
print "  UUID: $PID";
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
#debug
					($jdata, $info->{tocpdf_tmpfile}, $info->{toc_firstpage}, $info->{toctext}) = downloadtoc($PID,$PIDua,$tmp_dir,$custom_ean) if ($method eq 'periodicalitem' || $method eq 'monograph');
					$info->{cover_url} = downloadcover($baseURL, $PID, $jdata);
					$media = Obalky::Media->new_from_info($info);
					
					# verejny, alebo neverejny dokument
					$media->{ispublic} = 0;
					$media->{ispublic} = 1 if ($jsondata->{'policy'} eq 'public');
					
					# PDF fulltext
					my $pdfurl;
					if ($jsondata->{pdf} and $jsondata->{pdf}->{url}) {
						$pdfurl = $jsondata->{pdf}->{url};
					}

#warn Dumper([$bibinfo, $media, $product_url, undef, \@params, $pdfurl ]);

					push(@books, [$bibinfo, $media, $product_url, undef, \@params, $pdfurl ]);
				}
				
				else {
					print STDERR $resp->status_line, " - chyba pri dotaze na knihu\n";
				}
#debug
#$key = <STDIN>;
#last if (substr($key,0,1) eq 'q');
#last;
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
#debug
#last if (substr($key,0,1) eq 'q');
#last;
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
	$query_url = $baseURL . "api/v5.0/search?q=fedora.model:$method%20AND%20modified_date:%5B".$from."Z%20TO%20".$to."Z%5D&fl=PID&wt=xml&start=$start";
	warn "URL: $query_url" if ($ENV{DEBUG} && $ENV{DEBUG} eq 2);
	$ua = LWP::UserAgent->new;
	$ua->timeout(60);
	$ua->ssl_opts( verify_hostname => 0, SSL_verify_mode => 0x00 );
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
	my $tocOcrText;
	
	#try {
		my $parent_uuid = $PID;
		$parent_uuid =~ s/uuid\://g;
		my $toc_dir = "$tmp_dir/$PID";
		$toc_dir =~ s/uuid\://g;
		my $PIDjsonurl = $baseURL . 'api/v5.0/item/'. $PID .'/children';
		my $PIDreq = HTTP::Request->new(GET => $PIDjsonurl);
		$PIDreq->header('content-type' => 'application/json');
		my $PIDresp = $PIDua->request($PIDreq);
		my $jsondata= decode_json($PIDresp->content);
		return if (!$jsondata or ref $jsondata ne 'ARRAY');
	#} catch {}
	
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
				return ($jsondata, undef, undef);
			}
			my $toctxtUrl = $baseURL . 'img?pid=' . $toc_page . '&stream=TEXT_OCR&action=GETRAW';
			my $toctextReq = HTTP::Request->new(GET => $toctxtUrl);
			my $toctextResp = $PIDua->request($toctextReq);
			$tocOcrText .= $toctextResp->content if ($toctextResp);
			
			# https://kramerius.mzk.cz/search/img?pid=uuid:a0d213c0-1df6-11e4-8e0d-005056827e51&stream=TEXT_OCR&action=GETRAW
			# first page
			if ($index == 0) {
				system("wget --no-check-certificate -q $tocurl -O $tmp_dir/$parent_uuid-first >/dev/null");
			}
			$index++;
		}
	}
	if ($index != 0) {
		$toc_file = "$tmp_dir/$parent_uuid.pdf";
		$first_page = "$tmp_dir/$parent_uuid-first";
		system("convert $toc_dir/* $toc_file");
		system("rm -rf $toc_dir");
	}
	return ($jsondata, $toc_file, $first_page, $tocOcrText);	
}

sub downloadcover{
	my ($url, $childrenUUID, $jsondata) = @_;
	my $childrenURL = $url . 'api/v5.0/item/' . $childrenUUID .'/children';
	
	if (!$jsondata){
		$ua = LWP::UserAgent->new;
		$ua->timeout(60);
		$ua->ssl_opts( verify_hostname => 0 ,SSL_verify_mode => 0x00);
		my $PIDreq = HTTP::Request->new(GET => $childrenURL);
		$PIDreq->header('content-type' => 'application/json');
    	my $PIDresp = $ua->request($PIDreq);
    	$jsondata = decode_json($PIDresp->content);
	}
	return if (!$jsondata or ref $jsondata ne 'ARRAY');
	return unless (scalar @{$jsondata});
	my ($uuid, $coverurl);
	my $lowestTitleNumeric = 99999;
	foreach my $pagemodel (@{$jsondata}){
        $uuid = $pagemodel->{'pid'} if (!$uuid and $pagemodel->{'model'} eq 'page'); # aspon nejaka obalka
        # snaha o zistenie cisla strany
        if ($pagemodel->{'title'} =~ /\d+/) {
        	my $titleNumeric = $pagemodel->{'title'};
        	$titleNumeric =~ s/\[//g; # kvoli zapisom napr. [1a] aby sa zacala parsovat cislovka 
        	$titleNumeric = $titleNumeric + 0;
        	if ($titleNumeric gt 0 and $titleNumeric lt $lowestTitleNumeric) {
        		$uuid = $pagemodel->{'pid'};
        		$lowestTitleNumeric = $titleNumeric;
        	}
        }
        my $page = $pagemodel->{'details'}->{'type'};
		next if (!$page || (grep /^$page$/i, ("spine","hrbet")));
		$uuid = $pagemodel->{'pid'} if ($page eq 'FrontCover' or $page eq 'FrontJacket' or $page eq 'TitlePage');
		if ($uuid ne '') {
			$coverurl = downloadcover_helper($url, $uuid);
			last;
		}
	}
	$coverurl = downloadcover_helper($url, $uuid) if ($uuid ne '' and !$coverurl);
print "\n\n---------\n";
print Dumper("Vybrana obalka UUID: ".$uuid);
print Dumper("Vybrana obalka URL: ".$coverurl);
print "\n---------\n\n";

	return $coverurl;
}

sub downloadcover_helper {
	my ($url, $uuid) = @_;
	my $urlReq;
	
	$urlReq = $url . "iiif/$uuid/full/,510/0/default.jpg";
	my $uaIiif = LWP::UserAgent->new;
	$uaIiif->timeout(10);
	$uaIiif->ssl_opts( verify_hostname => 0 ,SSL_verify_mode => 0x00);
	my $response = $uaIiif->get($urlReq);
	if ($response->is_success) {
		return $urlReq;
	}

	$urlReq = $url . "api/v5.0/item/$uuid/full";
	my $uaFull = LWP::UserAgent->new;
	$uaFull->timeout(10);
	$uaFull->ssl_opts( verify_hostname => 0 ,SSL_verify_mode => 0x00);
	$response = $uaFull->get($urlReq);
	if ($response->is_success) {
		return $urlReq;
	}

	$urlReq = $url . "api/v5.0/item/$uuid/thumb";
	my $uaThumb = LWP::UserAgent->new;
	$uaThumb->timeout(10);
	$uaThumb->ssl_opts( verify_hostname => 0 ,SSL_verify_mode => 0x00);
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
