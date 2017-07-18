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
				my ($isbn,$issn,$bibinfo_authors);
				$rec->{'identifier_cnb'} = $metadata->{marc}->subfield('015', 'a');
				$rec->{'identifier_oclc'} = $metadata->{marc}->subfield('035', 'a');
				$rec->{'identifier_oclc'} =~ s/\(OCoLC\)//g if $rec->{'identifier_oclc'};
				$isbn = Obalky::BibInfo->parse_code($metadata->{marc}->subfield('020', 'a'));
				$issn = Obalky::BibInfo->parse_code($metadata->{marc}->subfield('022', 'a'));
				$rec->{'author'} = $metadata->{marc}->subfield('100', 'a');
				chop($rec->{'author'}) if ($rec->{'author'} && $rec->{'author'} =~ /,\z/  );
				$rec->{'title'} = $metadata->{marc}->subfield('245', 'a') || '';
				$rec->{'title_sub'} = $metadata->{marc}->subfield('245', 'b') || '';
				$rec->{'identifier'} = $isbn || $issn;
				$bibinfo_authors = $rec->{'author'} || '';
				if ($rec->{'subauthors'}){
					$bibinfo_authors = $bibinfo_authors . ", " . $rec->{'subauthors'} if ($bibinfo_authors ne '');
					$bibinfo_authors = $rec->{'subauthors'} if ($bibinfo_authors eq '');
				}
				else{
					undef $bibinfo_authors if (!$rec->{'author'});
				}
				
				if (!$isbn && !$issn && !$rec->{'identifier_oclc'} && !$rec->{'identifier_cnb'}) {
					$rec->{'identifier_cnb'} = 'abg001-'.$metadata->{marc}->field('001')->data();
				}
				
				#nadrazeny script (crawler_ebook.pl) prohleda podle bibinfa DB
				$bibinfo = Obalky::BibInfo->new_from_params({
					ean => $rec->{'identifier'},
					title => $rec->{'title'}.$rec->{'title_sub'},
					year => $rec->{'date'},
					authors => $bibinfo_authors,
					nbn => $rec->{'identifier_cnb'},
					oclc => $rec->{'identifier_oclc'}
				});
				
				my $product_url;
				my @ebook_files;
				my @t856 = $metadata->{marc}->field('856');
				foreach $subtag (@t856) {
					my $t856u = $subtag->subfield('u');
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
				push (@recArray,\@ebook_files,$bibinfo,undef,$product_url);
				
				$cnt++;
				warn 'oai #'.$cnt if ($cnt % 50 == 0);
			}
		}
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
	warn 'oai #'.$cnt;
	return @recArray;
}
1