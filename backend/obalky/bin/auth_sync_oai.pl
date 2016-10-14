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
	'from'            => '2012-07-01T00:00:00Z',
	'until'           => '2012-12-31T23:59:59Z',
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
				if (my $row = DB->resultset('Auth')->find($rec->{'id'}))
				{				
					if ($metadata->{marc}->field('500')) {
						foreach my $t500 ($metadata->{marc}->field('500')) {
							
							# vyhledat, jestli tato vazba uz neexistuje
							my $authRelId = $t500->subfield('7');
							next unless ($authRelId);
							my $authRel = DB->resultset('AuthRelation500')->search({
								-or => [
									{ auth_id_source => $rec->{'id'}, auth_id_relation => $authRelId },
									{ auth_id_source => $authRelId,   auth_id_relation => $rec->{'id'} }
								]
							});
							# pokud neexistuje vazba, poznacit
							unless ($authRel->next) {
								DB->resultset('AuthRelation500')->create({
									auth_id_source => $rec->{'id'},
									auth_id_relation => $authRelId
								});
							}
						}
					}
					
					if ($row->get_column('auth_datestamp') ne $rec->{auth_datestamp} or
					    $row->get_column('oai_datestamp') ne $rec->{oai_datestamp} or
						$row->get_column('auth_biography') ne $rec->{auth_biography} or
					    $row->get_column('auth_occupation') ne $rec->{auth_occupation} or
					    $row->get_column('auth_activity') ne $rec->{auth_activity} or
					    $row->get_column('auth_date') ne $rec->{auth_date} or
					    $row->get_column('auth_name') ne $rec->{auth_name})
					{
						$row->update({
							auth_datestamp => $rec->{auth_datestamp},
							oai_datestamp => $rec->{oai_datestamp},
							auth_biography => $rec->{auth_biography},
							auth_occupation => $rec->{auth_occupation},
							auth_activity => $rec->{auth_activity},
							auth_date => $rec->{auth_date},
							auth_name => $rec->{auth_name}
						});
						DB->resultset('FeSync')->auth_sync_remove($rec->{id});
						
						warn "###### ZMENA ZAZNAMU [$rec->{id}] ######";
						warn Dumper($row->{_column_data});
						warn Dumper($rec);
					}
					
				}
				
				# NOVY ZAZNAM AUTORITY
				else {
					warn "NEW [$rec->{id}]  auth_datestamp:$rec->{auth_datestamp}  oai_datestamp:$rec->{oai_datestamp}";
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
	
	print $lastDateStamp, "    >> Zaznamu: ", $cntTotal, "    >> Osobnich autorit: ", $cntAuth, "    ( $cntCycle )\n";
}

print "\n\n-----------[ KONEC ]----------\n\nPocet zaznamu: ", $cntTotal, "\nPocet autorit: ", $cntAuth, "\n\n";
