
package Eshop::SCKN; # nevim, jestli je funkcni SCKN_Harvest nebo toto
use base 'Eshop';

use LWP::UserAgent;
use Date::Simple qw/today/;
use Data::Dumper;
use Text::CSV::Encoded;
use Encode;

__PACKAGE__->register(crawl => 1, license => 'licensed', title => 'SCKN' );

sub baseURL { 'http://sckn.cz/ceskeknihy/html/stazeni_novinek.php?'.
				'vystup=csv&oddelovac=strednik&odeslano=true&datum_od=' }

sub crawl {
	my($self,$storable,$from,$to) = @_;	

	my $id = $storable->{last_id} || 1;
	$id = 1;
	for(;@list<5;$id++) {
		#sleep(1);

		my $listurl = 'http://www.sckn.cz/ceskeknihy/html/'.
			'csv_txt_export_hledani.php?dotaz='.$id.
			',0&vystup=csv&oddelovac=strednik&rozsah=vse&odeslano=true';
		my $csv = Text::CSV::Encoded->new({ sep_char => ';', 
											encoding_in => "cp1250" });
		open(CSV,"wget -q -O - '$listurl' |") or die;
		my $colref = $csv->getline(*CSV);
		next unless(ref $colref and @$colref);

		$csv->column_names(@$colref);

		my $media_info;
		while(my $row = $csv->getline_hr(*CSV)) {
			my $isbn = $row->{'ISBN 1'};
			my $ean = Obalky::BibInfo->isbn_to_ean13($isbn);  
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
			
			my $cover_file = '';
			if ($ean ne '') {
				$cover_file = "/tmp/.sckn-$$-$ean";
				my $cover_url = 'http://www.sckn.cz/ceskeknihy/images/covers_Orig/'.$ean.'.jpg';
				system("wget -q -O '$cover_file' '$cover_url'");
				unless (-s $cover_file) {
					$cover_url = 'http://www.sckn.cz/ceskeknihy/images/covers/'.$ean.'.jpg';
					system("wget -q -O '$cover_file' '$cover_url'");
				}
				
				$media_info = {};
				$media_info->{cover_url} = (-s $cover_file) ? $cover_url  : undef;
				$media_info->{cover_tmpfile} = (-s $cover_file) ? $cover_file : undef;
				$media_info->{price_vat} = $row->{'Cena'};
				$media_info->{price_cur} = 'CZK';
				$media_info->{review_html} = $row->{'Anotace'};
				$media_info->{review_impact} = $Obalky::Media::REVIEW_ANNOTATION;
			}
			my $product_url = 'http://www.sckn.cz/ceskeknihy/html/titul.php?id='.$id;

			my $media = Obalky::Media->new_from_info($media_info);
			push @list, [ $bibinfo, $media, $product_url ];
			print "$id $isbn: ".(-s $cover_file)." ".$row->{'ISBN souboru'}."\n";
		}
		$csv->eof or $csv->error_diag();
   		close(CSV);
	}
	$storable->{last_id} = $id;
	return @list;

}


1;
