#!/usr/bin/perl

use Data::Dumper;
use XML::Simple;
use WWW::Mechanize;
use strict;

use lib "../lib";

use DB;

my $feeds = DB->resultset('User')->get_xmlfeeds();
#warn @$feeds;
foreach my $feed (@$feeds) {
	warn $feed;
}

__DATA__
my $mech = new WWW::Mechanize;
$mech->get("http://fcvitejeves.cz/obalky.xml");
my $xml_content = $mech->content;

my $ean = "9788090289598";

my $xml = XMLin($xml_content,ForceArray => qr/TITUL/);

my $titles = $xml->{TITUL};
foreach my $tit (@$titles) {
	if($tit->{EAN} eq $ean) {
		my $product_url = $mech->base;
		my $bibinfo = $ean;
		my $info;

		$info->{cover_url} = $tit->{IMGURL};
		$info->{price_vat} = $tit->{CENA};
		$info->{price_cur} = 'CZK';

		$info->{review_impact} = $Obalky::Media::REVIEW_ANNOTATION;
		$info->{review_html} = $tit->{POPIS};
	
	    my $bibinfo = Obalky::BibInfo->new_from_ean($ean); # zname jen EAN
	    my $media = Obalky::Media->new_from_info( $info );
		return ($bibinfo,$media,$product_url);
	}
}

return ();
__DATA__
          'IMGURL' => 'http://www2.mlp....',
		            'URL' => 'http://search.mlp.cz/searchMKP.jsp?action=sTitul&key=3512759',
					          'EAN' => '9788090289598',
							            'TYPDOC' => "ti\x{161}t\x{11b}n\x{fd} text",
										          'NAKLADATEL' => 'ASA',
												            'ROKVYDANI' => '2009',
															          'POPIS' => "Dev\x{11b}t kr\x{e1}tk\x{fd}ch pov\x{ed}dek, v nich\x{17e} p\x{159}eva\x{17e}uje detektivn\x{ed} tematika, humorn\x{e9}ho a laskav\x{e9}ho nadhledu na sv\x{11b}t drobn\x{fd}ch lid\x{ed} v \x{10d}ase prvn\x{ed} republiky (1918-1938).",
																	            'ISBN' => '978-80-902895-9-8',
																				          'NAZEV' => "\x{201d}Pov\x{ed}dky z jedn\x{e9} kapsy\x{201d} a \x{201c}Pov\x{ed}dky z druh\x{e9} kapsy\x{201d}",
																						            'AUTOR' => "Karel \x{10c}apek",
																									        	'CENA' => '210'

