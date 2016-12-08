package Eshop::Kramerius_CBVK;
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

my ($req,$url,$resp,$ua,$xml,$res,$numFound,$query_url,$OBJIdentifiers);
my $start = 0; 
__PACKAGE__->register(crawl => 1, license => 'licensed', czech => 0 );


sub crawl{
	my($self,$storable,$from,$to,$tmp_dir,$feed_url,$eshop) = @_;
	#my @type = ("soundrecording","archive","graphic","sheetmusic","manuscript","monograph","periodicalitem");#debug
	my @type = ("monograph");
	my @list;
	foreach (@type){
		warn "Crawling $_";
		my @type_list = crawl_type($self,$storable,$from,$to,$tmp_dir,$feed_url,$eshop, $_);
		push (@list,@type_list) if (@type_list);
	}
	return @list;
}

sub crawl_type{
	my($self,$storable,$from,$to,$tmp_dir,$feed_url,$eshop,$method) = @_;
	my (@books,$root_pid);
	get_response($from,$to,$method);
	warn Dumper($resp);
	if ($resp->is_success) {
			$xml = eval { XMLin($resp->content,SuppressEmpty => 1, ForceArray =>['doc']) };
			$res = $xml->{'result'};
			$numFound = $res->{'numFound'};
			my $numberOfQueries = ceil($numFound / 10);
			warn Dumper('Pocet zaznamov:' . $numFound. '\n URL : ');#.$query_url);
		     for (my $i=1;$i <= $numberOfQueries ;$i++){
		     	 foreach my $xml_item (@{$res->{'doc'}}) {
		     	my ($PIDxml,$PID,$PIDurl,$PIDua,$PIDreq,$PIDresp,$content);
				$PID = $xml_item->{'str'}->{'content'};
				$PIDurl = 'http://kramerius.cbvk.cz/search/api/v5.0/item/' . $PID .'/streams/BIBLIO_MODS';
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
							$book_url = 'http://kramerius.cbvk.cz/search/api/v5.0/item/' . $PID .'/children';
							$product_url = 'http://kramerius.cbvk.cz/search/i.jsp?pid=' . $PID;
						    $OBJIdentifiers = $PIDxml->{'mods'}->{'identifier'};
						    $authorslist = $PIDxml->{'mods'}->{'name'};
							}
							
						case 'periodicalitem' {
							my ($PERjsonurl,$PERreq,$PERresp,$ROOTurl,$ROOTreq,$ROOTresp,$ROOTxml,$ROOTcontent);
												
							$PERjsonurl = 'http://kramerius.cbvk.cz/search/api/v5.0/item/'. $PID;
							$PERreq = HTTP::Request->new(GET => $PERjsonurl);
							$PERreq->header('content-type' => 'application/json');
						    $PERresp = $PIDua->request($PERreq);
						    $jsondata= decode_json($PERresp->content);
						    #ziskani korenoveho periodika	
						    $root_pid = $jsondata->{'root_pid'};
					    	$ROOTurl = 'http://kramerius.cbvk.cz/search/api/v5.0/item/' . $root_pid .'/streams/BIBLIO_MODS';
							$ROOTreq = HTTP::Request->new(GET => $ROOTurl);
							$ROOTreq->header('content-type' => 'application/xml');
							$ROOTresp = $PIDua->request($ROOTreq);
							$ROOTcontent = cut_content($ROOTresp->content);
							$ROOTxml = eval { XMLin($ROOTcontent,SuppressEmpty => 1, ForceArray => ['identifier','name','titleInfo','namePart','originInfo','dateIssued'])};
							$root_title = $ROOTxml->{'mods'}->{'titleInfo'}->[0]->{'title'};
							$root_year = $ROOTxml->{'mods'}->{'originInfo'}->[0]->{'dateIssued'}->[0];
							$root_book_url = 'http://kramerius.cbvk.cz/search/api/v5.0/item/' . $root_pid .'/children';
							$root_product_url = 'http://kramerius.cbvk.cz/search/i.jsp?pid=' . $root_pid;
							$OBJIdentifiers = $ROOTxml->{'mods'}->{'identifier'};
							$authorslist = $ROOTxml->{'mods'}->{'name'};	
							$title = $PIDxml->{'mods'}->{'titleInfo'}->[0]->{'title'} || $jsondata ->{'title'} ;
							$part_year = $PIDxml->{'mods'}->{'originInfo'}->[0]->{'dateIssued'}->[0] || $jsondata ->{'details'}>{'date'};
							$part_no = $PIDxml->{'mods'}->{'titleInfo'}->[0]->{'partNumber'} || $jsondata->{'details'}>{'partNumber'};
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
					next if (!$ean && !$oclc && !$nbn);
					
					#kdyz urnnbn je jediny identifikator					
					$nbn = $sysno || $urnnbn if (!$oclc && !$nbn && !$ean);
					#Kdyz objekt obsahuje vice EAN
					if (@eans){
						my $ean = shift(@eans);
						if (@eans > 0){
							foreach my $param (@eans){
								push @params, { 'ean13'=>$param, 'nbn'=>undef, 'oclc'=>undef } if ($param);
							}
						}
					}
					else{
						push(@eans,undef);
					}
					next if (!$ean && !$oclc && !$nbn);
					if ($method eq 'periodicalitem'){
						$rootbibinfo = Obalky::BibInfo->new_from_params({
							ean => $ean,
							nbn => $nbn,
							oclc => $oclc,
							title => $root_title,
							year => $root_year,
							authors => $authors,
							uuid => $root_pid
						});
						$rootinfo->{cover_url} = 'http://kramerius.cbvk.cz/search/api/v5.0/item/' . $PID .'/thumb';
						$rootmedia = Obalky::Media->new_from_info($rootinfo);
						$book_url = 'http://kramerius.cbvk.cz/search/api/v5.0/item/' . $PID .'/children';
						$product_url = 'http://kramerius.cbvk.cz/search/i.jsp?pid=' . $PID;
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
						uuid => $PID
					});
					next if (!$bibinfo);
					$bibinfo->{id_parent} =$book_id->id if ($book_id);
					$bibinfo->{part_type} = '2' if ($book_id);
					my $custom_ean = $ean || $nbn;
					my $jdata;
					($jdata, $info->{tocpdf_tmpfile}) = downloadtoc($PID,$PIDua,$tmp_dir,$custom_ean) if ($method eq 'periodicalitem' || $method eq 'monograph');
					$info->{cover_url} = downloadcover($book_url, $jdata);
					$media = Obalky::Media->new_from_info($info);
					push(@books, [$bibinfo, $media, $product_url, undef,\@params  ]);
					warn Dumper($bibinfo);
				}
				
				else {
					print STDERR $resp->status_line, " - chyba pri dotaze na knihu\n";
				}
		    }
		    last if ($i == $numberOfQueries);
	        $start += 10;
	     	get_response($from,$to,$method);
	     	if ($resp->is_success){
	     		$xml = eval { XMLin($resp->content,SuppressEmpty => 1, ForceArray =>['doc']) };
				$res = $xml->{'result'};	    					
	     	}
	     	else {
	     		print STDERR $resp->status_line, " - chyba pri dalsom dotaze na zaznam knih";
	     	}
	     	
	   }
	   return @books; 
	}
		else {
			print STDERR $resp->status_line, " - chyba pri dotaze na zoznam knih\n";
	}	
}
sub get_response{
	my($from,$to,$method) = @_;
	$method = "map" if ($method eq 'maprecord');
    $query_url = "http://kramerius.cbvk.cz/search/api/v5.0/search?q=fedora.model:$method%20AND%20modified_date:[".$from."Z%20TO%20".$to.'Z]&fl=PID&wt=xml' . "&start=$start";
    #$query_url = "http://kramerius.cbvk.cz/search/api/v5.0/search?q=fedora.model:$method%20AND%20PID:%22uuid:744fc0a0-79c8-11e2-b212-005056827e52%22&fl=PID&wt=xml&start=$start";
warn $query_url;
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

sub downloadtoc{
	my ($PID,$PIDua,$tmp_dir,$ean) = @_; 
	my $toc_dir = "$tmp_dir/$PID";
	my $PIDjsonurl = 'http://kramerius.cbvk.cz/search/api/v5.0/item/'. $PID .'/children';
	my $PIDreq = HTTP::Request->new(GET => $PIDjsonurl);
	$PIDreq->header('content-type' => 'application/json');
    my $PIDresp = $PIDua->request($PIDreq);
    my $jsondata= decode_json($PIDresp->content);
    return if (!$jsondata);
    my $index = 0;
    my $toc_page;
    my $toc_file;
	foreach my $pagemodel (@{$jsondata}){
		if (($pagemodel->{'details'}->{'type'} eq 'TableOfContents')){
			if ($index == 0){
				system("rm -rf $toc_dir");
				mkdir ($toc_dir	);
			}
			$index++;
			$toc_page = $pagemodel->{'pid'};
			my $tocurl = "http://kramerius.cbvk.cz/search/api/v5.0/item/$toc_page/thumb";
			if(system("wget -q $tocurl -O $toc_dir/$index >/dev/null")) {
				warn "$tocurl: failed to wget!\n";
				return ($jsondata, undef);
			}
		}
	}
	if ($index != 0){
		$toc_file = "$tmp_dir/$ean.pdf";
		system("convert $toc_dir/* $toc_file");
		system("rm -rf $toc_dir");
	}
	return ($jsondata, $toc_file);
	
}

sub downloadcover{
	my ($url, $jsondata) = @_;
	if (!$jsondata){
		$ua = LWP::UserAgent->new;
		$ua->timeout(60);
		my $PIDreq = HTTP::Request->new(GET => $url);
		$PIDreq->header('content-type' => 'application/json');
    	my $PIDresp = $ua->request($PIDreq);
    	$jsondata = decode_json($PIDresp->content);
	}
	return if (!$jsondata);
	my $coverpage;
	my $coverurl;
	foreach my $pagemodel (@{$jsondata}){
		my $page = $pagemodel->{'details'}->{'type'};
		next if (!$page || (grep /^$page$/i, ("spine","hrbet")));
		$coverpage = $pagemodel->{'pid'} if (!$coverpage || $page eq 'FrontCover');
		last if ($page eq 'FrontCover');
	}
    $coverurl = "http://kramerius.cbvk.cz/search/api/v5.0/item/$coverpage/thumb" if ($coverpage);
    #$coverurl = "http://kramerius.cbvk.cz/search/api/v5.0/item/$coverpage/full" if ($coverpage);
	return $coverurl;
	
}

sub cut_content{
	my $content = $_[0];
	$content =~ s/<mods\:/</g;
	$content =~ s/<\/mods\:/<\//g;
	$content =~ s/<ns2\:/</g;			
	$content =~ s/<\/ns2\:/<\//g;
	return $content;
}