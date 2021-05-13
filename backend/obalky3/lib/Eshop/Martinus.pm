
package Eshop::Martinus;
use base 'Eshop::Mechanize';
use WWW::Mechanize;

use strict;
use utf8;

sub cover_link {
    my($self,$mech,$ean) = @_;
	return; # dasabled since 201107 - pada na follow_link nize..
	$mech->get( "http://www.martinus.sk/" );
	$mech->submit_form(form_number => 1, 
			fields => { "uQ" => $ean, "uCo" => 'isbn'} );
	return unless($mech->content() =~ /Bol n/); # @found == 1
	$mech->follow_link( url_regex => qr/uItem/, class => "titlelist" );
	my $product_url = $mech->base;
	my $cover_url = $mech->find_link( url_regex => qr/data\/tovar/ );
	return ($cover_url, $product_url);
}

__PACKAGE__->register(harvest => 1, license => 'licensed', czech => 1,
					  test => '9788074180217' );

1;
