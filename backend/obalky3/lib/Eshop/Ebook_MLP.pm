package Eshop::Ebook_MLP;
use base 'Eshop';
use FindBin;
use lib "$FindBin::Bin/../lib";
use Net::OAI::Harvester;
use Data::Dumper;
use DB;

__PACKAGE__->register(crawl => 1, license => 'licensed', czech => 0 );

my $finished = 0;
my @recArray;
my $harvester = Net::OAI::Harvester->new(
	'baseURL' => 'http://web2.mlp.cz/cgi/oai'
);

sub crawl{
	my($self,$from,$to,) = @_;
	
	($from,$to) = ($from.'Z',$to.'Z');
	my $records = $harvester->listRecords(
		'metadataPrefix'  => 'marc21',
		'set'             => 'ebook',
		'from'            => $from,
		'until'           => $to,
		'metadataHandler' => 'MarcOAI'
	);

	warn "http://web2.mlp.cz/cgi/oai?verb=ListRecords&set=ebook&metadataPrefix=marc21&from=$from"."&until="."$to" if ($ENV{DEBUG});
	my $cnt = 0;
	while (!$finished) {
		while (my $record = $records->next()) {
			my $metadata = $record->metadata();
			if (defined $metadata->{marc} && $metadata->{marc}->field('001')) {
				my %rec;
				$rec = {};
				my ($isbn, $issn, $bibinfo, $title, $title_sub);
				$rec->{'identifier_cnb'} = $metadata->{marc}->subfield('015', 'a');
				$rec->{'identifier_oclc'} = $metadata->{marc}->subfield('035', 'a');
				$rec->{'identifier_oclc'} =~ s/\(OCoLC\)//g if $rec->{'identifier_oclc'};
				$isbn = $metadata->{marc}->subfield('020', 'a');
				$issn = $metadata->{marc}->subfield('022', 'a');
				$rec->{'author'} = $metadata->{marc}->subfield('100', 'a');
				$rec->{'author'} =~ s/,$// if ($rec->{'author'});
				$title = $metadata->{marc}->subfield('245', 'a') || '';
				chomp($title) if ($title);
				$title_sub = $metadata->{marc}->subfield('245', 'b') || '';
				$rec->{'title'} = $title.$title_sub;
				$rec->{'title'} =~ s/\s*\/\s*$// if ($rec->{'title'});
				$rec->{'date'} = '';
				$rec->{'date'} = $metadata->{marc}->subfield('264','c') if ($metadata->{marc}->subfield('264','c'));
				$rec->{'date'} = $metadata->{marc}->subfield('260','c') if ($rec->{'date'} eq '');
				$rec->{'annotation'} = $metadata->{marc}->subfield('520','a');
				$rec->{'identifier'} = $isbn || $issn;
				if ($rec->{'identifier'}){
					$rec->{'identifier'} =~ tr/-//d;
					chomp($rec->{'identifier'});
					$rec->{'identifier'} = Obalky::BibInfo->parse_code($rec->{'identifier'});					
				}
				if (!$isbn && !$issn && !$rec->{'identifier_oclc'} && !$rec->{'identifier_cnb'}) {
					$rec->{'identifier_cnb'} = 'abg001-'.$metadata->{marc}->field('001')->data();
				}
				#nadrazeny script (crawler_ebook.pl) prohleda podle bibinfa DB
				$bibinfo = Obalky::BibInfo->new_from_params({
					ean => $rec->{'identifier'},
					title => $rec->{'title'},
					year => $rec->{'date'},
					authors => $rec->{'author'},
					nbn => $rec->{'identifier_cnb'},
					oclc => $rec->{'identifier_oclc'}
				});
				foreach (values %{$bibinfo}){chomp($_) if ($_)}; 
				my ($product_url,$cover_url) = (undef,undef);
				my @ebook_files;
				my @t856 = $metadata->{marc}->field('856');
				foreach $subtag (@t856) {
					my $t856u = $subtag->subfield('u');
					$t856u =~ s/\n//;
					$t856up = substr($t856u, -4);
					$cover_url = $t856u if ($t856up eq '.jpg' or $t856up eq 'jpeg' or $t856up eq '.JPG' or $t856up eq 'JPEG' or $t856up eq '.png' or $t856up eq '.PNG' or $t856up eq '.gif' or $t856up eq '.GIF');
					next unless ($t856up eq 'epub' || $t856up eq '.pdf' || $t856up eq '.prc' || $t856up eq 'html');
					if ($t856u =~ '/search.mlp.cz/') {
						$product_url = $t856u;
					} else {
						push(@ebook_files, $t856u);
					}
				}

				if (!$product_url){
					my $id = $record->header()->identifier;
					($id) = $id =~ /.*:(.*)/;
					$product_url = 'http://search.mlp.cz/searchMKP.jsp?action=sTitul&key='.$id;
				}
				
				my ($media,$info) = (undef,undef);
				# obalka
				if (defined $cover_url) {
					$cover_url =~ s/https\:/http\:/g;
					my $ext = $1 if($cover_url =~ /\.(jpe?g|pdf|txt|png|tiff?|gif)$/i);
					unless($ext) {
						warn "Neznama pripona v $cover_url\n";
						return;
					}
					my $tmp_dir = "/tmp/crawler-Ebook_MLP";
					my $temp_file = "";
					$temp_file = Obalky::BibInfo->isbn_to_ean13($isbn || $issn) if (defined $isbn or defined $issn);
					$temp_file = $rec->{'identifier_cnb'} if ($temp_file eq '');
					$temp_file =~ s/\-//g;
					my $temp = "$tmp_dir/$temp_file.$ext";
					unless (system ("wget --no-check-certificate -q $cover_url -O $temp >/dev/null")) {
						$info->{cover_url} = $cover_url;
						$info->{cover_tmpfile} = $temp;
					}
				}
				# anotace
				if ($rec->{'annotation'} ne '') {
					$info->{review_impact} = $Obalky::Media::REVIEW_ANNOTATION;
					$info->{review_html} = $rec->{'annotation'};
					$info->{review_html} =~ s/"$//g if (defined $info->{review_html});
					$info->{review_html} =~ s/^"//g if (defined $info->{review_html});
					$info->{review_library} = 50029;
				}
				$media = Obalky::Media->new_from_info( $info ) if (defined $info);
				
				push (@recArray,\@ebook_files,$bibinfo,$media,$product_url);
				
				$cnt++;
#last;
			}
		}
#last;
		my $rToken = $records->resumptionToken();
		if ($rToken) {
			$records = $harvester->listRecords(
				'resumptionToken' => $rToken->token(),
				'metadataHandler' => 'MarcOAI'
			);
		} else {
			$finished = 1;
		}
	
	}
	warn 'found #'.$cnt;
	return @recArray;
}
1