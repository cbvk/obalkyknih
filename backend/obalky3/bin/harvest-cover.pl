#!/usr/bin/perl -w

use FindBin;
use lib "$FindBin::Bin/../lib";

use Source;
use Source::Mechanize; # SKAT,TOC, ...

use Getopt::Std;
my %opts;
getopts('t', \%opts);    # -t -- test mode, single-pass
#use Data::Dumper; print Dumper(\%opts, \@ARGV);

my($obalky_url) = @ARGV;
die "\nusage: $0 [-t] http://www.obalkyknih.cz\n\n" unless($obalky_url);

# "cd /opt/obalky"
# $today = today();
# while(1) {
#   # porad dokolecka tahej z MySQL 100 radku (abychom casto netridili)
#	my @queue = SELECT id,ean12,source FROM queue 
#					WHERE (fail_count = 0 OR fail_last < $now - week)
#					ORDER BY source,fail_count,want_last;
#					LIMIT 100
#    tj.: nejdriv ty, u kterych nam dal nekdo hint source
#         jinak ty, ktere jsme jeste nezkouseli
#         a to v LIFO poradi - na stare dotazy nemusi dojit
#         na ty, ktere se nepovedlo, tyden nesahni?
#
#	@harvested_sources = grep "pull" config?; # periodicke fetchujeme bez hintu
#	foreach [$id,$source,$ean12] (@queue) {
#		# last if(today() ne $today);
#		for($source ? ($source) : (@harvested_sources)) {
#			$url = $_->fetch($ean12);
#			if($url) {
#				wget("http://www.obalkyknih.cz/api/upload?file=...");
#				if($?) { # pri chybe posli mail a cekej hodinu
#					send_mail(..)
#					sleep 60*60; 
#					last last;
#				}
#				DELETE FROM queue where ean12 = $ean12;
#				unlink "www/queue/$id.$ext"
#				last;
#			}
#		}
#		unless($url) {
#			UPDATE queue SET fail_count++, fail_last=NOW() WHERE id = $id;
#		}
#		sleep 1; # v realu klidne i 6 minut (pro 100k novych zaznamu rocne)
#	}
#	vypsat do logu statistiku: cas, scalar(@queue)/scalar(@urls), 
#					COUNT(*) FROM queue WHERE fail_count = 0,...
#					$ratio foreach(@queried_sources)
# }

use DateTime;
use DateTime::Format::MySQL;
use Data::Dumper;
use URI::Escape;

my $MYSQL = "mysql -u obalky --password=visk2009 obalky";
my $QUEUE_DIR = "/opt/obalky/www/queue";
#my $OBALKY_URL = "http://localhost:3000";
#my $OBALKY_URL = "http://obalkyknih.cz";

##my $QUEUE_URL = "http://www.obalkyknih.cz:3000/queue";

# "cd /opt/obalky"
my $today = DateTime->today();
my $lastweek = $today->subtract(days => 7);
my $lastweek_mysql = DateTime::Format::MySQL->format_datetime($lastweek);

sub read_table {
	my($SELECT) = @_;
	my @rows;
	open(ROWS,"$MYSQL --skip-column-names -e \'$SELECT\' -B |") or die;
	while(<ROWS>) {
		chomp;
		push @rows, [ map $_ eq 'NULL' ? undef : $_, split(/\t/) ];
	}
	close(ROWS);
	return @rows;
}

sub select_batch {
	my($limit) = @_;
	# nejdriv ty, u kterych nam dal nekdo hint source
	# jinak ty, ktere jsme jeste nezkouseli
	# a to v LIFO poradi - na stare dotazy nemusi dojit
	# na ty, ktere se nepovedlo, tyden nesahni?
	my $SELECT = "SELECT id,ean12,source FROM queue ".
			"WHERE (fail_count = 0 OR fail_last < \"$lastweek_mysql\") ".
			# FIX: v realu want_last, ne want_count
			"AND ean12 is not null AND ean12 != \"\" ".
# ------------------ !!!!
			"AND fail_count = 0 ". # JUST NEW ONES NOW!!!!
			"ORDER BY source,fail_count,want_count DESC,want_last DESC ".
			"LIMIT $limit";
	return read_table($SELECT);
}

sub insert_cover {
	my($ean12,$url,$filename,$source,$license) = @_;
	next unless($ean12); # ???
	my $url_enc = uri_escape($url); 
	# fix: url by melo byt na localhost, orig_url na zdroj..
	my $api = $obalky_url."/api/upload?url=$url_enc&license=$license".
		                          "&source=".$source."&ean12=".$ean12;
	my $api_output = `wget -O - -q '$api' 2>&1`;
	print "$api_output\n";
	die $api_output if($?);
}

sub send_mail {
	my($to,$subject,$message) = @_;
	warn "To: $to\nSubject: $subject\n\n$message\n";

	my $from = 'root@obalkyknih.cz';
	my $sendmail = '/usr/lib/sendmail';
	open(MAIL, "|$sendmail -oi -t");
	print MAIL "From: $from\n";
	print MAIL "To: $to\n";
	print MAIL "Subject: $subject\n\n";
	print MAIL "$message\n";
	close(MAIL);
}

while(1) {
	# porad dokolecka tahej z MySQL 100 radku (abychom casto netridili)
	my $limit = 1000;
	my @batch = select_batch($limit);
	my %hits; my %try; my %fails; my $hits = 0;
	foreach(@batch) {
		my($id,$ean12,$sourcename) = @$_;
#		next unless($ean12 =~ /^\d{12}$/);
		print "DEBUG: $id $ean12\n";
		my($url,$filename,$found);
##		last LAST! unless(DateTime->compare($today,DateTime->today()));

    	# my($isbn,$ean,$isbn10,$isbn13) = Source->ean12_to_ean($ean12);

		foreach my $source ($sourcename ? (Source->get($sourcename)) : 
										  Source->get_harvested($ean12)) {
			eval { ($url,$filename) = $source->harvest($ean12,$QUEUE_DIR) };
			warn $source->{source}."->harvest($ean12): $@" if($@);
			$source->{fetch}++;
			$try{$source->{source}}++;
			$fails{$source->{source}}++ if($@);
			if($url and not $filename) {
				$filename = Source->fetch_image($ean12,$url,$QUEUE_DIR);
			}
			next unless($url and $filename);
			$source->{found}++;

			eval { insert_cover($ean12,$url,$filename,$source->{source},
								$source->{license}) };
			if($@) {
				send_mail('martin@sarfy.cz',"obalkyknih.cz: upload failed",$@);
				exit; # na dnes skonci, obalkyknih.cz nejede..
			}

			system("$MYSQL -e 'DELETE FROM queue WHERE ean12 = \"$ean12\"'");
			unlink($QUEUE_DIR."/".$filename);
			$found = 1; $hits++; $hits{$source->{source}}++;
			last;
		}
		unless($found) {
			system("$MYSQL -e 'UPDATE queue SET fail_count = fail_count+1, ".
								"fail_last = NOW() WHERE id = \"$id\"'");
#			sleep 1; # pri neuspechu cekej dele
		}
#		sleep 1; # v realu klidne i 5 minut (pro 100k novych zaznamu rocne)
	}

	last if(exists $opts{'t'}); # single-pass mode (for testing)

	my @a1 = read_table("SELECT COUNT(*) FROM queue WHERE fail_count = 0");
	my $count_new = $a1[0] ? $a1[0]->[0] : undef;
	my @a2 = read_table("SELECT COUNT(*) FROM queue");
	my $count_all = $a2[0] ? $a2[0]->[0] : undef;

	my $source_ratios = join(" ",map $_.":".($hits{$_}||0)."/".($try{$_}||0)
					.($fails{$_}?"/".$fails{$_}."!":""), sort keys %try);

	# fix: jak to vypsat v locale timezone??
	print DateTime->now()." ratio=".$hits."/".scalar(@batch)." #queue=".
					$count_new."/".$count_all." ".$source_ratios."\n";

	system("$MYSQL -e 'INSERT INTO harvest (ratio_hits,ratio_batch,
			queue_new,queue_all,source_stat) VALUES ".
			"($hits,".scalar(@batch).",$count_new,$count_all,".
			"\"$source_ratios\")'");

	print "DEBUG: empty batch, waiting 6 hours!\n" unless(@batch); 
	sleep 6*60*60 unless(@batch); # sleep 6 hours!!!
##	sleep 60 unless(@batch); 
#	last; # debug mode

}

