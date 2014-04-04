
package Eshop::SCKN; # nevim, jestli je funkcni SCKN_Harvest nebo toto
use base 'Eshop';

use LWP::UserAgent;
use Date::Simple qw/today/;
use Data::Dumper;
use Text::CSV::Encoded;
use Encode;

__PACKAGE__->register(crawl => 1, license => 'licensed', title => 'SCKN' );

sub baseURL { 'http://www.sckn.cz/ceskeknihy/html/csv_txt_export.php?'.
				'vystup=csv&oddelovac=strednik&odeslano=true&datum_od=' }

sub crawl {
	my($self,$storable,$from,$to) = @_;	

#	my $id = $storable->{last_id}; 
#	# 500 dozadu - pokud by pridali obalku?
#	$id = $id ? ($id > 500 ? $id-500 : 1) : 1;

	my $id = $storable->{last_id} || 1;
	for(;@list<1000;$id++) {
		sleep(1);

		my $listurl = 'http://www.sckn.cz/ceskeknihy/html/'.
			'csv_txt_export_hledani.php?dotaz='.$id.
			',0&vystup=csv&oddelovac=strednik&rozsah=vse&odeslano=true';
		my $csv = Text::CSV::Encoded->new({ sep_char => ';', 
											encoding_in => "cp1250" });
		open(CSV,"wget -q -O - '$listurl' |") or die;
		my $colref = $csv->getline(*CSV);
		next unless(ref $colref and @$colref);

		$csv->column_names(@$colref);

		while(my $row = $csv->getline_hr(*CSV)) {
			my $isbn = $row->{'ISBN 1'}; 
			warn "No ISBN (id $id)\n" unless($isbn);	
			next unless($isbn);	
			$isbn =~ s/\-//g;
			my $bibinfo = Obalky::BibInfo->new_from_params({ isbn => $isbn });
			next unless($bibinfo);
			$bibinfo->{title} = $row->{Podtitul} ? $row->{"N\x{e1}zev"}."; ".
									$row->{Podtitul} : $row->{"N\x{e1}zev"};
			$bibinfo->{authors} = [split(/\s\-\s/,$row->{'Autor'})];
			$bibinfo->{year} = $1 if($row->{"Datum vydani"} 
										=~ /^(\d\d\d\d)\-/);
		
			my $cover_file = "/tmp/.sckn-$$-$isbn";
			my $cover_url = 'http://www.sckn.cz/ceskeknihy/images/covers/'.
							$isbn.'.jpg';
			system("wget -q -O '$cover_file' '$cover_url'");

			my $media_info = {
				cover_url     => -s $cover_file ? $cover_url  : undef,
				cover_tmpfile => -s $cover_file ? $cover_file : undef,
				price_vat => $row->{'Cena'},
				price_cur => 'CZK',
				review_html => $row->{'Anotace'},
				review_impact => $Obalky::Media::REVIEW_ANNOTATION,
			};
			my $product_url = 
					'http://www.sckn.cz/ceskeknihy/html/titul.php?id='.$id;

			my $media = Obalky::Media->new_from_info($media_info);
			push @list, [ $bibinfo, $media, $product_url ];
			## print "$id $isbn: ".(-s $cover_file)." ".$row->{'ISBN souboru'}."\n";
		}
		$csv->eof or $csv->error_diag();
   		close(CSV);
	}
	$storable->{last_id} = $id;
	return @list;

=begin
	# nejak od do zjisti ID zaznamu - na zacatku 1..35000
	# http://www.sckn.cz/ceskeknihy/html/csv_txt_export_hledani.php?dotaz=36607,0&vystup=csv&oddelovac=strednik&rozsah=vse&odeslano=true
#Autor;Název;Podtitul;ISBN 1;ISBN 2;ISBN 3;Nakladatel ;TS;Stran;Vazba;Cena;Cena pozn. ;Jazyk;Anotace;Format;Edice;C. svazku;Typograf;Editor;Ilustrator;Prekladatel;Puv. nazev;Puv. nakladatel;Vydani;Tiskarna;Graf. studio;Jaz. originalu;ISBN souboru;ISBN koed1;ISBN koed2;Nakladatel2;Nakladatel3;Dalsi info;EAN;Datum vydani
#"Gilbert, Guy";"Křížová cesta";"";"978-80-7195-441-5";"";"";"Karmelitánské nakladatelství";"0";"39";"B";"49";"";"český";"Křížová cesta se může stát nejen zajímavou inspirací k meditaci a modlitbě, ale také pěkným dárkem.";"100x145";"";"";"Kubů, Anna";"Martinková, Ludmila";"";"Miklošková, Lucie";"";"";"1.";"tisk Grafotechna Print, s.r.o., Praha";"";"francouzský";"";"";"";"";"";"";"9788071954415";"2010-01-29"
	# Pak asi pres 'ISBN souboru':
	# http://www.sckn.cz/ceskeknihy/images/covers/9788073632472.jpg

#	my $since = today()-50;
#	print "SCKN: Downloading list since $since\n";
#	my $listURL = $self->baseURL.sprintf("%02d-%02d-%04d",
#					$since->day,$since->month,$since->year);
	
#    my $ua = LWP::UserAgent->new; $ua->timeout(10);
#    my $list_response = $ua->get($listURL);
#    my $list_csv = decode("windows-1250",$list_response->content);

	my $csv = Text::CSV::Encoded->new({ sep_char => ';', 
										encoding_in => "cp1250" });
	open(CSV,"wget -q -O - '$listURL' |") or die;
	$colref = $csv->getline(*CSV);
	$csv->column_names(@$colref);

	# 'Nakladatel', 'Autor', "N\x{e1}zev", 'Podtitul', 'ISBN', 'ISBN 1',
	# 'ISBN 2', "Po\x{10d}et stran", 'Vazba', 'Cena', 'Jazyk', 'Anotace',
	# "Datum z\x{e1}znamu", "Form\x{e1}t", 'Edice', "\x{10c}\x{ed}slo svazku",
	# 'TS', 'Typograf', 'Editor', "Ilustr\x{e1}tor", "P\x{159}ekladatel",
	# "P\x{16f}vodn\x{ed} n\x{e1}zev", "P\x{16f}vodn\x{ed} nakladatel",
	# "Vyd\x{e1}n\x{ed}", "Tisk\x{e1}rna", "Grafick\x{e9} studio",
	# "Jazyk origin\x{e1}lu", 'ISBN souboru', 'ISBN souboru koeditora 1',
	# 'ISBN souboru koeditora 2', 'Nakladatel 1', 'Nakladatel 2',
	# "\x{10c}\x{e1}rov\x{fd} k\x{f3}d", "Datum vyd\x{e1}n\x{ed}",
	# "Dal\x{161}\x{ed} informace", "Star\x{161}\x{ed} titul", 'Zadal'
=cut

}


1;
