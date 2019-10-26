#!/usr/bin/perl -w

use Time::HiRes qw( usleep gettimeofday tv_interval );

use DateTime::Format::MySQL;
use DateTime;
use Data::Dumper;
use HTTP::Request::Common qw(POST);  
use LWP::UserAgent;
use JSON;
use Encode qw(encode_utf8); 
use Fcntl qw(:flock);

#Vylucny beh harvestu
open(SELF,"<",$0) or die "Cannot open $0 - $!";
while (!flock(SELF, LOCK_EX|LOCK_NB)){
	exit;
}

use FindBin;
use lib "$FindBin::Bin/../lib";
use Obalky::Tools;

use Eshop;
use DB;

my($mode,$ID) = @ARGV;
#die "\nusage: $0 [debug|news|all]\n\n" unless($mode);
my $DEBUG = 1 if($mode and $mode eq 'debug');

my @harvester_eshops = Eshop->get_harvested();
my @eshops;
foreach (@harvester_eshops) {
	my @tmp_eshop = DB->resultset('Eshop')->search({ name => $_->{name}}) if ($_->{name});
	push (@eshops,$tmp_eshop[0]) if ($tmp_eshop[0] && $tmp_eshop[0]->type eq 'citace');	
}


#moznost upravit existujici citace starsi nez tyden
my $last_week = DateTime->today()->subtract(days => 7);
#my $books_list = ($mode ne 'all')
#		?
my $books_list;
unless ($ID) {  
	$books_list = DB->resultset('Book')->search({
				part_type => { '=', undef },
				cover => { '!=', undef },
				citation => { '=', undef },
				citation_time => { '=', undef },
				ean13 => { 'NOT LIKE', 'ARRAY%' },
				-or => {
					ean13 => { '!=', undef },
					nbn => { '!=', undef }
				}
#				-or => [{ citation => { '=', undef }},
#					-and => [
#						{ citation_found => { '<', $last_week } },
#						{ citation => { '!=', undef } }
#					]
#				]
		}, {
			rows => 20000,
#			offset => (($mode-1) * 20000)
		});
#		: DB->resultset('Book');
} else {
	# vyhledej jedno konkrekni ID, schvalne pomoci funkce ->search, aby se dal mohlo pouzit ->next
	$books_list = DB->resultset('Book')->search({ id => $ID });
}


my %hits; my %try; my %errors; my $hits = 0; my $cnt = 1;
while(my $book = $books_list->next) {
	next if ((!$book->ean13) && (!$book->nbn));
	my $priority;
#	if ($book->citation_source && $book->citation_source ne ''){
#		my @citation_eshop = DB->resultset('Eshop')->search({ id => $book->citation_source}) if ($book->citation_source);
#		$priority = $citation_eshop[0]->priority;
#	}
	my $bibinfo = $book->bibinfo;
	my $time_start = [gettimeofday];
	foreach my $factory (@eshops) {
		my $name = $factory->name;
		my $eshop = DB->resultset('Eshop')->find_by_name($name);
		my $new_eshop_priority = $eshop->priority;
		
		#zdroj citace ma vyssi prioritu - preskocit eshop
#		next if ($priority && $priority >= $new_eshop_priority);
		$eshop->update({ try_count => $eshop->try_count + 1 });
		
		$| = 1;
		my $factory_name = "Eshop::".$factory->name;
		$try{$eshop->name}++;
		$errors{$eshop->name}++ if($@);
		my $record = $factory_name->harvest($bibinfo);
#warn Dumper($record);
		
		if ($record) {print '*'} else {print '.'}
		$book->update({ citation_time => DateTime->now() }) unless ($record);
		
		next unless ($record);
		my $citation = get_citation($record);
warn $citation;
		
		warn "Adding citation \"$citation\" to ".$book->id if($ENV{DEBUG});
		$book->update({ citation => $citation,  citation_time => DateTime->now(), citation_source => $eshop->id });		
		$hits{$eshop->name}++;
		$eshop->update({ hit_count => $eshop->hit_count + 1 });
		last;
	}
	my $time_elapsed = tv_interval ( $time_start, [gettimeofday]);
	$cnt++;
	warn 'citace #'.$cnt.' ' if ($cnt % 50 == 0);
#	sleep 1 if($time_elapsed < 1);
	sleep 3;
	die if ($cnt % 1000 == 0);
}
open(LOG,">>utf8","/opt/obalky/data/harvest.csv") or die;
my($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
my $now = sprintf("%04d-%02d-%02dT%02d:%02d",
                  $year+1900,$mon+1,$mday,$hour,$min);
foreach my $name (sort keys %try) {
	print LOG "$now\t$name\t".$try{$name}."\t".($hits{$name}||0).
				"\t".($errors{$name}||0)."\n";
}
close(LOG);

sub get_citation{
	my ($rec) = @_;	
	my $ua = LWP::UserAgent->new();
	
	#komunikacia s FE
	my $resp = $ua->post('http://cache.obalkyknih.cz:8080/citace',$rec,'Content-type' => 'application/json;charset=utf-8',Content => encode_json($rec));
	return $resp->content;
	
}
