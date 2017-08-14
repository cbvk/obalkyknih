#!/usr/bin/perl -w

use Data::Dumper;
use DateTime::Format::MySQL;
use DateTime;
use Storable;

use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use JSON;
use Encode qw(encode_utf8);

use Fcntl qw(:flock);

use FindBin;
use lib "$FindBin::Bin/../lib";


use Eshop;
use DB;

my($mode,$force_from,$force_to) = @ARGV;
die "\nusage: DEBUG=100 $0 [continue|period 2018-10-10 2018-10-20]\n\n"
		unless($mode);
my $DEBUG = $ENV{DEBUG};

my $TMP_DIR = "/tmp/crawler"; 
system("rm -rf $TMP_DIR"); mkdir($TMP_DIR);

my $SESSION_DIR = "/opt/obalky/.crawler";
mkdir($SESSION_DIR);

my $KRAMERIUS_LOGFILE = "Kramerius.str";
my $KRAMERIUS_MODULE = "Eshop::Kramerius";
my $from_default = DateTime->today()->subtract(days => 2);
my $to_default   = DateTime->today()->subtract(days => 1);
$from_default = DateTime::Format::ISO8601->parse_datetime( $from_default );
$to_default   = DateTime::Format::ISO8601->parse_datetime( $to_default );
$to_default   =~ s/00:00:00/23:59:59/g;


###############################################################################

@eshops = check_eshops();

###############################################################################

my %found;

foreach my $eshop (@eshops) {
	next if (!$eshop->get_column('library'));
	next if($ENV{OBALKY_ESHOP} and $eshop->get_column('id') ne $ENV{OBALKY_ESHOP});
	$eshop_id = $eshop->get_column('id');
	warn "Crawluju ".$eshop->get_column('name')."\n" if($DEBUG);
	my $factory = $KRAMERIUS_MODULE;
	my $name = $eshop->get_column('name'); # name je jednoznacny identifikator eshopu
	unless($factory) {
		warn "Nevim jak crawlovat $name\n";
		next;
	}
	next unless($factory->can('crawl'));
	$found{$name} = 0;	
	my $storable = eval { retrieve("$SESSION_DIR/$KRAMERIUS_LOGFILE") } || {};
	if ($mode eq 'period') {
		$from = $force_from;
		$to = $force_to;
	} else {
		$from = $storable->{$eshop_id}->{to};
		$from = $from_default unless($from);
		$to = $to_default;
	}
	# priprav tmp dir jenom pro tento eshop, at si navzajem neprepisuji jpg
	system("rm -rf $TMP_DIR-$name"); mkdir "$TMP_DIR-$name" or die;
	warn "$SESSION_DIR/$KRAMERIUS_LOGFILE" if ($DEBUG);
	
	warn "Crawling $name from $from to $to\n" if($DEBUG);
	
	my @list;
	my $feedURL = $eshop->get_column('xmlfeed_url');
	eval { @list = $factory->crawl($eshop,$from,$to,"$TMP_DIR-$name",$feedURL) };
	warn $factory."->crawl(): $@" if($@);
	
	my $i = 0;
	foreach(@list) {
		my($bibinfo,$media,$product_url,$covers_uncommited,$eans) = @$_;
		
		next unless (defined $bibinfo);
		warn $name." found ".$bibinfo->to_some_id."\n" if($DEBUG);
		$found{$name}++;		
		$eshop->add_product($bibinfo,$media,$product_url,$covers_uncommited,$eans);
		
		$i++;
		warn 'add_product #'.$i if ($i % 50);
	}
	warn $name.": found ".$found{$name}."\n" if($DEBUG);
	
	system("rm -rf $TMP_DIR-$name");
	
	if ($mode ne 'period') {
		$storable->{$eshop_id}->{from} = $from;
		$storable->{$eshop_id}->{to} = $to;
		store $storable, "$SESSION_DIR/$KRAMERIUS_LOGFILE";
	}
	
	open(LOG,">>utf8","/opt/obalky/www/data/crawler.csv") or die;
	my($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
	my $now = sprintf("%04d-%02d-%02dT%02d:%02d",
					$year+1900,$mon+1,$mday,$hour,$min);
	print LOG "$now\t$name\t$from\t$to\t".$found{$name}."\n";
	close(LOG);
die; #debug
}

sub check_eshops{
	my ($libID, $newLib, @reports);
	$libraryList = connect_to('http://registr.digitalniknihovna.cz/libraries.json');
	foreach my $lib(@{$libraryList}){
		$libID = "Kramerius_".uc $lib->{'code'};
		my $libEshop= DB->resultset('Eshop')->find({name => $libID});
		if ($libEshop){
			#nezhoduje se feed URL
			if ($libEshop->get_column('xmlfeed_url') ne $lib->{'url'}){	
				$newLib = connect_to($lib->{'library_url'});
				$libEshop->update({xmlfeed_url => $newLib->{'url'}, web_url => $newLib->{'web'}, logo_url => $newLib->{'logo'}, fullname => $newLib->{'name'}, });
			}
		}
		#nove URL
		else {
			$newLib = connect_to($lib->{'library_url'});	
			$newLib->{'web'} = $newLib->{'url'} if (!$newLib->{'web'});
			$newLib->{'libID'} = $libID;
			DB->resultset('Eshop')->create({name => $libID, type => 'kramerius', xmlfeed_url => $newLib->{'url'}, web_url => $newLib->{'web'}, logo_url => $newLib->{'logo'}, fullname => $newLib->{'name'}, });
			push @reports, $newLib;
		}
	}	
	
	send_report(@reports) if (@reports);
	
	my @eshopList = DB->resultset('Eshop')->search({type  => 'kramerius'});
	return (@eshopList);
}

sub connect_to{
	my ($endpoint) = @_;
	my ($ua, $req, $resp);
	
	$ua = LWP::UserAgent->new;
	$ua->timeout(60);
	$req = HTTP::Request->new(GET => $endpoint);
	$req->header('content-type' => 'application/json');
		
	$resp = $ua->request($req);
	if ($resp->is_success){
		return decode_json($resp->content);
	}
	else{
		die 'Nepodarilo se pripojit!';
	}
}

#odeslani emailu s informacemi o novych knihovnach v registru
sub send_report{
	my @reports = @_;
	my $sender = 'orsag@cosmotron.cz';
	my $receiver = 'info@obalkyknih.cz';
	
	my (@libs, $emailContent);
	foreach my $report (@reports){
		my $reportString = $report->{'name'}."($report->{'libID'})\n".$report->{'web'};
		push @libs, $reportString;
	}
	
	$emailContent = $emailContent.join("\n\n\n", @libs);
	
	open(MUTT,"|mutt -b '$sender' -s 'obalkyknih.cz - tydenni prehled novych komentaru' '$receiver'");
	binmode(MUTT, ":encoding(utf8)");
	print MUTT <<EOF;

Do seznamu prohledavanych Kramerii byly pridany nasledujici knihovny.

$emailContent

EOF
	close(MUTT);
}
