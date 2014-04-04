
use strict;
use warnings;
use Test::More 'no_plan';
use utf8;

binmode(STDOUT,':utf8');

#use ok "Test::WWW::Mechanize::Catalyst" => "Obalky";
use Test::WWW::Mechanize::Catalyst;

my $ua = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Obalky');
$ua->get_ok("/api/cover?isbn=978-80-7203-884-8&return=js");
is($ua->ct, 'text/javascript');
#$ua->content_like(/img src\=\\\"(.+?)\\\"/,"JavaScript s odkazem na obalku");
my($url) = ($ua->content =~ /img src\=\\\"(.+?)\\\"/);
ok($url, "JavaScript s odkazem na obalku");
like($url, qr/file\/cover/, "Odkaz na nekam na file/cover");
$ua->get_ok($url);
is($ua->ct, 'image/jpeg');

## $ua->get_ok("/view?cover=2");
## $ua->content_contains("Kniha ISBN","Zobrazeni podrobnosti o obalce");

