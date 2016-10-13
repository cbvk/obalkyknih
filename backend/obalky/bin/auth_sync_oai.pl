use FindBin;
use lib "$FindBin::Bin/../lib";
use Fcntl qw(:flock);

use MarcOAI;
use Net::OAI::Harvester;
use Data::Dumper;
use DB;
use UUID::Generator::PurePerl;

sub unique_id {
    my $this =shift;
    my $args=shift;
    my $ug = UUID::Generator::PurePerl->new();
    my $uuid1 = $ug->generate_v1();
    return $uuid1;
}

my $finished = 0;
my ($cntTotal,$cntAuth,$cntCycle) = (0,0,0);
my $lastDateStamp;

my $harvester = Net::OAI::Harvester->new(
	'baseURL' => 'http://aleph.nkp.cz/OAI'
);

#my $records = $harvester->listRecords(
#	'metadataPrefix'  => 'marc21',
#	'set'             => 'AUT',
#	'from'            => '2015-11-01T00:00:00Z',
#	'until'           => '2015-11-01T23:59:59Z',
#	'metadataHandler' => 'MarcOAI'
#);
my $records = $harvester->listRecords(
	'metadataPrefix'  => 'marc21',
	'set'             => 'AUT',
	'from'            => '2016-03-01T00:00:00Z',
	'until'           => '2019-03-01T23:59:59Z',
	'metadataHandler' => 'MarcOAI'
);

while ( ! $finished ) {

	$cntCycle = 0;
	while ( my $record = $records->next() ) {
		my $header = $record->header();
		my $metadata = $record->metadata();
		$lastDateStamp = $header->{datestamp};
		if (defined $metadata->{marc}) {
			#print "\n\n------------[ $cntTotal ]-------------\n\n";
			#print "identifier: ", $header->identifier(), "\n";
			#print $metadata->{marc}->as_formatted;
			if ($metadata->{marc} and $metadata->{marc}->field('100') and $metadata->{marc}->field('001')) {
				my %rec;
				$rec->{'id'} = $metadata->{marc}->field('001')->data;
				$rec->{'oai_identifier'} = $header->{identifier};
				$rec->{'oai_datestamp'} = $header->{datestamp};
				$rec->{'auth_datestamp'} = $metadata->{marc}->field('005')->data if ($metadata->{marc}->field('005'));
				$rec->{'auth_name'} = $metadata->{marc}->subfield('100', 'a');
				$rec->{'auth_date'} = $metadata->{marc}->subfield('100', 'd');
				$rec->{'auth_activity'} = $metadata->{marc}->subfield('372', 'a');
				$rec->{'auth_occupation'} = $metadata->{marc}->subfield('374', 'a');
				$rec->{'auth_biography'} = $metadata->{marc}->subfield('678', 'a');
				$rec->{'nkp_aut_url'} = $metadata->{marc}->subfield('998', 'a');
				
				# id must be unique (and XML might contain malformed data which will colide)
				if (my $row = DB->resultset('Auth')->find($rec->{'id'})) {
					#$rec->{'id'} = '_(' . $rec->{'id'} . ')_' . unique_id
					warn "###### DUPLICITA [$rec->{id}] ######";
					DB->resultset('AuthOaiTmp')->create($rec);
				} else {
					warn "NEW [$rec->{id}]";
					DB->resultset('Auth')->create($rec);
				}

				$cntAuth++;
			}
		}
		$cntTotal++;
		$cntCycle++;
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
	
	print $lastDateStamp, "    >> Pocet zaznamu: ", $cntTotal, "    >> Pocet autorit: ", $cntAuth, "    ( $cntCycle )\n";
}

print "\n\n-----------[ KONEC ]----------\n\nPocet zaznamu: ", $cntTotal, "\nPocet autorit: ", $cntAuth, "\n\n";
