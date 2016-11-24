#!/usr/bin/perl -w

# Crawler - stahuj vsechno, co ma nakladatel nove

use Data::Dumper;
use DateTime::Format::MySQL;
use DateTime;
use Storable; # ??

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
die "\nusage: DEBUG=100 $0 [today|period 2008-10-10 2008-10-20]\n\n"
		unless($mode);
my $DEBUG = $ENV{DEBUG};
my $from = DateTime->today()->subtract(days => 2);
my $to   = DateTime->today()->subtract(days => 1);
if($mode eq 'period') {
	$from = DateTime::Format::ISO8601->parse_datetime( $force_from );
	$to   = DateTime::Format::ISO8601->parse_datetime( $force_to );
}

#moznost upravit existujici citace starsi nez tyden
my $crawlable =  DateTime->today()->subtract(days => 7);
my @crawler_eshops = Eshop->get_crawled();
my @eshops;

#vyselektuje crawlery vhodne na zber citaci
foreach (@crawler_eshops) {
	my @tmp_eshop = DB->resultset('Eshop')->search({ name => $_->{name}}) if ($_->{name});
	push (@eshops,$tmp_eshop[0]) if ($tmp_eshop[0] && $tmp_eshop[0]->type eq 'citace');	
}
my %found;
foreach my $eshop (@eshops) {
	# trida, ktera se o tento eshop stara..
	next if($ENV{OBALKY_ESHOP} and $eshop->id ne $ENV{OBALKY_ESHOP});
	warn "Crawluju ".$eshop->id." ".$eshop->name."\n" if($ENV{DEBUG});

	my $factory = "Eshop::".$eshop->name if($eshop->name); 
	my $name = $eshop->name || $eshop->id; # nase jednoznacne id eshopu
	unless($factory) {
		warn "Nevim jak crawlovat $name (".$eshop->fullname.")\n";
		next;
	}
	next unless($factory->can('crawl'));
	$found{$name} = 0;
	warn "Crawling $name from $from to $to\n" if($DEBUG);

	my @list;

	eval { @list = $factory->crawl($from,$to)
		    };
	warn $factory."->crawl(): $@" if($@);
	while(my ($rec,$bibinfo) = splice(@list,0,2)) {
		next unless ($rec and $bibinfo);
		my $book = DB->resultset('Book')->find_by_bibinfo($bibinfo);
		if ($book){
			if (($book->citation && $crawlable > $book->citation_found)){
				my @previous_citation_eshop =  DB->resultset('Eshop')->search({ id => $book->citation_source});
				my $priority = $previous_citation_eshop[0]->priority;
				#prepise citaci jestli ma crawlujici eshop vyssi prioritu
				$citation = get_citation($rec) if ($eshop->priority > $priority);
			}		
			elsif (!$book->citation){
				$citation = get_citation($rec);
			}
		}
		
		else {
			my $hash = {};
			$bibinfo->save_to_hash($hash);
			warn "Creating book  " if($ENV{DEBUG});
			$book = DB->resultset('Book')->create($hash);
			$bibinfo->save_to($book);
			$citation = get_citation($rec);
		}
		if ($citation){
			$found{$name}++;
			$book->update({citation => $citation,  citation_found => DateTime->now(), citation_source => $eshop->id  });
			warn "Adding citation : \n$citation" if($ENV{DEBUG});
		}
	}
	
	open(LOG,">>utf8","/opt/obalky/www/data/crawler.csv") or die;
	my($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
	my $now = sprintf("%04d-%02d-%02dT%02d:%02d",
					$year+1900,$mon+1,$mday,$hour,$min);
	print LOG "$now\t$name\t$from\t$to\t".$found{$name}."\n";
	close(LOG);
}




sub get_citation{
	my ($rec) = @_;	
	my $ua = LWP::UserAgent->new();

	#komunikacia s FE - treba upravit adresu
	my $resp = $ua->post('http://192.168.1.165:1339/citace',$rec,'Content-type' => 'application/json;charset=utf-8',Content => encode_json($rec));
	return $resp->content;
	
}