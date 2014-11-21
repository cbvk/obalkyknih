#!/usr/bin/perl -w

# KONSOLIDACE STATISTIK FRONT-END SERVERU
# Prenos statistik z FE serveru do databaze BE serveru

use FindBin;
use lib "$FindBin::Bin/../lib";

use DB;
use DBI;
use Data::Dumper;
use MongoDB;
use MongoDB::OID;
use DateTime::Format::MySQL;
use Fcntl qw(:flock);

my @allowedRows = qw/timeout_count etag_match etag_toc_pdf_match etag_toc_thumbnail_match
		    etag_file_match file_requests meta_requests meta_fetches cover_requests
		    cover_api_requests cover_fetches cover_notfound toc_thumbnail_requests
		    toc_thumbnail_api_requests toc_thumbnail_fetches toc_thumbnail_notfound
		    toc_pdf_requests toc_pdf_api_requests toc_pdf_notfound meta_removes
		    cover_removes toc_thumbnail_removes timestamp uptime
		    meta_count cover_count logs_count/;

#Vylucny beh
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	warn "Locked...";
	die;
}

my $IDFE;
$IDFE = $ARGV[0];
die "[ FE ID MISSING ]\n" unless ($IDFE);

# pripojeni zdrojove MongoDB databaze
my $client = MongoDB::MongoClient->new(host => 'localhost:27017');
my $db = $client->get_database('test');
my $conSrc = $db->get_collection('stat');

# pripojeni cilove lokalni MySQL databaze
my $conDest = DBI->connect("DBI:mysql:database=obalky","obalky","visk2009");

# zjisti posledny nacteny timestamp
my $resLastTs = DB->resultset('FeStat')->search({ id_fe_list => $IDFE });
my $lastTs = $resLastTs->get_column('timestamp')->max();
my $lastUptime = '';
if ($lastTs) {
	$beStat = DB->resultset('FeStat')->search({ id_fe_list => $IDFE, timestamp => $lastTs })->next;
	$lastUptime = $beStat->get_column('uptime');
}
my $flagRestarted = 0;
print "[ FE#$IDFE: LAST LOADED TIMESTAMP $lastTs ]\n";


# MongoDB DOTAZ: nacti jeste nenactene zaznamy
my ($feStats,$feTs) = (undef,undef);
if ($lastTs) {
	$feTs = DateTime::Format::MySQL->parse_datetime($lastTs);
	$feTs->add(seconds => 1); # pridej 1sec, protoze Mongo se hraje na mikrosekundy, ale BE pouze na sekundy
	$feStats = $conSrc->find({ 'timestamp' => {'$gt' => $feTs->datetime()} })->sort({ 'timestamp' => 1 });
} else {
	$feStats = $conSrc->find()->sort({ 'timestamp' => 1 });
}

die "[ FE#$IDFE: NO NEW STATS ]" unless ($feStats->count);

# MongoDB CURSOR: projdi vsechny nenactene zaznamy a dopln
my %siglaArr;
my $siglaStats;
while (my $row = $feStats->next) {
    #warn Dumper($row); #debug
    print "[ FE#$IDFE: PROCESSING TIMESTAMP $row->{timestamp} ]\n";
    
    # detekce restartu porovnanim aktualniho a predchoziho uptime
	$flagRestarted = 0;
	if (substr($row->{uptime},-24) ne substr($lastUptime,-24)) {
		$flagRestarted = 1;
		print "[ FE#$IDFE: RESTART DETECTED ]\n";
	}
    
    # vytvor seznam vsech knihoven v aktualni nactene statistice
    %siglaArr = ();
    map { getSiglaContained($row->{$_}, \%siglaArr) if (ref($row->{$_}) eq 'HASH'); } keys %$row;
    %siglaArr = ('admin'=>50000) unless(scalar(keys %siglaArr));
    #warn Dumper(\%siglaArr); #debug
    
    # vypocet metrik pro konkretni knihovnu
    foreach (keys %siglaArr) {
    	$siglaStats = getMetrics($_, $flagRestarted, $lastTs, $row);    	
    	
    	# doplneni ridicich dimenzi
    	$siglaStats->{id_fe_list} = $IDFE;
    	$siglaStats->{id_library} = $siglaArr{$_};
    	$siglaStats->{library_code} = $_;
    	$siglaStats->{flag_restarted} = $flagRestarted;
    	
    	# metriky a dimenze dopocitane, zapis do DB
    	DB->resultset('FeStat')->create($siglaStats);
	#warn Dumper($siglaStats); #debug
    }
    
    $lastTs = substr($siglaStats->{timestamp}, 0, -5);
    $lastUptime = $siglaStats->{uptime};
    #die "[ FE#$IDFE: INTERRUPTED ]";
}


=head1 HELPER siglaContained

 AKTUALIZUJ POLE VYSKYTU IDENTIFIKATORU SIGLA

=cut
sub getSiglaContained {
	my($src,$dest) = @_;
	foreach (keys %$src) {
		unless (defined $dest->{$_}) {
			my $isAdmin = $_ eq 'admin';
			my $id_library;
			unless ($isAdmin) {
				my $sigla = DB->resultset('Library')->search({ 'code' => $_ })->next;
				$id_library = $sigla->get_column('id')+0.0 if ($sigla);
			}
			$dest->{$_} = $isAdmin ? 50000 : $id_library;
		}
	}
}


=head1 HELPER getMetrics

 AKTUALIZUJ POLE VYSKYTU IDENTIFIKATORU SIGLA

=cut
sub getMetrics {
	my($sigla,$flagRestarted,$lastTs,$src) = @_;
	my ($out,$val) = (undef,undef);
	my $isAdmin = $sigla eq 'admin' ? 1 : 0;
	
	# nacti predchozi metriky
	my $prevStats;
	unless ($flagRestarted) {
		$prevStats = DB->resultset('FeStat')->search({
			id_fe_list => $IDFE,
			library_code => $sigla,
			timestamp => $lastTs
		})->next;
	}
	
	# vypocti aktualni metriky
	foreach (keys %$src) {
		my $col = $_;
		if (grep {$_ eq $col} @allowedRows) {
			# aktualni hodnota
			$val = 0;
			$val = $src->{$_} if (ref($src->{$_}) ne 'HASH' && ($isAdmin || $_ eq 'uptime' || $_ eq 'timestamp'));
			$val = $src->{$_}->{$sigla} if (ref($src->{$_}) eq 'HASH');
			$val = 0 unless (defined($val));
			my $rawVal = $val;
			
			# odpocti predchozi hodnotu pokud od posledni zaznamenane statistiky nedoslo k restartu FE
			unless ($flagRestarted) {
				if ($prevStats && $_ ne 'timestamp' && $_ ne 'uptime') {
					$prevVal = 0;
					$prevVal = $prevStats->get_column('raw_'.$_);
					$prevVal = 0 unless (defined($prevVal));
					$val -= $prevVal;
				}
			}
			
			$out->{$_} = $val if ($_ ne 'meta_count' && $_ ne 'cover_count' && $_ ne 'logs_count');
			$out->{'raw_'.$_} = $rawVal if ($_ ne 'timestamp' && $_ ne 'uptime');
		}
	}
	return $out;
}


print "[ FE#$IDFE: DONE ]\n";