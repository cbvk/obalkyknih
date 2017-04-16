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

	warn Dumper("http://aleph.nkp.cz/OAI?verb=ListRecords&metadataPrefix=marc21&set=NKC&from=$from"."&until="."$to");
	my $cnt = 0;
	while (!$finished) {
		while (my $record = $records->next()) {
#warn Dumper($record);
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
				next if (!$isbn && !$issn && !$rec->{'identifier_oclc'} && !$rec->{'identifier_cnb'});
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
				
				#data urcena pro FE
				my %bib;
				$bib = { 'Fields'=>{}, 'Type'=>substr($metadata->{marc}->leader(),6,2), 'Sysno'=>$metadata->{marc}->field('001')->data(), 'Sigla'=>'ABA001' };
				my $fld = $bib->{'Fields'};
				
				foreach $tag (@{$metadata->{marc}->{_fields}}) {
					my $tagNo = $tag->{_tag};
					next if ($tagNo < 10);
					my $i1 = $tag->{_ind1};
					my $i2 = $tag->{_ind2};
					
					if (defined $tag->{_subfields}) {
						$fld->{$tagNo} = [] unless ($fld->{$tagNo});
						my $bibTag = { 'Subtags'=>{}, 'Ind1'=>$i1, 'Ind2'=>$i2 };
						my $subtags = $bibTag->{'Subtags'};
						my $subtagName;
						foreach $subtag (@{$tag->{_subfields}}) {
							unless ($subtagName) {
								$subtagName = $subtag;
								next;
							}
							$subtags->{$subtagName} = [] unless ();
							push @{$subtags->{$subtagName}}, $subtag;
							$subtagName = undef;
						}
						push @{$fld->{$tagNo}}, $bibTag;
					}
				}
				
				#crawler prohleda podle bibinfa DB
				$bibinfo = Obalky::BibInfo->new_from_params({
					ean => $rec->{'identifier'},
					title => $rec->{'title'}.$rec->{'title_sub'},
					year => $rec->{'date'},
					authors => $bibinfo_authors,
					nbn => $rec->{'identifier_cnb'},
					oclc => $rec->{'identifier_oclc'}
				});
				push (@recArray,$bib,$bibinfo);
				
				
				# odzalohovat bibliograficka data
#				if (defined $metadata->{marc}) {
#					my ($t005,$t008,$dbTable) = (undef,undef,undef);
#					$t005 = $metadata->{marc}->field('005')->data() if ($metadata->{marc}->field('005'));
#					$t008 = $metadata->{marc}->field('008')->data() if ($metadata->{marc}->field('008'));
#					warn Dumper($metadata->{marc}) unless ($metadata->{marc}->field('001'));
#					my $rec = DB->resultset('BiblioRec')->find_or_create({
#						't000' => $metadata->{marc}->leader(),
#						't001' => $metadata->{marc}->field('001')->data(),
#						't005' => $t005,
#						't008' => $t008
#					});
#					DB->resultset('BiblioSubtag')->search({ id_biblio_rec => $rec->id })->delete_all;
#					DB->resultset('BiblioSubtagText')->search({ id_biblio_rec => $rec->id })->delete_all;
#					
#					foreach $tag (@{$metadata->{marc}->{_fields}}) {
#						my $tagNo = $tag->{_tag};
#						next if ($tagNo < 10);
#						my $i1 = $tag->{_ind1};
#						my $i2 = $tag->{_ind2};
#						$i1 = undef if ($i1 eq ' ');
#						$i2 = undef if ($i2 eq ' ');
#						my $val = $tag->data if (defined $tag->{data});
#						my $subtagName;
#						if (defined $tag->{_subfields}) {
#							foreach $subtag (@{$tag->{_subfields}}) {
#								unless ($subtagName) {
#									$subtagName = $subtag;
#									next;
#								}
#								if ($tagNo eq '020' && $subtagName eq 'a') {
#									$subtag =~ s/-//g;
#									my @eanParts = split(/ /, $subtag);
#									$subtag = Obalky::BibInfo->parse_code($eanParts[0]);
#								}
#								$dbTable = 'BiblioSubtag';
#								$dbTable = 'BiblioSubtagText' if (length $subtag > 255);
#								DB->resultset($dbTable)->create({ id_biblio_rec=>$rec, i1=>$i1, i2=>$i2, tag=>$tagNo, subtag=>$subtagName, val=>$subtag });
#								$subtagName = undef;
#							}
#						} else {
#							$dbTable = 'BiblioSubtag';
#							$dbTable = 'BiblioSubtagText' if (length $val > 255);
#							DB->resultset($dbTable)->create({ id_biblio_rec=>$rec, i1=>$i1, i2=>$i2, tag=>$tagNo, val=>$val });
#						}
#					}
#				}
				
				$cnt++;			
				warn 'oai #'.$cnt if ($cnt % 50 == 0);
			}
#last;
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
		
#last;
	
	}
	warn 'oai #'.$cnt;
	
	return @recArray;
}
1