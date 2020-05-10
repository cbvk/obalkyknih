#!/usr/bin/perl -w

# usage: ./crawl.pl || ./crawl.pl 2008-10-10 2008-10-20
use FindBin;
use lib "$FindBin::Bin/../lib";
use lib "$FindBin::Bin";
use Source;
use Source::SKAT;
use Source::TOC;

use Obalky::Identifier;

my $MYSQL = "mysql -u obalky --password=visk2008 obalky";
#my $OBALKY_URL = "http://mini:3000";
my $OBALKY_URL = "http://obalkyknih.cz";
#my $OBALKY_URL = "http://obalky.sarfy.cz";

use DateTime;
use DateTime::Format::MySQL;
use Data::Dumper;
use URI::Escape qw/uri_escape_utf8/;

my $from = DateTime->today()->subtract(days => 2);
my $to   = DateTime->today()->subtract(days => 1);

my($force_from,$force_to) = @ARGV;
if($force_from or $force_to) {
	die "\nusage: $0 [from to] ($0 2008-10-10 2008-10-20)\n\n" 
		unless($force_from =~ /^(\d\d\d\d)\-?(\d\d)\-?(\d\d)$/);
	$from = DateTime->new(year => $1, month => $2, day => $3);
	# skaredy odstavec
	die "\nusage: $0 [from to] ($0 2008-10-10 2008-10-20)\n\n" 
		unless($force_to =~ /^(\d\d\d\d)\-?(\d\d)\-?(\d\d)$/);
	$to  = DateTime->new(year => $1, month => $2, day => $3);
}

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

# fix: presun do nejake spolecne knihovny
sub insert_cover {
	my($id,$url,$filename,$source,$license) = @_;
	next unless($id); # ???
	my $url_enc = uri_escape_utf8($url); 
	# fix: url by melo byt na localhost, orig_url na zdroj..
	# fix: Source::TOC filename nevraci, jen primo URL
	my $api = $OBALKY_URL."/api/upload?url=$url_enc&license=$license".
						  "&source=".$source."&".$id->to_params;	
#	print "API URL: $api\n";
	my $api_output = `wget -O - -q '$api' 2>&1`;
	my $ok = ($api_output =~ /SUCCESS/) ? 1 : 0;
	unless($ok) {
		warn "API URL: $api\n";
		warn "$api_output\n\n";
	}
#	die $api_output if($?);
	return $ok;
}

sub send_mail {
	my($to,$subject,$message) = @_;
	warn "To: $to\nSubject: $subject\n\n$message\n";
}

my $inserted = 0;

foreach my $source (Source->get_crawled) {
	my @list;
	print "crawling ".$source->{source}." ".$from." ".$to."\n";
	eval { @list = $source->crawl($from,$to) };
	warn $source->{source}."->crawl(): $@" if($@);
	foreach(@list) {
		my($id,$url,$filename) = @$_;
		next unless($id and $url); #?
		print $id->to_string." (".$url.")\n";
		$source->{found}++;

		eval { $inserted += insert_cover($id,$url,$filename,
							$source->{source},$source->{license}) };
		if($@) {
			send_mail('martin@sarfy.cz',"obalkyknih.cz: upload failed",$@);
			exit; # na dnes skonci, obalkyknih.cz nejede..
		}
		system("$MYSQL -e 'DELETE FROM queue ". # fix: i ostatni typy?
			"WHERE ean12 = ".$id->ean12."'") if($id->ean12);
#		unlink($QUEUE_DIR."/".$filename);
#		$hits{$source->{source}}++;
	}
	print $source->{source}.": ".$source->{found}."\n" if($source->{found});
	system("$MYSQL -e 'INSERT INTO crawl (source,found,range_from,range_to) ".
			"VALUES (\"".$source->{source}."\",".$source->{found}.",".
			"\"".DateTime::Format::MySQL->format_date($from)."\",".
			"\"".DateTime::Format::MySQL->format_date($to)."\");'");

	print "     inserted $inserted/".$source->{found}." covers\n";
}


