
package Eshop::SCKN_Harvest; # nevim, jestli je funkcni SCKN_Crawler nebo toto
use base 'Eshop::Mechanize';
use WWW::Mechanize;
use HTML::TreeBuilder::XPath;
use Data::Dumper;


# www.sckn.cz/ceskeknihy/ -> rozsirene vyhledavani -> Od DEN Do DEN, ISBN 9
# -> http://www.sckn.cz/ceskeknihy/html/csv_txt_export_hledani.php?dotaz=15674,22305,23255,32050,32051,32052,32053,32054,32055,
# -> stahnout ISBN a detaily
# pripadne obalky z 
# http://www.sckn.cz/ceskeknihy/html/obalky_zip_archiv.php
# SCKN - cca 6.000 obalek

sub mechanize {
    my($self,$mech,$ean) = @_;
	$mech->get("http://www.sckn.cz/ceskeknihy/html/vyhledavani.php?".
				"isbn=$ean&odeslano=1");
	my $product_url = $mech->base;
	return () unless($product_url =~ /titul\.php/);

	my $tree = HTML::TreeBuilder::XPath->new_from_content($mech->content);

	my $info;

	my($review) = $tree->findnodes('//div[@class="titul_anotace"]');
	if($review) {
		$info->{review_impact} = $Obalky::Media::REVIEW_ANNOTATION;
		$info->{review_html} = $review->as_text 
	}

	my $cover_link = $mech->find_image( url_regex => qr/\/images\/.*jpe?g$/ );
	$info->{cover_url} = ref $cover_link ? $cover_link->url_abs : $cover_link;

	my $text = $tree->findnodes_as_string('//td');
	if($text =~ /Doporučená cena\:\s+([\s\d\.\,]+)\s*\,\-/) {
		my($price_int,$price_cent) = ($1,'00');
		if($price_int =~ /^(.+)[\,\.](\d\d)$/) {
			($price_int,$price_cent) = ($1,$2);
		}
		$price_int =~ s/[\s\,\.]//g;
		$info->{price_vat} = sprintf("%d.%02d",$price_int,$price_cent);
		$info->{price_cur} = 'CZK';
		print "Cena: ".$info->{price_vat}."\n";
	}

	my $bibinfo = Obalky::BibInfo->new_from_ean($ean); # zname jen EAN
	my $media = Obalky::Media->new_from_info( $info );
	return ($bibinfo,$media,$product_url);
}
sub cover_link {
    my($self,$mech,$ean) = @_;
#	my $url = "http://www.sckn.cz/ceskeknihy/html";
#	my $html = `wget -O - '$url/vyhledavani.php?isbn=$ean&odeslano=1'`;
#	$tree->dump;
	print "SCKN: $ean\n";
	$mech->get("http://www.sckn.cz/ceskeknihy/html/vyhledavani.php?".
				"isbn=$ean&odeslano=1");
#	$mech->post( "http://www.sckn.cz/ceskeknihy/html/vyhledavani.php", 
#				 isbn => $ean, odeslano => 1 );
	my $tree = HTML::TreeBuilder::XPath->new_from_content($mech->content);
	my($review) = $tree->findnodes('//div[@class="titul_anotace"]');
#	print $review->as_text."\n" if $review;
#	my($cover) = $tree->findnodes('//img[@class="obalka"]');
	print $mech->find_image( url_regex => qr/\/images\/.*jpe?g$/ )."\n";
	my $cover_url = $mech->find_image( url_regex => qr/\/images\/.*jpe?g$/ );
	return $cover_url ? ($cover_url,$mech->base) : ();
}

__PACKAGE__->register(harvest => 1, license => 'licensed', czech => 1,
	title => 'Svaz českých knihkupců a nakladatelů', test => '9788086849607' );

1;
