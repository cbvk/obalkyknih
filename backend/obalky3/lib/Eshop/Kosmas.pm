
package Eshop::Kosmas;
use base 'Eshop::Mechanize';
use WWW::Mechanize;

sub cover_link {
    my($self,$mech,$ean) = @_;

	# uff uff..
	my $length = 25-12+length($ean);
	alarm 30;
	open(NC,"| nc www.kosmas.cz 80 > /tmp/.post-kosmas-$$") or die;
	print NC <<EOF;
POST /hledani_vysledek.asp HTTP/1.1
Host: www.kosmas.cz
Content-Type: application/x-www-form-urlencoded
Content-Length: $length

isbn=$ean&hled=1
EOF
	print NC "\n\n"; # close?
	close(NC);
	open(TMP,"<","/tmp/.post-kosmas-$$") or die;
	my $url;
	while(<TMP>) {
		if(/^Location:\s*(http\:\/\/.+\/knihy\/.+)/) { $url = $1; last }
	}
	close(TMP); unlink "/tmp/.post-kosmas-$$";
	return unless $url;

	$mech->get( $url );
#	$mech->submit_form(form_number => 2, fields => 
#		{ "isbn" => $ean, hled => 1, pgCnt => 10 } );
#	print $mech->content; exit;
#	return if($mech->content() =~ /nebyl bohu/);
	my $cover_url = $mech->find_image( url_regex => qr/kosmas.cz\/obalky\// );
	return $cover_url ? ($cover_url, $mech->base) : ();
}

#__PACKAGE__->register(harvest => 1, license => 'licensed', czech => 1,
#					  test => '9788072943210' );

1;
