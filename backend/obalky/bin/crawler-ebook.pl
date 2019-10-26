#!/usr/bin/perl -w

use ZOOM;
use MARC::Record;
use MARC::Charset 'utf8_to_marc8';


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

use warnings;
use strict;

MARC::Charset->ignore_errors(1);
MARC::Charset->assume_encoding('UTF-8');

my($mode,$force_from,$force_to) = @ARGV;
die "\nusage: DEBUG=100 $0 [today|period 2008-10-10 2008-10-20]\n\n"
		unless($mode);
my $DEBUG = $ENV{DEBUG} ? $ENV{DEBUG} : 0;
my $from = DateTime->today()->subtract(days => 2);
my $to   = DateTime->today()->subtract(days => 1);
if($mode eq 'period') {
	$from = DateTime::Format::ISO8601->parse_datetime( $force_from );
	$to   = DateTime::Format::ISO8601->parse_datetime( $force_to );
	$to   =~ s/00:00:00/23:59:59/g;
}

#$from = '2017-03-22T10:52:53';   #debug
#$to = '2017-04-20T10:53:53';     #debug

#moznost upravit existujici citace starsi nez tyden
my $crawlable =  DateTime->today()->subtract(days => 90);
my @crawler_eshops = Eshop->get_crawled();
my @eshops;


#vyselektuje crawlery vhodne na zber citaci
foreach (@crawler_eshops) {
	my @tmp_eshop = DB->resultset('Eshop')->search({ name => $_->{name}}) if ($_->{name});
	push (@eshops,$tmp_eshop[0]) if ($tmp_eshop[0] && $tmp_eshop[0]->type eq 'ebook');	
}

my %found;

my ($addr, $port, $dbname) = ('aleph.nkp.cz', '9991', 'SKC-UTF');
my $conn = connect_via_zoom($addr, $port, $dbname);
my $sizetotal = 0;
foreach my $eshop (@eshops) {
	# trida, ktera se o tento eshop stara..
	next if($ENV{OBALKY_ESHOP} and $eshop->id ne $ENV{OBALKY_ESHOP});
	warn "Crawluju ".$eshop->id." ".$eshop->name."\n" if($DEBUG);
	
	my $TMP_DIR = "/tmp/crawler-".$eshop->name;
	system("rm -rf $TMP_DIR"); mkdir($TMP_DIR);

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
	my $cnt = 0;
	
	############################################
	eval { @list = $factory->crawl($from,$to) };
	############################################
	
	warn $factory."->crawl(): $@" if($@);

	while(my ($digitalRecords,$bibinfo,$media,$product_url) = splice(@list, 0, 4)) {
		next unless ($digitalRecords and $bibinfo);
		my (@productExts, @extArray);
		
		foreach my $rec (@{$digitalRecords}){
			my ($ext) = $rec =~ /.*\.(.*)/;
			push (@productExts, $ext);
		}
		
		my $product = $eshop->add_product($bibinfo,$media,$product_url);
		$product->book->update({ doc_type => 3 });
		
		#znovu sa pokusit o spojenie ak zlyhalo
		$conn = connect_via_zoom($addr, $port, $dbname) if (!$conn);
		
		suggest_ebooks($bibinfo, $product->book->id, $eshop->id, $conn) if ($conn and $bibinfo->{title});
		add_params_types(\@productExts);
		add_params($product, $digitalRecords, \@productExts);
		$cnt++;
	}			
	warn 'ebooks: #'.$cnt if ($DEBUG);
	warn $sizetotal;
	open(LOG,">>utf8","/opt/obalky/www/data/crawler.csv") or die;
	my($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
	my $now = sprintf("%04d-%02d-%02dT%02d:%02d",
					$year+1900,$mon+1,$mday,$hour,$min);
	print LOG "$now\t$name\t$from\t$to\t".$found{$name}."\n";
	close(LOG);
#	system("rm -rf $TMP_DIR");
}

# aktualizuje zoznam koncoviek 
sub add_params_types{
	my ($exts) = @_;
	
	foreach my $ext (@{$exts}){
		DB->resultset('ProductParamsType')->find_or_create({type => $ext, description => "Ebook ".$ext." format", flag_ebook => 1});
	}
}

sub add_params{
	my ($product, $urls, $exts) = @_;

	# nacita zoznam ProductParams pre danu book/product kombinanciu
	my @params = DB->resultset('ProductParams')->search({book => $product->book->id, product => $product->id, ean13 => $product->ean13, oclc => $product->oclc, nbn => $product->nbn});
	
	# zmaze neaktualne polozky
	foreach my $param (@params){	
		$param->delete() if (!($param->other_param_type->get_column('type') ~~ @{$exts}));
	}

	# aktualizuje polozky, ktorych URL bolo pozmenene
	# ulozi novo najdene polozky
	foreach my $i (0 .. ((@{$urls}) -1)){
		my $url = @{$urls}[$i];
		my $ext = @{$exts}[$i];
		my $param_id = DB->resultset('ProductParamsType')->find_or_create({type => $ext, flag_ebook => 1})->id;
		
		my $productParam = DB->resultset('ProductParams')->find({book => $product->book->id, product => $product->id, ean13 => $product->ean13, oclc => $product->oclc, 
			nbn => $product->nbn, other_param_type => $param_id});
			
		if ($productParam){				
			$productParam->update({other_param_value => $url}) if ($productParam->other_param_value ne $url);
		}
		else{
			DB->resultset('ProductParams')->create({book => $product->book->id, product => $product->id, ean13 => $product->ean13, oclc => $product->oclc, 
				nbn => $product->nbn, other_param_value => $url,other_param_type => $param_id});
		}		
	}
}


#navrh vazieb
sub suggest_ebooks{
	my ($p_bibinfo, $parent_id, $eshop_id, $conn) = @_;
	my $SUGGESTION_LIMIT_SIZE = 100;
	
	#tvorba pqf dotazu
	my ($and, $title, $authors) = ("","","");
	my $title_cut = $p_bibinfo->{title};
	$title_cut =~ s/\s?\:[^\:]*$//p;
	# vyhladavanie podla titulu alebo titulu bez podtitulu
	my $bib_title = $p_bibinfo->{title};
	my $bib_authors;
	$bib_authors = $p_bibinfo->{authors} if ($p_bibinfo->{authors});
	$bib_title =~ s/[.,\/#!$%\^&\*;:{}=\-_`~()\?"']//g;
	$title_cut =~ s/[.,\/#!$%\^&\*;:{}=\-_`~()\?"']//g;
	$bib_authors =~ s/[.,\/#!$%\^&\*;:{}=\-_`~()\?"']//g;
	$bib_title = substr($bib_title, 0, 150);
	$title_cut = substr($title_cut, 0, 80);
	$bib_authors = substr($bib_authors, 0, 80);
	$title ='@or @attr 1=4 "'.$bib_title.'" '.'@attr 1=4 "'.$title_cut.'" ';
	$authors = '@attr 1=1003 "'.$bib_authors.'"' if ($bib_authors);
	$and = '@and ' if ($authors);
	my $query = $and.$title.$authors;
	
	my $rs = $conn->search_pqf($query);
	my $size = $rs->size();

	warn $size." results.";
	return if ($size eq 0 or $size > $SUGGESTION_LIMIT_SIZE);
	
	for (my $i = 0; $i < $size; ++$i){
		my ($title_proper, $title_sub);
		my $record = $rs->record($i);
		my $marc = new_from_usmarc MARC::Record($record->raw());
		my $sysno = $marc->subfield('998','a');#$marc->field('001')->data();
		my $bib = {};
		$bib->{'nbn'} = $marc->subfield('015', "a");
		$bib->{'oclc'} = $marc->subfield('035', "a");
		$bib->{'oclc'} =~ s/\(.*\)//g if ($bib->{'oclc'});
		$title_proper = $marc->title_proper();
		$title_proper =~ s/\s*\/\s*$// if ($title_proper);
		$title_sub = $marc->subfield('245', 'b') || '';
		$bib->{'title'} = $title_proper;
		$bib->{'authors'} = $marc->subfield('100', 'a');
		$bib->{'authors'} =~ s/,$// if $bib->{'authors'};
		$bib->{'year'} = '';
		$bib->{'year'} = $marc->subfield('264','c') if ($marc->subfield('264','c'));
		$bib->{'year'} = $marc->subfield('260','c') if ($bib->{'year'} eq '');
		my (@eanfield, $bibinfo, $has_eans, $cnt);
		my ($suggestion_id, $source_db, $source_url, $found);
		$found = 0;
		push @eanfield, ($marc->field('020'),$marc->field('022'),$marc->field('024'),$marc->field('902'));
		
		$has_eans =  0;
		#foreach my $field (@eanfield){
		#	my $ean = $field->subfield("a");
		#	next if (!$ean);
		#	#mozu existovat prazdne polia, kde chyba subfield 'a'
		#	$has_eans = 1 if (!$has_eans);
		#	$ean =~ tr/-//d;
		#	$ean = Obalky::BibInfo->parse_code($ean);
		#	$bib->{'ean'} = $ean;
		#	$bibinfo = Obalky::BibInfo->new_from_params($bib);
		#	($suggestion_id, $source_db, $source_url, $found) = search_book($bibinfo, $parent_id);
		#	last if ($found);
		#}

		if (!@eanfield or !$has_eans){
			$bibinfo = Obalky::BibInfo->new_from_params($bib);
		#	($suggestion_id, $source_db, $source_url, $found) = search_book($bibinfo, $parent_id);	
		}
		
		# kniha neni v internej DB
		if (!$found){
			$suggestion_id = $sysno;
			$source_db = $dbname;
			$source_url = 'http://aleph.nkp.cz/F/?func=direct&doc_number='.$sysno.'&local_base='.$dbname;
			warn "Adding from external source: ".$sysno if ($DEBUG);
		}

		#navrhnuty zaznam je identicky s rodicovskym
		next if ($found eq 2 or (!$has_eans and !$bib->{'nbn'} and !$bib->{'oclc'}));
		$bibinfo->{title} = $title_proper.$title_sub;
		$bibinfo->{title} =~ s/\s*\/\s*$// if ($title_sub);
		#vytvorenie navrhu
		next if (!$source_url);
		DB->resultset('BookRelationSuggestion')->find_or_create({id => $parent_id, suggestion_id => $suggestion_id, ean13 => $bibinfo->{ean13}, oclc => $bibinfo->{oclc}, nbn => $bibinfo->{nbn}, authors => $bibinfo->{authors}, title => $bibinfo->{title}, year => $bibinfo->{year}, source => $source_db, source_url => $source_url, eshop => 7136, flag => 0});				
	}
	
}

#hladanie knihy v internej DB
sub search_book{
	my ($bibinfo, $parent_id) = @_;
	my $book;
	$book = DB->resultset('Book')->find_by_bibinfo($bibinfo);
	
	my ($suggestion_id, $source_db, $source_url, $found);
	$found = 0;
	if ($book){
		if ($book->id eq $parent_id){
			warn "already exists";
			$found = 2;
			return (undef, undef, undef, $found);		
		}
		$found = 1;
		$suggestion_id = $book->id;
		$source_db = "internal";
		$source_url = 'https://www.obalkyknih.cz/view?book_id='.$book->id;
		warn "Adding from internal source:".$book->id if ($DEBUG);
	}
	return ($suggestion_id, $source_db, $source_url, $found);
}

#spojenie cez Z39.50 protokol
sub connect_via_zoom{
	my ($addr, $port, $dbname) = @_;
	
	my $conn = new ZOOM::Connection($addr, $port, databaseName => $dbname);
	return (!$conn->errcode() ? $conn : undef);
}
