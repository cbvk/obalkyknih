package Eshop::NKP_OAI;
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
	'baseURL' => 'http://aleph.nkp.cz/OAI'
);

sub crawl{
	my($self,$from,$to,) = @_;
	
	($from,$to) = ($from.'Z',$to.'Z');
	my $records = $harvester->listRecords(
	'metadataPrefix'  => 'marc21',
	'set'             => 'NKC',
	'from'            => $from,
	'until'           => $to,
	'metadataHandler' => 'MarcOAI'
	);

	warn Dumper("http://aleph.nkp.cz/OAI?verb=ListRecords&metadataPrefix=marc21&set=NKC&from=$from."."&until="."$to");
	while (!$finished) {
		while (my $record = $records->next()) {
warn Dumper($record);
			my $metadata = $record->metadata();
			my $leader = $metadata->{marc}->leader();
			my $record_type = substr($leader,6,1);
			my $bib_level = substr($leader,7,1);
			#TODO : periodika - chybaju informacie o citacnych pravidlach
			if (defined $metadata->{marc} && $record_type eq 'a' && $bib_level eq 'm' ) {
				if ($metadata->{marc}->field('001')) {
					my %rec;
					$rec = {};
					my ($isbn,$issn,$authors,$bibinfo_authors);
					$rec->{'identifier_cnb'} = $metadata->{marc}->subfield('015', 'a');
					$rec->{'identifier_oclc'} = $metadata->{marc}->subfield('035', 'a');
					$rec->{'identifier_oclc'} =~ s/\(OCoLC\)//g if $rec->{'identifier_oclc'};
					$isbn = Obalky::BibInfo->parse_code($metadata->{marc}->subfield('020', 'a'));
					$issn = Obalky::BibInfo->parse_code($metadata->{marc}->subfield('022', 'a'));
					next if (!$isbn && !$issn && !$rec->{'identifier_oclc'} && !$rec->{'identifier_cnb'});
					#data urcena pro FE
					$rec->{'author'} = $metadata->{marc}->subfield('100', 'a');
					chop($rec->{'author'}) if ($rec->{'author'} && $rec->{'author'} =~ /,\z/  );
					$rec->{'sigla'} = $metadata->{marc}->subfield('910', 'a');
					$rec->{'title'} = $metadata->{marc}->subfield('245', 'a');
					$rec->{'title_sub'} = $metadata->{marc}->subfield('245', 'b');
					$rec->{'pub'} = $metadata->{marc}->subfield('250', 'a');
					$rec->{'pub_place'} = $metadata->{marc}->subfield('260', 'a');
					$rec->{'label'} = $metadata->{marc}->subfield('260', 'b');
					$rec->{'date'} = $metadata->{marc}->subfield('260', 'c');
					$rec->{'pages'} = $metadata->{marc}->subfield('300', 'a');
					$rec->{'subedition'} = $metadata->{marc}->subfield('490', 'a');
					$rec->{'edition'} = $metadata->{marc}->subfield('490', 'v');
					$rec->{'avaiability'} = $metadata->{marc}->subfield('856', 'a');
					$rec->{'notes'} = $metadata->{marc}->subfield('500', 'a');
					$rec->{'identifier'} = $isbn || $issn;
					#vicero autoru
					$bibinfo_authors = $rec->{'author'} || '';
					$authors = '';
					if ($metadata->{marc}->subfield('700','a')){
						my $ccc;
						foreach $author ($metadata->{marc}->field('700')){
							$ccc++;
							$author = $author->subfield('a');
							chop ($author) if ($author =~ /,\z/);
							$authors = $authors . $author.", ";
						}
						$authors= substr($authors, 0, -2);
						$rec->{'subauthors'} = $authors;
					}
					if ($rec->{'subauthors'}){
						$bibinfo_authors = $bibinfo_authors . ", " . $rec->{'subauthors'} if ($bibinfo_authors ne '');
						$bibinfo_authors = $rec->{'subauthors'} if ($bibinfo_authors eq '');
					}
					else{
						undef $bibinfo_authors if (!$rec->{'author'});
					}
					
					#crawler prohleda podle bibinfa DB
					$bibinfo = Obalky::BibInfo->new_from_params({ean => $rec->{'identifier'},
					title => $rec->{'title'},
					year => $rec->{'date'},
					authors => $bibinfo_authors,
					nbn => $rec->{'identifier_cnb'},
					oclc => $rec->{'identifier_oclc'}
					});
					push (@recArray,$rec,$bibinfo);
					}
					
			}
last;
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
		
last;
		
	}
	return @recArray;
	
}
1