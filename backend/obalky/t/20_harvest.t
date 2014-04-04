
use strict;
use warnings;
use Test::More 'no_plan';
use utf8;

my $ROOT = "/opt/obalky";
my $isbn = '9788074180217';

binmode(STDOUT,':utf8');

# naplnit?

is(system("/opt/obalky/bin/harvest.pl debug >/dev/null"),0,
   "./bin/harvest.pl debug failed");

__END__
exit;

use WWW::Mechanize;
my $mech = WWW::Mechanize->new();

open(APP,"$ROOT/script/obalky_server.pl -p 3030 |") or die;
#alarm 10;
#while(<APP>) {
#	last if(/You can connect to your server at (http:\/\/.+)/);
#}
#alarm 0;
#my $URL = $1 or fail("Nastartovani obalkoveho serveru");
sleep 5;
my $URL = "http://localhost:3030";

$mech->get( $URL."/api/cover?isbn=$isbn&return=js" );
unlike($mech->content,qr/cover/,"Po resetu prazdna databaze");

#alarm 10;
system("cd $ROOT/bin && ./harvest.pl -t $URL") and die;

sleep 5;
$mech = WWW::Mechanize->new();
$mech->get( $URL."/api/cover?isbn=$isbn&return=js" );
like($mech->content,qr/cover/,"Stazeni obalky $isbn pres harvest.pl");

close(APP); # kill server

##$ua->get_ok("/view?cover=2");
#$ua->content_contains("Kniha ISBN","Zobrazeni podrobnosti o obalce");

