#!/usr/bin/perl -w

use lib 'lib';
use Eshop::TOC;
use Data::Dumper;

while(<DATA>) {
	chomp;
	my($rok,$id1,$id2,$title,$url) = split(/ \@ /,$_);
	my($sysno) = $2 if($url and $url =~ /(number|request)=(\d+)/);
	next if($rok eq '1999' or not $sysno);
	print "$sysno\n";
	my $bibinfo = Eshop::TOC->nbn_to_bibinfo($sysno);
	print Dumper($sysno,$bibinfo);
}

__DATA__
1999 @ 01 @ 05 @ Pražský kudykam. Vydání sever-centrum @ http://aleph.nkp.cz/F/?func=find-b&request=000601998&find_code=SYS&local_base=nkc
1999 @ 02 @ 04 @ Exit. Praha a střední Čechy. @ http://aleph.nkp.cz/F/?func=find-b&request=000646666&find_code=SYS&local_base=nkc
1999 @ 02 @ 03 @ Dubáček. Zpravodaj z Dubé a jejího okolí @ http://aleph.nkp.cz/F/?func=find-b&request=000645557&find_code=SYS&local_base=nkc
1999 @ 02 @ 02 @ Doubrava. Obecní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000646691&find_code=SYS&local_base=nkc
1999 @ 02 @ 01 @ Čakan. Klenečský měsíční zpavodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000646303&find_code=SYS&local_base=nkc
1999 @ 03 @ 19 @ Materiály pro stavbu @ http://aleph.nkp.cz/F/?func=find-b&request=000648297&find_code=SYS&local_base=nkc
1999 @ 03 @ 18 @ Markýz @ http://aleph.nkp.cz/F/?func=find-b&request=000648572&find_code=SYS&local_base=nkc
1999 @ 03 @ 17 @ Lobby. List Hospodářské komory ČR @ http://aleph.nkp.cz/F/?func=find-b&request=000648659&find_code=SYS&local_base=nkc
1999 @ 09 @ 11 @ Hobby horse. Magazín zajímavostí a odborných rad pro aktivní jezdce @ http://aleph.nkp.cz/F/?func=find-b&request=704522&find_code=SYS&local_base=nkc
1999 @ 09 @ 10 @ Glóbus. Měsíčník domácího cestovního ruchu @ http://aleph.nkp.cz/F/?func=find-b&request=738082&find_code=SYS&local_base=nkc
1999 @ 09 @ 07 @ Fit pro život. Longevity. Časopis zdraví@ zdatnosti a půvabu', 'http://aleph.nkp.cz/F/?func=find-b&request=704559&find_code=SYS&local_base=nkc
1999 @ 09 @ 05 @ Domažlický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=704226&find_code=SYS&local_base=nkc
1999 @ 09 @ 09 @ Global - inzert. Týdeník. Inzertní a reklamní noviny pro podnikatelskou a soukromou inzerci @ http://aleph.nkp.cz/F/?func=find-b&request=704841&find_code=SYS&local_base=nkc
1999 @ 09 @ 08 @ Floorbal. Měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=733804&find_code=SYS&local_base=nkc
1999 @ 09 @ 06 @ Dudlík. Vhodné pro začínající luštitele @ http://aleph.nkp.cz/F/?func=find-b&request=738355&find_code=SYS&local_base=nkc
1999 @ 09 @ 04 @ Český západ. Západočeský programový časopis @ http://aleph.nkp.cz/F/?func=find-b&request=704237&find_code=SYS&local_base=nkc
1999 @ 09 @ 03 @ Bulletin plus @ http://aleph.nkp.cz/F/?func=find-b&request=704647&find_code=SYS&local_base=nkc
1999 @ 09 @ 02 @ Attack magazín @ http://aleph.nkp.cz/F/?func=find-b&request=704231&find_code=SYS&local_base=nkc
1999 @ 09 @ 01 @ Alternativa plus @ http://aleph.nkp.cz/F/?func=find-b&request=733817&find_code=SYS&local_base=nkc
1999 @ 06 @ 07 @ Křížovky rozverné @ http://aleph.nkp.cz/F/?func=find-b&request=000662813&find_code=SYS&local_base=nkc
1999 @ 06 @ 04 @ Environmentální značení @ http://aleph.nkp.cz/F/?func=find-b&request=000692171&find_code=SYS&local_base=nkc
1999 @ 06 @ 06 @ Kosmetika. Odborný časopis pro drogerii@ kosmetiku a zdraví', 'http://aleph.nkp.cz/F/?func=find-b&request=000662749&find_code=SYS&local_base=nkc
1999 @ 06 @ 05 @ Kamelot. Týdeník okresu Karviná @ http://aleph.nkp.cz/F/?func=find-b&request=000661688&find_code=SYS&local_base=nkc
1999 @ 06 @ 03 @ Data Communications. Kde začínají sítě a komunikace @ http://aleph.nkp.cz/F/?func=find-b&request=000660893&find_code=SYS&local_base=nkc
1999 @ 06 @ 01 @ Armádní magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000693192&find_code=SYS&local_base=nkc
1999 @ 06 @ 02 @ Commando plus @ http://aleph.nkp.cz/F/?func=find-b&request=000692162&find_code=SYS&local_base=nkc
1999 @ 05 @ 19 @ Kebule. Dobrodružný příběh s křížovkami pro děti @ http://aleph.nkp.cz/F/?func=find-b&request=000659183&find_code=SYS&local_base=nkc
1999 @ 05 @ 17 @ Informační magazín pro vinohradnictví a sadařství @ http://aleph.nkp.cz/F/?func=find-b&request=000654602&find_code=SYS&local_base=nkc
1999 @ 05 @ 13 @ Horník. Noviny zdarma nejen pro havíře @ http://aleph.nkp.cz/F/?func=find-b&request=000659354&find_code=SYS&local_base=nkc
1999 @ 05 @ 18 @ Interní medicína pro praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000654394&find_code=SYS&local_base=nkc
1999 @ 05 @ 16 @ Incognito? Nezávislý informační měsíčník lesbických žen a jejich přátel @ http://aleph.nkp.cz/F/?func=find-b&request=000655353&find_code=SYS&local_base=nkc
1999 @ 05 @ 15 @ Hotel a restaurant. Revue pro gastronomii@ hotelnictví a cestovní ruch', 'http://aleph.nkp.cz/F/?func=find-b&request=000653930&find_code=SYS&local_base=nkc
1999 @ 05 @ 14 @ Hornoújezdský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000655423&find_code=SYS&local_base=nkc
1999 @ 05 @ 12 @ Hobby expres. Noviny pro celou rodinu @ http://aleph.nkp.cz/F/?func=find-b&request=000658234&find_code=SYS&local_base=nkc
1999 @ 05 @ 11 @ Hlinecký Šrek. Hlinecký měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000658427&find_code=SYS&local_base=nkc
1999 @ 05 @ 10 @ Hele. Poslední věc@ kterou potřebujete', 'http://aleph.nkp.cz/F/?func=find-b&request=000654584&find_code=SYS&local_base=nkc
1999 @ 05 @ 09 @ GameStar @ http://aleph.nkp.cz/F/?func=find-b&request=000658637&find_code=SYS&local_base=nkc
1999 @ 05 @ 08 @ E + M. Ekonomie a management @ http://aleph.nkp.cz/F/?func=find-b&request=000653385&find_code=SYS&local_base=nkc
1999 @ 05 @ 07 @ Distance. Revue pro kritické myšlení @ http://aleph.nkp.cz/F/?func=find-b&request=000653381&find_code=SYS&local_base=nkc
1999 @ 05 @ 06 @ Česko-moravské realitní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000655430&find_code=SYS&local_base=nkc
1999 @ 05 @ 05 @ Causa privata. České obchodní právo @ http://aleph.nkp.cz/F/?func=find-b&request=000655365&find_code=SYS&local_base=nkc
2003 @ 05 @ 01 @ ATM @ http://aleph.nkp.cz/F/?func=find-b&request=000999402&find_code=SYS&local_base=nkc
2003 @ 05 @ 02 @ Archivní listy @ http://aleph.nkp.cz/F/?func=find-b&request=001249262&find_code=SYS&local_base=nkc
2003 @ 05 @ 03 @ Avokádo @ http://aleph.nkp.cz/F/?func=find-b&request=001250313&find_code=SYS&local_base=nkc
2003 @ 05 @ 04 @ Czech production @ http://aleph.nkp.cz/F/?func=find-b&request=001250317&find_code=SYS&local_base=nkc
2003 @ 05 @ 05 @ Čepské obecní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001250315&find_code=SYS&local_base=nkc
2003 @ 05 @ 06 @ Český bikros @ http://aleph.nkp.cz/F/?func=find-b&request=001249255&find_code=SYS&local_base=nkc
2003 @ 05 @ 07 @ Dělnické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001250318&find_code=SYS&local_base=nkc
2003 @ 05 @ 08 @ Elegant @ http://aleph.nkp.cz/F/?func=find-b&request=001249270&find_code=SYS&local_base=nkc
2003 @ 05 @ 09 @ Eurotel business informace @ http://aleph.nkp.cz/F/?func=find-b&request=001250296&find_code=SYS&local_base=nkc
2003 @ 05 @ 10 @ Eurotel business information @ http://aleph.nkp.cz/F/?func=find-b&request=001250309&find_code=SYS&local_base=nkc
2003 @ 05 @ 11 @ Guest@ @ http://aleph.nkp.cz/F/?func=find-b&request=001250496&find_code=SYS&local_base=nkc
2003 @ 05 @ 12 @ Industry inzert @ http://aleph.nkp.cz/F/?func=find-b&request=001250343&find_code=SYS&local_base=nkc
2003 @ 05 @ 13 @ ITS revue @ http://aleph.nkp.cz/F/?func=find-b&request=001250316&find_code=SYS&local_base=nkc
2003 @ 05 @ 14 @ Kalimera @ http://aleph.nkp.cz/F/?func=find-b&request=001250314&find_code=SYS&local_base=nkc
2003 @ 05 @ 15 @ Kamenoviny @ http://aleph.nkp.cz/F/?func=find-b&request=001249292&find_code=SYS&local_base=nkc
2003 @ 05 @ 16 @ Kamínky @ http://aleph.nkp.cz/F/?func=find-b&request=001249288&find_code=SYS&local_base=nkc
2003 @ 05 @ 17 @ Lapis refugii @ http://aleph.nkp.cz/F/?func=find-b&request=001249279&find_code=SYS&local_base=nkc
2003 @ 05 @ 18 @ Lidé v pohybu @ http://aleph.nkp.cz/F/?func=find-b&request=001248893&find_code=SYS&local_base=nkc
2003 @ 05 @ 19 @ Mág @ http://aleph.nkp.cz/F/?func=find-b&request=001249253&find_code=SYS&local_base=nkc
2003 @ 05 @ 20 @ Maxim @ http://aleph.nkp.cz/F/?func=find-b&request=001248891&find_code=SYS&local_base=nkc
2003 @ 05 @ 21 @ Mecca @ http://aleph.nkp.cz/F/?func=find-b&request=001250321&find_code=SYS&local_base=nkc
2003 @ 05 @ 22 @ Mezinárodní a srovnávací právní revue @ http://aleph.nkp.cz/F/?func=find-b&request=001250268&find_code=SYS&local_base=nkc
2003 @ 05 @ 23 @ Olbramovický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001250782&find_code=SYS&local_base=nkc
2003 @ 05 @ 24 @ Protein @ http://aleph.nkp.cz/F/?func=find-b&request=001250339&find_code=SYS&local_base=nkc
2003 @ 05 @ 25 @ Puls tisku @ http://aleph.nkp.cz/F/?func=find-b&request=001250786&find_code=SYS&local_base=nkc
2003 @ 05 @ 26 @ Skalisko @ http://aleph.nkp.cz/F/?func=find-b&request=001249331&find_code=SYS&local_base=nkc
2003 @ 05 @ 27 @ Zábava pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=001249319
2003 @ 05 @ 28 @ Zpravodaj obce Troubelice @ http://aleph.nkp.cz/F/?func=find-b&request=001249311
2003 @ 03 @ 33 @ Šalamounky @ http://aleph.nkp.cz/F/?func=find-b&request=001239739&find_code=SYS&local_base=nkc
2003 @ 03 @ 32 @ Slánsko @ http://aleph.nkp.cz/F/?func=find-b&request=001242921&find_code=SYS&local_base=nkc
2003 @ 03 @ 31 @ Rodopisná revue @ http://aleph.nkp.cz/F/?func=find-b&request=001239745&find_code=SYS&local_base=nkc
2003 @ 03 @ 30 @ Rockshock @ http://aleph.nkp.cz/F/?func=find-b&request=001241529&find_code=SYS&local_base=nkc
2003 @ 03 @ 29 @ Print plus @ http://aleph.nkp.cz/F/?func=find-b&request=001034186&find_code=SYS&local_base=nkc
2003 @ 03 @ 28 @ Pražský kulturní měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=001239734&find_code=SYS&local_base=nkc
2003 @ 03 @ 27 @ Porno kutil @ http://aleph.nkp.cz/F/?func=find-b&request=001242939&find_code=SYS&local_base=nkc
2003 @ 03 @ 26 @ PlayStation 2 @ http://aleph.nkp.cz/F/?func=find-b&request=001240886&find_code=SYS&local_base=nkc
2003 @ 03 @ 25 @ Plant@ soil and environment', 'http://aleph.nkp.cz/F/?func=find-b&request=001241999&find_code=SYS&local_base=nkc
2003 @ 03 @ 24 @ Netřebický zvon @ http://aleph.nkp.cz/F/?func=find-b&request=001240877&find_code=SYS&local_base=nkc
2003 @ 03 @ 23 @ Moje generace @ http://aleph.nkp.cz/F/?func=find-b&request=001240497&find_code=SYS&local_base=nkc
2003 @ 03 @ 22 @ Mini Max (Havlíčkův Brod) @ http://aleph.nkp.cz/F/?func=find-b&request=001242482&find_code=SYS&local_base=nkc
2003 @ 03 @ 21 @ LP magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000980962&find_code=SYS&local_base=nkc
2003 @ 03 @ 20 @ Love story @ http://aleph.nkp.cz/F/?func=find-b&request=000360437&find_code=SYS&local_base=nkc
2003 @ 03 @ 19 @ Líšnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001241984&find_code=SYS&local_base=nkc
2003 @ 03 @ 18 @ Kvasické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001240879&find_code=SYS&local_base=nkc
2003 @ 03 @ 17 @ Krušovice @ http://aleph.nkp.cz/F/?func=find-b&request=001241945&find_code=SYS&local_base=nkc
2003 @ 03 @ 16 @ Kronika regionu @ http://aleph.nkp.cz/F/?func=find-b&request=001241919&find_code=SYS&local_base=nkc
2003 @ 03 @ 15 @ Králický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001241125&find_code=SYS&local_base=nkc
2003 @ 03 @ 14 @ Kovárenství @ http://aleph.nkp.cz/F/?func=find-b&request=001241981&find_code=SYS&local_base=nkc
2003 @ 03 @ 13 @ Katalog nákladních automobilů @ http://aleph.nkp.cz/F/?func=find-b&request=001023600&find_code=SYS&local_base=nkc
2003 @ 03 @ 12 @ Jindřichovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001240882&find_code=SYS&local_base=nkc
2003 @ 03 @ 11 @ Jemnické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001241986&find_code=SYS&local_base=nkc
2003 @ 03 @ 10 @ Inform Praga @ http://aleph.nkp.cz/F/?func=find-b&request=001182607&find_code=SYS&local_base=nkc
2003 @ 03 @ 09 @ Cholinský list @ http://aleph.nkp.cz/F/?func=find-b&request=001240875&find_code=SYS&local_base=nkc
2003 @ 03 @ 08 @ Hradecký telegraf @ http://aleph.nkp.cz/F/?func=find-b&request=001241940&find_code=SYS&local_base=nkc
2003 @ 03 @ 07 @ Highend @ http://aleph.nkp.cz/F/?func=find-b&request=000360840&find_code=SYS&local_base=nkc
2003 @ 03 @ 06 @ Hamerský list @ http://aleph.nkp.cz/F/?func=find-b&request=001241943&find_code=SYS&local_base=nkc
2003 @ 03 @ 05 @ Formule @ http://aleph.nkp.cz/F/?func=find-b&request=001242913&find_code=SYS&local_base=nkc
2003 @ 03 @ 04 @ Facility management news @ http://aleph.nkp.cz/F/?func=find-b&request=001239332&find_code=SYS&local_base=nkc
2003 @ 03 @ 03 @ Euro firma @ http://aleph.nkp.cz/F/?func=find-b&request=001241955&find_code=SYS&local_base=nkc
2003 @ 03 @ 02 @ Digimon @ http://aleph.nkp.cz/F/?func=find-b&request=001243532&find_code=SYS&local_base=nkc
2003 @ 03 @ 01 @ Arnikum @ http://aleph.nkp.cz/F/?func=find-b&request=001241963&find_code=SYS&local_base=nkc
2003 @ 01 @ 01 @ Ain Karim @ http://aleph.nkp.cz/F/?func=find-b&request=001200239&find_code=SYS&local_base=nkc
2003 @ 01 @ 02 @ Anče Veselá @ http://aleph.nkp.cz/F/?func=find-b&request=001199106&find_code=SYS&local_base=nkc
2003 @ 01 @ 03 @ Boskovicko @ http://aleph.nkp.cz/F/?func=find-b&request=001200572&find_code=SYS&local_base=nkc
2003 @ 01 @ 04 @ Č.P. service @ http://aleph.nkp.cz/F/?func=find-b&request=001198774&find_code=SYS&local_base=nkc
2003 @ 01 @ 05 @ Entertainment @ http://aleph.nkp.cz/F/?func=find-b&request=001001978&find_code=SYS&local_base=nkc
2003 @ 01 @ 06 @ Fany info @ http://aleph.nkp.cz/F/?func=find-b&request=001199110&find_code=SYS&local_base=nkc
2003 @ 01 @ 07 @ Formule 1 @ http://aleph.nkp.cz/F/?func=find-b&request=001199109&find_code=SYS&local_base=nkc
2003 @ 01 @ 08 @ Horoskopy a osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001200215&find_code=SYS&local_base=nkc
2003 @ 01 @ 09 @ Jestřebský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001200226&find_code=SYS&local_base=nkc
2003 @ 01 @ 10 @ Journal of applied biomedicine @ http://aleph.nkp.cz/F/?func=find-b&request=001199079&find_code=SYS&local_base=nkc
2003 @ 01 @ 11 @ Kavárna Pohoda @ http://aleph.nkp.cz/F/?func=find-b&request=001199098&find_code=SYS&local_base=nkc
2003 @ 01 @ 12 @ Kousek @ http://aleph.nkp.cz/F/?func=find-b&request=001199077&find_code=SYS&local_base=nkc
2003 @ 01 @ 13 @ Krajské noviny (Pardubický kraj) @ http://aleph.nkp.cz/F/?func=find-b&request=001199103&find_code=SYS&local_base=nkc
2003 @ 01 @ 14 @ Křížovky plné fórů speciál @ http://aleph.nkp.cz/F/?func=find-b&request=001198463&find_code=SYS&local_base=nkc
2003 @ 01 @ 15 @ Křížovky s Pegasem @ http://aleph.nkp.cz/F/?func=find-b&request=001199472&find_code=SYS&local_base=nkc
2003 @ 01 @ 16 @ Kunínek @ http://aleph.nkp.cz/F/?func=find-b&request=000968456&find_code=SYS&local_base=nkc
2003 @ 01 @ 17 @ Labor aktuell @ http://aleph.nkp.cz/F/?func=find-b&request=001199346&find_code=SYS&local_base=nkc
2003 @ 01 @ 18 @ Mohelnicko @ http://aleph.nkp.cz/F/?func=find-b&request=001200251&find_code=SYS&local_base=nkc
2003 @ 01 @ 19 @ Music @ http://aleph.nkp.cz/F/?func=find-b&request=001067309&find_code=SYS&local_base=nkc
2003 @ 01 @ 20 @ Národní listy @ http://aleph.nkp.cz/F/?func=find-b&request=001200205&find_code=SYS&local_base=nkc
2003 @ 01 @ 21 @ Občasník Auto Racek @ http://aleph.nkp.cz/F/?func=find-b&request=001191327&find_code=SYS&local_base=nkc
2003 @ 01 @ 22 @ Samé dobré zprávy @ http://aleph.nkp.cz/F/?func=find-b&request=001199357&find_code=SYS&local_base=nkc
2003 @ 01 @ 23 @ Stavospoj @ http://aleph.nkp.cz/F/?func=find-b&request=001199269&find_code=SYS&local_base=nkc
2003 @ 01 @ 24 @ Together @ http://aleph.nkp.cz/F/?func=find-b&request=001200256&find_code=SYS&local_base=nkc
2003 @ 01 @ 25 @ Veletoč @ http://aleph.nkp.cz/F/?func=find-b&request=001199299&find_code=SYS&local_base=nkc
1999 @ 01 @ 04 @ IKD. Informace královéhradecké diecéze @ http://aleph.nkp.cz/F/?func=find-b&request=000642404&find_code=SYS&local_base=nkc
1999 @ 01 @ 03 @ Hurvajz plus @ http://aleph.nkp.cz/F/?func=find-b&request=000605856&find_code=SYS&local_base=nkc
1999 @ 01 @ 02 @ Golf. Český golfový časopis @ http://aleph.nkp.cz/F/?func=find-b&request=000607836&find_code=SYS&local_base=nkc
1999 @ 01 @ 01 @ Fitstyl. V kondici@ hezká, sexy', 'http://aleph.nkp.cz/F/?func=find-b&request=000605873&find_code=SYS&local_base=nkc
2000 @ 01 @ 26 @ Revue psychoanalytické psychoterapie. Časopis České společnosti pro ...  @ http://aleph.nkp.cz/F/?func=find-b&request=00785996&find_code=SYS&local_base=nkc
2000 @ 01 @ 25 @ Pozor Y2K. Zpravodaj Národního koordinačního ...  @ http://aleph.nkp.cz/F/?func=find-b&request=00784379&find_code=SYS&local_base=nkc
2000 @ 01 @ 24 @ Pasáž @ http://aleph.nkp.cz/F/?func=find-b&request=00784385&find_code=SYS&local_base=nkc
2000 @ 01 @ 22 @ Outdoor @ http://aleph.nkp.cz/F/?func=find-b&request=00785549&find_code=SYS&local_base=nkc
2000 @ 01 @ 23 @ Paegas Impuls @ http://aleph.nkp.cz/F/?func=find-b&request=00782928&find_code=SYS&local_base=nkc
2000 @ 01 @ 21 @ Odpadové fórum. Odborný časopis pro vše ...  @ http://aleph.nkp.cz/F/?func=find-b&request=00786095&find_code=SYS&local_base=nkc
2000 @ 01 @ 20 @ Naše krásná zahrada Speciál @ http://aleph.nkp.cz/F/?func=find-b&request=00785619&find_code=SYS&local_base=nkc
2000 @ 01 @ 19 @ Náš kraj. Jizerské/Lužické hory. Magazín pro Liberecký kraj  @ http://aleph.nkp.cz/F/?func=find-b&request=00786283&find_code=SYS&local_base=nkc
2000 @ 01 @ 18 @ Medicína v praxi @ http://aleph.nkp.cz/F/?func=find-b&request=00785716&find_code=SYS&local_base=nkc
2000 @ 01 @ 17 @ Magazín pro top dívky @ http://aleph.nkp.cz/F/?func=find-b&request=00784376&find_code=SYS&local_base=nkc
2000 @ 01 @ 16 @ M. Měsíčník pro Prahu 6 a blízké okolí  @ http://aleph.nkp.cz/F/?func=find-b&request=00785698&find_code=SYS&local_base=nkc
2000 @ 01 @ 15 @ Listy. Čechy - Slovensko - Európa  @ http://aleph.nkp.cz/F/?func=find-b&request=00785609&find_code=SYS&local_base=nkc
2000 @ 01 @ 14 @ Křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=00786176&find_code=SYS&local_base=nkc
2000 @ 01 @ 13 @ Kladno 2000. Měsíčník informací...  @ http://aleph.nkp.cz/F/?func=find-b&request=00786080&find_code=SYS&local_base=nkc
2000 @ 01 @ 12 @ Kalendář. Zpravodaj Společnosti všeobecného lékařství  @ http://aleph.nkp.cz/F/?func=find-b&request=00785670&find_code=SYS&local_base=nkc
2000 @ 01 @ 11 @ Jihočeské mlékárny Dnes. Čtvrtletník akcionářů...  @ http://aleph.nkp.cz/F/?func=find-b&request=00787047&find_code=SYS&local_base=nkc
2000 @ 01 @ 10 @ IT-NET. Specializovaný měsíčník o sítích@ telekomunikacích a službách ', 'http://aleph.nkp.cz/F/?func=find-b&request=00786184&find_code=SYS&local_base=nkc
2000 @ 01 @ 09 @ Informační list obce Lanžhot @ http://aleph.nkp.cz/F/?func=find-b&request=00787068&find_code=SYS&local_base=nkc
2000 @ 01 @ 08 @ Energo. Časopis pro energetiku ...  @ http://aleph.nkp.cz/F/?func=find-b&request=00785707&find_code=SYS&local_base=nkc
2000 @ 01 @ 07 @ Elixír aneb jak příjemně (ne)stárnout  @ http://aleph.nkp.cz/F/?func=find-b&request=00782927&find_code=SYS&local_base=nkc
2000 @ 01 @ 06 @ Ekonomika@ právo a politika. Sborník textů ze seminářů ', 'http://aleph.nkp.cz/F/?func=find-b&request=00787064&find_code=SYS&local_base=nkc
2000 @ 01 @ 05 @ Dobříšské listy + Nový směr @ http://aleph.nkp.cz/F/?func=find-b&request=00786461&find_code=SYS&local_base=nkc
2000 @ 01 @ 04 @ Dluhy a dlužníci @ http://aleph.nkp.cz/F/?func=find-b&request=00785706&find_code=SYS&local_base=nkc
2000 @ 01 @ 03 @ Dáda @ http://aleph.nkp.cz/F/?func=find-b&request=00784007&find_code=SYS&local_base=nkc
2000 @ 01 @ 02 @ Blesk extra @ http://aleph.nkp.cz/F/?func=find-b&request=00785621&find_code=SYS&local_base=nkc
2000 @ 01 @ 01 @ Armádní zápisník @ http://aleph.nkp.cz/F/?func=find-b&request=00785702&find_code=SYS&local_base=nkc
1999 @ 05 @ 04 @ Callida partner. Rozpočty a kalkulace ve stavebnictví @ http://aleph.nkp.cz/F/?func=find-b&request=000655341&find_code=SYS&local_base=nkc
1999 @ 05 @ 03 @ Ano-ne Evropská unie @ http://aleph.nkp.cz/F/?func=find-b&request=000654594&find_code=SYS&local_base=nkc
2000 @ 02 @ 39 @ Zvířata @ http://aleph.nkp.cz/F/?func=find-b&request=00838899&find_code=SYS&local_base=nkc
2000 @ 02 @ 38 @ Zpravodaj Velká Bíteš @ http://aleph.nkp.cz/F/?func=find-b&request=00839004&find_code=SYS&local_base=nkc
2000 @ 02 @ 37 @ Zlínský a moravský den. Noviny pro okresy Zlín@ Kroměříž...', 'http://aleph.nkp.cz/F/?func=find-b&request=00817083&find_code=SYS&local_base=nkc
2000 @ 02 @ 36 @ XXL. Velké švédské křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=00838901&find_code=SYS&local_base=nkc
2000 @ 02 @ 34 @ Uhřický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00838879&find_code=SYS&local_base=nkc
2000 @ 02 @ 35 @ Váš osobní lékař aneb Aeskulap radí @ http://aleph.nkp.cz/F/?func=find-b&request=00838939&find_code=SYS&local_base=nkc
2000 @ 02 @ 32 @ Švédské křížovky za bůra @ http://aleph.nkp.cz/F/?func=find-b&request=00787585&find_code=SYS&local_base=nkc
2000 @ 02 @ 33 @ Terno. Časopis sítě supermarketů... @ http://aleph.nkp.cz/F/?func=find-b&request=00787570&find_code=SYS&local_base=nkc
2000 @ 02 @ 31 @ Švédské křížovky za babku @ http://aleph.nkp.cz/F/?func=find-b&request=00787399&find_code=SYS&local_base=nkc
2000 @ 02 @ 30 @ Svět myslivosti. Měsíčník pro myslivce a přátele přírody @ http://aleph.nkp.cz/F/?func=find-b&request=00838888&find_code=SYS&local_base=nkc
2000 @ 02 @ 29 @ Sranda magazín @ http://aleph.nkp.cz/F/?func=find-b&request=00838907&find_code=SYS&local_base=nkc
2000 @ 02 @ 28 @ Sportovní občasník @ http://aleph.nkp.cz/F/?func=find-b&request=00838804&find_code=SYS&local_base=nkc
2000 @ 02 @ 26 @ Rádioamatér. Časopis Českého radioklubu pro amatérský... @ http://aleph.nkp.cz/F/?func=find-b&request=00838893&find_code=SYS&local_base=nkc
2000 @ 02 @ 27 @ Senza senior. Časopis nejen pro jednu generaci @ http://aleph.nkp.cz/F/?func=find-b&request=00838824&find_code=SYS&local_base=nkc
2000 @ 02 @ 23 @ Právo a rodina @ http://aleph.nkp.cz/F/?func=find-b&request=00876354&find_code=SYS&local_base=nkc
2000 @ 02 @ 24 @ Pravobřežní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00838904&find_code=SYS&local_base=nkc
2000 @ 02 @ 25 @ Pro footbal. Magazín o mezinárodním fotbalu @ http://aleph.nkp.cz/F/?func=find-b&request=00838906&find_code=SYS&local_base=nkc
2000 @ 02 @ 22 @ Polabský týdeník TOK @ http://aleph.nkp.cz/F/?func=find-b&request=00838881&find_code=SYS&local_base=nkc
2000 @ 02 @ 21 @ Okresní úřad Žďár nad Sázavou @ http://aleph.nkp.cz/F/?func=find-b&request=00838902&find_code=SYS&local_base=nkc
2000 @ 02 @ 19 @ Noviny Brano Group. Noviny zaměstnanců... @ http://aleph.nkp.cz/F/?func=find-b&request=00838833&find_code=SYS&local_base=nkc
2000 @ 02 @ 20 @ Noviny pro konkurz a vyrovnání. Nezávislý měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=00840172&find_code=SYS&local_base=nkc
2000 @ 02 @ 18 @ My a naše peníze @ http://aleph.nkp.cz/F/?func=find-b&request=00840531&find_code=SYS&local_base=nkc
2000 @ 02 @ 17 @ Maxxx. Gay erotický magazín @ http://aleph.nkp.cz/F/?func=find-b&request=00838909&find_code=SYS&local_base=nkc
2000 @ 02 @ 14 @ Magazín Vítkovice @ http://aleph.nkp.cz/F/?func=find-b&request=00840176&find_code=SYS&local_base=nkc
2000 @ 02 @ 15 @ Magie švédských křížovek @ http://aleph.nkp.cz/F/?func=find-b&request=00787076&find_code=SYS&local_base=nkc
2000 @ 02 @ 16 @ Marketing & media. Týdeník pro média@ marketing a kreativitu', 'http://aleph.nkp.cz/F/?func=find-b&request=00838908&find_code=SYS&local_base=nkc
2000 @ 02 @ 13 @ Magazín MIK @ http://aleph.nkp.cz/F/?func=find-b&request=00838762&find_code=SYS&local_base=nkc
2000 @ 02 @ 12 @ Luxusní osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=00787080&find_code=SYS&local_base=nkc
2000 @ 02 @ 10 @ Kullt. Jihočeský kullturní časopis @ http://aleph.nkp.cz/F/?func=find-b&request=00787385&find_code=SYS&local_base=nkc
2000 @ 02 @ 11 @ Lego akce! @ http://aleph.nkp.cz/F/?func=find-b&request=00840525&find_code=SYS&local_base=nkc
2000 @ 02 @ 09 @ Křížovky veselé perličky @ http://aleph.nkp.cz/F/?func=find-b&request=00876358&find_code=SYS&local_base=nkc
2000 @ 02 @ 07 @ Harcovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=00787404&find_code=SYS&local_base=nkc
2000 @ 02 @ 08 @ Kontakt. Čtvrtletník pro obchodní partnery RadioMobilu a.s. @ http://aleph.nkp.cz/F/?func=find-b&request=00787381&find_code=SYS&local_base=nkc
2000 @ 02 @ 06 @ FC klub (příloha časopisu Folk & country) @ http://aleph.nkp.cz/F/?func=find-b&request=00838873&find_code=SYS&local_base=nkc
2000 @ 02 @ 03 @ Bond. Exkluzivní fotomagazín @ http://aleph.nkp.cz/F/?func=find-b&request=00787610&find_code=SYS&local_base=nkc
2000 @ 02 @ 05 @ Český jih. Jihočeský programový časopis @ http://aleph.nkp.cz/F/?func=find-b&request=00838873&find_code=SYS&local_base=nkc
2000 @ 02 @ 04 @ Bulletin Asociace českých chemických společností @ http://aleph.nkp.cz/F/?func=find-b&request=00816394&find_code=SYS&local_base=nkc
2000 @ 02 @ 02 @ Blatecký měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=00787070&find_code=SYS&local_base=nkc
2000 @ 02 @ 01 @ Autoburza @ http://aleph.nkp.cz/F/?func=find-b&request=00858692&find_code=SYS&local_base=nkc
1999 @ 05 @ 02 @ Alergie. Časopis pro kontinuální vzdělávání v alergologii a ... @ http://aleph.nkp.cz/F/?func=find-b&request=000655448&find_code=SYS&local_base=nkc
1999 @ 05 @ 01 @ Acta Universitatis Bohemiae Meridionales @ http://aleph.nkp.cz/F/?func=find-b&request=000655327&find_code=SYS&local_base=nkc
1999 @ 04 @ 04 @ Kardiologická revue. Neoficiální diskusní fórum českých kardiologů @ http://aleph.nkp.cz/F/?func=find-b&request=000652003&find_code=SYS&local_base=nkc
1999 @ 04 @ 03 @ Evangelík. Časopis Luterské evangelické církve a.v. v ČR @ http://aleph.nkp.cz/F/?func=find-b&request=000649602&find_code=SYS&local_base=nkc
1999 @ 04 @ 01 @ Archa. Zpravodaj o výchově a využití volného času dětí a mládeže @ http://aleph.nkp.cz/F/?func=find-b&request=000652018&find_code=SYS&local_base=nkc
1999 @ 04 @ 02 @ Dluhy a dlužníci. Časopis pro úspěšné řešení závazků a pohledávek @ http://aleph.nkp.cz/F/?func=find-b&request=000651967&find_code=SYS&local_base=nkc
1999 @ 03 @ 16 @ Libochovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000647690&find_code=SYS&local_base=nkc
1999 @ 03 @ 15 @ Koclířovský zpravodaj. Měsíčník obce Koclířov @ http://aleph.nkp.cz/F/?func=find-b&request=000649752&find_code=SYS&local_base=nkc
1999 @ 03 @ 14 @ Kamelot. Týdeník okresu Opava @ http://aleph.nkp.cz/F/?func=find-b&request=000648315&find_code=SYS&local_base=nkc
1999 @ 03 @ 11 @ Hustler @ http://aleph.nkp.cz/F/?func=find-b&request=000648557&find_code=SYS&local_base=nkc
1999 @ 03 @ 12 @ Jabko. Zpravodaj města Jablunkova @ http://aleph.nkp.cz/F/?func=find-b&request=000649523&find_code=SYS&local_base=nkc
1999 @ 03 @ 13 @ Joint. Úplník o svobodě a odpovědnosti @ http://aleph.nkp.cz/F/?func=find-b&request=000648533&find_code=SYS&local_base=nkc
1999 @ 03 @ 10 @ Holýšovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000648802&find_code=SYS&local_base=nkc
1999 @ 03 @ 09 @ Evropský soudní dvůr v Lucemburku @ http://aleph.nkp.cz/F/?func=find-b&request=000648437&find_code=SYS&local_base=nkc
1999 @ 03 @ 08 @ Dělení@ spojování, svařování materiálů', 'http://aleph.nkp.cz/F/?func=find-b&request=000648854&find_code=SYS&local_base=nkc
1999 @ 03 @ 07 @ České ložnice @ http://aleph.nkp.cz/F/?func=find-b&request=000651568&find_code=SYS&local_base=nkc
1999 @ 03 @ 06 @ COT business. Časopis pro profesionály v cestovním ruchu @ http://aleph.nkp.cz/F/?func=find-b&request=000649122&find_code=SYS&local_base=nkc
2001 @ 02 @ 10 @ Haló Zlín @ http://aleph.nkp.cz/F/?func=find-b&request=000989902&find_code=SYS&local_base=nkc
2001 @ 02 @ 09 @ Haló region @ http://aleph.nkp.cz/F/?func=find-b&request=000990640&find_code=SYS&local_base=nkc
2001 @ 02 @ 08 @ Haló Prostějov @ http://aleph.nkp.cz/F/?func=find-b&request=000990641&find_code=SYS&local_base=nkc
1999 @ 03 @ 03 @ Autosport & Tuning @ http://aleph.nkp.cz/F/?func=find-b&request=000648645&find_code=SYS&local_base=nkc
2001 @ 02 @ 07 @ Haló Brno @ http://aleph.nkp.cz/F/?func=find-b&request=000989914&find_code=SYS&local_base=nkc
2001 @ 02 @ 03 @ Černovicko. Zpravodaj města Černovice a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=000990469&find_code=SYS&local_base=nkc
2001 @ 02 @ 04 @ Dialog. Měsíčník pro zákazníky společnosti Radiomobil @ http://aleph.nkp.cz/F/?func=find-b&request=000990587&find_code=SYS&local_base=nkc
2001 @ 02 @ 06 @ Dubický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000989977&find_code=SYS&local_base=nkc
2001 @ 02 @ 05 @ Doteky. Bulletin LORMU @ http://aleph.nkp.cz/F/?func=find-b&request=000990856&find_code=SYS&local_base=nkc
2001 @ 01 @ 36 @ Zpravodaj ČNS @ http://aleph.nkp.cz/F/?func=find-b&request=000987394&find_code=SYS&local_base=nkc
2001 @ 01 @ 37 @ Zpravodaj Malé Březno a Leština @ http://aleph.nkp.cz/F/?func=find-b&request=000987420&find_code=SYS&local_base=nkc
2001 @ 01 @ 38 @ Zpravodaj Ostravského muzea @ http://aleph.nkp.cz/F/?func=find-b&request=000987340&find_code=SYS&local_base=nkc
2001 @ 02 @ 01 @ Ázet noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000990480&find_code=SYS&local_base=nkc
2001 @ 02 @ 02 @ Bariéry. Časopis pro odstranění společenských bariér @ http://aleph.nkp.cz/F/?func=find-b&request=000990628&find_code=SYS&local_base=nkc
2001 @ 01 @ 34 @ Závislosti a my @ http://aleph.nkp.cz/F/?func=find-b&request=000983786&find_code=SYS&local_base=nkc
2001 @ 01 @ 35 @ Zpravodaj (Obecní úřad Suchohrdly) @ http://aleph.nkp.cz/F/?func=find-b&request=000987311&find_code=SYS&local_base=nkc
2001 @ 01 @ 32 @ Vítkovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000984769&find_code=SYS&local_base=nkc
2001 @ 01 @ 33 @ Vlast @ http://aleph.nkp.cz/F/?func=find-b&request=000987452&find_code=SYS&local_base=nkc
2001 @ 01 @ 28 @ Šluknovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000987591&find_code=SYS&local_base=nkc
2001 @ 01 @ 29 @ Špindlerovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000987583&find_code=SYS&local_base=nkc
2001 @ 01 @ 30 @ Toužimské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000987533&find_code=SYS&local_base=nkc
2001 @ 01 @ 31 @ Uhelňáček @ http://aleph.nkp.cz/F/?func=find-b&request=000984772&find_code=SYS&local_base=nkc
2001 @ 01 @ 27 @ Šikula @ http://aleph.nkp.cz/F/?func=find-b&request=000984370&find_code=SYS&local_base=nkc
2001 @ 01 @ 26 @ Šenovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000987597&find_code=SYS&local_base=nkc
2001 @ 01 @ 23 @ Proboštovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000984770&find_code=SYS&local_base=nkc
2001 @ 01 @ 24 @ Radniční noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000987573&find_code=SYS&local_base=nkc
2001 @ 01 @ 25 @ Rokytník @ http://aleph.nkp.cz/F/?func=find-b&request=000984771&find_code=SYS&local_base=nkc
2001 @ 01 @ 22 @ Petřvaldský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000986903&find_code=SYS&local_base=nkc
2001 @ 01 @ 18 @ Mikroregion Jesenicko @ http://aleph.nkp.cz/F/?func=find-b&request=000981032&find_code=SYS&local_base=nkc
2001 @ 01 @ 19 @ Moraváček @ http://aleph.nkp.cz/F/?func=find-b&request=000987447&find_code=SYS&local_base=nkc
2001 @ 01 @ 20 @ Mostecké listy @ http://aleph.nkp.cz/F/?func=find-b&request=000987085&find_code=SYS&local_base=nkc
2001 @ 01 @ 21 @ Ořechovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000987588&find_code=SYS&local_base=nkc
2001 @ 01 @ 15 @ Měsíčník města Příbora @ http://aleph.nkp.cz/F/?func=find-b&request=000986802&find_code=SYS&local_base=nkc
2001 @ 01 @ 16 @ Měsíčník obce Dolní Domaslavice @ http://aleph.nkp.cz/F/?func=find-b&request=000986961&find_code=SYS&local_base=nkc
2001 @ 01 @ 17 @ Mikroregion Frýdlantsko-Beskydy @ http://aleph.nkp.cz/F/?func=find-b&request=000984768&find_code=SYS&local_base=nkc
2001 @ 01 @ 12 @ Letovický list @ http://aleph.nkp.cz/F/?func=find-b&request=000983697&find_code=SYS&local_base=nkc
2001 @ 01 @ 13 @ Maletínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000986968&find_code=SYS&local_base=nkc
2001 @ 01 @ 14 @ Masarykův lid @ http://aleph.nkp.cz/F/?func=find-b&request=000987488&find_code=SYS&local_base=nkc
2001 @ 01 @ 10 @ Křížovkářský třesk @ http://aleph.nkp.cz/F/?func=find-b&request=000983698&find_code=SYS&local_base=nkc
2001 @ 01 @ 11 @ Kutnohorské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000987076&find_code=SYS&local_base=nkc
2001 @ 01 @ 09 @ Kouzlo rostlin @ http://aleph.nkp.cz/F/?func=find-b&request=000984766&find_code=SYS&local_base=nkc
2001 @ 01 @ 04 @ Dívka @ http://aleph.nkp.cz/F/?func=find-b&request=000987359&find_code=SYS&local_base=nkc
2001 @ 01 @ 05 @ Chlumáček @ http://aleph.nkp.cz/F/?func=find-b&request=000987451&find_code=SYS&local_base=nkc
2001 @ 01 @ 06 @ Chlumecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000986964&find_code=SYS&local_base=nkc
2001 @ 01 @ 07 @ Interkom @ http://aleph.nkp.cz/F/?func=find-b&request=000987453&find_code=SYS&local_base=nkc
2001 @ 01 @ 08 @ Inzertin @ http://aleph.nkp.cz/F/?func=find-b&request=000984767&find_code=SYS&local_base=nkc
2001 @ 01 @ 01 @ Bydlím v Rybitví @ http://aleph.nkp.cz/F/?func=find-b&request=000987080&find_code=SYS&local_base=nkc
2001 @ 01 @ 03 @ Černoviny. Zpravodaj městské části Brno - Černovice @ http://aleph.nkp.cz/F/?func=find-b&request=000987308&find_code=SYS&local_base=nkc
2001 @ 01 @ 02 @ CK tip @ http://aleph.nkp.cz/F/?func=find-b&request=000987450&find_code=SYS&local_base=nkc
1999 @ 03 @ 05 @ Causa subita. Časopis pro lékaře v 1. linii @ http://aleph.nkp.cz/F/?func=find-b&request=000649856&find_code=SYS&local_base=nkc
1999 @ 03 @ 04 @ Bludiště. Zábavný magazín pro odvážné šikulky jako jsi ty @ http://aleph.nkp.cz/F/?func=find-b&request=000648353&find_code=SYS&local_base=nkc
1999 @ 03 @ 02 @ AliaChem Dnes. Čtrnáctideník akciové společnosti AliaChem @ http://aleph.nkp.cz/F/?func=find-b&request=000648447&find_code=SYS&local_base=nkc
1999 @ 03 @ 01 @ Alergie@ astma, bronchitida', 'http://aleph.nkp.cz/F/?func=find-b&request=000648595&find_code=SYS&local_base=nkc
1999 @ 10 @ 22 @ Kleopatra. Ve velkém stylu @ http://aleph.nkp.cz/F/?func=find-b&request=000767062&find_code=SYS&local_base=nkc
1999 @ 10 @ 33 @ Mora. Zpravodaj pro obchodní partnery a veřejnost @ http://aleph.nkp.cz/F/?func=find-b&request=000740186&find_code=SYS&local_base=nkc
1999 @ 10 @ 32 @ Metal info. Informační bulletin určený strojírensky ... @ http://aleph.nkp.cz/F/?func=find-b&request=000740203&find_code=SYS&local_base=nkc
1999 @ 10 @ 31 @ Megazín. Časopis pro výrobce razítek v České a Slovenské republice @ http://aleph.nkp.cz/F/?func=find-b&request=000766255&find_code=SYS&local_base=nkc
1999 @ 10 @ 29 @ Lokátor. Manual for free time @ http://aleph.nkp.cz/F/?func=find-b&request=000738538&find_code=SYS&local_base=nkc
1999 @ 10 @ 30 @ Magazín Komerční banky @ http://aleph.nkp.cz/F/?func=find-b&request=000766880&find_code=SYS&local_base=nkc
1999 @ 10 @ 27 @ Křížovky skoro pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=000767559&find_code=SYS&local_base=nkc
1999 @ 10 @ 28 @ Leasing. Časopis akciové společnosti IPB Leasing @ http://aleph.nkp.cz/F/?func=find-b&request=000766870&find_code=SYS&local_base=nkc
1999 @ 10 @ 26 @ Krona. Češskij nezavisimyj informacionnyj ježenědělnik @ http://aleph.nkp.cz/F/?func=find-b&request=000767329&find_code=SYS&local_base=nkc
1999 @ 10 @ 24 @ Konkurz & konjunktura @ http://aleph.nkp.cz/F/?func=find-b&request=000766357&find_code=SYS&local_base=nkc
1999 @ 10 @ 25 @ Kontakt. Scientific Acta Faculty of Social and Health Studies @ http://aleph.nkp.cz/F/?func=find-b&request=000766355&find_code=SYS&local_base=nkc
1999 @ 10 @ 23 @ Karvinský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000740207&find_code=SYS&local_base=nkc
1999 @ 10 @ 21 @ Kariéry@ příležitosti, zaměstnání, vzdělávání', 'http://aleph.nkp.cz/F/?func=find-b&request=000767749&find_code=SYS&local_base=nkc
1999 @ 10 @ 19 @ Informační list. Měsíčník pro občany města Ústí nad Orlicí @ http://aleph.nkp.cz/F/?func=find-b&request=000766243&find_code=SYS&local_base=nkc
1999 @ 10 @ 20 @ Journal of forest science @ http://aleph.nkp.cz/F/?func=find-b&request=000739834&find_code=SYS&local_base=nkc
1999 @ 10 @ 18 @ Chebské radniční noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000766164&find_code=SYS&local_base=nkc
1999 @ 10 @ 17 @ Hrušecké okénko. Čtvrtletní obecní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000739771&find_code=SYS&local_base=nkc
1999 @ 10 @ 13 @ ? ftipné osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=000767953&find_code=SYS&local_base=nkc
1999 @ 10 @ 14 @ Geographic camera @ http://aleph.nkp.cz/F/?func=find-b&request=000767427&find_code=SYS&local_base=nkc
1999 @ 10 @ 15 @ Hatrick. Fotbalový magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000766999&find_code=SYS&local_base=nkc
1999 @ 10 @ 16 @ Hořepnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000766175&find_code=SYS&local_base=nkc
1999 @ 10 @ 10 @ Digital revue. O spotřební elektronice zítřka @ http://aleph.nkp.cz/F/?func=find-b&request=000767058&find_code=SYS&local_base=nkc
1999 @ 10 @ 11 @ Evropský demokrat @ http://aleph.nkp.cz/F/?func=find-b&request=000766901&find_code=SYS&local_base=nkc
1999 @ 10 @ 12 @ Foto & video @ http://aleph.nkp.cz/F/?func=find-b&request=000767397&find_code=SYS&local_base=nkc
1999 @ 10 @ 09 @ Denní menu @ http://aleph.nkp.cz/F/?func=find-b&request=000740198&find_code=SYS&local_base=nkc
1999 @ 10 @ 06 @ Country roads. Časopis country music & country styl @ http://aleph.nkp.cz/F/?func=find-b&request=000767054&find_code=SYS&local_base=nkc
1999 @ 10 @ 07 @ Českomoravský dopravák. Měsíčník zaměstnanců ČSAD Ostrava @ http://aleph.nkp.cz/F/?func=find-b&request=000739698&find_code=SYS&local_base=nkc
1999 @ 10 @ 08 @ Český venkov @ http://aleph.nkp.cz/F/?func=find-b&request=000739764&find_code=SYS&local_base=nkc
1999 @ 10 @ 05 @ California fitness news. Časopis pro více než.... @ http://aleph.nkp.cz/F/?func=find-b&request=000739573&find_code=SYS&local_base=nkc
1999 @ 10 @ 01 @ Aliance. Česká revue pro Euroatlantickou obrannou spolupráci @ http://aleph.nkp.cz/F/?func=find-b&request=000739509&find_code=SYS&local_base=nkc
1999 @ 10 @ 02 @ Analýzy & studie. Informační bulletin Ústavu strategických studií MÚ Brno @ http://aleph.nkp.cz/F/?func=find-b&request=000739551&find_code=SYS&local_base=nkc
2003 @ 12 @ 48 @ Žihelský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001294492&local_base=nkc
1999 @ 10 @ 04 @ Bodycare. Odborný časopis pro drogerii@ kosmetiku a zdraví', 'http://aleph.nkp.cz/F/?func=find-b&request=000739997&find_code=SYS&local_base=nkc
1999 @ 10 @ 03 @ Bludovan @ http://aleph.nkp.cz/F/?func=find-b&request=000766194&find_code=SYS&local_base=nkc
2003 @ 12 @ 45 @ Veřejné zakázky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001294508&local_base=nkc
2003 @ 12 @ 46 @ Zpravodaj obce Dražovice @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001294910&local_base=nkc
2003 @ 12 @ 47 @ ZS noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001296743&local_base=nkc
2003 @ 12 @ 44 @ Vademecum veterinárních léčivých přípravků @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001294741&local_base=nkc
2003 @ 12 @ 39 @ Stavební a investorské noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001295076&local_base=nkc
2003 @ 12 @ 43 @ TV programy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001296728&local_base=nkc
2003 @ 12 @ 42 @ Truck magazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001296004&local_base=nkc
2003 @ 12 @ 40 @ Testy a křížovky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001294233&local_base=nkc
2003 @ 12 @ 41 @ Travel life @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001294489&local_base=nkc
2003 @ 12 @ 38 @ Pulsus @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001294229&local_base=nkc
2003 @ 12 @ 37 @ Pražské byty @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001296297&local_base=nkc
2003 @ 12 @ 36 @ Porno roku @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001295992&local_base=nkc
2003 @ 12 @ 34 @ Pekař cukrář @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001296741&local_base=nkc
2003 @ 12 @ 35 @ Plus @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001296671&local_base=nkc
2003 @ 12 @ 33 @ Packaging @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001296726&local_base=nkc
2003 @ 12 @ 32 @ Obecní zpravodaj Suchdolska @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001295508&local_base=nkc
2003 @ 12 @ 30 @ Newsletter pro management akciových společností @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000528061&local_base=nkc
2003 @ 12 @ 31 @ Nový Hejkal @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000992070&local_base=nkc
2003 @ 12 @ 28 @ Naut @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001296654&local_base=nkc
2003 @ 12 @ 29 @ Newsletter pro jednatele@ společníky a management s.r.o.', 'http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000528595&local_base=nkc
2003 @ 12 @ 27 @ Naše vesnice @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001294917&local_base=nkc
2003 @ 12 @ 26 @ Morning star @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000311179&local_base=nkc
2003 @ 12 @ 25 @ Match @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001295730&local_base=nkc
2003 @ 12 @ 24 @ Lodě exclusive @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001294221&local_base=nkc
2003 @ 12 @ 22 @ Lékárna a léky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289490&local_base=nkc
2003 @ 12 @ 23 @ Libišská radnice @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001295723&local_base=nkc
2003 @ 12 @ 21 @ Lanštorfský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001035198&local_base=nkc
2003 @ 12 @ 20 @ Kytlický občasník @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000602177&local_base=nkc
2003 @ 12 @ 19 @ Klubový zpravodaj (Klub plynárenských podnikatelů ČR) @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000978815&local_base=nkc
2003 @ 12 @ 18 @ Informace pro občany obce Chvalšiny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001093295&local_base=nkc
2003 @ 12 @ 17 @ Info (Informační zpravodaj obce Slabčice) @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000967964&local_base=nkc
2003 @ 12 @ 16 @ Chebský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001294234&local_base=nkc
2003 @ 12 @ 15 @ HiPath Spektrum @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001295717&local_base=nkc
2003 @ 12 @ 14 @ Fragmenta Ioannea collecta @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001034883&local_base=nkc
2003 @ 12 @ 13 @ Folia gastroenterologica et hepatologica @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001295080&local_base=nkc
2003 @ 12 @ 11 @ Euroregion @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001295802&local_base=nkc
2003 @ 12 @ 12 @ FinanceNewEurope @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000787047&local_base=nkc
2003 @ 12 @ 10 @ Dovolená @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001296685&local_base=nkc
2003 @ 12 @ 09 @ Diario de Praga @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001295760&local_base=nkc
2003 @ 12 @ 07 @ Čekárna @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000661418&local_base=nkc
2003 @ 12 @ 08 @ Čtvrtletník Charity Ostrava @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001295689&local_base=nkc
2003 @ 12 @ 06 @ Car & hifi @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000658544&local_base=nkc
2003 @ 12 @ 05 @ Campus @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000311899&local_base=nkc
2003 @ 12 @ 04 @ Březovský občasník @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000648754&local_base=nkc
2003 @ 12 @ 03 @ Autoškola dnes @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000782892&local_base=nkc
2003 @ 12 @ 02 @ Auto tip extra @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001294934&local_base=nkc
2003 @ 12 @ 01 @ AutoBusiness @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001295878&local_base=nkc
1999 @ 09 @ 12 @ Hobby magazín TV @ http://aleph.nkp.cz/F/?func=find-b&request=704207&find_code=SYS&local_base=nkc
1999 @ 09 @ 13 @ Chovatel - rádce @ http://aleph.nkp.cz/F/?func=find-b&request=704558&find_code=SYS&local_base=nkc
1999 @ 09 @ 14 @ Inno. České inzertní noviny pro podnikatelskou a soukromou inzerci @ http://aleph.nkp.cz/F/?func=find-b&request=356299&find_code=SYS&local_base=nkc
1999 @ 09 @ 15 @ Kovo@ dřevo, stavby, zásoby, služby. Týdeník pro každého podnikatele', 'http://aleph.nkp.cz/F/?func=find-b&request=704633&find_code=SYS&local_base=nkc
1999 @ 09 @ 16 @ Křížovky za bůra. Pro celou rodinu @ http://aleph.nkp.cz/F/?func=find-b&request=738352&find_code=SYS&local_base=nkc
1999 @ 09 @ 17 @ Kuděj. Časopis pro kulturní dějiny @ http://aleph.nkp.cz/F/?func=find-b&request=738201&find_code=SYS&local_base=nkc
1999 @ 09 @ 18 @ Milotice. Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=704223&find_code=SYS&local_base=nkc
1999 @ 09 @ 19 @ Mistři klasické hudby @ http://aleph.nkp.cz/F/?func=find-b&request=733809&find_code=SYS&local_base=nkc
1999 @ 09 @ 20 @ Noviny VŠ. Měsíčník soukromé vysoké školy @ http://aleph.nkp.cz/F/?func=find-b&request=733971&find_code=SYS&local_base=nkc
1999 @ 09 @ 21 @ Otázky a odpovědi @ http://aleph.nkp.cz/F/?func=find-b&request=738088&find_code=SYS&local_base=nkc
1999 @ 09 @ 22 @ Pastelka. Měsíčník pro školy i na doma pro ... @ http://aleph.nkp.cz/F/?func=find-b&request=734137&find_code=SYS&local_base=nkc
1999 @ 09 @ 23 @ Praktická kuchařka @ http://aleph.nkp.cz/F/?func=find-b&request=734125&find_code=SYS&local_base=nkc
1999 @ 09 @ 24 @ Venkov. Časopis pro obnovu venkova @ ekologii a neziskové organizace', 'http://aleph.nkp.cz/F/?func=find-b&request=734093&find_code=SYS&local_base=nkc
1999 @ 10 @ 34 @ Nejdečák @ http://aleph.nkp.cz/F/?func=find-b&request=000739664&find_code=SYS&local_base=nkc
1999 @ 10 @ 35 @ Neon. Časopis o kultuře @ http://aleph.nkp.cz/F/?func=find-b&request=000768288&find_code=SYS&local_base=nkc
1999 @ 10 @ 36 @ Noviny pro grafický průmysl @ http://aleph.nkp.cz/F/?func=find-b&request=000740230&find_code=SYS&local_base=nkc
1999 @ 10 @ 37 @ O penězích. Měsíčník Klubu investorů BBG @ http://aleph.nkp.cz/F/?func=find-b&request=000767955&find_code=SYS&local_base=nkc
1999 @ 10 @ 38 @ Otázky a odpovědi. Měsíčník dotazů a odpovědí z oblasti daní a účetnictví @ http://aleph.nkp.cz/F/?func=find-b&request=000767261&find_code=SYS&local_base=nkc
1999 @ 10 @ 39 @ Outdoor magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000767564&find_code=SYS&local_base=nkc
1999 @ 10 @ 40 @ PC gamer @ http://aleph.nkp.cz/F/?func=find-b&request=000767569&find_code=SYS&local_base=nkc
1999 @ 10 @ 41 @ Pé Vé Káčko. Informační zpravodaj PVK@ a.s.', 'http://aleph.nkp.cz/F/?func=find-b&request=000768262&find_code=SYS&local_base=nkc
1999 @ 10 @ 42 @ Polický měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000740064&find_code=SYS&local_base=nkc
1999 @ 10 @ 43 @ """Prachovice"" " @ http://aleph.nkp.cz/F/?func=find-b&request=000767334&find_code=SYS&local_base=nkc
1999 @ 10 @ 44 @ Pražská pětka. Měsíčník městské části Praha 5 @ http://aleph.nkp.cz/F/?func=find-b&request=000740248&find_code=SYS&local_base=nkc
1999 @ 10 @ 45 @ Sekretářka & asistentka. Praktické tipy pro úspěšnou kancelářskou praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000767588&find_code=SYS&local_base=nkc
1999 @ 10 @ 46 @ Širák. Regionální časopis @ http://aleph.nkp.cz/F/?func=find-b&request=000767277&find_code=SYS&local_base=nkc
1999 @ 10 @ 47 @ T3. Hračky pro muže @ http://aleph.nkp.cz/F/?func=find-b&request=000768180&find_code=SYS&local_base=nkc
1999 @ 10 @ 48 @ Tuřanský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000739958&find_code=SYS&local_base=nkc
1999 @ 10 @ 49 @ TV revue. Týdenní magazín pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=000767552&find_code=SYS&local_base=nkc
1999 @ 10 @ 50 @ Týdeník Ostrava @ http://aleph.nkp.cz/F/?func=find-b&request=000768206&find_code=SYS&local_base=nkc
1999 @ 10 @ 51 @ Zpravodaj. Místní agenda 21 v ČR @ http://aleph.nkp.cz/F/?func=find-b&request=000767727&find_code=SYS&local_base=nkc
1999 @ 11 @ 01 @ Anekdoty @ http://aleph.nkp.cz/F/?func=find-b&request=000771984&find_code=SYS&local_base=nkc
1999 @ 11 @ 02 @ Autoh@ndel annonce @ http://aleph.nkp.cz/F/?func=find-b&request=000771088&find_code=SYS&local_base=nkc
1999 @ 11 @ 03 @ Časopis pražské ZOO @ http://aleph.nkp.cz/F/?func=find-b&request=000772573&find_code=SYS&local_base=nkc
1999 @ 11 @ 04 @ České motocyklové noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000772407&find_code=SYS&local_base=nkc
1999 @ 11 @ 05 @ 4x4 automagazín @ http://aleph.nkp.cz/F/?func=find-b&request=000772657&find_code=SYS&local_base=nkc
1999 @ 11 @ 06 @ Dino zpravodaj. Zpravodaj Dubečské iniciativy nezávislých občanů @ http://aleph.nkp.cz/F/?func=find-b&request=000770922&find_code=SYS&local_base=nkc
1999 @ 11 @ 07 @ Drnholecký občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000772662&find_code=SYS&local_base=nkc
1999 @ 11 @ 08 @ Gladius. Dvouměsíčník tradičních hodnot @ http://aleph.nkp.cz/F/?func=find-b&request=000704196&find_code=SYS&local_base=nkc
1999 @ 11 @ 09 @ Hezké osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=000772630&find_code=SYS&local_base=nkc
1999 @ 11 @ 10 @ Heart of Europe @ http://aleph.nkp.cz/F/?func=find-b&request=000769834&find_code=SYS&local_base=nkc
1999 @ 11 @ 11 @ Humorné švédské křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=000770829&find_code=SYS&local_base=nkc
1999 @ 11 @ 12 @ IQ @ http://aleph.nkp.cz/F/?func=find-b&request=000771100&find_code=SYS&local_base=nkc
1999 @ 11 @ 13 @ Jesličky. Křížovky pro začínající @ http://aleph.nkp.cz/F/?func=find-b&request=000772627&find_code=SYS&local_base=nkc
1999 @ 11 @ 14 @ Lechtivé osmisměrky a jiná luštění @ http://aleph.nkp.cz/F/?func=find-b&request=000770828&find_code=SYS&local_base=nkc
1999 @ 11 @ 15 @ Lidovky. Švédské a jiné křížovky za lidovou cenu @ http://aleph.nkp.cz/F/?func=find-b&request=000772628&find_code=SYS&local_base=nkc
1999 @ 11 @ 16 @ Lubenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000770176&find_code=SYS&local_base=nkc
1999 @ 11 @ 17 @ Luštění @ http://aleph.nkp.cz/F/?func=find-b&request=000770151&find_code=SYS&local_base=nkc
1999 @ 11 @ 18 @ Magazín Zlín @ http://aleph.nkp.cz/F/?func=find-b&request=000771980&find_code=SYS&local_base=nkc
1999 @ 11 @ 19 @ Meziměstský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000770339&find_code=SYS&local_base=nkc
1999 @ 11 @ 20 @ Murphyho osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=000772632&find_code=SYS&local_base=nkc
1999 @ 11 @ 21 @ Naše Zlínsko. Týdeník pro okres Zlín @ http://aleph.nkp.cz/F/?func=find-b&request=000771061&find_code=SYS&local_base=nkc
1999 @ 11 @ 22 @ Nedělní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000772655&find_code=SYS&local_base=nkc
1999 @ 11 @ 23 @ Nové Bratrské Listy @ http://aleph.nkp.cz/F/?func=find-b&request=000770281&find_code=SYS&local_base=nkc
1999 @ 11 @ 24 @ Noviny Prahy 2 @ http://aleph.nkp.cz/F/?func=find-b&request=000770830&find_code=SYS&local_base=nkc
1999 @ 11 @ 25 @ Podnikání v praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000772111&find_code=SYS&local_base=nkc
1999 @ 11 @ 26 @ Podnikatel(ka) - manažer(ka). List o podnikání @ http://aleph.nkp.cz/F/?func=find-b&request=000771044&find_code=SYS&local_base=nkc
1999 @ 11 @ 27 @ Právní zpravodaj. Časopis pro právo a podnikání @ http://aleph.nkp.cz/F/?func=find-b&request=000772074&find_code=SYS&local_base=nkc
1999 @ 11 @ 28 @ Příroda a člověk @ http://aleph.nkp.cz/F/?func=find-b&request=000772398&find_code=SYS&local_base=nkc
1999 @ 11 @ 29 @ Radniční list. Měsíčník města Prachatice @ http://aleph.nkp.cz/F/?func=find-b&request=000772399&find_code=SYS&local_base=nkc
1999 @ 11 @ 30 @ Radniční zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000772682&find_code=SYS&local_base=nkc
1999 @ 11 @ 31 @ Regionální zpravodaj severní Moravy a Slezka @ http://aleph.nkp.cz/F/?func=find-b&request=000771010&find_code=SYS&local_base=nkc
1999 @ 11 @ 32 @ Ráj křížovek @ http://aleph.nkp.cz/F/?func=find-b&request=000771081&find_code=SYS&local_base=nkc
1999 @ 11 @ 33 @ Rudolfinum bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=000771988&find_code=SYS&local_base=nkc
1999 @ 11 @ 34 @ SDA info. Informační bulletin Sociologického datového archívu @ http://aleph.nkp.cz/F/?func=find-b&request=000771023&find_code=SYS&local_base=nkc
1999 @ 11 @ 35 @ Senior. Přítel@ společník a rádce dříve narozených', 'http://aleph.nkp.cz/F/?func=find-b&request=000772673&find_code=SYS&local_base=nkc
1999 @ 11 @ 36 @ Sportotéka. Měsíčník pro sběratele a příznivce sportu @ http://aleph.nkp.cz/F/?func=find-b&request=000771016&find_code=SYS&local_base=nkc
1999 @ 11 @ 37 @ Stehelčeveský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000770329&find_code=SYS&local_base=nkc
1999 @ 11 @ 38 @ Super komiks @ http://aleph.nkp.cz/F/?func=find-b&request=000770267&find_code=SYS&local_base=nkc
1999 @ 11 @ 39 @ Švédské křížovky luxusní @ http://aleph.nkp.cz/F/?func=find-b&request=000771073&find_code=SYS&local_base=nkc
1999 @ 11 @ 40 @ TV plus @ http://aleph.nkp.cz/F/?func=find-b&request=000772080&find_code=SYS&local_base=nkc
1999 @ 11 @ 41 @ V!P financial service. Odborný časopis pro management @ http://aleph.nkp.cz/F/?func=find-b&request=000772106&find_code=SYS&local_base=nkc
1999 @ 11 @ 42 @ Vodárenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000772084&find_code=SYS&local_base=nkc
1999 @ 11 @ 43 @ Volareza news. List Vojenských lázeňských a rekreačních zařízení @ http://aleph.nkp.cz/F/?func=find-b&request=000772026&find_code=SYS&local_base=nkc
1999 @ 11 @ 44 @ Zpravodaj janovské radnice @ http://aleph.nkp.cz/F/?func=find-b&request=000772401&find_code=SYS&local_base=nkc
1999 @ 11 @ 45 @ Zpravodaj obce Polnička @ http://aleph.nkp.cz/F/?func=find-b&request=000772403&find_code=SYS&local_base=nkc
1999 @ 11 @ 46 @ Zpravodaj SIS @ http://aleph.nkp.cz/F/?func=find-b&request=000772638&find_code=SYS&local_base=nkc
1999 @ 12 @ 01 @ Ahoj Budějovice. Měsíčník pro celou rodinu @ http://aleph.nkp.cz/F/?func=find-b&request=000783071&find_code=SYS&local_base=nkc
1999 @ 12 @ 02 @ Burza práce volných míst @ http://aleph.nkp.cz/F/?func=find-b&request=000783163&find_code=SYS&local_base=nkc
1999 @ 12 @ 03 @ Construction journal @ http://aleph.nkp.cz/F/?func=find-b&request=000782816&find_code=SYS&local_base=nkc
1999 @ 12 @ 04 @ Čerstvý vítr. Občasník Sdružení podnikatelů v Novém Strašecí @ http://aleph.nkp.cz/F/?func=find-b&request=000782892&find_code=SYS&local_base=nkc
1999 @ 12 @ 05 @ Fondy a vy. Časopis Spořitelní investiční společnosti @ http://aleph.nkp.cz/F/?func=find-b&request=000783052&find_code=SYS&local_base=nkc
1999 @ 12 @ 06 @ Gayčko. Společenský magazín Gay kontaktu a Soho revue @ http://aleph.nkp.cz/F/?func=find-b&request=000782027&find_code=SYS&local_base=nkc
1999 @ 12 @ 07 @ HR forum. Časopis České společnosti pro rozvoj lidských zdrojů @ http://aleph.nkp.cz/F/?func=find-b&request=000783162&find_code=SYS&local_base=nkc
1999 @ 12 @ 08 @ Info zpravodaj Karlovarsko @ http://aleph.nkp.cz/F/?func=find-b&request=000773049&find_code=SYS&local_base=nkc
1999 @ 12 @ 09 @ Interna. Časopis pro interní lékaře @ http://aleph.nkp.cz/F/?func=find-b&request=000782895&find_code=SYS&local_base=nkc
1999 @ 12 @ 10 @ JPZ. Jablonecký podnikatelský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000783079&find_code=SYS&local_base=nkc
1999 @ 12 @ 11 @ Kobyláček @ http://aleph.nkp.cz/F/?func=find-b&request=000783087&find_code=SYS&local_base=nkc
1999 @ 12 @ 12 @ Kutnohorsko. Vlastivědný sborník @ http://aleph.nkp.cz/F/?func=find-b&request=000782918&find_code=SYS&local_base=nkc
1999 @ 12 @ 13 @ Mercedes. Magazín pro lidi v pohybu @ http://aleph.nkp.cz/F/?func=find-b&request=000783064&find_code=SYS&local_base=nkc
1999 @ 12 @ 14 @ Minerální suroviny @ http://aleph.nkp.cz/F/?func=find-b&request=000773222&find_code=SYS&local_base=nkc
1999 @ 12 @ 15 @ Noviny Prachovice @ http://aleph.nkp.cz/F/?func=find-b&request=000782811&find_code=SYS&local_base=nkc
1999 @ 12 @ 16 @ Obecní listy. Informační bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=000782888&find_code=SYS&local_base=nkc
1999 @ 12 @ 17 @ Ocelové konstrukce. Časopis pro vědu@ techniku a strategii', 'http://aleph.nkp.cz/F/?func=find-b&request=000773050&find_code=SYS&local_base=nkc
1999 @ 12 @ 18 @ Ošetřovatelství. Teorie a praxe moderního ošetřovatelství @ http://aleph.nkp.cz/F/?func=find-b&request=000773223&find_code=SYS&local_base=nkc
1999 @ 12 @ 19 @ Patron bez hranic @ http://aleph.nkp.cz/F/?func=find-b&request=000782879&find_code=SYS&local_base=nkc
1999 @ 12 @ 20 @ Praque a faire. Magazine @ http://aleph.nkp.cz/F/?func=find-b&request=000783153&find_code=SYS&local_base=nkc
1999 @ 12 @ 21 @ Prague affair. Magazine and city guide @ http://aleph.nkp.cz/F/?func=find-b&request=000783155&find_code=SYS&local_base=nkc
1999 @ 12 @ 22 @ Rýmařovský horizont @ http://aleph.nkp.cz/F/?func=find-b&request=000783161&find_code=SYS&local_base=nkc
1999 @ 12 @ 23 @ Sanquis. Originale sanguinis vestri @ http://aleph.nkp.cz/F/?func=find-b&request=000783130&find_code=SYS&local_base=nkc
1999 @ 12 @ 24 @ Soudce. Profesní časopis soudců a soudů ČR @ http://aleph.nkp.cz/F/?func=find-b&request=000783160&find_code=SYS&local_base=nkc
1999 @ 12 @ 25 @ Stavební žurnál @ http://aleph.nkp.cz/F/?func=find-b&request=000783096&find_code=SYS&local_base=nkc
1999 @ 12 @ 26 @ Svět magie @ http://aleph.nkp.cz/F/?func=find-b&request=000783090&find_code=SYS&local_base=nkc
1999 @ 12 @ 27 @ Svět švédských křížovek @ http://aleph.nkp.cz/F/?func=find-b&request=000783137&find_code=SYS&local_base=nkc
1999 @ 12 @ 28 @ Top art foto @ http://aleph.nkp.cz/F/?func=find-b&request=000782915&find_code=SYS&local_base=nkc
1999 @ 12 @ 29 @ VW svět. Časopis všech příznivců vozů Volkswagen @ http://aleph.nkp.cz/F/?func=find-b&request=000783075&find_code=SYS&local_base=nkc
1999 @ 12 @ 30 @ Zpravodaj obce Chelčice @ http://aleph.nkp.cz/F/?func=find-b&request=000783131&find_code=SYS&local_base=nkc
1999 @ 12 @ 31 @ Zpravodaj odrůdového zkušebnictví @ http://aleph.nkp.cz/F/?func=find-b&request=000782893&find_code=SYS&local_base=nkc
1999 @ 12 @ 32 @ Zpravodaj Severu. Informační čtvrtletník pro členy SBD Sever @ http://aleph.nkp.cz/F/?func=find-b&request=000782889&find_code=SYS&local_base=nkc
2000 @ 01 @ 27 @ Sadské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=00786100&find_code=SYS&local_base=nkc
2000 @ 01 @ 28 @ Svět balení @ http://aleph.nkp.cz/F/?func=find-b&request=00786018&find_code=SYS&local_base=nkc
2000 @ 01 @ 29 @ Výherní křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=00786264&find_code=SYS&local_base=nkc
2000 @ 01 @ 30 @ Výherní levné recepty @ http://aleph.nkp.cz/F/?func=find-b&request=00786180&find_code=SYS&local_base=nkc
2000 @ 01 @ 31 @ Zemědělec. Jeden týdeník pro všechny zemědělce  @ http://aleph.nkp.cz/F/?func=find-b&request=00785892&find_code=SYS&local_base=nkc
2000 @ 03 @ 01 @ A sex @ http://aleph.nkp.cz/F/?func=find-b&request=00926239&find_code=SYS&local_base=nkc
2000 @ 03 @ 02 @ Autohit @ http://aleph.nkp.cz/F/?func=find-b&request=00926098&find_code=SYS&local_base=nkc
2000 @ 03 @ 03 @ Delovaja Praga @ http://aleph.nkp.cz/F/?func=find-b&request=00926093&find_code=SYS&local_base=nkc
2000 @ 03 @ 04 @ Ekonomické zpravodajství ze zemí SNS @ http://aleph.nkp.cz/F/?func=find-b&request=00926090&find_code=SYS&local_base=nkc
2000 @ 03 @ 05 @ Foto román @ http://aleph.nkp.cz/F/?func=find-b&request=00928073&find_code=SYS&local_base=nkc
2000 @ 03 @ 06 @ Hleďsebský kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=00926200&find_code=SYS&local_base=nkc
2000 @ 03 @ 07 @ Integrace. Časopis pro evropská studia... @ http://aleph.nkp.cz/F/?func=find-b&request=00927119&find_code=SYS&local_base=nkc
2000 @ 03 @ 08 @ Jak bydlet. Průvodce světem bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=00926256&find_code=SYS&local_base=nkc
2000 @ 03 @ 09 @ K-report. Časopis příznivců kolejové dopravy @ http://aleph.nkp.cz/F/?func=find-b&request=00928525&find_code=SYS&local_base=nkc
2000 @ 03 @ 10 @ Keramik. Časopis pro design a umění @ http://aleph.nkp.cz/F/?func=find-b&request=00926250&find_code=SYS&local_base=nkc
2000 @ 03 @ 11 @ Now. Měsíčník pro krizové řízení a... @ http://aleph.nkp.cz/F/?func=find-b&request=00928523&find_code=SYS&local_base=nkc
2000 @ 03 @ 12 @ Otázky a odpovědi z praxe. Měsíčník dotazů a odpovědí z oblasti daní a účetnictví @ http://aleph.nkp.cz/F/?func=find-b&request=00926069&find_code=SYS&local_base=nkc
2000 @ 03 @ 13 @ Praktický poradce v daňových otázkách. Časopis daňových a účetních aktualit... @ http://aleph.nkp.cz/F/?func=find-b&request=00925632&find_code=SYS&local_base=nkc
2000 @ 03 @ 14 @ Přítomnost. Měsíčník pro politiku a kulturu @ http://aleph.nkp.cz/F/?func=find-b&request=00928548&find_code=SYS&local_base=nkc
2000 @ 03 @ 15 @ Svět kuchyně @ http://aleph.nkp.cz/F/?func=find-b&request=00926434&find_code=SYS&local_base=nkc
2000 @ 03 @ 16 @ Účetnictví. Daně a právo v zemědělství @ http://aleph.nkp.cz/F/?func=find-b&request=00928095&find_code=SYS&local_base=nkc
2000 @ 03 @ 17 @ Veselé křížovky na cestu @ http://aleph.nkp.cz/F/?func=find-b&request=00925626&find_code=SYS&local_base=nkc
2000 @ 04 @ 01 @ Banky et finance @ http://aleph.nkp.cz/F/?func=find-b&request=00960447&find_code=SYS&local_base=nkc
2000 @ 04 @ 02 @ Baťa magazín @ http://aleph.nkp.cz/F/?func=find-b&request=00960043&find_code=SYS&local_base=nkc
2000 @ 04 @ 03 @ Březovické zprávičky @ http://aleph.nkp.cz/F/?func=find-b&request=00960870&find_code=SYS&local_base=nkc
2000 @ 04 @ 04 @ Capital 2D @ http://aleph.nkp.cz/F/?func=find-b&request=00959612&find_code=SYS&local_base=nkc
2000 @ 04 @ 05 @ České pracovní lékařství @ http://aleph.nkp.cz/F/?func=find-b&request=00960342&find_code=SYS&local_base=nkc
2000 @ 04 @ 06 @ Daňová judikatura @ http://aleph.nkp.cz/F/?func=find-b&request=00960468&find_code=SYS&local_base=nkc
2000 @ 04 @ 07 @ DPH. Revue o dani z přidané hodnoty @ http://aleph.nkp.cz/F/?func=find-b&request=00960470&find_code=SYS&local_base=nkc
2000 @ 04 @ 08 @ Jóga v denní životě @ http://aleph.nkp.cz/F/?func=find-b&request=00959624&find_code=SYS&local_base=nkc
2000 @ 04 @ 09 @ Justitia bulletin. První odborný časopis o veřejných zakázkách @ http://aleph.nkp.cz/F/?func=find-b&request=00960455&find_code=SYS&local_base=nkc
2000 @ 04 @ 10 @ Krimi křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=00959627&find_code=SYS&local_base=nkc
2000 @ 04 @ 11 @ Love me. Věčné téma láska @ http://aleph.nkp.cz/F/?func=find-b&request=00960866&find_code=SYS&local_base=nkc
2000 @ 04 @ 12 @ Největší malíři. Život@ inspirace a dílo', 'http://aleph.nkp.cz/F/?func=find-b&request=00960353&find_code=SYS&local_base=nkc
2000 @ 04 @ 13 @ OK sport! @ http://aleph.nkp.cz/F/?func=find-b&request=00960473&find_code=SYS&local_base=nkc
2000 @ 04 @ 14 @ Panta rhei. Hardcore magazín @ http://aleph.nkp.cz/F/?func=find-b&request=00960376&find_code=SYS&local_base=nkc
2000 @ 04 @ 15 @ Pečecké noviny @ http://aleph.nkp.cz/F/?func=find-b&request=00960071&find_code=SYS&local_base=nkc
2000 @ 04 @ 16 @ Pražské listy @ http://aleph.nkp.cz/F/?func=find-b&request=00960075&find_code=SYS&local_base=nkc
2000 @ 04 @ 17 @ Premiere. Nejprodávanější filmový časopis na světě @ http://aleph.nkp.cz/F/?func=find-b&request=00960383&find_code=SYS&local_base=nkc
2000 @ 04 @ 18 @ Pro formula. Magazín o světě F1 @ http://aleph.nkp.cz/F/?func=find-b&request=00960472&find_code=SYS&local_base=nkc
2000 @ 04 @ 19 @ Ráj osmisměrek @ http://aleph.nkp.cz/F/?func=find-b&request=00960230&find_code=SYS&local_base=nkc
2000 @ 04 @ 20 @ Rally @ http://aleph.nkp.cz/F/?func=find-b&request=00960027&find_code=SYS&local_base=nkc
2000 @ 04 @ 21 @ Sbírka mezinárodních smluv @ http://aleph.nkp.cz/F/?func=find-b&request=00960440&find_code=SYS&local_base=nkc
2000 @ 04 @ 22 @ Svět koupelen @ http://aleph.nkp.cz/F/?func=find-b&request=00960219&find_code=SYS&local_base=nkc
2000 @ 04 @ 23 @ Švédské křížovky ty pravé @ http://aleph.nkp.cz/F/?func=find-b&request=00960231&find_code=SYS&local_base=nkc
2000 @ 04 @ 24 @ Tachovgraf @ http://aleph.nkp.cz/F/?func=find-b&request=00959630&find_code=SYS&local_base=nkc
2000 @ 04 @ 25 @ Tip týden @ http://aleph.nkp.cz/F/?func=find-b&request=00960082&find_code=SYS&local_base=nkc
2000 @ 04 @ 26 @ Top class. Magazín pro horních deset tisíc @ http://aleph.nkp.cz/F/?func=find-b&request=00960201&find_code=SYS&local_base=nkc
2000 @ 04 @ 27 @ Total film @ http://aleph.nkp.cz/F/?func=find-b&request=00960311&find_code=SYS&local_base=nkc
2000 @ 04 @ 28 @ Tripmag @ http://aleph.nkp.cz/F/?func=find-b&request=00960923&find_code=SYS&local_base=nkc
2000 @ 04 @ 29 @ Týdeník Přerovsko @ http://aleph.nkp.cz/F/?func=find-b&request=00960459&find_code=SYS&local_base=nkc
2000 @ 04 @ 30 @ Vratislavický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00959887&find_code=SYS&local_base=nkc
2000 @ 04 @ 31 @ Zlatá kniha receptů a luštění @ http://aleph.nkp.cz/F/?func=find-b&request=00960367&find_code=SYS&local_base=nkc
2000 @ 04 @ 32 @ Zpravodaj (obec Herálec) @ http://aleph.nkp.cz/F/?func=find-b&request=00960565&find_code=SYS&local_base=nkc
2000 @ 04 @ 33 @ Zpravodaj obce Metylovice @ http://aleph.nkp.cz/F/?func=find-b&request=00960337&find_code=SYS&local_base=nkc
2000 @ 04 @ 34 @ Zpravodaj obce Tasovice @ http://aleph.nkp.cz/F/?func=find-b&request=00959864&find_code=SYS&local_base=nkc
2000 @ 04 @ 35 @ Zručské nové. Nezávislý měsíčník pro Zruč nad Sázavou a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=00960405&find_code=SYS&local_base=nkc
2000 @ 05 @ 01 @ Aktuality cestovního ruchu @ http://aleph.nkp.cz/F/?func=find-b&request=00963565&find_code=SYS&local_base=nkc
2000 @ 05 @ 02 @ Autohit speciál @ http://aleph.nkp.cz/F/?func=find-b&request=00965583&find_code=SYS&local_base=nkc
2000 @ 05 @ 03 @ Bike sport @ http://aleph.nkp.cz/F/?func=find-b&request=00964931&find_code=SYS&local_base=nkc
2000 @ 05 @ 04 @ Budišovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00965152&find_code=SYS&local_base=nkc
2000 @ 05 @ 05 @ Bydlíme s květinami @ http://aleph.nkp.cz/F/?func=find-b&request=00965209&find_code=SYS&local_base=nkc
2000 @ 05 @ 06 @ C + N aktuality. Samostatná příloha Cenových zpráv ÚRS @ http://aleph.nkp.cz/F/?func=find-b&request=00964639&find_code=SYS&local_base=nkc
2000 @ 05 @ 07 @ Cenové zprávy @ http://aleph.nkp.cz/F/?func=find-b&request=00964703&find_code=SYS&local_base=nkc
2000 @ 05 @ 08 @ Cestovní ruch. Zpravodaj České centrály cestovního ruchu @ http://aleph.nkp.cz/F/?func=find-b&request=00965231&find_code=SYS&local_base=nkc
2000 @ 05 @ 09 @ Collector. Inzertní časopis pro sběratele různých zájmových oborů @ http://aleph.nkp.cz/F/?func=find-b&request=00964772&find_code=SYS&local_base=nkc
2000 @ 05 @ 10 @ Convergence. Globálně o komunikacích @ http://aleph.nkp.cz/F/?func=find-b&request=00960789&find_code=SYS&local_base=nkc
2000 @ 05 @ 11 @ Cosmogirl! @ http://aleph.nkp.cz/F/?func=find-b&request=00964986&find_code=SYS&local_base=nkc
2000 @ 05 @ 12 @ ČD Cargo. Bulletin nákladní přepravy Českých drah @ http://aleph.nkp.cz/F/?func=find-b&request=00965558&find_code=SYS&local_base=nkc
2000 @ 05 @ 13 @ Český golfista @ http://aleph.nkp.cz/F/?func=find-b&request=00964698&find_code=SYS&local_base=nkc
2000 @ 05 @ 14 @ Český telecom @ http://aleph.nkp.cz/F/?func=find-b&request=00963655&find_code=SYS&local_base=nkc
2000 @ 05 @ 15 @ Dobrnský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00961192&find_code=SYS&local_base=nkc
2000 @ 05 @ 16 @ Dolce vita @ http://aleph.nkp.cz/F/?func=find-b&request=00965567&find_code=SYS&local_base=nkc
2000 @ 05 @ 17 @ Dražický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=00965149&find_code=SYS&local_base=nkc
2000 @ 05 @ 18 @ Dubský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00964397&find_code=SYS&local_base=nkc
2000 @ 05 @ 19 @ Easy English @ http://aleph.nkp.cz/F/?func=find-b&request=00964718&find_code=SYS&local_base=nkc
2000 @ 05 @ 20 @ Forest magazín @ http://aleph.nkp.cz/F/?func=find-b&request=00963501&find_code=SYS&local_base=nkc
2000 @ 05 @ 21 @ Helvíkovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00964403&find_code=SYS&local_base=nkc
2000 @ 05 @ 22 @ Informační servis GAS @ http://aleph.nkp.cz/F/?func=find-b&request=00964537&find_code=SYS&local_base=nkc
2000 @ 05 @ 23 @ Kim. Křesťanský informační magazín @ http://aleph.nkp.cz/F/?func=find-b&request=00965205&find_code=SYS&local_base=nkc
2000 @ 05 @ 24 @ Kojické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=00965130&find_code=SYS&local_base=nkc
2000 @ 05 @ 25 @ Koktejl trip @ http://aleph.nkp.cz/F/?func=find-b&request=00964569&find_code=SYS&local_base=nkc
2000 @ 05 @ 26 @ Komárovák. Měsíční zpravodaj obce Komárov @ http://aleph.nkp.cz/F/?func=find-b&request=00965603&find_code=SYS&local_base=nkc
2000 @ 05 @ 27 @ Krajánek. Trutnovsko@ Náchodsko, Jičínsko...', 'http://aleph.nkp.cz/F/?func=find-b&request=00965253&find_code=SYS&local_base=nkc
2000 @ 05 @ 28 @ Lanškrounský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00965139&find_code=SYS&local_base=nkc
2000 @ 05 @ 29 @ Magazín. Měsíčník zaměstnanců finanční skupiny ČSOB @ http://aleph.nkp.cz/F/?func=find-b&request=00963596&find_code=SYS&local_base=nkc
2000 @ 05 @ 30 @ Nemocniční listy @ http://aleph.nkp.cz/F/?func=find-b&request=00965289&find_code=SYS&local_base=nkc
2000 @ 05 @ 31 @ Noviny města Třebíče @ http://aleph.nkp.cz/F/?func=find-b&request=00964474&find_code=SYS&local_base=nkc
2000 @ 05 @ 32 @ Obecné@ výchozí ceny a koeficienty prodejnosti ojetých motorových vozidel ČR', 'http://aleph.nkp.cz/F/?func=find-b&request=00965454&find_code=SYS&local_base=nkc
2000 @ 05 @ 33 @ Osmisměrky Relax @ http://aleph.nkp.cz/F/?func=find-b&request=00963678&find_code=SYS&local_base=nkc
2000 @ 05 @ 34 @ Pá. Spousta legrace@ zábavy a ...', 'http://aleph.nkp.cz/F/?func=find-b&request=00964299&find_code=SYS&local_base=nkc
2000 @ 05 @ 35 @ Princip. Týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=00963981&find_code=SYS&local_base=nkc
2000 @ 05 @ 36 @ Quintessenz. Paradontologie @ http://aleph.nkp.cz/F/?func=find-b&request=00964395&find_code=SYS&local_base=nkc
2000 @ 05 @ 37 @ Raketové noviny @ http://aleph.nkp.cz/F/?func=find-b&request=00964233&find_code=SYS&local_base=nkc
2000 @ 05 @ 38 @ Rokytenské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=00964235&find_code=SYS&local_base=nkc
2000 @ 05 @ 39 @ Soul. Aggresive in-line magazine @ http://aleph.nkp.cz/F/?func=find-b&request=00965576&find_code=SYS&local_base=nkc
2000 @ 05 @ 40 @ Svět rozhlasu @ http://aleph.nkp.cz/F/?func=find-b&request=00965061&find_code=SYS&local_base=nkc
2000 @ 05 @ 41 @ Transfuze dnes. Časopis společnosti pro transfuzní lékařství @ http://aleph.nkp.cz/F/?func=find-b&request=00964953&find_code=SYS&local_base=nkc
2000 @ 05 @ 42 @ Výzva pro deset milionů @ http://aleph.nkp.cz/F/?func=find-b&request=00964274&find_code=SYS&local_base=nkc
2000 @ 05 @ 43 @ Zpravodaj. Informační leták obecního zastupitelstva obce Klabava @ http://aleph.nkp.cz/F/?func=find-b&request=00964359&find_code=SYS&local_base=nkc
2000 @ 05 @ 44 @ Zpravodaj Českého úřadu bezpečnosti práce @ http://aleph.nkp.cz/F/?func=find-b&request=00965202&find_code=SYS&local_base=nkc
2000 @ 05 @ 45 @ Zpravodaj fy DETOA Albrechtice@ s.r.o.', 'http://aleph.nkp.cz/F/?func=find-b&request=00965461&find_code=SYS&local_base=nkc
2000 @ 05 @ 46 @ Zpravodaj obce Kněžmost @ http://aleph.nkp.cz/F/?func=find-b&request=00964172&find_code=SYS&local_base=nkc
2000 @ 05 @ 47 @ Zpravodaj Rychnovska @ http://aleph.nkp.cz/F/?func=find-b&request=00965072&find_code=SYS&local_base=nkc
2000 @ 05 @ 48 @ Zrní @ http://aleph.nkp.cz/F/?func=find-b&request=00965520&find_code=SYS&local_base=nkc
2000 @ 05 @ 49 @ Železňák. Informační občasník obecního úřadu v Železné @ http://aleph.nkp.cz/F/?func=find-b&request=00963788&find_code=SYS&local_base=nkc
2000 @ 06 @ 01 @ Acta medica (Hradec Králové) @ http://aleph.nkp.cz/F/?func=find-b&request=00968309&find_code=SYS&local_base=nkc
2000 @ 06 @ 02 @ Agro navigátor. Signální informace ze světa zemědělství a potravinářství @ http://aleph.nkp.cz/F/?func=find-b&request=00968272&find_code=SYS&local_base=nkc
2000 @ 06 @ 03 @ Alternativy. Časopis pro politiku@ vědu a kulturu', 'http://aleph.nkp.cz/F/?func=find-b&request=00967934&find_code=SYS&local_base=nkc
2000 @ 06 @ 04 @ Anténa. Zpravodaj českého vysílání TWR @ http://aleph.nkp.cz/F/?func=find-b&request=00967845&find_code=SYS&local_base=nkc
2000 @ 06 @ 05 @ Archivní zpravodaj. Čtvrtletník Státního okresního archivu... @ http://aleph.nkp.cz/F/?func=find-b&request=00968071&find_code=SYS&local_base=nkc
2000 @ 06 @ 06 @ Arnika. Časopis českých homeopatů @ http://aleph.nkp.cz/F/?func=find-b&request=00968141&find_code=SYS&local_base=nkc
2000 @ 06 @ 07 @ Bonsai. Časopis pro milovníky přírody a bonsají @ http://aleph.nkp.cz/F/?func=find-b&request=00967646&find_code=SYS&local_base=nkc
2000 @ 06 @ 08 @ Bukováček. Občasník Obecního úřadu Velká Buková @ http://aleph.nkp.cz/F/?func=find-b&request=00967842&find_code=SYS&local_base=nkc
2000 @ 06 @ 09 @ CD-Romek @ http://aleph.nkp.cz/F/?func=find-b&request=00968470&find_code=SYS&local_base=nkc
2000 @ 06 @ 10 @ Dárce @ http://aleph.nkp.cz/F/?func=find-b&request=00967807&find_code=SYS&local_base=nkc
2000 @ 06 @ 11 @ Dublovický bubeník @ http://aleph.nkp.cz/F/?func=find-b&request=00968196&find_code=SYS&local_base=nkc
2000 @ 06 @ 12 @ e-biz. Nová ekonomika@ nové příležitosti', 'http://aleph.nkp.cz/F/?func=find-b&request=00968405&find_code=SYS&local_base=nkc
2000 @ 06 @ 13 @ Energie & Peníze @ http://aleph.nkp.cz/F/?func=find-b&request=00967774&find_code=SYS&local_base=nkc
2000 @ 06 @ 14 @ F1 Racing @ http://aleph.nkp.cz/F/?func=find-b&request=00968655&find_code=SYS&local_base=nkc
2000 @ 06 @ 15 @ Fit for fun. Velký magazín pro ženy i muže @ http://aleph.nkp.cz/F/?func=find-b&request=00967734&find_code=SYS&local_base=nkc
2000 @ 06 @ 16 @ Ftipné osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=00968635&find_code=SYS&local_base=nkc
2000 @ 06 @ 17 @ Hezké luštění @ http://aleph.nkp.cz/F/?func=find-b&request=00968628&find_code=SYS&local_base=nkc
2000 @ 06 @ 18 @ Hodinové osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=00968638&find_code=SYS&local_base=nkc
2000 @ 06 @ 19 @ Holoubkovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00968673&find_code=SYS&local_base=nkc
2000 @ 06 @ 20 @ Informační servis ČSTZ @ http://aleph.nkp.cz/F/?func=find-b&request=00968413&find_code=SYS&local_base=nkc
2000 @ 06 @ 21 @ Inzert. Noviny pro soukromou bezplatnou inzerci @ http://aleph.nkp.cz/F/?func=find-b&request=00968014&find_code=SYS&local_base=nkc
2000 @ 06 @ 22 @ Inzertin. Soukromá inzerce zdarma @ http://aleph.nkp.cz/F/?func=find-b&request=00968288&find_code=SYS&local_base=nkc
2000 @ 06 @ 23 @ Janovský kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=00967959&find_code=SYS&local_base=nkc
2000 @ 06 @ 24 @ Jevíčské listy @ http://aleph.nkp.cz/F/?func=find-b&request=00968028&find_code=SYS&local_base=nkc
2000 @ 06 @ 25 @ Křížovky. Po vlastech českých a moravských @ http://aleph.nkp.cz/F/?func=find-b&request=00968398&find_code=SYS&local_base=nkc
2000 @ 06 @ 26 @ Kuriozity v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=00968642&find_code=SYS&local_base=nkc
2000 @ 06 @ 27 @ Léky bez receptu @ http://aleph.nkp.cz/F/?func=find-b&request=00968687&find_code=SYS&local_base=nkc
2000 @ 06 @ 28 @ Lidovky. Osmisměrky za lidovou cenu @ http://aleph.nkp.cz/F/?func=find-b&request=00968641&find_code=SYS&local_base=nkc
2000 @ 06 @ 29 @ Luštění pro všechny @ http://aleph.nkp.cz/F/?func=find-b&request=00968632&find_code=SYS&local_base=nkc
2000 @ 06 @ 30 @ Luštění za babku @ http://aleph.nkp.cz/F/?func=find-b&request=00968608&find_code=SYS&local_base=nkc
2000 @ 06 @ 31 @ Magie osmisměrek @ http://aleph.nkp.cz/F/?func=find-b&request=00968640&find_code=SYS&local_base=nkc
2000 @ 06 @ 32 @ Medicína po promoci. Časopis postgraduálního vzdělávání lékařů @ http://aleph.nkp.cz/F/?func=find-b&request=00968147&find_code=SYS&local_base=nkc
2000 @ 06 @ 33 @ Městské noviny. Informační list pro občany města Ústí nad Labem @ http://aleph.nkp.cz/F/?func=find-b&request=00968603&find_code=SYS&local_base=nkc
2000 @ 06 @ 34 @ Motýloviny @ http://aleph.nkp.cz/F/?func=find-b&request=00967897&find_code=SYS&local_base=nkc
2000 @ 06 @ 35 @ Národní politika. Politicko-kulturní měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=00967964&find_code=SYS&local_base=nkc
2000 @ 06 @ 36 @ Naše listy @ http://aleph.nkp.cz/F/?func=find-b&request=00968415&find_code=SYS&local_base=nkc
2000 @ 06 @ 37 @ Nemetschek enter @ http://aleph.nkp.cz/F/?func=find-b&request=00968456&find_code=SYS&local_base=nkc
2000 @ 06 @ 38 @ Nezištník. Dvouměsíčník pro nevládní neziskové ... @ http://aleph.nkp.cz/F/?func=find-b&request=00967847&find_code=SYS&local_base=nkc
2000 @ 06 @ 39 @ Pediatrie pro praxi @ http://aleph.nkp.cz/F/?func=find-b&request=00968697&find_code=SYS&local_base=nkc
2000 @ 06 @ 40 @ Prague Carrousel @ http://aleph.nkp.cz/F/?func=find-b&request=00968524&find_code=SYS&local_base=nkc
2000 @ 06 @ 41 @ Středočeský magazín. Časopis moderní rodiny pro Prahu a střední Čechy @ http://aleph.nkp.cz/F/?func=find-b&request=00968350&find_code=SYS&local_base=nkc
2000 @ 06 @ 42 @ Stříbrný kruh. Zpravodaj o prevenci kriminality na ... @ http://aleph.nkp.cz/F/?func=find-b&request=00967937&find_code=SYS&local_base=nkc
2000 @ 06 @ 43 @ Svět kuchyní. Čtvrtletník moderního bytu @ http://aleph.nkp.cz/F/?func=find-b&request=00967963&find_code=SYS&local_base=nkc
2000 @ 06 @ 44 @ Svět luštění @ http://aleph.nkp.cz/F/?func=find-b&request=00968666&find_code=SYS&local_base=nkc
2000 @ 06 @ 45 @ Světelské listy. Obecní informační občasník @ http://aleph.nkp.cz/F/?func=find-b&request=00968337&find_code=SYS&local_base=nkc
2000 @ 06 @ 46 @ Tempo. Týdenní nabídky realit a stavebnictví @ http://aleph.nkp.cz/F/?func=find-b&request=00968341&find_code=SYS&local_base=nkc
2000 @ 06 @ 47 @ XXL. Velké osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=00968668&find_code=SYS&local_base=nkc
2000 @ 06 @ 48 @ Zpravodaj Střední policejní školy MV v Brně @ http://aleph.nkp.cz/F/?func=find-b&request=00968575&find_code=SYS&local_base=nkc
2000 @ 07 @ 01 @ Albert. Magazín pro zákazníky supermarketů Albert @ http://aleph.nkp.cz/F/?func=find-b&request=000970262&find_code=SYS&local_base=nkc
2000 @ 07 @ 02 @ Bohuslávské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000970530&find_code=SYS&local_base=nkc
2000 @ 07 @ 03 @ Buřinkoviny @ http://aleph.nkp.cz/F/?func=find-b&request=000970210&find_code=SYS&local_base=nkc
2000 @ 07 @ 04 @ Caravan a camping. Magazín volného času... @ http://aleph.nkp.cz/F/?func=find-b&request=000970577&find_code=SYS&local_base=nkc
2000 @ 07 @ 05 @ Encyklopedie přírodní medicíny @ http://aleph.nkp.cz/F/?func=find-b&request=000970182&find_code=SYS&local_base=nkc
2000 @ 07 @ 06 @ Folia geobotanica @ http://aleph.nkp.cz/F/?func=find-b&request=000970048&find_code=SYS&local_base=nkc
2000 @ 07 @ 07 @ Horizonty. Pro muže i pro ženy. Společenský inzertní časopis @ http://aleph.nkp.cz/F/?func=find-b&request=000970331&find_code=SYS&local_base=nkc
2000 @ 07 @ 08 @ Hýskováček. Zpravodaj obecního úřadu Hýskov @ http://aleph.nkp.cz/F/?func=find-b&request=000970004&find_code=SYS&local_base=nkc
2000 @ 07 @ 09 @ Informační zparvodaj. Vydává kancelář přednosty okresního úřadu Beroun... @ http://aleph.nkp.cz/F/?func=find-b&request=000970187&find_code=SYS&local_base=nkc
2000 @ 07 @ 10 @ Jistoty. Měsíčník SŽJ @ http://aleph.nkp.cz/F/?func=find-b&request=000970390&find_code=SYS&local_base=nkc
2000 @ 07 @ 11 @ Judikatura Ústavního soudu ČR. Výběr @ http://aleph.nkp.cz/F/?func=find-b&request=000970205&find_code=SYS&local_base=nkc
2000 @ 07 @ 12 @ Jundrov. Informační zpravodaj zastupitelstva... @ http://aleph.nkp.cz/F/?func=find-b&request=000970170&find_code=SYS&local_base=nkc
2000 @ 07 @ 13 @ Libišský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000970546&find_code=SYS&local_base=nkc4
2000 @ 07 @ 14 @ Městské noviny. Vydává město Česká Lípa @ http://aleph.nkp.cz/F/?func=find-b&request=000970533&find_code=SYS&local_base=nkc
2000 @ 07 @ 15 @ Nové bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=000970132&find_code=SYS&local_base=nkc
2000 @ 07 @ 16 @ Noviny AI. Časopis pro lidská práva @ http://aleph.nkp.cz/F/?func=find-b&request=000970014&find_code=SYS&local_base=nkc
2000 @ 07 @ 17 @ Obecní noviny. Nezávislý nebílovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000970502&find_code=SYS&local_base=nkc
2000 @ 07 @ 18 @ Peckoviny. Nezávislý časopis odpůrců@ ale i příznivců letního času', 'http://aleph.nkp.cz/F/?func=find-b&request=000970582&find_code=SYS&local_base=nkc
2000 @ 07 @ 19 @ Petrol magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000970172&find_code=SYS&local_base=nkc
2000 @ 07 @ 20 @ Promi. Dnem i nocí mezi prominenty @ http://aleph.nkp.cz/F/?func=find-b&request=000970463&find_code=SYS&local_base=nkc
2000 @ 07 @ 21 @ Psychiatrie pro praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000969690&find_code=SYS&local_base=nkc
2000 @ 07 @ 22 @ Rekordy v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=000970027&find_code=SYS&local_base=nkc
2000 @ 07 @ 23 @ Scartalóg. Foto kino katalóg @ http://aleph.nkp.cz/F/?func=find-b&request=000970462&find_code=SYS&local_base=nkc
2000 @ 07 @ 24 @ Siesta s křížovkami @ http://aleph.nkp.cz/F/?func=find-b&request=000970176&find_code=SYS&local_base=nkc
2000 @ 07 @ 25 @ Skok do reality. Noviny o české legislativě pro zdravotně postižené @ http://aleph.nkp.cz/F/?func=find-b&request=000969901&find_code=SYS&local_base=nkc
2000 @ 07 @ 26 @ Squash & ricochet & badminton @ http://aleph.nkp.cz/F/?func=find-b&request=000970528&find_code=SYS&local_base=nkc
2000 @ 07 @ 27 @ Tetování @ http://aleph.nkp.cz/F/?func=find-b&request=000969419&find_code=SYS&local_base=nkc
2000 @ 07 @ 28 @ Toužimské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000969980&find_code=SYS&local_base=nkc
2000 @ 07 @ 29 @ Trafikant. Časopis distribuční sítě PNS @ http://aleph.nkp.cz/F/?func=find-b&request=000970204&find_code=SYS&local_base=nkc
2000 @ 07 @ 30 @ Ty pravé osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=000970015&find_code=SYS&local_base=nkc
2000 @ 07 @ 31 @ Výčepní listy. Noviny královského pivovaru Krušovice @ http://aleph.nkp.cz/F/?func=find-b&request=000969916&find_code=SYS&local_base=nkc
2000 @ 07 @ 32 @ Zpravodaj. Obecní úřad Vyškov @ http://aleph.nkp.cz/F/?func=find-b&request=000969993&find_code=SYS&local_base=nkc
2000 @ 07 @ 33 @ Zpravodaj Lipůvky @ http://aleph.nkp.cz/F/?func=find-b&request=000969976&find_code=SYS&local_base=nkc
2000 @ 07 @ 34 @ Zpravodaj Sdružení obcí Metuje @ http://aleph.nkp.cz/F/?func=find-b&request=000969730&find_code=SYS&local_base=nkc
2000 @ 08 @ 01 @ Albert. Magazín pro zákazníky supermarketů Albert @ http://aleph.nkp.cz/F/?func=find-b&request=000970262&find_code=SYS&local_base=nkc
2000 @ 08 @ 02 @ Bohuslávské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000970530&find_code=SYS&local_base=nkc
2000 @ 08 @ 03 @ Buřinkoviny @ http://aleph.nkp.cz/F/?func=find-b&request=000970210&find_code=SYS&local_base=nkc
2000 @ 08 @ 04 @ Caravan a camping. Magazín volného času... @ http://aleph.nkp.cz/F/?func=find-b&request=000970577&find_code=SYS&local_base=nkc
2000 @ 08 @ 05 @ Encyklopedie přírodní medicíny @ http://aleph.nkp.cz/F/?func=find-b&request=000970182&find_code=SYS&local_base=nkc
2000 @ 08 @ 06 @ Folia geobotanica @ http://aleph.nkp.cz/F/?func=find-b&request=000970048&find_code=SYS&local_base=nkc
2000 @ 08 @ 07 @ Horizonty. Pro muže i pro ženy. Společenský inzertní časopis @ http://aleph.nkp.cz/F/?func=find-b&request=000970331&find_code=SYS&local_base=nkc
2000 @ 08 @ 08 @ Hýskováček. Zpravodaj obecního úřadu Hýskov @ http://aleph.nkp.cz/F/?func=find-b&request=000970004&find_code=SYS&local_base=nkc
2000 @ 08 @ 09 @ Informační zparvodaj. Vydává kancelář přednosty okresního úřadu Beroun... @ http://aleph.nkp.cz/F/?func=find-b&request=000970187&find_code=SYS&local_base=nkc
2000 @ 08 @ 10 @ Jistoty. Měsíčník SŽJ @ http://aleph.nkp.cz/F/?func=find-b&request=000970390&find_code=SYS&local_base=nkc
2000 @ 08 @ 11 @ Judikatura Ústavního soudu ČR. Výběr @ http://aleph.nkp.cz/F/?func=find-b&request=000970205&find_code=SYS&local_base=nkc
2000 @ 08 @ 12 @ Jundrov. Informační zpravodaj zastupitelstva... @ http://aleph.nkp.cz/F/?func=find-b&request=000970170&find_code=SYS&local_base=nkc
2000 @ 08 @ 13 @ Libišský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000970546&find_code=SYS&local_base=nkc4
2000 @ 08 @ 14 @ Městské noviny. Vydává město Česká Lípa @ http://aleph.nkp.cz/F/?func=find-b&request=000970533&find_code=SYS&local_base=nkc
2000 @ 08 @ 15 @ Nové bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=000970132&find_code=SYS&local_base=nkc
2000 @ 08 @ 16 @ Noviny AI. Časopis pro lidská práva @ http://aleph.nkp.cz/F/?func=find-b&request=000970014&find_code=SYS&local_base=nkc
2000 @ 08 @ 17 @ Obecní noviny. Nezávislý nebílovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000970502&find_code=SYS&local_base=nkc
2000 @ 08 @ 18 @ Peckoviny. Nezávislý časopis odpůrců@ ale i příznivců letního času', 'http://aleph.nkp.cz/F/?func=find-b&request=000970582&find_code=SYS&local_base=nkc
2000 @ 08 @ 19 @ Petrol magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000970172&find_code=SYS&local_base=nkc
2000 @ 08 @ 20 @ Promi. Dnem i nocí mezi prominenty @ http://aleph.nkp.cz/F/?func=find-b&request=000970463&find_code=SYS&local_base=nkc
2000 @ 08 @ 21 @ Psychiatrie pro praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000969690&find_code=SYS&local_base=nkc
2000 @ 08 @ 22 @ Rekordy v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=000970027&find_code=SYS&local_base=nkc
2000 @ 08 @ 23 @ Scartalóg. Foto kino katalóg @ http://aleph.nkp.cz/F/?func=find-b&request=000970462&find_code=SYS&local_base=nkc
2000 @ 08 @ 24 @ Siesta s křížovkami @ http://aleph.nkp.cz/F/?func=find-b&request=000970176&find_code=SYS&local_base=nkc
2000 @ 08 @ 25 @ Skok do reality. Noviny o české legislativě pro zdravotně postižené @ http://aleph.nkp.cz/F/?func=find-b&request=000969901&find_code=SYS&local_base=nkc
2000 @ 08 @ 26 @ Squash & ricochet & badminton @ http://aleph.nkp.cz/F/?func=find-b&request=000970528&find_code=SYS&local_base=nkc
2000 @ 08 @ 27 @ Tetování @ http://aleph.nkp.cz/F/?func=find-b&request=000969419&find_code=SYS&local_base=nkc
2000 @ 08 @ 28 @ Toužimské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000969980&find_code=SYS&local_base=nkc
2000 @ 08 @ 29 @ Trafikant. Časopis distribuční sítě PNS @ http://aleph.nkp.cz/F/?func=find-b&request=000970204&find_code=SYS&local_base=nkc
2000 @ 08 @ 30 @ Ty pravé osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=000970015&find_code=SYS&local_base=nkc
2000 @ 08 @ 31 @ Výčepní listy. Noviny královského pivovaru Krušovice @ http://aleph.nkp.cz/F/?func=find-b&request=000969916&find_code=SYS&local_base=nkc
2000 @ 08 @ 32 @ Zpravodaj. Obecní úřad Vyškov @ http://aleph.nkp.cz/F/?func=find-b&request=000969993&find_code=SYS&local_base=nkc
2000 @ 08 @ 33 @ Zpravodaj Lipůvky @ http://aleph.nkp.cz/F/?func=find-b&request=000969976&find_code=SYS&local_base=nkc
2000 @ 08 @ 34 @ Zpravodaj Sdružení obcí Metuje @ http://aleph.nkp.cz/F/?func=find-b&request=000969730&find_code=SYS&local_base=nkc
2000 @ 09 @ 01 @ Armáda České republiky dnes @ http://aleph.nkp.cz/F/?func=find-b&request=000973692&find_code=SYS&local_base=nkc
2000 @ 09 @ 02 @ Benefit magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000974543&find_code=SYS&local_base=nkc
2000 @ 09 @ 03 @ Moravská brána. informační věstník pro občany Hranic @ http://aleph.nkp.cz/F/?func=find-b&request=000974669&find_code=SYS&local_base=nkc
2000 @ 09 @ 04 @ Oldřichovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000974608&find_code=SYS&local_base=nkc
2000 @ 09 @ 05 @ Olomoucký týden. Okresní týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=000974519&find_code=SYS&local_base=nkc
2000 @ 09 @ 06 @ Paragliding magazín. Český a slovenský časopis o paraglidingu a létání @ http://aleph.nkp.cz/F/?func=find-b&request=000974631&find_code=SYS&local_base=nkc
2000 @ 09 @ 07 @ Partner @ http://aleph.nkp.cz/F/?func=find-b&request=000974550&find_code=SYS&local_base=nkc
2000 @ 09 @ 08 @ Silnice a mosty @ http://aleph.nkp.cz/F/?func=find-b&request=000974596&find_code=SYS&local_base=nkc
2000 @ 09 @ 09 @ Staroměstský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000973786&find_code=SYS&local_base=nkc
2000 @ 09 @ 10 @ Studentská pečeť. Nezávislý studentský časopis @ http://aleph.nkp.cz/F/?func=find-b&request=000974792&find_code=SYS&local_base=nkc
2000 @ 09 @ 11 @ Šenovinky @ http://aleph.nkp.cz/F/?func=find-b&request=000974556&find_code=SYS&local_base=nkc
2000 @ 09 @ 12 @ Štramberské novinky @ http://aleph.nkp.cz/F/?func=find-b&request=000974558&find_code=SYS&local_base=nkc
2000 @ 09 @ 13 @ Švihováček @ http://aleph.nkp.cz/F/?func=find-b&request=000974551&find_code=SYS&local_base=nkc
2000 @ 09 @ 14 @ Tetínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000974681&find_code=SYS&local_base=nkc
2000 @ 09 @ 15 @ TZ Informace. Časopis Asociace odborných velkoobchodů... @ http://aleph.nkp.cz/F/?func=find-b&request=000973776&find_code=SYS&local_base=nkc
2000 @ 09 @ 16 @ ÚSMD info @ http://aleph.nkp.cz/F/?func=find-b&request=000974804&find_code=SYS&local_base=nkc
2000 @ 09 @ 17 @ Vaše šance. Inzertní magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000973755&find_code=SYS&local_base=nkc
2000 @ 09 @ 18 @ Věstník Okresního úřadu Šumperk @ http://aleph.nkp.cz/F/?func=find-b&request=000974678&find_code=SYS&local_base=nkc
2000 @ 09 @ 19 @ Vlčnovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000974677&find_code=SYS&local_base=nkc
2000 @ 09 @ 20 @ Vranov. Zpravodaj obecního zastupitelstva obce Vranov @ http://aleph.nkp.cz/F/?func=find-b&request=000974671&find_code=SYS&local_base=nkc
2000 @ 09 @ 21 @ Zpravodaj Obecního úřadu v Zárybech @ http://aleph.nkp.cz/F/?func=find-b&request=000974611&find_code=SYS&local_base=nkc
2000 @ 09 @ 22 @ Zpravodaj Vysoké školy ekonomické v Praze @ http://aleph.nkp.cz/F/?func=find-b&request=000973782&find_code=SYS&local_base=nkc
2000 @ 09 @ 23 @ Zprávy z Přední Výtoně @ http://aleph.nkp.cz/F/?func=find-b&request=000974629&find_code=SYS&local_base=nkc
2000 @ 09 @ 24 @ Želivské ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=000974603&find_code=SYS&local_base=nkc
2000 @ 10 @ 01 @ Akademické listy. Časopis příslušníků Vojenské akademie Brno @ http://aleph.nkp.cz/F/?func=find-b&request=000976351&find_code=SYS&local_base=nkc
2000 @ 10 @ 02 @ Aktuality z českého plynárenství @ http://aleph.nkp.cz/F/?func=find-b&request=000976373&find_code=SYS&local_base=nkc
2000 @ 10 @ 03 @ Atrium. Informační bulletin Střediska knihovnických a kulturních služeb Chomutov @ http://aleph.nkp.cz/F/?func=find-b&request=000975207&find_code=SYS&local_base=nkc
2000 @ 10 @ 04 @ Beau Monde = Báječný svět @ http://aleph.nkp.cz/F/?func=find-b&request=000977257&find_code=SYS&local_base=nkc
2000 @ 10 @ 05 @ Boroviny. Občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000976798&find_code=SYS&local_base=nkc
2000 @ 10 @ 06 @ Bratronice. Naše obec @ http://aleph.nkp.cz/F/?func=find-b&request=000977129&find_code=SYS&local_base=nkc
2000 @ 10 @ 07 @ Bystrcké noviny. Občasník městské části Brno-Bystrc @ http://aleph.nkp.cz/F/?func=find-b&request=000977507&find_code=SYS&local_base=nkc
2000 @ 10 @ 08 @ Čenkovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000976200&find_code=SYS&local_base=nkc
2000 @ 10 @ 09 @ Generace seniorů @ http://aleph.nkp.cz/F/?func=find-b&request=000975260&find_code=SYS&local_base=nkc
2000 @ 10 @ 10 @ Hostouňský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000977500&find_code=SYS&local_base=nkc
2000 @ 10 @ 11 @ Informační občasník pro obce Strupčice@ Okořín ...', 'http://aleph.nkp.cz/F/?func=find-b&request=000975926&find_code=SYS&local_base=nkc
2000 @ 10 @ 12 @ Informační zprávy z plynárenství @ http://aleph.nkp.cz/F/?func=find-b&request=000975397&find_code=SYS&local_base=nkc
2000 @ 10 @ 13 @ Jindřichovické listy @ http://aleph.nkp.cz/F/?func=find-b&request=000977127&find_code=SYS&local_base=nkc4
2000 @ 10 @ 14 @ Kojetínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000975975&find_code=SYS&local_base=nkc
2000 @ 10 @ 15 @ Komerční informace ze zahraničního plynárenství @ http://aleph.nkp.cz/F/?func=find-b&request=000976377&find_code=SYS&local_base=nkc
2000 @ 10 @ 16 @ Lipenské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000977499&find_code=SYS&local_base=nkc
2000 @ 10 @ 17 @ Lomnické listy @ http://aleph.nkp.cz/F/?func=find-b&request=000976288&find_code=SYS&local_base=nkc
2000 @ 10 @ 18 @ Mazda news @ http://aleph.nkp.cz/F/?func=find-b&request=000977321&find_code=SYS&local_base=nkc
2000 @ 10 @ 19 @ Maxima magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000976908&find_code=SYS&local_base=nkc
2000 @ 10 @ 20 @ Neon. Časopis o kultuře @ http://aleph.nkp.cz/F/?func=find-b&request=000976709&find_code=SYS&local_base=nkc
2000 @ 10 @ 21 @ Novomitrovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000975321&find_code=SYS&local_base=nkc
2000 @ 10 @ 22 @ Oběžník č. ... @ http://aleph.nkp.cz/F/?func=find-b&request=000977094&find_code=SYS&local_base=nkc
2000 @ 10 @ 23 @ Obzor. Informační časopis ... @ http://aleph.nkp.cz/F/?func=find-b&request=000976943&find_code=SYS&local_base=nkc
2000 @ 10 @ 24 @ Okno. Oslavenské kuriozity @ http://aleph.nkp.cz/F/?func=find-b&request=000976813&find_code=SYS&local_base=nkc
2000 @ 10 @ 25 @ Olešnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000977472&find_code=SYS&local_base=nkc
2000 @ 10 @ 26 @ Opera @ http://aleph.nkp.cz/F/?func=find-b&request=000977329&find_code=SYS&local_base=nkc
2000 @ 10 @ 27 @ Patriot. Občasník hornického muzea v Rudolfově @ http://aleph.nkp.cz/F/?func=find-b&request=000977163&find_code=SYS&local_base=nkc
2000 @ 10 @ 28 @ Pepa Suprajz. Měsíčník humoru a zábavy pro celou rodinu @ http://aleph.nkp.cz/F/?func=find-b&request=000976360&find_code=SYS&local_base=nkc
2000 @ 10 @ 29 @ Rudolfovský Patriot. Občasník rudolfovského spolku Patriot @ http://aleph.nkp.cz/F/?func=find-b&request=000976303&find_code=SYS&local_base=nkc
2000 @ 10 @ 30 @ Sbírky Orac. Rozhodnutí českých soudů ve věcech daňových @ http://aleph.nkp.cz/F/?func=find-b&request=000976552&find_code=SYS&local_base=nkc
2000 @ 10 @ 31 @ Sbírky Orac. Rozhodnutí českých soudů ve věcech trestních @ http://aleph.nkp.cz/F/?func=find-b&request=000976557&find_code=SYS&local_base=nkc
2000 @ 10 @ 32 @ Sedlčanské info. Informační a zábavná časopis @ http://aleph.nkp.cz/F/?func=find-b&request=000974972&find_code=SYS&local_base=nkc
2000 @ 10 @ 33 @ Směr Evropská unie @ http://aleph.nkp.cz/F/?func=find-b&request=000975253&find_code=SYS&local_base=nkc
2000 @ 10 @ 34 @ Spojilská drbna @ http://aleph.nkp.cz/F/?func=find-b&request=000975338&find_code=SYS&local_base=nkc
2000 @ 10 @ 35 @ Starokřečanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000975350&find_code=SYS&local_base=nkc
2000 @ 10 @ 36 @ Stavební profit. Noviny pro stavební praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000975393&find_code=SYS&local_base=nkc
2000 @ 10 @ 37 @ Stavebnictví a interiér @ http://aleph.nkp.cz/F/?func=find-b&request=000974819&find_code=SYS&local_base=nkc
2000 @ 10 @ 38 @ Stodské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000977333&find_code=SYS&local_base=nkc
2000 @ 10 @ 39 @ Střela. Zpravodaj obecního úřadu v Postřelmově @ http://aleph.nkp.cz/F/?func=find-b&request=000975148&find_code=SYS&local_base=nkc
2000 @ 10 @ 40 @ Střelický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000976002&find_code=SYS&local_base=nkc
2000 @ 10 @ 41 @ Studénka. Zpravodaj města @ http://aleph.nkp.cz/F/?func=find-b&request=000976543&find_code=SYS&local_base=nkc
2000 @ 10 @ 42 @ Studentský Fénix @ http://aleph.nkp.cz/F/?func=find-b&request=000975258&find_code=SYS&local_base=nkc
2000 @ 10 @ 43 @ Style. Hvězdný styl pro všechny @ http://aleph.nkp.cz/F/?func=find-b&request=000976717&find_code=SYS&local_base=nkc
2000 @ 10 @ 44 @ Sudoměřský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000976947&find_code=SYS&local_base=nkc
2000 @ 10 @ 45 @ Sun news. Bulletin společnosti Sun Microsystems @ http://aleph.nkp.cz/F/?func=find-b&request=000975407&find_code=SYS&local_base=nkc
2000 @ 10 @ 46 @ Syrovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000975152&find_code=SYS&local_base=nkc
2000 @ 10 @ 47 @ Šumavanka. Noviny pro podporu podnikání a trhu práce @ http://aleph.nkp.cz/F/?func=find-b&request=000977083&find_code=SYS&local_base=nkc
2000 @ 10 @ 48 @ TA-servis. Inzertní a kulturní měsíčník města Tábora @ http://aleph.nkp.cz/F/?func=find-b&request=000976029&find_code=SYS&local_base=nkc
2000 @ 10 @ 49 @ TAMTAM. Reklamní měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000976914&find_code=SYS&local_base=nkc
2000 @ 10 @ 50 @ Taneční zóna. Revue současného tance @ http://aleph.nkp.cz/F/?func=find-b&request=000976381&find_code=SYS&local_base=nkc
2000 @ 10 @ 51 @ Tichavský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000976180&find_code=SYS&local_base=nkc
2000 @ 10 @ 52 @ Tlučenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000976148&find_code=SYS&local_base=nkc
2000 @ 10 @ 53 @ Tlustický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000976070&find_code=SYS&local_base=nkc
2000 @ 10 @ 54 @ Trnavský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000976898&find_code=SYS&local_base=nkc
2000 @ 10 @ 55 @ Troubský hlasatel @ http://aleph.nkp.cz/F/?func=find-b&request=000976183&find_code=SYS&local_base=nkc
2000 @ 10 @ 56 @ Tvaroženský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000976157&find_code=SYS&local_base=nkc
2000 @ 10 @ 57 @ Úsovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000976199&find_code=SYS&local_base=nkc
2000 @ 10 @ 58 @ Velatický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000975267&find_code=SYS&local_base=nkc
2000 @ 10 @ 59 @ Velehradský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000975986&find_code=SYS&local_base=nkc
2000 @ 10 @ 60 @ Veselí inzert. Inzerce s kresleným humorem @ http://aleph.nkp.cz/F/?func=find-b&request=000975387&find_code=SYS&local_base=nkc
2000 @ 10 @ 61 @ Voldušský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000976027&find_code=SYS&local_base=nkc
2000 @ 10 @ 62 @ Vroutecké noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000975266&find_code=SYS&local_base=nkc
2000 @ 10 @ 63 @ Všeminský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000977109&find_code=SYS&local_base=nkc
2000 @ 10 @ 64 @ Všetatsko-přívorský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000975288&find_code=SYS&local_base=nkc
2000 @ 10 @ 65 @ Výšivka. Časopis pro křížkové vyšívání @ http://aleph.nkp.cz/F/?func=find-b&request=000975939&find_code=SYS&local_base=nkc
2000 @ 10 @ 66 @ Záchranář. Zpravodaj integrovaného záchranného systému ... @ http://aleph.nkp.cz/F/?func=find-b&request=000977468&find_code=SYS&local_base=nkc
2000 @ 10 @ 67 @ Západočeská pošta @ http://aleph.nkp.cz/F/?func=find-b&request=000975917&find_code=SYS&local_base=nkc
2000 @ 10 @ 68 @ Zpravodaj. Lázně Bohdaneč @ http://aleph.nkp.cz/F/?func=find-b&request=000977471&find_code=SYS&local_base=nkc
2000 @ 10 @ 69 @ Zpravodaj města Cvikova @ http://aleph.nkp.cz/F/?func=find-b&request=000976801&find_code=SYS&local_base=nkc
2000 @ 10 @ 70 @ Zpravodaj města Chodova @ http://aleph.nkp.cz/F/?func=find-b&request=000977139&find_code=SYS&local_base=nkc
2000 @ 10 @ 71 @ Zpravodaj města Jablonné v Podještědí @ http://aleph.nkp.cz/F/?func=find-b&request=000977118&find_code=SYS&local_base=nkc
2000 @ 10 @ 72 @ Zpravodaj městského obvodu Pardubice 7 @ http://aleph.nkp.cz/F/?func=find-b&request=000976799&find_code=SYS&local_base=nkc
2000 @ 10 @ 73 @ Zpravodaj obce Lelekovice @ http://aleph.nkp.cz/F/?func=find-b&request=000975857&find_code=SYS&local_base=nkc
2000 @ 10 @ 74 @ Zpravodaj obce Mankovice @ http://aleph.nkp.cz/F/?func=find-b&request=000977123&find_code=SYS&local_base=nkc
2000 @ 10 @ 75 @ Zpravodaj obce Sádek @ http://aleph.nkp.cz/F/?func=find-b&request=000977091&find_code=SYS&local_base=nkc
2000 @ 10 @ 76 @ Zpravodaj obce Světlá Hora @ http://aleph.nkp.cz/F/?func=find-b&request=000975323&find_code=SYS&local_base=nkc
2000 @ 10 @ 77 @ Žebětínský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000975912&find_code=SYS&local_base=nkc
2000 @ 11 @ 01 @ The British Council. Newsletter (Czech republic) @ http://aleph.nkp.cz/F/?func=find-b&request=000979568&find_code=SYS&local_base=nkc
2000 @ 11 @ 02 @ Daně a účetnictví pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=000979066&find_code=SYS&local_base=nkc
2000 @ 11 @ 03 @ Decros news. Informační bulletin pro ... @ http://aleph.nkp.cz/F/?func=find-b&request=000977661&find_code=SYS&local_base=nkc
2000 @ 11 @ 04 @ Dokský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000979291&find_code=SYS&local_base=nkc
2000 @ 11 @ 05 @ Dolní Bojanovice. Zpravodaj obecního úřadu @ http://aleph.nkp.cz/F/?func=find-b&request=000978020&find_code=SYS&local_base=nkc
2000 @ 11 @ 06 @ Domanínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000979586&find_code=SYS&local_base=nkc
2000 @ 11 @ 07 @ Easy Deutsch @ http://aleph.nkp.cz/F/?func=find-b&request=000977740&find_code=SYS&local_base=nkc
2000 @ 11 @ 08 @ Eso. Informační bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=000979059&find_code=SYS&local_base=nkc
2000 @ 11 @ 09 @ Galaxy news. Zpravodaj pro využití metody AV @ http://aleph.nkp.cz/F/?func=find-b&request=000979309&find_code=SYS&local_base=nkc
2000 @ 11 @ 10 @ Go express @ http://aleph.nkp.cz/F/?func=find-b&request=000979416&find_code=SYS&local_base=nkc
2000 @ 11 @ 11 @ Hatikva @ http://aleph.nkp.cz/F/?func=find-b&request=000977688&find_code=SYS&local_base=nkc
2000 @ 11 @ 12 @ Hlas obce. Zpravodaj obecního úřadu Velké Albrechtice @ http://aleph.nkp.cz/F/?func=find-b&request=000978722&find_code=SYS&local_base=nkc
2000 @ 11 @ 13 @ Hlubocký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000978859&find_code=SYS&local_base=nkc4
2000 @ 11 @ 14 @ Houser. Aktuální kulturní programový týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=000979503&find_code=SYS&local_base=nkc
2000 @ 11 @ 15 @ Hrušovanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000979590&find_code=SYS&local_base=nkc
2000 @ 11 @ 16 @ Chomutovský průboj. Okresní noviny KSČM a ... @ http://aleph.nkp.cz/F/?func=find-b&request=000978816&find_code=SYS&local_base=nkc
2000 @ 11 @ 17 @ Informační list obce Římov @ http://aleph.nkp.cz/F/?func=find-b&request=000979223&find_code=SYS&local_base=nkc
2000 @ 11 @ 18 @ Informátor obce Třanovice @ http://aleph.nkp.cz/F/?func=find-b&request=000978716&find_code=SYS&local_base=nkc
2000 @ 11 @ 19 @ Karel magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000979555&find_code=SYS&local_base=nkc
2000 @ 11 @ 20 @ KM noviny. Nezávislý měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000978801&find_code=SYS&local_base=nkc
2000 @ 11 @ 21 @ Komplet. Projekty rodinných domů @ http://aleph.nkp.cz/F/?func=find-b&request=000979192&find_code=SYS&local_base=nkc
2000 @ 11 @ 22 @ Kosmonoské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000978365&find_code=SYS&local_base=nkc
2000 @ 11 @ 23 @ Kostomlatský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000978775&find_code=SYS&local_base=nkc
2000 @ 11 @ 24 @ Listy Ašska. Regionální týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=000978017&find_code=SYS&local_base=nkc
2000 @ 11 @ 25 @ Makovice. Pro chytré hlavy @ http://aleph.nkp.cz/F/?func=find-b&request=000978266&find_code=SYS&local_base=nkc
2000 @ 11 @ 26 @ Marianne. Život začíná ve třiceti @ http://aleph.nkp.cz/F/?func=find-b&request=000978664&find_code=SYS&local_base=nkc
2000 @ 11 @ 27 @ Naše noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000978791&find_code=SYS&local_base=nkc
2000 @ 11 @ 28 @ Nos. Týdeník pro Brno a jižní Moravu @ http://aleph.nkp.cz/F/?func=find-b&request=000977459&find_code=SYS&local_base=nkc
2000 @ 11 @ 29 @ Nosislavský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000978777&find_code=SYS&local_base=nkc
2000 @ 11 @ 30 @ Noviny radnic Přibyslav@ Sázava, Šlapanov, Věznice', 'http://aleph.nkp.cz/F/?func=find-b&request=000978982&find_code=SYS&local_base=nkc
2000 @ 11 @ 31 @ Obecní zpravodaj (Kamenné Žehrovice) @ http://aleph.nkp.cz/F/?func=find-b&request=000978715&find_code=SYS&local_base=nkc
2000 @ 11 @ 32 @ Omický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000978227&find_code=SYS&local_base=nkc
2000 @ 11 @ 33 @ Ostravar. Listy festivalového vření @ http://aleph.nkp.cz/F/?func=find-b&request=000979462&find_code=SYS&local_base=nkc
2000 @ 11 @ 34 @ PC Jak na to @ http://aleph.nkp.cz/F/?func=find-b&request=000979327&find_code=SYS&local_base=nkc
2000 @ 11 @ 35 @ Pharma news. Odborný časopis pro lékárníky a laborantky @ http://aleph.nkp.cz/F/?func=find-b&request=000979424&find_code=SYS&local_base=nkc
2000 @ 11 @ 36 @ Plus 21. Zpravodaj Klubu rodičů a ... @ http://aleph.nkp.cz/F/?func=find-b&request=000978706&find_code=SYS&local_base=nkc
2000 @ 11 @ 37 @ Podyjské listí @ http://aleph.nkp.cz/F/?func=find-b&request=000978961&find_code=SYS&local_base=nkc
2000 @ 11 @ 38 @ Potravinářský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000978558&find_code=SYS&local_base=nkc
2000 @ 11 @ 39 @ Profesionální nehty. Odborné noviny pro nehtové designéry @ http://aleph.nkp.cz/F/?func=find-b&request=000977873&find_code=SYS&local_base=nkc
2000 @ 11 @ 40 @ Ratíškovický zvon @ http://aleph.nkp.cz/F/?func=find-b&request=000977653&find_code=SYS&local_base=nkc
2000 @ 11 @ 41 @ Rekonstrukce a experiment v archeologii @ http://aleph.nkp.cz/F/?func=find-b&request=000978688&find_code=SYS&local_base=nkc
2000 @ 11 @ 42 @ Seriál. Všechno o světě seriálů @ http://aleph.nkp.cz/F/?func=find-b&request=000978770&find_code=SYS&local_base=nkc
2000 @ 11 @ 43 @ Stříbrské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000978349&find_code=SYS&local_base=nkc
2000 @ 11 @ 44 @ Sudoměřický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000979284&find_code=SYS&local_base=nkc
2000 @ 11 @ 45 @ Systémy logistiky @ http://aleph.nkp.cz/F/?func=find-b&request=000978092&find_code=SYS&local_base=nkc
2000 @ 11 @ 46 @ Tachovgraf @ http://aleph.nkp.cz/F/?func=find-b&request=000959630&find_code=SYS&local_base=nkc
2000 @ 11 @ 47 @ Tachovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000978338&find_code=SYS&local_base=nkc
2000 @ 11 @ 48 @ Teologický sborník @ http://aleph.nkp.cz/F/?func=find-b&request=000978491&find_code=SYS&local_base=nkc
2000 @ 11 @ 49 @ Top účesy @ http://aleph.nkp.cz/F/?func=find-b&request=000977746&find_code=SYS&local_base=nkc
2000 @ 11 @ 50 @ Týnské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000978094&find_code=SYS&local_base=nkc
2000 @ 11 @ 51 @ Vinice Páně. Občasník farnosti nivnické @ http://aleph.nkp.cz/F/?func=find-b&request=000979576&find_code=SYS&local_base=nkc
2000 @ 11 @ 52 @ Vracovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000978028&find_code=SYS&local_base=nkc
2000 @ 11 @ 53 @ Zpravodaj Hospodářské komory okresu Přerov @ http://aleph.nkp.cz/F/?func=find-b&request=000977690&find_code=SYS&local_base=nkc
2000 @ 11 @ 54 @ Zpravodaj Jihočeské univerzity @ http://aleph.nkp.cz/F/?func=find-b&request=000977689&find_code=SYS&local_base=nkc
2000 @ 11 @ 55 @ Zpravodaj lipoveckého úřadu @ http://aleph.nkp.cz/F/?func=find-b&request=000978026&find_code=SYS&local_base=nkc
2000 @ 11 @ 56 @ Zpravodaj obecního úřadu (Moravská Nová Ves) @ http://aleph.nkp.cz/F/?func=find-b&request=000978031&find_code=SYS&local_base=nkc
2000 @ 11 @ 57 @ Zpravodaj okresního úřadu Jeseník @ http://aleph.nkp.cz/F/?func=find-b&request=000978238&find_code=SYS&local_base=nkc
2000 @ 11 @ 58 @ Zpravodaj Pražské teplárenské a.s. @ http://aleph.nkp.cz/F/?func=find-b&request=000978519&find_code=SYS&local_base=nkc
2000 @ 11 @ 59 @ Zpravodaj pro obec Tisá @ http://aleph.nkp.cz/F/?func=find-b&request=000978024&find_code=SYS&local_base=nkc
2000 @ 12 @ 01 @ Aero. Zpravodaj akciové společnosti Aero Vodochody @ http://aleph.nkp.cz/F/?func=find-b&request=000981106&find_code=SYS&local_base=nkc
2000 @ 12 @ 02 @ Auto Max. Noviny s maximální inzercí @ http://aleph.nkp.cz/F/?func=find-b&request=000982166&find_code=SYS&local_base=nkc
2000 @ 12 @ 03 @ Autovrakoviště @ http://aleph.nkp.cz/F/?func=find-b&request=000980970&find_code=SYS&local_base=nkc
2000 @ 12 @ 04 @ Bělský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000980957&find_code=SYS&local_base=nkc
2000 @ 12 @ 05 @ Bonsai. Příroda a člověk @ http://aleph.nkp.cz/F/?func=find-b&request=000982159&find_code=SYS&local_base=nkc
2000 @ 12 @ 06 @ Bonsai revue. Informační zpravodaj... @ http://aleph.nkp.cz/F/?func=find-b&request=000982162&find_code=SYS&local_base=nkc
2000 @ 12 @ 07 @ Boršický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000983238&find_code=SYS&local_base=nkc
2000 @ 12 @ 08 @ Bulletin. Vydává Okresní úřad Přerov @ http://aleph.nkp.cz/F/?func=find-b&request=000980873&find_code=SYS&local_base=nkc
2000 @ 12 @ 09 @ CEP - církevní ekumenický plátek @ http://aleph.nkp.cz/F/?func=find-b&request=000983180&find_code=SYS&local_base=nkc
2000 @ 12 @ 10 @ Cesta. Křesťanský časopis pro děti @ http://aleph.nkp.cz/F/?func=find-b&request=000983250&find_code=SYS&local_base=nkc
2000 @ 12 @ 11 @ Černokostelecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000981376&find_code=SYS&local_base=nkc
2000 @ 12 @ 12 @ Českokamenické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000983164&find_code=SYS&local_base=nkc
2000 @ 12 @ 13 @ Českomoravský lev @ http://aleph.nkp.cz/F/?func=find-b&request=000982183&find_code=SYS&local_base=nkc
2000 @ 12 @ 14 @ Českotřebovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000981967&find_code=SYS&local_base=nkc
2000 @ 12 @ 15 @ Čistecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000979736&find_code=SYS&local_base=nkc
2000 @ 12 @ 16 @ Deblínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000983253&find_code=SYS&local_base=nkc
2000 @ 12 @ 17 @ Dobrý den s kurýrem @ http://aleph.nkp.cz/F/?func=find-b&request=000982238&find_code=SYS&local_base=nkc
2000 @ 12 @ 18 @ Drozdovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000983177&find_code=SYS&local_base=nkc
2000 @ 12 @ 19 @ Esprit. Zpravodaj České asociace pro psychické zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=000981177&find_code=SYS&local_base=nkc
2000 @ 12 @ 20 @ Game 4U @ http://aleph.nkp.cz/F/?func=find-b&request=000981580&find_code=SYS&local_base=nkc
2000 @ 12 @ 21 @ Gerontologické aktuality @ http://aleph.nkp.cz/F/?func=find-b&request=000980827&find_code=SYS&local_base=nkc
2000 @ 12 @ 22 @ Hlásná Třebáň. Zpravodaj třebáňských občanů a chatařů @ http://aleph.nkp.cz/F/?func=find-b&request=000983145&find_code=SYS&local_base=nkc
2000 @ 12 @ 23 @ Horizont. Zpravodajský čtrnáctideník města Šumperka @ http://aleph.nkp.cz/F/?func=find-b&request=000981417&find_code=SYS&local_base=nkc
2000 @ 12 @ 24 @ Chřibský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000983223&find_code=SYS&local_base=nkc
2000 @ 12 @ 25 @ Info Jeseník. Informační čtrnáctideník okresního města @ http://aleph.nkp.cz/F/?func=find-b&request=000981084&find_code=SYS&local_base=nkc
2000 @ 12 @ 26 @ Infor. Skrbeňský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000983163&find_code=SYS&local_base=nkc
2000 @ 12 @ 27 @ Informační zpravodaj obecního úřadu pro obce Břasy@ Stupno...', 'http://aleph.nkp.cz/F/?func=find-b&request=000979765&find_code=SYS&local_base=nkc
2000 @ 12 @ 28 @ Investiční poradce @ http://aleph.nkp.cz/F/?func=find-b&request=000980837&find_code=SYS&local_base=nkc
2000 @ 12 @ 29 @ Inzert plus. Reklamní a inzertní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000980967&find_code=SYS&local_base=nkc
2000 @ 12 @ 30 @ Jakost pro život. Populárně odborný časopis @ http://aleph.nkp.cz/F/?func=find-b&request=000981260&find_code=SYS&local_base=nkc
2000 @ 12 @ 31 @ Jedovnice. Informace obecního úřadu @ http://aleph.nkp.cz/F/?func=find-b&request=000979658&find_code=SYS&local_base=nkc
2000 @ 12 @ 32 @ JO magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000981162&find_code=SYS&local_base=nkc
2000 @ 12 @ 33 @ Josef Burda. Divadelní zpravodaj městského divadla v Karlových Varech @ http://aleph.nkp.cz/F/?func=find-b&request=000981483&find_code=SYS&local_base=nkc
2000 @ 12 @ 34 @ Journal of European Baptist Studies @ http://aleph.nkp.cz/F/?func=find-b&request=000981244&find_code=SYS&local_base=nkc
2000 @ 12 @ 35 @ Jurisprudence. Vynutitelnost práva a právní praxe @ http://aleph.nkp.cz/F/?func=find-b&request=000981674&find_code=SYS&local_base=nkc
2000 @ 12 @ 36 @ K .... Třinecký kulturní měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000981215&find_code=SYS&local_base=nkc
2000 @ 12 @ 37 @ Kerečka @ http://aleph.nkp.cz/F/?func=find-b&request=000979490&find_code=SYS&local_base=nkc
2000 @ 12 @ 38 @ Léčíme se jídlem. Osmisměrky zdravá výživa @ http://aleph.nkp.cz/F/?func=find-b&request=000981924&find_code=SYS&local_base=nkc
2000 @ 12 @ 39 @ Lékárenský bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=000980962&find_code=SYS&local_base=nkc
2000 @ 12 @ 40 @ Libhošťský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000979773&find_code=SYS&local_base=nkc
2000 @ 12 @ 41 @ Loketské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000981299&find_code=SYS&local_base=nkc
2000 @ 12 @ 42 @ Mail. CEE bankwatch network @ http://aleph.nkp.cz/F/?func=find-b&request=000981479&find_code=SYS&local_base=nkc
2000 @ 12 @ 43 @ Manětínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000980924&find_code=SYS&local_base=nkc
2000 @ 12 @ 44 @ Měčínské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000982073&find_code=SYS&local_base=nkc
2000 @ 12 @ 45 @ Moštěnský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000979783&find_code=SYS&local_base=nkc
2000 @ 12 @ 46 @ N.C.R.. Časopis o cestování @ http://aleph.nkp.cz/F/?func=find-b&request=000982178&find_code=SYS&local_base=nkc
2000 @ 12 @ 47 @ Nabídka zaměstnání. Inzertní týdeník pracovních příleľitostí... @ http://aleph.nkp.cz/F/?func=find-b&request=000981060&find_code=SYS&local_base=nkc
2000 @ 12 @ 48 @ Náchodský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000983153&find_code=SYS&local_base=nkc
2000 @ 12 @ 49 @ Naše nejmilejší zvíře @ http://aleph.nkp.cz/F/?func=find-b&request=000981300&find_code=SYS&local_base=nkc
2000 @ 12 @ 50 @ NemoStránky Annonce. Velká celostátní nabídka nemovitostí... @ http://aleph.nkp.cz/F/?func=find-b&request=000981151&find_code=SYS&local_base=nkc
2000 @ 12 @ 51 @ Nivnické ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=000980980&find_code=SYS&local_base=nkc
2000 @ 12 @ 52 @ Nové. Nezávislý čtrnáctideník středního Posázaví @ http://aleph.nkp.cz/F/?func=find-b&request=000982002&find_code=SYS&local_base=nkc
2000 @ 12 @ 53 @ Nový prostor @ http://aleph.nkp.cz/F/?func=find-b&request=000982171&find_code=SYS&local_base=nkc
2000 @ 12 @ 54 @ Obecní akutality (Český Rudolec) @ http://aleph.nkp.cz/F/?func=find-b&request=000981691&find_code=SYS&local_base=nkc
2000 @ 12 @ 55 @ Obecní noviny (Šumice) @ http://aleph.nkp.cz/F/?func=find-b&request=000981697&find_code=SYS&local_base=nkc
2000 @ 12 @ 56 @ Obecní zpravodaj (Heřmanice u Oder) @ http://aleph.nkp.cz/F/?func=find-b&request=000981679&find_code=SYS&local_base=nkc
2000 @ 12 @ 57 @ Obecní zpravodaj pro Čenkov@ Dobřejice...', 'http://aleph.nkp.cz/F/?func=find-b&request=000981687&find_code=SYS&local_base=nkc
2000 @ 12 @ 58 @ Oběžník č. ... (OÚ Žermanice) @ http://aleph.nkp.cz/F/?func=find-b&request=000980860&find_code=SYS&local_base=nkc
2000 @ 12 @ 59 @ Ostrovačický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000981682&find_code=SYS&local_base=nkc
2000 @ 12 @ 60 @ Pavlínovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000979767&find_code=SYS&local_base=nkc
2000 @ 12 @ 61 @ Polničský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000980913&find_code=SYS&local_base=nkc
2000 @ 12 @ 62 @ Pozdrav z Thajska @ http://aleph.nkp.cz/F/?func=find-b&request=000982232&find_code=SYS&local_base=nkc
2000 @ 12 @ 63 @ Pozořický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000980915&find_code=SYS&local_base=nkc
2000 @ 12 @ 64 @ Praktický rodinný lékař @ http://aleph.nkp.cz/F/?func=find-b&request=000981027&find_code=SYS&local_base=nkc
2000 @ 12 @ 65 @ Pražmovské ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=000980922&find_code=SYS&local_base=nkc
2000 @ 12 @ 66 @ Pražský strážník @ http://aleph.nkp.cz/F/?func=find-b&request=000979781&find_code=SYS&local_base=nkc
2000 @ 12 @ 67 @ Přídolsko @ http://aleph.nkp.cz/F/?func=find-b&request=000981122&find_code=SYS&local_base=nkc
2000 @ 12 @ 68 @ Radenínský čtvrtletník @ http://aleph.nkp.cz/F/?func=find-b&request=000981414&find_code=SYS&local_base=nkc
2000 @ 12 @ 69 @ Radnice informuje. Noviny pro Moravský Beroun @ http://aleph.nkp.cz/F/?func=find-b&request=000981414&find_code=SYS&local_base=nkc
2000 @ 12 @ 70 @ Regionální noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000981411&find_code=SYS&local_base=nkc
2000 @ 12 @ 71 @ Research in agricultural engineering = Zemědělská technika @ http://aleph.nkp.cz/F/?func=find-b&request=000982006&find_code=SYS&local_base=nkc
2000 @ 12 @ 72 @ Rosa. Zpravovaj Rosicka @ http://aleph.nkp.cz/F/?func=find-b&request=000981969&find_code=SYS&local_base=nkc
2000 @ 12 @ 73 @ Rozhledy @ http://aleph.nkp.cz/F/?func=find-b&request=000981230&find_code=SYS&local_base=nkc
2000 @ 12 @ 74 @ Roztocké listy @ http://aleph.nkp.cz/F/?func=find-b&request=000981077&find_code=SYS&local_base=nkc
2000 @ 12 @ 75 @ Rybnišťský (pod)vodník @ http://aleph.nkp.cz/F/?func=find-b&request=000981118&find_code=SYS&local_base=nkc
2000 @ 12 @ 76 @ Řehlovické listy @ http://aleph.nkp.cz/F/?func=find-b&request=000982087&find_code=SYS&local_base=nkc
2000 @ 12 @ 77 @ Scarabeus. Nezávislý studentský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000979788&find_code=SYS&local_base=nkc
2000 @ 12 @ 78 @ Sloupnický pelmel @ http://aleph.nkp.cz/F/?func=find-b&request=000981092&find_code=SYS&local_base=nkc
2000 @ 12 @ 79 @ Solidarita. Noviny revolučních anarchistů @ http://aleph.nkp.cz/F/?func=find-b&request=000981514&find_code=SYS&local_base=nkc
2000 @ 12 @ 80 @ Sociální péče. Odborný časopis pracovníků sociální péče @ http://aleph.nkp.cz/F/?func=find-b&request=000983256&find_code=SYS&local_base=nkc
2000 @ 12 @ 81 @ Světové křížovky s humorem @ http://aleph.nkp.cz/F/?func=find-b&request=000981575&find_code=SYS&local_base=nkc
2000 @ 12 @ 82 @ Transplantace dnes @ http://aleph.nkp.cz/F/?func=find-b&request=000980911&find_code=SYS&local_base=nkc
2000 @ 12 @ 83 @ Tschechien. Ihr Führer durch die tschechische Gastronomie... @ http://aleph.nkp.cz/F/?func=find-b&request=000981113&find_code=SYS&local_base=nkc
2000 @ 12 @ 84 @ Tuněchodské okénko @ http://aleph.nkp.cz/F/?func=find-b&request=000983229&find_code=SYS&local_base=nkc
2000 @ 12 @ 85 @ Týnecké střípky @ http://aleph.nkp.cz/F/?func=find-b&request=000982095&find_code=SYS&local_base=nkc
2000 @ 12 @ 86 @ Urologie pro praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000981553&find_code=SYS&local_base=nkc
2000 @ 12 @ 87 @ Vendryňské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000982149&find_code=SYS&local_base=nkc
2000 @ 12 @ 88 @ Vlčický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000981067&find_code=SYS&local_base=nkc
2000 @ 12 @ 89 @ Volný čas @ http://aleph.nkp.cz/F/?func=find-b&request=000980975&find_code=SYS&local_base=nkc
2000 @ 12 @ 90 @ Xaver. Nezávislý studentský časopis... @ http://aleph.nkp.cz/F/?func=find-b&request=000981676&find_code=SYS&local_base=nkc
2000 @ 12 @ 91 @ Zastávecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000981297&find_code=SYS&local_base=nkc
2000 @ 12 @ 92 @ Zeměměřič. Časopis o geodézii@ katastru nemovitostí...', 'http://aleph.nkp.cz/F/?func=find-b&request=000981524&find_code=SYS&local_base=nkc
2000 @ 12 @ 93 @ Zpravodaj... Jiráskův Hronov @ http://aleph.nkp.cz/F/?func=find-b&request=000981055&find_code=SYS&local_base=nkc
2000 @ 12 @ 94 @ Zpravodaj. Obec Morkovice - Slížany @ http://aleph.nkp.cz/F/?func=find-b&request=000982155&find_code=SYS&local_base=nkc
2000 @ 12 @ 95 @ Zpravodaj ČEA @ http://aleph.nkp.cz/F/?func=find-b&request=000981460&find_code=SYS&local_base=nkc
2000 @ 12 @ 96 @ Zpravodaj KCHBK @ http://aleph.nkp.cz/F/?func=find-b&request=000981916&find_code=SYS&local_base=nkc
2000 @ 12 @ 97 @ Zpravodaj Modřice @ http://aleph.nkp.cz/F/?func=find-b&request=000981888&find_code=SYS&local_base=nkc
2000 @ 12 @ 98 @ Zpravodaj obce Bernartic n. Odrou @ http://aleph.nkp.cz/F/?func=find-b&request=000981381&find_code=SYS&local_base=nkc
2000 @ 12 @ 99 @ Zpravodaj obce Praskolesy @ http://aleph.nkp.cz/F/?func=find-b&request=000981867&find_code=SYS&local_base=nkc
2000 @ 12 @ 100 @ Zpravodaj obce Pstruží @ http://aleph.nkp.cz/F/?func=find-b&request=000981965&find_code=SYS&local_base=nkc
2000 @ 12 @ 101 @ Zpravodaj obce Soběšovice @ http://aleph.nkp.cz/F/?func=find-b&request=000982091&find_code=SYS&local_base=nkc
2000 @ 12 @ 102 @ Zpravodaj obecního zastupitelstva Brloh @ http://aleph.nkp.cz/F/?func=find-b&request=000981866&find_code=SYS&local_base=nkc
2000 @ 12 @ 103 @ Zpravodaj Okresního úřadu Mělník @ http://aleph.nkp.cz/F/?func=find-b&request=000981082&find_code=SYS&local_base=nkc
2000 @ 12 @ 104 @ Žena třetího tisíciletí. Zpravodaj Českého svazu žen @ http://aleph.nkp.cz/F/?func=find-b&request=000981864&find_code=SYS&local_base=nkc
2001 @ 02 @ 11 @ Hlinecké noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000990475&find_code=SYS&local_base=nkc
2001 @ 02 @ 12 @ Horažďovický obzor @ http://aleph.nkp.cz/F/?func=find-b&request=000989860&find_code=SYS&local_base=nkc
2001 @ 02 @ 13 @ Klapka. Měsíčník zaměstnanců MSA@ a.s.', 'http://aleph.nkp.cz/F/?func=find-b&request=000990816&find_code=SYS&local_base=nkc
2001 @ 02 @ 14 @ Kokorské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000990001&find_code=SYS&local_base=nkc
2001 @ 02 @ 15 @ Krásenká pošta @ http://aleph.nkp.cz/F/?func=find-b&request=000989963&find_code=SYS&local_base=nkc
2001 @ 02 @ 16 @ Lhotský informátor @ http://aleph.nkp.cz/F/?func=find-b&request=000989878&find_code=SYS&local_base=nkc
2001 @ 02 @ 17 @ Lomňánek. Zpravodaj obce Horní Lomná @ http://aleph.nkp.cz/F/?func=find-b&request=000989993&find_code=SYS&local_base=nkc
2001 @ 02 @ 18 @ Martin. Občasník městského obvodu Martinov @ http://aleph.nkp.cz/F/?func=find-b&request=000989882&find_code=SYS&local_base=nkc
2001 @ 02 @ 19 @ Noviny Alimpek @ http://aleph.nkp.cz/F/?func=find-b&request=000991089&find_code=SYS&local_base=nkc
2001 @ 02 @ 20 @ PIN (Paegas Info News) @ http://aleph.nkp.cz/F/?func=find-b&request=000991076&find_code=SYS&local_base=nkc
2001 @ 02 @ 21 @ Podnikatelské lobby. Časopis Hospodářské komory ČR @ http://aleph.nkp.cz/F/?func=find-b&request=000990573&find_code=SYS&local_base=nkc
2001 @ 02 @ 22 @ Praktický instalatér @ http://aleph.nkp.cz/F/?func=find-b&request=000990013&find_code=SYS&local_base=nkc
2001 @ 02 @ 23 @ Promenáda. Mariánskolázeňský informační měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000990894&find_code=SYS&local_base=nkc
2001 @ 02 @ 24 @ RC revue. Nezávislý modelářský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000991071&find_code=SYS&local_base=nkc
2001 @ 02 @ 25 @ Real tip gaute. Moravské realitní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000990631&find_code=SYS&local_base=nkc
2001 @ 02 @ 26 @ Region Jižní Čechy @ http://aleph.nkp.cz/F/?func=find-b&request=000989898&find_code=SYS&local_base=nkc
2001 @ 02 @ 27 @ Region Press. Reklamní měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000990490&find_code=SYS&local_base=nkc
2001 @ 02 @ 28 @ Sportovec ministerstva vnitra @ http://aleph.nkp.cz/F/?func=find-b&request=000990644&find_code=SYS&local_base=nkc
2001 @ 02 @ 29 @ Student inzert @ http://aleph.nkp.cz/F/?func=find-b&request=000990634&find_code=SYS&local_base=nkc
2001 @ 02 @ 30 @ T-uni. Časopis Technické univerzity v Liberci @ http://aleph.nkp.cz/F/?func=find-b&request=000990840&find_code=SYS&local_base=nkc
2001 @ 02 @ 31 @ Tulipán. Exkluzivně pro klienty Nationale-Nederlanden @ http://aleph.nkp.cz/F/?func=find-b&request=000990599&find_code=SYS&local_base=nkc
2001 @ 02 @ 32 @ Vikýř. Krásnolipský půlměsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000990824&find_code=SYS&local_base=nkc
2001 @ 02 @ 33 @ Vilémovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000987599&find_code=SYS&local_base=nkc
2001 @ 02 @ 34 @ Votické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000989870&find_code=SYS&local_base=nkc
2001 @ 02 @ 35 @ Zpravodaj Klubu čtenářů Bohumila Hrabala Nymburký pábitel @ http://aleph.nkp.cz/F/?func=find-b&request=000991099&find_code=SYS&local_base=nkc
2001 @ 02 @ 36 @ Žihelský zítřek @ http://aleph.nkp.cz/F/?func=find-b&request=000990861&find_code=SYS&local_base=nkc
2001 @ 03 @ 01 @ AliaChemmagazín @ http://aleph.nkp.cz/F/?func=find-b&request=000991607&find_code=SYS&local_base=nkc
2001 @ 03 @ 02 @ Bělohradské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000992051&find_code=SYS&local_base=nkc
2001 @ 03 @ 03 @ Branecký občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000992856&find_code=SYS&local_base=nkc
2001 @ 03 @ 04 @ Březovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000992807&find_code=SYS&local_base=nkc
2001 @ 03 @ 05 @ Collection of scientific papers (Faculty of Agriculture in České Budějovice) @ http://aleph.nkp.cz/F/?func=find-b&request=000991871&find_code=SYS&local_base=nkc
2001 @ 03 @ 06 @ České listy @ http://aleph.nkp.cz/F/?func=find-b&request=000992062&find_code=SYS&local_base=nkc
2001 @ 03 @ 07 @ Dance spektrum @ http://aleph.nkp.cz/F/?func=find-b&request=000991262&find_code=SYS&local_base=nkc
2001 @ 03 @ 08 @ Franzensbader Blätter @ http://aleph.nkp.cz/F/?func=find-b&request=000991819&find_code=SYS&local_base=nkc
2001 @ 03 @ 09 @ Gynekologie po promoci @ http://aleph.nkp.cz/F/?func=find-b&request=000993473&find_code=SYS&local_base=nkc
2001 @ 03 @ 10 @ Holické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000992784&find_code=SYS&local_base=nkc
2001 @ 03 @ 11 @ Chovatelství @ http://aleph.nkp.cz/F/?func=find-b&request=000993417&find_code=SYS&local_base=nkc
2001 @ 03 @ 12 @ Chrášťanské slovo @ http://aleph.nkp.cz/F/?func=find-b&request=000992083&find_code=SYS&local_base=nkc
2001 @ 03 @ 13 @ InfoCity @ http://aleph.nkp.cz/F/?func=find-b&request=000993485&find_code=SYS&local_base=nkc
2001 @ 03 @ 14 @ Informační zpravodaj (Dřevařský ústav) @ http://aleph.nkp.cz/F/?func=find-b&request=000991142&find_code=SYS&local_base=nkc
2001 @ 03 @ 15 @ Janovský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000992041&find_code=SYS&local_base=nkc
2001 @ 03 @ 16 @ Kamelot @ http://aleph.nkp.cz/F/?func=find-b&request=000993918&find_code=SYS&local_base=nkc
2001 @ 03 @ 17 @ Komínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000992406&find_code=SYS&local_base=nkc
2001 @ 03 @ 18 @ max Aktuel @ http://aleph.nkp.cz/F/?func=find-b&request=000993457&find_code=SYS&local_base=nkc
2001 @ 03 @ 19 @ Mikroregion Nepomucko @ http://aleph.nkp.cz/F/?func=find-b&request=000992070&find_code=SYS&local_base=nkc
2001 @ 03 @ 20 @ Mini Max @ http://aleph.nkp.cz/F/?func=find-b&request=000991146&find_code=SYS&local_base=nkc
2001 @ 03 @ 21 @ Motor journal @ http://aleph.nkp.cz/F/?func=find-b&request=000991250&find_code=SYS&local_base=nkc
2001 @ 03 @ 22 @ Náchodský nečas @ http://aleph.nkp.cz/F/?func=find-b&request=000992832&find_code=SYS&local_base=nkc
2001 @ 03 @ 23 @ Necenzurovaný libušsko-písnický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000992066&find_code=SYS&local_base=nkc
2001 @ 03 @ 24 @ www Nemlib.cz @ http://aleph.nkp.cz/F/?func=find-b&request=000993448&find_code=SYS&local_base=nkc
2001 @ 03 @ 25 @ Neurologie pro praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000991418&find_code=SYS&local_base=nkc
2001 @ 03 @ 26 @ Novoknínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000992046&find_code=SYS&local_base=nkc
2001 @ 03 @ 27 @ Octopus @ http://aleph.nkp.cz/F/?func=find-b&request=000991728&find_code=SYS&local_base=nkc
2001 @ 03 @ 28 @ Osobní lékař @ http://aleph.nkp.cz/F/?func=find-b&request=000993365&find_code=SYS&local_base=nkc
2001 @ 03 @ 29 @ Pivní občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000992798&find_code=SYS&local_base=nkc
2001 @ 03 @ 30 @ Popovice. Místní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000992844&find_code=SYS&local_base=nkc
2001 @ 03 @ 31 @ Potápění @ http://aleph.nkp.cz/F/?func=find-b&request=000992813&find_code=SYS&local_base=nkc
2001 @ 03 @ 32 @ Professional modern management @ http://aleph.nkp.cz/F/?func=find-b&request=000991752&find_code=SYS&local_base=nkc
2001 @ 03 @ 33 @ Průvodce rybáře @ http://aleph.nkp.cz/F/?func=find-b&request=000991831&find_code=SYS&local_base=nkc
2001 @ 03 @ 34 @ Regio magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000991302&find_code=SYS&local_base=nkc
2001 @ 03 @ 35 @ Revue Společnost @ http://aleph.nkp.cz/F/?func=find-b&request=000991683&find_code=SYS&local_base=nkc
2001 @ 03 @ 36 @ Rudolfovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000991148&find_code=SYS&local_base=nkc
2001 @ 03 @ 37 @ Severní expres @ http://aleph.nkp.cz/F/?func=find-b&request=000992072&find_code=SYS&local_base=nkc
2001 @ 03 @ 38 @ Sexy str@nky @ http://aleph.nkp.cz/F/?func=find-b&request=000991741&find_code=SYS&local_base=nkc
2001 @ 03 @ 39 @ Srbecký občasník @ http://aleph.nkp.cz/F/?func=find-b&request=000992055&find_code=SYS&local_base=nkc
2001 @ 03 @ 40 @ Svět exotických rostlin @ http://aleph.nkp.cz/F/?func=find-b&request=000993407&find_code=SYS&local_base=nkc
2001 @ 03 @ 41 @ Tap news @ http://aleph.nkp.cz/F/?func=find-b&request=000991162&find_code=SYS&local_base=nkc
2001 @ 03 @ 42 @ Transport magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000991744&find_code=SYS&local_base=nkc
2001 @ 03 @ 43 @ U plynárny 500 @ http://aleph.nkp.cz/F/?func=find-b&request=000993388&find_code=SYS&local_base=nkc
2001 @ 03 @ 44 @ Update @ http://aleph.nkp.cz/F/?func=find-b&request=000991722&find_code=SYS&local_base=nkc
2001 @ 03 @ 45 @ Vaše práva @ http://aleph.nkp.cz/F/?func=find-b&request=000991452&find_code=SYS&local_base=nkc
2001 @ 03 @ 46 @ Za starou Prahu @ http://aleph.nkp.cz/F/?func=find-b&request=000991475&find_code=SYS&local_base=nkc
2001 @ 03 @ 47 @ Zaměstnání @ http://aleph.nkp.cz/F/?func=find-b&request=000991236&find_code=SYS&local_base=nkc
2001 @ 04 @ 01 @ Alergie @ http://aleph.nkp.cz/F/?func=find-b&request=000999240&find_code=SYS&local_base=nkc
2001 @ 04 @ 02 @ Auto rating @ http://aleph.nkp.cz/F/?func=find-b&request=000998542&find_code=SYS&local_base=nkc
2001 @ 04 @ 03 @ Bassline @ http://aleph.nkp.cz/F/?func=find-b&request=000996892&find_code=SYS&local_base=nkc
2001 @ 04 @ 04 @ Borecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000998130&find_code=SYS&local_base=nkc
2001 @ 04 @ 05 @ Bulletin Klubu přátel ruské písemnosti @ http://aleph.nkp.cz/F/?func=find-b&request=000998754&find_code=SYS&local_base=nkc
2001 @ 04 @ 06 @ Cartoon network @ http://aleph.nkp.cz/F/?func=find-b&request=000998132&find_code=SYS&local_base=nkc
2001 @ 04 @ 07 @ Diabetologie @ http://aleph.nkp.cz/F/?func=find-b&request=000999243&find_code=SYS&local_base=nkc
2001 @ 04 @ 08 @ Esorea @ http://aleph.nkp.cz/F/?func=find-b&request=000998733&find_code=SYS&local_base=nkc
2001 @ 04 @ 09 @ Gastroenterologie @ http://aleph.nkp.cz/F/?func=find-b&request=000999246&find_code=SYS&local_base=nkc
2001 @ 04 @ 10 @ Holasický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000998091&find_code=SYS&local_base=nkc
2001 @ 04 @ 11 @ Informátor (OÚ Horní Domaslavice) @ http://aleph.nkp.cz/F/?func=find-b&request=000998571&find_code=SYS&local_base=nkc
2001 @ 04 @ 12 @ Lev. Nadační měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000998068&find_code=SYS&local_base=nkc
2001 @ 04 @ 13 @ Liga proti rakovině. Informační zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000999175&find_code=SYS&local_base=nkc
2001 @ 04 @ 14 @ Litovelské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000999172&find_code=SYS&local_base=nkc
2001 @ 04 @ 15 @ Luhačovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000998577&find_code=SYS&local_base=nkc
2001 @ 04 @ 16 @ Mikulášovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000999094&find_code=SYS&local_base=nkc
2001 @ 04 @ 17 @ Naše město Dolní Kounice @ http://aleph.nkp.cz/F/?func=find-b&request=000998758&find_code=SYS&local_base=nkc
2001 @ 04 @ 18 @ Německý ovčák @ http://aleph.nkp.cz/F/?func=find-b&request=000998561&find_code=SYS&local_base=nkc
2001 @ 04 @ 19 @ Neurologie a neurochirurgie @ http://aleph.nkp.cz/F/?func=find-b&request=000999250&find_code=SYS&local_base=nkc
2001 @ 04 @ 20 @ Novostrašecké listy @ http://aleph.nkp.cz/F/?func=find-b&request=000999088&find_code=SYS&local_base=nkc
2001 @ 04 @ 21 @ Novostrašecký měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000999170&find_code=SYS&local_base=nkc
2001 @ 04 @ 22 @ Pardubický bulvár @ http://aleph.nkp.cz/F/?func=find-b&request=000999084&find_code=SYS&local_base=nkc
2001 @ 04 @ 23 @ Pelhřimovský obchodník @ http://aleph.nkp.cz/F/?func=find-b&request=000999181&find_code=SYS&local_base=nkc
2001 @ 04 @ 24 @ Posel z lesa @ http://aleph.nkp.cz/F/?func=find-b&request=000977740&find_code=SYS&local_base=nkc
2001 @ 04 @ 25 @ Pozdrav ze Křtin @ http://aleph.nkp.cz/F/?func=find-b&request=000999191&find_code=SYS&local_base=nkc
2001 @ 04 @ 26 @ Půdní byt @ http://aleph.nkp.cz/F/?func=find-b&request=000998078&find_code=SYS&local_base=nkc
2001 @ 04 @ 27 @ Rakovina prsu @ http://aleph.nkp.cz/F/?func=find-b&request=000999253&find_code=SYS&local_base=nkc
2001 @ 04 @ 28 @ Rybenský pořádník @ http://aleph.nkp.cz/F/?func=find-b&request=000999261&find_code=SYS&local_base=nkc
2001 @ 04 @ 29 @ Včela. Listy občanů Havlíčkova Brodu @ http://aleph.nkp.cz/F/?func=find-b&request=000999312&find_code=SYS&local_base=nkc
2001 @ 04 @ 30 @ Vyškovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000998108&find_code=SYS&local_base=nkc
2001 @ 04 @ 31 @ Zpravodaj (Diecézní charita Brno) @ http://aleph.nkp.cz/F/?func=find-b&request=000964718&find_code=SYS&local_base=nkc
2001 @ 04 @ 32 @ Zpravodaj (Klub ekonomů) @ http://aleph.nkp.cz/F/?func=find-b&request=000999305&find_code=SYS&local_base=nkc
2001 @ 04 @ 33 @ Zpravodaj (SPAE) @ http://aleph.nkp.cz/F/?func=find-b&request=000999288&find_code=SYS&local_base=nkc
2001 @ 04 @ 34 @ Zpravodaj obce Doloplazy a části Poličky @ http://aleph.nkp.cz/F/?func=find-b&request=000998128&find_code=SYS&local_base=nkc
2001 @ 04 @ 35 @ Zpravodaj obcí Řetůvka@ Řetová a Přívrat', 'http://aleph.nkp.cz/F/?func=find-b&request=000998102&find_code=SYS&local_base=nkc
2001 @ 05 @ 01 @ Agro magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000999763&find_code=SYS&local_base=nkc
2001 @ 05 @ 02 @ Ahoj Tábor @ http://aleph.nkp.cz/F/?func=find-b&request=001000872&find_code=SYS&local_base=nkc
2001 @ 05 @ 03 @ Alis mail @ http://aleph.nkp.cz/F/?func=find-b&request=000999658&find_code=SYS&local_base=nkc
2001 @ 05 @ 04 @ Běžecký svět @ http://aleph.nkp.cz/F/?func=find-b&request=000999649&find_code=SYS&local_base=nkc
2001 @ 05 @ 05 @ Břežan @ http://aleph.nkp.cz/F/?func=find-b&request=001000900&find_code=SYS&local_base=nkc
2001 @ 05 @ 06 @ Český reiner @ http://aleph.nkp.cz/F/?func=find-b&request=001000861&find_code=SYS&local_base=nkc
2001 @ 05 @ 07 @ Dřevo a dýhy revue @ http://aleph.nkp.cz/F/?func=find-b&request=000999652&find_code=SYS&local_base=nkc
2001 @ 05 @ 08 @ Fin club @ http://aleph.nkp.cz/F/?func=find-b&request=000999949&find_code=SYS&local_base=nkc
2001 @ 05 @ 09 @ Frymburské ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=000359873&find_code=SYS&local_base=nkc
2001 @ 05 @ 10 @ Gigantos @ http://aleph.nkp.cz/F/?func=find-b&request=001000880&find_code=SYS&local_base=nkc
2001 @ 05 @ 11 @ Herálecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000658384&find_code=SYS&local_base=nkc
2001 @ 05 @ 12 @ Informace z Černé Hory @ http://aleph.nkp.cz/F/?func=find-b&request=000999674&find_code=SYS&local_base=nkc
2001 @ 05 @ 13 @ Informace z radnice (Město Lanškroun) @ http://aleph.nkp.cz/F/?func=find-b&request=001001025&find_code=SYS&local_base=nkc
2001 @ 05 @ 14 @ Informace z radnice (Obec Petrovice) @ http://aleph.nkp.cz/F/?func=find-b&request=001000647&find_code=SYS&local_base=nkc
2001 @ 05 @ 15 @ Inzertka @ http://aleph.nkp.cz/F/?func=find-b&request=001001036&find_code=SYS&local_base=nkc
2001 @ 05 @ 16 @ Jupííí @ http://aleph.nkp.cz/F/?func=find-b&request=000999957&find_code=SYS&local_base=nkc
2001 @ 05 @ 17 @ K - servis @ http://aleph.nkp.cz/F/?func=find-b&request=001000639&find_code=SYS&local_base=nkc
2001 @ 05 @ 18 @ Kamenský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001001129&find_code=SYS&local_base=nkc
2001 @ 05 @ 19 @ Karpet magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000999554&find_code=SYS&local_base=nkc
2001 @ 05 @ 20 @ Kaznějovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001000834&find_code=SYS&local_base=nkc
2001 @ 05 @ 21 @ KIAI @ http://aleph.nkp.cz/F/?func=find-b&request=000999540&find_code=SYS&local_base=nkc
2001 @ 05 @ 22 @ Komínské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000999541&find_code=SYS&local_base=nkc
2001 @ 05 @ 23 @ Kostelecké novinky @ http://aleph.nkp.cz/F/?func=find-b&request=000999675&find_code=SYS&local_base=nkc
2001 @ 05 @ 24 @ Krmivářství - krmivárstvo @ http://aleph.nkp.cz/F/?func=find-b&request=000999495&find_code=SYS&local_base=nkc
2001 @ 05 @ 25 @ Lege artis @ http://aleph.nkp.cz/F/?func=find-b&request=000999549&find_code=SYS&local_base=nkc
2001 @ 05 @ 26 @ Lišovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001000683&find_code=SYS&local_base=nkc
2001 @ 05 @ 27 @ Lomnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001001017&find_code=SYS&local_base=nkc
2001 @ 05 @ 28 @ Lukavický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001001021&find_code=SYS&local_base=nkc
2001 @ 05 @ 29 @ Luštíme o ceny @ http://aleph.nkp.cz/F/?func=find-b&request=000999756&find_code=SYS&local_base=nkc
2001 @ 05 @ 30 @ Měcholupský list @ http://aleph.nkp.cz/F/?func=find-b&request=001001029&find_code=SYS&local_base=nkc
2001 @ 05 @ 31 @ Mělnická radnice @ http://aleph.nkp.cz/F/?func=find-b&request=000999653&find_code=SYS&local_base=nkc
2001 @ 05 @ 32 @ Mikulov @ http://aleph.nkp.cz/F/?func=find-b&request=001001132&find_code=SYS&local_base=nkc
2001 @ 05 @ 33 @ Mozaika @ http://aleph.nkp.cz/F/?func=find-b&request=000999477&find_code=SYS&local_base=nkc
2001 @ 05 @ 34 @ Mšenské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000999656&find_code=SYS&local_base=nkc
2001 @ 05 @ 35 @ Nebušice @ http://aleph.nkp.cz/F/?func=find-b&request=001001006&find_code=SYS&local_base=nkc
2001 @ 05 @ 36 @ Obecní zpravodaj (Opolany) @ http://aleph.nkp.cz/F/?func=find-b&request=001000673&find_code=SYS&local_base=nkc
2001 @ 05 @ 37 @ Oskavský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001000675&find_code=SYS&local_base=nkc
2001 @ 05 @ 38 @ Pavilon @ http://aleph.nkp.cz/F/?func=find-b&request=000999987&find_code=SYS&local_base=nkc
2001 @ 05 @ 39 @ Plumlovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001001134&find_code=SYS&local_base=nkc
2001 @ 05 @ 40 @ Plus @ http://aleph.nkp.cz/F/?func=find-b&request=000999514&find_code=SYS&local_base=nkc
2001 @ 05 @ 41 @ Prague in your pocket @ http://aleph.nkp.cz/F/?func=find-b&request=000999988&find_code=SYS&local_base=nkc
2001 @ 05 @ 42 @ Primo inzert @ http://aleph.nkp.cz/F/?func=find-b&request=001000698&find_code=SYS&local_base=nkc
2001 @ 05 @ 43 @ Radon bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=000999768&find_code=SYS&local_base=nkc
2001 @ 05 @ 44 @ Redhot @ http://aleph.nkp.cz/F/?func=find-b&request=000999986&find_code=SYS&local_base=nkc
2001 @ 05 @ 45 @ Report obecního úřadu v Libušíně @ http://aleph.nkp.cz/F/?func=find-b&request=001000983&find_code=SYS&local_base=nkc
2001 @ 05 @ 46 @ Rozvoj @ http://aleph.nkp.cz/F/?func=find-b&request=001000899&find_code=SYS&local_base=nkc
2001 @ 05 @ 47 @ Spektra nátěrových hmot @ http://aleph.nkp.cz/F/?func=find-b&request=000999647&find_code=SYS&local_base=nkc
2001 @ 05 @ 48 @ Squash & badminton revue @ http://aleph.nkp.cz/F/?func=find-b&request=001000712&find_code=SYS&local_base=nkc
2001 @ 05 @ 49 @ Středoevropské politické studie @ http://aleph.nkp.cz/F/?func=find-b&request=000999580&find_code=SYS&local_base=nkc
2001 @ 05 @ 50 @ Střecha @ http://aleph.nkp.cz/F/?func=find-b&request=001000990&find_code=SYS&local_base=nkc
2001 @ 05 @ 51 @ Ševětínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001000888&find_code=SYS&local_base=nkc
2001 @ 05 @ 52 @ Technické aktuality a metodické rozhledy pro střední technické vzdělávání @ http://aleph.nkp.cz/F/?func=find-b&request=001000669&find_code=SYS&local_base=nkc
2001 @ 05 @ 53 @ Tripmag @ http://aleph.nkp.cz/F/?func=find-b&request=000999402&find_code=SYS&local_base=nkc
2001 @ 05 @ 54 @ Unhošťské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001000995&find_code=SYS&local_base=nkc
2001 @ 05 @ 55 @ Věstník Asociace muzeí a galerií ČR @ http://aleph.nkp.cz/F/?func=find-b&request=000999901&find_code=SYS&local_base=nkc
2001 @ 05 @ 56 @ Vox @ http://aleph.nkp.cz/F/?func=find-b&request=000999553&find_code=SYS&local_base=nkc
2001 @ 05 @ 57 @ Western world @ http://aleph.nkp.cz/F/?func=find-b&request=000999940&find_code=SYS&local_base=nkc
2001 @ 05 @ 58 @ Zpravodaj (Bystřice pod Lopeníkem) @ http://aleph.nkp.cz/F/?func=find-b&request=001001047&find_code=SYS&local_base=nkc
2001 @ 05 @ 59 @ Zpravodaj Britské rady @ http://aleph.nkp.cz/F/?func=find-b&request=000999377&find_code=SYS&local_base=nkc
2001 @ 05 @ 60 @ Zpravodaj obce Krmelín @ http://aleph.nkp.cz/F/?func=find-b&request=001000678&find_code=SYS&local_base=nkc
2001 @ 05 @ 61 @ Zpravodaj obce Přemyslovice @ http://aleph.nkp.cz/F/?func=find-b&request=001000843&find_code=SYS&local_base=nkc
2001 @ 05 @ 62 @ Zpravodaj obce Strážek @ http://aleph.nkp.cz/F/?func=find-b&request=001001128&find_code=SYS&local_base=nkc
2001 @ 06 @ 01 @ AgroS bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=001001577&find_code=SYS&local_base=nkc
2001 @ 06 @ 02 @ Aktuality o Slatině @ http://aleph.nkp.cz/F/?func=find-b&request=001001301&find_code=SYS&local_base=nkc
2001 @ 06 @ 03 @ Audio @ http://aleph.nkp.cz/F/?func=find-b&request=001002862&find_code=SYS&local_base=nkc
2001 @ 06 @ 04 @ Beauty forum @ http://aleph.nkp.cz/F/?func=find-b&request=001003267&find_code=SYS&local_base=nkc
2001 @ 06 @ 05 @ Bezměrovák @ http://aleph.nkp.cz/F/?func=find-b&request=001004511&find_code=SYS&local_base=nkc
2001 @ 06 @ 06 @ Bohutický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001001288&find_code=SYS&local_base=nkc
2001 @ 06 @ 07 @ Car tip @ http://aleph.nkp.cz/F/?func=find-b&request=001001793&find_code=SYS&local_base=nkc
2001 @ 06 @ 08 @ Česká kultura @ http://aleph.nkp.cz/F/?func=find-b&request=001003162&find_code=SYS&local_base=nkc
2001 @ 06 @ 09 @ Dětské křížovky a hádanky s výhrou @ http://aleph.nkp.cz/F/?func=find-b&request=001003975&find_code=SYS&local_base=nkc
2001 @ 06 @ 10 @ Dezinfekce@ dezinsekce, deratizace', 'http://aleph.nkp.cz/F/?func=find-b&request=001001830&find_code=SYS&local_base=nkc
2001 @ 06 @ 11 @ Ema @ http://aleph.nkp.cz/F/?func=find-b&request=001001822&find_code=SYS&local_base=nkc
2001 @ 06 @ 13 @ Hokej @ http://aleph.nkp.cz/F/?func=find-b&request=001003325&find_code=SYS&local_base=nkc
2001 @ 06 @ 14 @ Hotel a restaurant @ http://aleph.nkp.cz/F/?func=find-b&request=001003422&find_code=SYS&local_base=nkc
2001 @ 06 @ 15 @ HIS voice @ http://aleph.nkp.cz/F/?func=find-b&request=001003558&find_code=SYS&local_base=nkc
2001 @ 06 @ 16 @ Hostěnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001001306&find_code=SYS&local_base=nkc
2001 @ 06 @ 17 @ Interiér stavby @ http://aleph.nkp.cz/F/?func=find-b&request=001002308&find_code=SYS&local_base=nkc
2001 @ 06 @ 18 @ Inzert journal @ http://aleph.nkp.cz/F/?func=find-b&request=001001775&find_code=SYS&local_base=nkc
2001 @ 06 @ 19 @ Jasenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001003248&find_code=SYS&local_base=nkc
2001 @ 06 @ 20 @ Jesenický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001003569&find_code=SYS&local_base=nkc
2001 @ 06 @ 21 @ Ještěr @ http://aleph.nkp.cz/F/?func=find-b&request=001001503&find_code=SYS&local_base=nkc
2001 @ 06 @ 22 @ Kadeřnické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001003257&find_code=SYS&local_base=nkc
2001 @ 06 @ 23 @ Klinická výživa a intenzivní metabolická péče @ http://aleph.nkp.cz/F/?func=find-b&request=001003283&find_code=SYS&local_base=nkc
2001 @ 06 @ 24 @ Kniha osmisměrek @ http://aleph.nkp.cz/F/?func=find-b&request=001003984&find_code=SYS&local_base=nkc
2001 @ 06 @ 25 @ Kontakt @ http://aleph.nkp.cz/F/?func=find-b&request=001001497&find_code=SYS&local_base=nkc
2001 @ 06 @ 26 @ Křížovky na ... @ http://aleph.nkp.cz/F/?func=find-b&request=001004004&find_code=SYS&local_base=nkc
2001 @ 06 @ 27 @ Ledčické novinky @ http://aleph.nkp.cz/F/?func=find-b&request=001003238&find_code=SYS&local_base=nkc
2001 @ 06 @ 28 @ Listy Budějovicka @ http://aleph.nkp.cz/F/?func=find-b&request=001001296&find_code=SYS&local_base=nkc
2001 @ 06 @ 29 @ Listy Lanškrounska @ http://aleph.nkp.cz/F/?func=find-b&request=001001197&find_code=SYS&local_base=nkc
2001 @ 06 @ 30 @ Losiňáček @ http://aleph.nkp.cz/F/?func=find-b&request=001003591&find_code=SYS&local_base=nkc
2001 @ 06 @ 31 @ Lučinský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001003590&find_code=SYS&local_base=nkc
2001 @ 06 @ 32 @ Luštíme o ceny @ http://aleph.nkp.cz/F/?func=find-b&request=001001978&find_code=SYS&local_base=nkc
2001 @ 06 @ 33 @ Maxi křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001003482&find_code=SYS&local_base=nkc
2001 @ 06 @ 34 @ Mezi řádky @ http://aleph.nkp.cz/F/?func=find-b&request=001003236&find_code=SYS&local_base=nkc
2001 @ 06 @ 35 @ Morava @ http://aleph.nkp.cz/F/?func=find-b&request=001002006&find_code=SYS&local_base=nkc
2001 @ 06 @ 36 @ Muškař a vazač @ http://aleph.nkp.cz/F/?func=find-b&request=001001481&find_code=SYS&local_base=nkc
2001 @ 06 @ 37 @ New express @ http://aleph.nkp.cz/F/?func=find-b&request=001003136&find_code=SYS&local_base=nkc
2001 @ 06 @ 38 @ Nové Králicko @ http://aleph.nkp.cz/F/?func=find-b&request=001001286&find_code=SYS&local_base=nkc
2001 @ 06 @ 39 @ Oáza @ http://aleph.nkp.cz/F/?func=find-b&request=001001761&find_code=SYS&local_base=nkc
2001 @ 06 @ 40 @ Od Horácka k Podyjí @ http://aleph.nkp.cz/F/?func=find-b&request=001001641&find_code=SYS&local_base=nkc
2001 @ 06 @ 41 @ Okno @ http://aleph.nkp.cz/F/?func=find-b&request=001001634&find_code=SYS&local_base=nkc
2001 @ 06 @ 42 @ Orientační běh @ http://aleph.nkp.cz/F/?func=find-b&request=001004493&find_code=SYS&local_base=nkc
2001 @ 06 @ 43 @ Orin @ http://aleph.nkp.cz/F/?func=find-b&request=001003970&find_code=SYS&local_base=nkc
2001 @ 06 @ 44 @ Pace news @ http://aleph.nkp.cz/F/?func=find-b&request=001002114&find_code=SYS&local_base=nkc
2001 @ 06 @ 45 @ Pátecký plátek @ http://aleph.nkp.cz/F/?func=find-b&request=001002114&find_code=SYS&local_base=nkc
2001 @ 06 @ 46 @ Phyto news @ http://aleph.nkp.cz/F/?func=find-b&request=001002106&find_code=SYS&local_base=nkc
2001 @ 06 @ 47 @ Písecký servis @ http://aleph.nkp.cz/F/?func=find-b&request=001001584&find_code=SYS&local_base=nkc
2001 @ 06 @ 48 @ Pracovní info-služby @ http://aleph.nkp.cz/F/?func=find-b&request=001001995&find_code=SYS&local_base=nkc
2001 @ 06 @ 49 @ Příbramský servis @ http://aleph.nkp.cz/F/?func=find-b&request=001001582&find_code=SYS&local_base=nkc
2001 @ 06 @ 50 @ Realitní noviny (JZ Čechy) @ http://aleph.nkp.cz/F/?func=find-b&request=001002087&find_code=SYS&local_base=nkc
2001 @ 06 @ 51 @ Realitní noviny (Moravské) @ http://aleph.nkp.cz/F/?func=find-b&request=001002096&find_code=SYS&local_base=nkc
2001 @ 06 @ 52 @ Realitní noviny (Střední Čechy) @ http://aleph.nkp.cz/F/?func=find-b&request=001002076&find_code=SYS&local_base=nkc
2001 @ 06 @ 53 @ Report @ http://aleph.nkp.cz/F/?func=find-b&request=001002333&find_code=SYS&local_base=nkc
2001 @ 06 @ 54 @ Revue Proglas @ http://aleph.nkp.cz/F/?func=find-b&request=001002849&find_code=SYS&local_base=nkc
2001 @ 06 @ 55 @ Ruce a nehty @ http://aleph.nkp.cz/F/?func=find-b&request=001003270&find_code=SYS&local_base=nkc
2001 @ 06 @ 56 @ Rybský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001003570&find_code=SYS&local_base=nkc
2001 @ 06 @ 57 @ Sedlčansko-votické info @ http://aleph.nkp.cz/F/?func=find-b&request=001002757&find_code=SYS&local_base=nkc
2001 @ 06 @ 58 @ Senožatské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001003662&find_code=SYS&local_base=nkc
2001 @ 06 @ 59 @ Servis @ http://aleph.nkp.cz/F/?func=find-b&request=001001562&find_code=SYS&local_base=nkc
2001 @ 06 @ 60 @ Sirius @ http://aleph.nkp.cz/F/?func=find-b&request=001001566&find_code=SYS&local_base=nkc
2001 @ 06 @ 61 @ Slovanský jih @ http://aleph.nkp.cz/F/?func=find-b&request=001002845&find_code=SYS&local_base=nkc
2001 @ 06 @ 62 @ Sokolnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001003855&find_code=SYS&local_base=nkc
2001 @ 06 @ 63 @ Svět čerstvých potravin @ http://aleph.nkp.cz/F/?func=find-b&request=001001588&find_code=SYS&local_base=nkc
2001 @ 06 @ 64 @ Svět kina @ http://aleph.nkp.cz/F/?func=find-b&request=001001619&find_code=SYS&local_base=nkc
2001 @ 06 @ 65 @ Šťastný Jim @ http://aleph.nkp.cz/F/?func=find-b&request=001002018&find_code=SYS&local_base=nkc
2001 @ 06 @ 66 @ TeliaCall @ http://aleph.nkp.cz/F/?func=find-b&request=001003433&find_code=SYS&local_base=nkc
2001 @ 06 @ 67 @ Turistický zpravodaj Klubu turistů TJ Praga @ http://aleph.nkp.cz/F/?func=find-b&request=001001500&find_code=SYS&local_base=nkc
2001 @ 06 @ 68 @ Újezdský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001002756&find_code=SYS&local_base=nkc
2001 @ 06 @ 69 @ Vaňkoviny @ http://aleph.nkp.cz/F/?func=find-b&request=001003479&find_code=SYS&local_base=nkc
2001 @ 06 @ 70 @ Veletrhy @ http://aleph.nkp.cz/F/?func=find-b&request=001003439&find_code=SYS&local_base=nkc
2001 @ 06 @ 71 @ Verměřovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001001189&find_code=SYS&local_base=nkc
2001 @ 06 @ 72 @ Věstník vlády pro orgány krajů@ okresní úřady a orgány obcí', 'http://aleph.nkp.cz/F/?func=find-b&request=001003176&find_code=SYS&local_base=nkc
2001 @ 06 @ 73 @ Vítkovice news @ http://aleph.nkp.cz/F/?func=find-b&request=001002265&find_code=SYS&local_base=nkc
2001 @ 06 @ 74 @ Vltavín @ http://aleph.nkp.cz/F/?func=find-b&request=001001241&find_code=SYS&local_base=nkc
2001 @ 06 @ 75 @ Vox Karviná @ http://aleph.nkp.cz/F/?func=find-b&request=001001627&find_code=SYS&local_base=nkc
2001 @ 06 @ 76 @ Vox pediatrie @ http://aleph.nkp.cz/F/?func=find-b&request=001001487&find_code=SYS&local_base=nkc
2001 @ 06 @ 77 @ Vsetínské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001003824&find_code=SYS&local_base=nkc
2001 @ 06 @ 78 @ Všudybyl @ http://aleph.nkp.cz/F/?func=find-b&request=001004312&find_code=SYS&local_base=nkc
2001 @ 06 @ 79 @ Západočeská energetika @ http://aleph.nkp.cz/F/?func=find-b&request=001001509&find_code=SYS&local_base=nkc
2001 @ 06 @ 80 @ Závišan @ http://aleph.nkp.cz/F/?func=find-b&request=001003593&find_code=SYS&local_base=nkc
2001 @ 06 @ 81 @ Železnorudsko @ http://aleph.nkp.cz/F/?func=find-b&request=001003597&find_code=SYS&local_base=nkc
2001 @ 06 @ 82 @ Zličínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001001512&find_code=SYS&local_base=nkc
2001 @ 06 @ 83 @ Zloboj @ http://aleph.nkp.cz/F/?func=find-b&request=001001313&find_code=SYS&local_base=nkc
2001 @ 06 @ 84 @ Zpravodaj (Asociace ústavů sociální péče v ČR) @ http://aleph.nkp.cz/F/?func=find-b&request=001003964&find_code=SYS&local_base=nkc
2001 @ 06 @ 85 @ Zpravodaj (Jaderná elektrárna Dukovany) @ http://aleph.nkp.cz/F/?func=find-b&request=001004504&find_code=SYS&local_base=nkc
2001 @ 06 @ 86 @ Zpravodaj (město Židlochovice) @ http://aleph.nkp.cz/F/?func=find-b&request=001002920&find_code=SYS&local_base=nkc
2001 @ 06 @ 87 @ Zpravodaj (obec Mokrá-Horákov) @ http://aleph.nkp.cz/F/?func=find-b&request=001003659&find_code=SYS&local_base=nkc
2001 @ 06 @ 88 @ Zpravodaj (Odborné vzdělávání v zahraničí) @ http://aleph.nkp.cz/F/?func=find-b&request=001003465&find_code=SYS&local_base=nkc
2001 @ 06 @ 89 @ Zpravodaj (Středisko služeb školám a IT Karviná) @ http://aleph.nkp.cz/F/?func=find-b&request=001001477&find_code=SYS&local_base=nkc
2001 @ 06 @ 90 @ Zpravodaj ČSVV @ http://aleph.nkp.cz/F/?func=find-b&request=001002014&find_code=SYS&local_base=nkc
2001 @ 06 @ 91 @ Zpravodaj Johnson Controls @ http://aleph.nkp.cz/F/?func=find-b&request=001004526&find_code=SYS&local_base=nkc
2001 @ 06 @ 92 @ Zpravodaj města Žebráku @ http://aleph.nkp.cz/F/?func=find-b&request=001003755&find_code=SYS&local_base=nkc
2001 @ 06 @ 93 @ Zpravodaj městského úřadu v Rajhradě @ http://aleph.nkp.cz/F/?func=find-b&request=001002246&find_code=SYS&local_base=nkc
2001 @ 06 @ 94 @ Zpravodaj obce Svatobořice-Mistřín @ http://aleph.nkp.cz/F/?func=find-b&request=001003840&find_code=SYS&local_base=nkc
2001 @ 06 @ 95 @ Zpravodaj plus @ http://aleph.nkp.cz/F/?func=find-b&request=001003873&find_code=SYS&local_base=nkc
2001 @ 06 @ 96 @ Zpravodaj pro personalisty a ředitele @ http://aleph.nkp.cz/F/?func=find-b&request=001001612&find_code=SYS&local_base=nkc
2001 @ 06 @ 97 @ Zvířata @ http://aleph.nkp.cz/F/?func=find-b&request=001002758&find_code=SYS&local_base=nkc
2001 @ 06 @ 98 @ Žižkovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001001192&find_code=SYS&local_base=nkc
2001 @ 07 @ 01 @ Airedale terrier @ http://aleph.nkp.cz/F/?func=find-b&request=001005359&find_code=SYS&local_base=nkc
2001 @ 07 @ 02 @ Blok @ http://aleph.nkp.cz/F/?func=find-b&request=001004942&find_code=SYS&local_base=nkc
2001 @ 07 @ 03 @ Bosonožský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001005228&find_code=SYS&local_base=nkc
2001 @ 07 @ 04 @ Budějovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001004664&find_code=SYS&local_base=nkc
2001 @ 07 @ 05 @ Bulteno de Esperantista Klubo en Praha @ http://aleph.nkp.cz/F/?func=find-b&request=001005371&find_code=SYS&local_base=nkc
2001 @ 07 @ 06 @ Bušovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001004772&find_code=SYS&local_base=nkc
2001 @ 07 @ 07 @ Campus @ http://aleph.nkp.cz/F/?func=find-b&request=001004660&find_code=SYS&local_base=nkc
2001 @ 07 @ 08 @ Cesta @ http://aleph.nkp.cz/F/?func=find-b&request=001007370&find_code=SYS&local_base=nkc
2001 @ 07 @ 09 @ Common law review @ http://aleph.nkp.cz/F/?func=find-b&request=001004963&find_code=SYS&local_base=nkc
2001 @ 07 @ 10 @ Což takhle dát si osmisměrky? @ http://aleph.nkp.cz/F/?func=find-b&request=001005270&find_code=SYS&local_base=nkc
2001 @ 07 @ 11 @ Což takhle dát si švédské křížovky? @ http://aleph.nkp.cz/F/?func=find-b&request=001005272&find_code=SYS&local_base=nkc
2001 @ 07 @ 12 @ Czech cooperator @ http://aleph.nkp.cz/F/?func=find-b&request=001005223&find_code=SYS&local_base=nkc
2001 @ 07 @ 13 @ ČTI! (Český Telecom Informuje) @ http://aleph.nkp.cz/F/?func=find-b&request=001004661&find_code=SYS&local_base=nkc
2001 @ 07 @ 14 @ Ďáblík @ http://aleph.nkp.cz/F/?func=find-b&request=001004974&find_code=SYS&local_base=nkc
2001 @ 07 @ 15 @ Dobrovodský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001004756&find_code=SYS&local_base=nkc
2001 @ 07 @ 16 @ Drak @ http://aleph.nkp.cz/F/?func=find-b&request=001005256&find_code=SYS&local_base=nkc
2001 @ 07 @ 17 @ Dubský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001006429&find_code=SYS&local_base=nkc
2001 @ 07 @ 18 @ Erotické švédské křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001004767&find_code=SYS&local_base=nkc
2001 @ 07 @ 19 @ Euro magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001004684&find_code=SYS&local_base=nkc
2001 @ 07 @ 20 @ Chabařovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001004691&find_code=SYS&local_base=nkc
2001 @ 07 @ 21 @ Chotečský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001004755&find_code=SYS&local_base=nkc
2001 @ 07 @ 22 @ Informační list (Dobřichovice) @ http://aleph.nkp.cz/F/?func=find-b&request=001004676&find_code=SYS&local_base=nkc
2001 @ 07 @ 23 @ Informační zpravodaj chovatelů holubů @ http://aleph.nkp.cz/F/?func=find-b&request=001005227&find_code=SYS&local_base=nkc
2001 @ 07 @ 24 @ Informátor (obec Pustějov) @ http://aleph.nkp.cz/F/?func=find-b&request=001004685&find_code=SYS&local_base=nkc
2001 @ 07 @ 25 @ Jednička @ http://aleph.nkp.cz/F/?func=find-b&request=001004989&find_code=SYS&local_base=nkc
2001 @ 07 @ 26 @ Jezeráček @ http://aleph.nkp.cz/F/?func=find-b&request=001005044&find_code=SYS&local_base=nkc
2001 @ 07 @ 27 @ Kapří svět @ http://aleph.nkp.cz/F/?func=find-b&request=001005101&find_code=SYS&local_base=nkc
2001 @ 07 @ 28 @ Kartografie a geoinformatika @ http://aleph.nkp.cz/F/?func=find-b&request=001004949&find_code=SYS&local_base=nkc
2001 @ 07 @ 29 @ Kněževák @ http://aleph.nkp.cz/F/?func=find-b&request=001005225&find_code=SYS&local_base=nkc
2001 @ 07 @ 30 @ Křížovkářská všehochuť @ http://aleph.nkp.cz/F/?func=find-b&request=001004760&find_code=SYS&local_base=nkc
2001 @ 07 @ 31 @ Křížovkářský trhák @ http://aleph.nkp.cz/F/?func=find-b&request=001004769&find_code=SYS&local_base=nkc
2001 @ 07 @ 32 @ Liběchovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001005235&find_code=SYS&local_base=nkc
2001 @ 07 @ 33 @ Listy Muzejního spolku v Pardubicích @ http://aleph.nkp.cz/F/?func=find-b&request=001004970&find_code=SYS&local_base=nkc
2001 @ 07 @ 34 @ Mariánskolázeňské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001004668&find_code=SYS&local_base=nkc
2001 @ 07 @ 35 @ Mini Cosmogirl! @ http://aleph.nkp.cz/F/?func=find-b&request=001005266&find_code=SYS&local_base=nkc
2001 @ 07 @ 36 @ Moje 1. noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001004673&find_code=SYS&local_base=nkc
2001 @ 07 @ 37 @ Moravskotřebovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001004337&find_code=SYS&local_base=nkc
2001 @ 07 @ 38 @ Nejen knižní novin(k)y @ http://aleph.nkp.cz/F/?func=find-b&request=001005080&find_code=SYS&local_base=nkc
2001 @ 07 @ 39 @ Oftalmologie @ http://aleph.nkp.cz/F/?func=find-b&request=001005746&find_code=SYS&local_base=nkc
2001 @ 07 @ 40 @ Patriot @ http://aleph.nkp.cz/F/?func=find-b&request=001004922&find_code=SYS&local_base=nkc
2001 @ 07 @ 41 @ Permoník @ http://aleph.nkp.cz/F/?func=find-b&request=001004754&find_code=SYS&local_base=nkc
2001 @ 07 @ 42 @ Posádka Vyškov @ http://aleph.nkp.cz/F/?func=find-b&request=001006182&find_code=SYS&local_base=nkc
2001 @ 07 @ 43 @ The Prague Carrousel @ http://aleph.nkp.cz/F/?func=find-b&request=001004656&find_code=SYS&local_base=nkc
2001 @ 07 @ 44 @ Prométheus @ http://aleph.nkp.cz/F/?func=find-b&request=001005240&find_code=SYS&local_base=nkc
2001 @ 07 @ 45 @ Předškolák @ http://aleph.nkp.cz/F/?func=find-b&request=001006192&find_code=SYS&local_base=nkc
2001 @ 07 @ 46 @ Puchejř @ http://aleph.nkp.cz/F/?func=find-b&request=001006297&find_code=SYS&local_base=nkc
2001 @ 07 @ 47 @ Radnice @ http://aleph.nkp.cz/F/?func=find-b&request=001004761&find_code=SYS&local_base=nkc
2001 @ 07 @ 48 @ Ráj švédských křížovek plus @ http://aleph.nkp.cz/F/?func=find-b&request=001004759&find_code=SYS&local_base=nkc
2001 @ 07 @ 49 @ RealCity @ http://aleph.nkp.cz/F/?func=find-b&request=001005363&find_code=SYS&local_base=nkc
2001 @ 07 @ 50 @ Rožmitálsko @ http://aleph.nkp.cz/F/?func=find-b&request=001006318&find_code=SYS&local_base=nkc
2001 @ 07 @ 51 @ Scan @ http://aleph.nkp.cz/F/?func=find-b&request=001006205&find_code=SYS&local_base=nkc
2001 @ 07 @ 52 @ Setkávání @ http://aleph.nkp.cz/F/?func=find-b&request=001004518&find_code=SYS&local_base=nkc
2001 @ 07 @ 53 @ Super magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001005361&find_code=SYS&local_base=nkc
2001 @ 07 @ 54 @ Světelský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001004768&find_code=SYS&local_base=nkc
2001 @ 07 @ 55 @ Špicl @ http://aleph.nkp.cz/F/?func=find-b&request=001005365&find_code=SYS&local_base=nkc
2001 @ 07 @ 56 @ TV anténa @ http://aleph.nkp.cz/F/?func=find-b&request=001006544&find_code=SYS&local_base=nkc
2001 @ 07 @ 57 @ Větrník @ http://aleph.nkp.cz/F/?func=find-b&request=001005246&find_code=SYS&local_base=nkc
2001 @ 07 @ 58 @ Víkend @ http://aleph.nkp.cz/F/?func=find-b&request=001006394&find_code=SYS&local_base=nkc
2001 @ 07 @ 59 @ Vinohradský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001006199&find_code=SYS&local_base=nkc
2001 @ 07 @ 60 @ Zpravodaj - občasník (SZdP ČR) @ http://aleph.nkp.cz/F/?func=find-b&request=001005350&find_code=SYS&local_base=nkc
2001 @ 07 @ 61 @ Zpravodaj (Městský úřad Klimkovice) @ http://aleph.nkp.cz/F/?func=find-b&request=001006096&find_code=SYS&local_base=nkc
2001 @ 07 @ 62 @ Zpravodaj města Štramberka @ http://aleph.nkp.cz/F/?func=find-b&request=001004408&find_code=SYS&local_base=nkc
2001 @ 07 @ 63 @ Zpravodaj města Velké Opatovice @ http://aleph.nkp.cz/F/?func=find-b&request=001006158&find_code=SYS&local_base=nkc
2001 @ 07 @ 64 @ Zpravodaj nemocnice Třinec @ http://aleph.nkp.cz/F/?func=find-b&request=000999193&find_code=SYS&local_base=nkc
2001 @ 07 @ 65 @ Zpravodaj obce Tisá @ http://aleph.nkp.cz/F/?func=find-b&request=001002281&find_code=SYS&local_base=nkc
2001 @ 07 @ 66 @ Zpravodaj Obecního úřadu v Krhovicích @ http://aleph.nkp.cz/F/?func=find-b&request=001005267&find_code=SYS&local_base=nkc
2001 @ 08 @ 01 @ Airedale terrier @ http://aleph.nkp.cz/F/?func=find-b&request=001005359&find_code=SYS&local_base=nkc
2001 @ 08 @ 02 @ Blok @ http://aleph.nkp.cz/F/?func=find-b&request=001004942&find_code=SYS&local_base=nkc
2001 @ 08 @ 03 @ Bosonožský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001005228&find_code=SYS&local_base=nkc
2001 @ 08 @ 04 @ Budějovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001004664&find_code=SYS&local_base=nkc
2001 @ 08 @ 05 @ Bulteno de Esperantista Klubo en Praha @ http://aleph.nkp.cz/F/?func=find-b&request=001005371&find_code=SYS&local_base=nkc
2001 @ 08 @ 06 @ Bušovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001004772&find_code=SYS&local_base=nkc
2001 @ 08 @ 07 @ Campus @ http://aleph.nkp.cz/F/?func=find-b&request=001004660&find_code=SYS&local_base=nkc
2001 @ 08 @ 08 @ Cesta @ http://aleph.nkp.cz/F/?func=find-b&request=001007370&find_code=SYS&local_base=nkc
2001 @ 08 @ 09 @ Common law review @ http://aleph.nkp.cz/F/?func=find-b&request=001004963&find_code=SYS&local_base=nkc
2001 @ 08 @ 10 @ Což takhle dát si osmisměrky? @ http://aleph.nkp.cz/F/?func=find-b&request=001005270&find_code=SYS&local_base=nkc
2001 @ 08 @ 11 @ Což takhle dát si švédské křížovky? @ http://aleph.nkp.cz/F/?func=find-b&request=001005272&find_code=SYS&local_base=nkc
2001 @ 08 @ 12 @ Czech cooperator @ http://aleph.nkp.cz/F/?func=find-b&request=001005223&find_code=SYS&local_base=nkc
2001 @ 08 @ 13 @ ČTI! (Český Telecom Informuje) @ http://aleph.nkp.cz/F/?func=find-b&request=001004661&find_code=SYS&local_base=nkc
2001 @ 08 @ 14 @ Ďáblík @ http://aleph.nkp.cz/F/?func=find-b&request=001004974&find_code=SYS&local_base=nkc
2001 @ 08 @ 15 @ Dobrovodský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001004756&find_code=SYS&local_base=nkc
2001 @ 08 @ 16 @ Drak @ http://aleph.nkp.cz/F/?func=find-b&request=001005256&find_code=SYS&local_base=nkc
2001 @ 08 @ 17 @ Dubský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001006429&find_code=SYS&local_base=nkc
2001 @ 08 @ 18 @ Erotické švédské křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001004767&find_code=SYS&local_base=nkc
2001 @ 08 @ 19 @ Euro magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001004684&find_code=SYS&local_base=nkc
2001 @ 08 @ 20 @ Chabařovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001004691&find_code=SYS&local_base=nkc
2001 @ 08 @ 21 @ Chotečský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001004755&find_code=SYS&local_base=nkc
2001 @ 08 @ 22 @ Informační list (Dobřichovice) @ http://aleph.nkp.cz/F/?func=find-b&request=001004676&find_code=SYS&local_base=nkc
2001 @ 08 @ 23 @ Informační zpravodaj chovatelů holubů @ http://aleph.nkp.cz/F/?func=find-b&request=001005227&find_code=SYS&local_base=nkc
2001 @ 08 @ 24 @ Informátor (obec Pustějov) @ http://aleph.nkp.cz/F/?func=find-b&request=001004685&find_code=SYS&local_base=nkc
2001 @ 08 @ 25 @ Jednička @ http://aleph.nkp.cz/F/?func=find-b&request=001004989&find_code=SYS&local_base=nkc
2001 @ 08 @ 26 @ Jezeráček @ http://aleph.nkp.cz/F/?func=find-b&request=001005044&find_code=SYS&local_base=nkc
2001 @ 08 @ 27 @ Kapří svět @ http://aleph.nkp.cz/F/?func=find-b&request=001005101&find_code=SYS&local_base=nkc
2001 @ 08 @ 28 @ Kartografie a geoinformatika @ http://aleph.nkp.cz/F/?func=find-b&request=001004949&find_code=SYS&local_base=nkc
2001 @ 08 @ 29 @ Kněževák @ http://aleph.nkp.cz/F/?func=find-b&request=001005225&find_code=SYS&local_base=nkc
2001 @ 08 @ 30 @ Křížovkářská všehochuť @ http://aleph.nkp.cz/F/?func=find-b&request=001004760&find_code=SYS&local_base=nkc
2001 @ 08 @ 31 @ Křížovkářský trhák @ http://aleph.nkp.cz/F/?func=find-b&request=001004769&find_code=SYS&local_base=nkc
2001 @ 08 @ 32 @ Liběchovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001005235&find_code=SYS&local_base=nkc
2001 @ 08 @ 33 @ Listy Muzejního spolku v Pardubicích @ http://aleph.nkp.cz/F/?func=find-b&request=001004970&find_code=SYS&local_base=nkc
2001 @ 08 @ 34 @ Mariánskolázeňské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001004668&find_code=SYS&local_base=nkc
2001 @ 08 @ 35 @ Mini Cosmogirl! @ http://aleph.nkp.cz/F/?func=find-b&request=001005266&find_code=SYS&local_base=nkc
2001 @ 08 @ 36 @ Moje 1. noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001004673&find_code=SYS&local_base=nkc
2001 @ 08 @ 37 @ Moravskotřebovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001004337&find_code=SYS&local_base=nkc
2001 @ 08 @ 38 @ Nejen knižní novin(k)y @ http://aleph.nkp.cz/F/?func=find-b&request=001005080&find_code=SYS&local_base=nkc
2001 @ 08 @ 39 @ Oftalmologie @ http://aleph.nkp.cz/F/?func=find-b&request=001005746&find_code=SYS&local_base=nkc
2001 @ 08 @ 40 @ Patriot @ http://aleph.nkp.cz/F/?func=find-b&request=001004922&find_code=SYS&local_base=nkc
2001 @ 08 @ 41 @ Permoník @ http://aleph.nkp.cz/F/?func=find-b&request=001004754&find_code=SYS&local_base=nkc
2001 @ 08 @ 42 @ Posádka Vyškov @ http://aleph.nkp.cz/F/?func=find-b&request=001006182&find_code=SYS&local_base=nkc
2001 @ 08 @ 43 @ The Prague Carrousel @ http://aleph.nkp.cz/F/?func=find-b&request=001004656&find_code=SYS&local_base=nkc
2001 @ 08 @ 44 @ Prométheus @ http://aleph.nkp.cz/F/?func=find-b&request=001005240&find_code=SYS&local_base=nkc
2001 @ 08 @ 45 @ Předškolák @ http://aleph.nkp.cz/F/?func=find-b&request=001006192&find_code=SYS&local_base=nkc
2001 @ 08 @ 46 @ Puchejř @ http://aleph.nkp.cz/F/?func=find-b&request=001006297&find_code=SYS&local_base=nkc
2001 @ 08 @ 47 @ Radnice @ http://aleph.nkp.cz/F/?func=find-b&request=001004761&find_code=SYS&local_base=nkc
2001 @ 08 @ 48 @ Ráj švédských křížovek plus @ http://aleph.nkp.cz/F/?func=find-b&request=001004759&find_code=SYS&local_base=nkc
2001 @ 08 @ 49 @ RealCity @ http://aleph.nkp.cz/F/?func=find-b&request=001005363&find_code=SYS&local_base=nkc
2001 @ 08 @ 50 @ Rožmitálsko @ http://aleph.nkp.cz/F/?func=find-b&request=001006318&find_code=SYS&local_base=nkc
2001 @ 08 @ 51 @ Scan @ http://aleph.nkp.cz/F/?func=find-b&request=001006205&find_code=SYS&local_base=nkc
2001 @ 08 @ 52 @ Setkávání @ http://aleph.nkp.cz/F/?func=find-b&request=001004518&find_code=SYS&local_base=nkc
2001 @ 08 @ 53 @ Super magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001005361&find_code=SYS&local_base=nkc
2001 @ 08 @ 54 @ Světelský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001004768&find_code=SYS&local_base=nkc
2001 @ 08 @ 55 @ Špicl @ http://aleph.nkp.cz/F/?func=find-b&request=001005365&find_code=SYS&local_base=nkc
2001 @ 08 @ 56 @ TV anténa @ http://aleph.nkp.cz/F/?func=find-b&request=001006544&find_code=SYS&local_base=nkc
2001 @ 08 @ 57 @ Větrník @ http://aleph.nkp.cz/F/?func=find-b&request=001005246&find_code=SYS&local_base=nkc
2001 @ 08 @ 58 @ Víkend @ http://aleph.nkp.cz/F/?func=find-b&request=001006394&find_code=SYS&local_base=nkc
2001 @ 08 @ 59 @ Vinohradský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001006199&find_code=SYS&local_base=nkc
2001 @ 08 @ 60 @ Zpravodaj - občasník (SZdP ČR) @ http://aleph.nkp.cz/F/?func=find-b&request=001005350&find_code=SYS&local_base=nkc
2001 @ 08 @ 61 @ Zpravodaj (Městský úřad Klimkovice) @ http://aleph.nkp.cz/F/?func=find-b&request=001006096&find_code=SYS&local_base=nkc
2001 @ 08 @ 62 @ Zpravodaj města Štramberka @ http://aleph.nkp.cz/F/?func=find-b&request=001004408&find_code=SYS&local_base=nkc
2001 @ 08 @ 63 @ Zpravodaj města Velké Opatovice @ http://aleph.nkp.cz/F/?func=find-b&request=001006158&find_code=SYS&local_base=nkc
2001 @ 08 @ 64 @ Zpravodaj nemocnice Třinec @ http://aleph.nkp.cz/F/?func=find-b&request=000999193&find_code=SYS&local_base=nkc
2001 @ 08 @ 65 @ Zpravodaj obce Tisá @ http://aleph.nkp.cz/F/?func=find-b&request=001002281&find_code=SYS&local_base=nkc
2001 @ 08 @ 66 @ Zpravodaj Obecního úřadu v Krhovicích @ http://aleph.nkp.cz/F/?func=find-b&request=001005267&find_code=SYS&local_base=nkc
2001 @ 09 @ 01 @ Acta musealia @ http://aleph.nkp.cz/F/?func=find-b&request=001023248&find_code=SYS&local_base=nkc
2001 @ 09 @ 02 @ Bulletin České komory architektů @ http://aleph.nkp.cz/F/?func=find-b&request=001023596&find_code=SYS&local_base=nkc
2001 @ 09 @ 03 @ Bulletin česko-polského pohraničí @ http://aleph.nkp.cz/F/?func=find-b&request=001022467&find_code=SYS&local_base=nkc
2001 @ 09 @ 04 @ Čas videa @ http://aleph.nkp.cz/F/?func=find-b&request=001023109&find_code=SYS&local_base=nkc
2001 @ 09 @ 05 @ Čerčanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001023354&find_code=SYS&local_base=nkc
2001 @ 09 @ 06 @ Dobrman @ http://aleph.nkp.cz/F/?func=find-b&request=001023097&find_code=SYS&local_base=nkc
2001 @ 09 @ 07 @ Družstevní informační bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=001023332&find_code=SYS&local_base=nkc
2001 @ 09 @ 08 @ Informace pro lékařské praxe @ http://aleph.nkp.cz/F/?func=find-b&request=001023485&find_code=SYS&local_base=nkc
2001 @ 09 @ 09 @ Inka @ http://aleph.nkp.cz/F/?func=find-b&request=001023600&find_code=SYS&local_base=nkc
2001 @ 09 @ 10 @ Inside @ http://aleph.nkp.cz/F/?func=find-b&request=001023708&find_code=SYS&local_base=nkc
2001 @ 09 @ 11 @ Kosmetika Drogerie @ http://aleph.nkp.cz/F/?func=find-b&request=001023593&find_code=SYS&local_base=nkc
2001 @ 09 @ 12 @ Kritické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001023222&find_code=SYS&local_base=nkc
2001 @ 09 @ 13 @ Magazín MIK @ http://aleph.nkp.cz/F/?func=find-b&request=001023736&find_code=SYS&local_base=nkc
2001 @ 09 @ 14 @ Modrá planeta @ http://aleph.nkp.cz/F/?func=find-b&request=001023105&find_code=SYS&local_base=nkc
2001 @ 09 @ 15 @ Nabídka zaměstnání a služeb @ http://aleph.nkp.cz/F/?func=find-b&request=001023214&find_code=SYS&local_base=nkc
2001 @ 09 @ 16 @ Náš miláček @ http://aleph.nkp.cz/F/?func=find-b&request=001023480&find_code=SYS&local_base=nkc
2001 @ 09 @ 17 @ Oáza (Olomouc a okolí) @ http://aleph.nkp.cz/F/?func=find-b&request=001023355&find_code=SYS&local_base=nkc
2001 @ 09 @ 18 @ Oáza (Prostějov a okolí) @ http://aleph.nkp.cz/F/?func=find-b&request=001023089&find_code=SYS&local_base=nkc
2001 @ 09 @ 19 @ Oáza (Šumperk@ Zábřeh)', 'http://aleph.nkp.cz/F/?func=find-b&request=001023087&find_code=SYS&local_base=nkc
2001 @ 09 @ 20 @ Oáza (Uničov@ Litovel …)', 'http://aleph.nkp.cz/F/?func=find-b&request=001023088&find_code=SYS&local_base=nkc
2001 @ 09 @ 21 @ Obec aktuálně @ http://aleph.nkp.cz/F/?func=find-b&request=001023796&find_code=SYS&local_base=nkc
2001 @ 09 @ 22 @ Obvodní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001023066&find_code=SYS&local_base=nkc
2001 @ 09 @ 23 @ OK.CZ.LIFE @ http://aleph.nkp.cz/F/?func=find-b&request=001023567&find_code=SYS&local_base=nkc
2001 @ 09 @ 24 @ Oko @ http://aleph.nkp.cz/F/?func=find-b&request=001023359&find_code=SYS&local_base=nkc
2001 @ 09 @ 25 @ Panorama @ http://aleph.nkp.cz/F/?func=find-b&request=001023689&find_code=SYS&local_base=nkc
2001 @ 09 @ 26 @ Paprsek @ http://aleph.nkp.cz/F/?func=find-b&request=001023368&find_code=SYS&local_base=nkc
2001 @ 09 @ 27 @ Payo @ http://aleph.nkp.cz/F/?func=find-b&request=001023495&find_code=SYS&local_base=nkc
2001 @ 09 @ 28 @ Porodní asistentka @ http://aleph.nkp.cz/F/?func=find-b&request=001023450&find_code=SYS&local_base=nkc
2001 @ 09 @ 29 @ Poštovní holub @ http://aleph.nkp.cz/F/?func=find-b&request=001023502&find_code=SYS&local_base=nkc
2001 @ 09 @ 30 @ Prezentace stavebních materiálů @ http://aleph.nkp.cz/F/?func=find-b&request=001023460&find_code=SYS&local_base=nkc
2001 @ 09 @ 31 @ Prosečský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001023240&find_code=SYS&local_base=nkc
2001 @ 09 @ 32 @ Příspěvky k ústecké vlastivědě @ http://aleph.nkp.cz/F/?func=find-b&request=001023339&find_code=SYS&local_base=nkc
2001 @ 09 @ 33 @ Quakinoviny @ http://aleph.nkp.cz/F/?func=find-b&request=001023341&find_code=SYS&local_base=nkc
2001 @ 09 @ 34 @ Show people! @ http://aleph.nkp.cz/F/?func=find-b&request=001023722&find_code=SYS&local_base=nkc
2001 @ 09 @ 35 @ Schnauzer bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=001023679&find_code=SYS&local_base=nkc
2001 @ 09 @ 36 @ Společenskovědní předměty @ http://aleph.nkp.cz/F/?func=find-b&request=001023363&find_code=SYS&local_base=nkc
2001 @ 09 @ 37 @ Turistické noviny Vysočiny (česky@ německy)', 'http://aleph.nkp.cz/F/?func=find-b&request=001023782&find_code=SYS&local_base=nkc
2001 @ 09 @ 38 @ Zpravodaj (ČSPÚ) @ http://aleph.nkp.cz/F/?func=find-b&request=001023237&find_code=SYS&local_base=nkc
2001 @ 09 @ 39 @ Zpravodaj Klubu francouzských buldočků @ http://aleph.nkp.cz/F/?func=find-b&request=001023511&find_code=SYS&local_base=nkc
2001 @ 09 @ 40 @ Zpravodaj obce Čermná nad Orlicí @ http://aleph.nkp.cz/F/?func=find-b&request=001022475&find_code=SYS&local_base=nkc
2001 @ 09 @ 41 @ Zpravodaj Společnosti křesťanů a Židů @ http://aleph.nkp.cz/F/?func=find-b&request=001023578&find_code=SYS&local_base=nkc
2001 @ 10 @ 01 @ Abilympijský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001028238&find_code=SYS&local_base=nkc
2001 @ 10 @ 02 @ Adiktologie @ http://aleph.nkp.cz/F/?func=find-b&request=001024152&find_code=SYS&local_base=nkc
2001 @ 10 @ 03 @ Adrenalin rush @ http://aleph.nkp.cz/F/?func=find-b&request=001026203&find_code=SYS&local_base=nkc
2001 @ 10 @ 04 @ Aral klub @ http://aleph.nkp.cz/F/?func=find-b&request=001024204&find_code=SYS&local_base=nkc
2001 @ 10 @ 05 @ Armaturář @ http://aleph.nkp.cz/F/?func=find-b&request=001024333&find_code=SYS&local_base=nkc
2001 @ 10 @ 06 @ České listy @ http://aleph.nkp.cz/F/?func=find-b&request=001028050&find_code=SYS&local_base=nkc
2001 @ 10 @ 07 @ DC-servis @ http://aleph.nkp.cz/F/?func=find-b&request=001024494&find_code=SYS&local_base=nkc
2001 @ 10 @ 08 @ Demokrat Vysočiny @ http://aleph.nkp.cz/F/?func=find-b&request=001027287&find_code=SYS&local_base=nkc
2001 @ 10 @ 09 @ Divadelní hromada @ http://aleph.nkp.cz/F/?func=find-b&request=001024612&find_code=SYS&local_base=nkc
2001 @ 10 @ 10 @ Economic revue @ http://aleph.nkp.cz/F/?func=find-b&request=001024230&find_code=SYS&local_base=nkc
2001 @ 10 @ 11 @ Evidence personální agentury JOB Kolín @ http://aleph.nkp.cz/F/?func=find-b&request=001001978&find_code=SYS&local_base=nkc
2001 @ 10 @ 12 @ Evropská inspirace @ http://aleph.nkp.cz/F/?func=find-b&request=001024491&find_code=SYS&local_base=nkc
2001 @ 10 @ 13 @ Exota @ http://aleph.nkp.cz/F/?func=find-b&request=001024076&find_code=SYS&local_base=nkc
2001 @ 10 @ 14 @ Gender@ rovné příležitosti, výzkum', 'http://aleph.nkp.cz/F/?func=find-b&request=001024831&find_code=SYS&local_base=nkc
2001 @ 10 @ 15 @ Hypo zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001025240&find_code=SYS&local_base=nkc
2001 @ 10 @ 16 @ Chudenický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001024952&find_code=SYS&local_base=nkc
2001 @ 10 @ 17 @ Ideální noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001027281&find_code=SYS&local_base=nkc
2001 @ 10 @ 18 @ Jihlavský týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=001024657&find_code=SYS&local_base=nkc
2001 @ 10 @ 19 @ Klub anglického bull terriera @ http://aleph.nkp.cz/F/?func=find-b&request=001025215&find_code=SYS&local_base=nkc
2001 @ 10 @ 20 @ Knižní značka @ http://aleph.nkp.cz/F/?func=find-b&request=001028038&find_code=SYS&local_base=nkc
2001 @ 10 @ 21 @ Komínské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001024216&find_code=SYS&local_base=nkc
2001 @ 10 @ 22 @ Křížovky plné vtipů @ http://aleph.nkp.cz/F/?func=find-b&request=001024651&find_code=SYS&local_base=nkc
2001 @ 10 @ 23 @ Křížovky pro začínající @ http://aleph.nkp.cz/F/?func=find-b&request=001024611&find_code=SYS&local_base=nkc
2001 @ 10 @ 24 @ Kult @ http://aleph.nkp.cz/F/?func=find-b&request=001027915&find_code=SYS&local_base=nkc
2001 @ 10 @ 25 @ Libčické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001024661&find_code=SYS&local_base=nkc
2001 @ 10 @ 26 @ Luxusní luštění @ http://aleph.nkp.cz/F/?func=find-b&request=001024649&find_code=SYS&local_base=nkc
2001 @ 10 @ 28 @ Měsíční zpravodaj novobystřických občanů @ http://aleph.nkp.cz/F/?func=find-b&request=001025295&find_code=SYS&local_base=nkc
2001 @ 10 @ 29 @ Mini Cosmopolitan @ http://aleph.nkp.cz/F/?func=find-b&request=001027250&find_code=SYS&local_base=nkc
2001 @ 10 @ 30 @ Minor @ http://aleph.nkp.cz/F/?func=find-b&request=001023734&find_code=SYS&local_base=nkc
2001 @ 10 @ 31 @ Moderní domácí paní @ http://aleph.nkp.cz/F/?func=find-b&request=001024047&find_code=SYS&local_base=nkc
2001 @ 10 @ 32 @ Národně sociální výzva @ http://aleph.nkp.cz/F/?func=find-b&request=001024937&find_code=SYS&local_base=nkc
2001 @ 10 @ 33 @ Naše město @ http://aleph.nkp.cz/F/?func=find-b&request=001025278&find_code=SYS&local_base=nkc
2001 @ 10 @ 34 @ Největší osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001024654&find_code=SYS&local_base=nkc
2001 @ 10 @ 35 @ Notes from the North @ http://aleph.nkp.cz/F/?func=find-b&request=001024192&find_code=SYS&local_base=nkc
2001 @ 10 @ 36 @ Obecní zpravodaj (Šerkovice) @ http://aleph.nkp.cz/F/?func=find-b&request=001026171&find_code=SYS&local_base=nkc
2001 @ 10 @ 37 @ Osmisměrky a rekordy @ http://aleph.nkp.cz/F/?func=find-b&request=001024337&find_code=SYS&local_base=nkc
2001 @ 10 @ 38 @ Otrokovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001024381&find_code=SYS&local_base=nkc
2001 @ 10 @ 39 @ Pro krotitele osmisměrek @ http://aleph.nkp.cz/F/?func=find-b&request=001024342&find_code=SYS&local_base=nkc
2001 @ 10 @ 40 @ Rigips magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001025083&find_code=SYS&local_base=nkc
2001 @ 10 @ 41 @ Rozluštěný a vyluštěný @ http://aleph.nkp.cz/F/?func=find-b&request=001024338&find_code=SYS&local_base=nkc
2001 @ 10 @ 42 @ Speciál kačer Donald @ http://aleph.nkp.cz/F/?func=find-b&request=001024780&find_code=SYS&local_base=nkc
2001 @ 10 @ 43 @ Square meal @ http://aleph.nkp.cz/F/?func=find-b&request=001024813&find_code=SYS&local_base=nkc
2001 @ 10 @ 44 @ Stavební noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001025221&find_code=SYS&local_base=nkc
2001 @ 10 @ 45 @ Střípky @ http://aleph.nkp.cz/F/?func=find-b&request=001025101&find_code=SYS&local_base=nkc
2001 @ 10 @ 46 @ Studia theologica @ http://aleph.nkp.cz/F/?func=find-b&request=001024079&find_code=SYS&local_base=nkc
2001 @ 10 @ 47 @ Svítání @ http://aleph.nkp.cz/F/?func=find-b&request=001024993&find_code=SYS&local_base=nkc
2001 @ 10 @ 48 @ Špígl @ http://aleph.nkp.cz/F/?func=find-b&request=001024486&find_code=SYS&local_base=nkc
2001 @ 10 @ 49 @ Švédské křížovky plné vtipů @ http://aleph.nkp.cz/F/?func=find-b&request=001024343&find_code=SYS&local_base=nkc
2001 @ 10 @ 50 @ Tajenky o sex rekordech a kuriozitách @ http://aleph.nkp.cz/F/?func=find-b&request=001024823&find_code=SYS&local_base=nkc
2001 @ 10 @ 51 @ Ťip ťop @ http://aleph.nkp.cz/F/?func=find-b&request=001024380&find_code=SYS&local_base=nkc
2001 @ 10 @ 52 @ Tryska @ http://aleph.nkp.cz/F/?func=find-b&request=000357850&find_code=SYS&local_base=nkc
2001 @ 10 @ 53 @ Týnecké listy @ http://aleph.nkp.cz/F/?func=find-b&request=001024379&find_code=SYS&local_base=nkc
2001 @ 10 @ 54 @ Unique one @ http://aleph.nkp.cz/F/?func=find-b&request=001026190&find_code=SYS&local_base=nkc
2001 @ 10 @ 55 @ Universalia @ http://aleph.nkp.cz/F/?func=find-b&request=001023985&find_code=SYS&local_base=nkc
2001 @ 10 @ 56 @ Velkobystřické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001024446&find_code=SYS&local_base=nkc
2001 @ 10 @ 57 @ Věstník ÚSKVBL @ http://aleph.nkp.cz/F/?func=find-b&request=001027922&find_code=SYS&local_base=nkc
2001 @ 10 @ 58 @ Vox pediatriae @ http://aleph.nkp.cz/F/?func=find-b&request=001028031&find_code=SYS&local_base=nkc
2001 @ 10 @ 59 @ Znojemský týden @ http://aleph.nkp.cz/F/?func=find-b&request=001024819&find_code=SYS&local_base=nkc
2001 @ 10 @ 60 @ Zpravodaj (Český Krumlov) @ http://aleph.nkp.cz/F/?func=find-b&request=001023988&find_code=SYS&local_base=nkc
2001 @ 10 @ 61 @ Zpravodaj (Klub laryngektomovaných) @ http://aleph.nkp.cz/F/?func=find-b&request=001025164&find_code=SYS&local_base=nkc
2001 @ 10 @ 62 @ Zpravodaj (Městská část Lysolaje) @ http://aleph.nkp.cz/F/?func=find-b&request=001026178&find_code=SYS&local_base=nkc
2001 @ 10 @ 63 @ Zpravodaj České metrologické společnosti @ http://aleph.nkp.cz/F/?func=find-b&request=001024072&find_code=SYS&local_base=nkc
2001 @ 11 @ 01 @ Aplaus @ http://aleph.nkp.cz/F/?func=find-b&request=001032253&find_code=SYS&local_base=nkc
2001 @ 11 @ 02 @ Ať žijí osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001032126&find_code=SYS&local_base=nkc
2001 @ 11 @ 03 @ Avízo Motor @ http://aleph.nkp.cz/F/?func=find-b&request=001030902&find_code=SYS&local_base=nkc
2001 @ 11 @ 04 @ Báječné křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001032122&find_code=SYS&local_base=nkc
2001 @ 11 @ 05 @ Báječné osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001032119&find_code=SYS&local_base=nkc
2001 @ 11 @ 06 @ Bochořský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001032053&find_code=SYS&local_base=nkc
2001 @ 11 @ 07 @ Bučovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001032508&find_code=SYS&local_base=nkc
2001 @ 11 @ 08 @ Bukovanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001031912&find_code=SYS&local_base=nkc
2001 @ 11 @ 09 @ Caravan magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001030939&find_code=SYS&local_base=nkc
2001 @ 11 @ 10 @ Cesta do hlubin luštění @ http://aleph.nkp.cz/F/?func=find-b&request=001032128&find_code=SYS&local_base=nkc
2001 @ 11 @ 11 @ Časopis Společnosti instrumentářek @ http://aleph.nkp.cz/F/?func=find-b&request=001032735&find_code=SYS&local_base=nkc
2001 @ 11 @ 12 @ Česká energetika @ http://aleph.nkp.cz/F/?func=find-b&request=001030946&find_code=SYS&local_base=nkc
2001 @ 11 @ 13 @ Depeše Českého svazu ochánců přírody @ http://aleph.nkp.cz/F/?func=find-b&request=001030898&find_code=SYS&local_base=nkc
2001 @ 11 @ 14 @ Dětské lušťovky a křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001030937&find_code=SYS&local_base=nkc
2001 @ 11 @ 15 @ Elefant @ http://aleph.nkp.cz/F/?func=find-b&request=001032716&find_code=SYS&local_base=nkc
2001 @ 11 @ 16 @ EuroTelin @ http://aleph.nkp.cz/F/?func=find-b&request=001030416&find_code=SYS&local_base=nkc
2001 @ 11 @ 17 @ Everest @ http://aleph.nkp.cz/F/?func=find-b&request=001032331&find_code=SYS&local_base=nkc
2001 @ 11 @ 18 @ Ftipný šejk @ http://aleph.nkp.cz/F/?func=find-b&request=001032131&find_code=SYS&local_base=nkc
2001 @ 11 @ 19 @ Hnutí Pro život @ http://aleph.nkp.cz/F/?func=find-b&request=001032269&find_code=SYS&local_base=nkc
2001 @ 11 @ 20 @ Inwest @ http://aleph.nkp.cz/F/?func=find-b&request=001032702&find_code=SYS&local_base=nkc
2001 @ 11 @ 21 @ Je libo osmisměrky? @ http://aleph.nkp.cz/F/?func=find-b&request=001032116&find_code=SYS&local_base=nkc
2001 @ 11 @ 22 @ Jistebnický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001032357&find_code=SYS&local_base=nkc
2001 @ 11 @ 23 @ Katechetický věstník @ http://aleph.nkp.cz/F/?func=find-b&request=001030917&find_code=SYS&local_base=nkc
2001 @ 11 @ 24 @ Kyselovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001032095&find_code=SYS&local_base=nkc
2001 @ 11 @ 25 @ Lehčí křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001032117&find_code=SYS&local_base=nkc
2001 @ 11 @ 26 @ Luštěte s námi! @ http://aleph.nkp.cz/F/?func=find-b&request=001032123&find_code=SYS&local_base=nkc
2001 @ 11 @ 27 @ Meridian @ http://aleph.nkp.cz/F/?func=find-b&request=001030289&find_code=SYS&local_base=nkc
2001 @ 11 @ 28 @ Motoráj @ http://aleph.nkp.cz/F/?func=find-b&request=001030800&find_code=SYS&local_base=nkc
2001 @ 11 @ 29 @ Obecní noviny (Sobotín) @ http://aleph.nkp.cz/F/?func=find-b&request=001029281&find_code=SYS&local_base=nkc
2001 @ 11 @ 30 @ Oceán @ http://aleph.nkp.cz/F/?func=find-b&request=001032338&find_code=SYS&local_base=nkc
2001 @ 11 @ 31 @ Ostravská radnice @ http://aleph.nkp.cz/F/?func=find-b&request=001030661&find_code=SYS&local_base=nkc
2001 @ 11 @ 32 @ Pražskije ogni @ http://aleph.nkp.cz/F/?func=find-b&request=001030577&find_code=SYS&local_base=nkc
2001 @ 11 @ 33 @ Profesionál @ http://aleph.nkp.cz/F/?func=find-b&request=001030401&find_code=SYS&local_base=nkc
2001 @ 11 @ 34 @ Přibyslavský čtvrtletník @ http://aleph.nkp.cz/F/?func=find-b&request=001032349&find_code=SYS&local_base=nkc
2001 @ 11 @ 35 @ Přibyslavský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001030777&find_code=SYS&local_base=nkc
2001 @ 11 @ 36 @ Rave @ http://aleph.nkp.cz/F/?func=find-b&request=001030660&find_code=SYS&local_base=nkc
2001 @ 11 @ 37 @ Rovenské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001030767&find_code=SYS&local_base=nkc
2001 @ 11 @ 38 @ Starojický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001031869&find_code=SYS&local_base=nkc
2001 @ 11 @ 39 @ Studna @ http://aleph.nkp.cz/F/?func=find-b&request=001030649&find_code=SYS&local_base=nkc
2001 @ 11 @ 40 @ SUDOP revue @ http://aleph.nkp.cz/F/?func=find-b&request=001032041&find_code=SYS&local_base=nkc
2001 @ 11 @ 41 @ Šipkáč @ http://aleph.nkp.cz/F/?func=find-b&request=001030959&find_code=SYS&local_base=nkc
2001 @ 11 @ 42 @ UNISYS review @ http://aleph.nkp.cz/F/?func=find-b&request=001030826&find_code=SYS&local_base=nkc
2001 @ 11 @ 43 @ Uno @ http://aleph.nkp.cz/F/?func=find-b&request=001030810&find_code=SYS&local_base=nkc
2001 @ 11 @ 44 @ Věstník pro rodinu @ http://aleph.nkp.cz/F/?func=find-b&request=001030252&find_code=SYS&local_base=nkc
2001 @ 11 @ 45 @ WWW sex @ http://aleph.nkp.cz/F/?func=find-b&request=001030824&find_code=SYS&local_base=nkc
2001 @ 11 @ 46 @ Zdař bůh @ http://aleph.nkp.cz/F/?func=find-b&request=001031943&find_code=SYS&local_base=nkc
2001 @ 11 @ 47 @ Zpravodaj (Český volejbalový svaz) @ http://aleph.nkp.cz/F/?func=find-b&request=001030785&find_code=SYS&local_base=nkc
2001 @ 11 @ 48 @ Zpravodaj (ČSVTS) @ http://aleph.nkp.cz/F/?func=find-b&request=001032565&find_code=SYS&local_base=nkc
2001 @ 11 @ 49 @ Zpravodaj (Klub chovatelů málopočetných plemen psů) @ http://aleph.nkp.cz/F/?func=find-b&request=001032771&find_code=SYS&local_base=nkc
2001 @ 11 @ 50 @ Zpravodaj (Obec Křelov-Břuchotín) @ http://aleph.nkp.cz/F/?func=find-b&request=001032560&find_code=SYS&local_base=nkc
2001 @ 11 @ 51 @ Zpravodaj (Svaz chovatelů ovcí a koz v ČR) @ http://aleph.nkp.cz/F/?func=find-b&request=001031907&find_code=SYS&local_base=nkc
2001 @ 11 @ 52 @ Zpravodaj (školy okresu Šumperk) @ http://aleph.nkp.cz/F/?func=find-b&request=001032480&find_code=SYS&local_base=nkc
2001 @ 11 @ 53 @ Zpravodaj obce Bystrovany @ http://aleph.nkp.cz/F/?func=find-b&request=001030426&find_code=SYS&local_base=nkc
2001 @ 11 @ 54 @ Zpravodaj obce Drahanovice @ http://aleph.nkp.cz/F/?func=find-b&request=001030470&find_code=SYS&local_base=nkc
2001 @ 11 @ 55 @ Zpravodaj obce Hodslavice @ http://aleph.nkp.cz/F/?func=find-b&request=001032758&find_code=SYS&local_base=nkc
2001 @ 11 @ 56 @ Zpravodaj obecního úřadu Malhostovice Nuzířov @ http://aleph.nkp.cz/F/?func=find-b&request=001032720&find_code=SYS&local_base=nkc
2001 @ 11 @ 57 @ Zpravodaj sdružení Patriot @ http://aleph.nkp.cz/F/?func=find-b&request=001032766&find_code=SYS&local_base=nkc
2001 @ 11 @ 58 @ Zpravodaj územní rady ČZS Brno @ http://aleph.nkp.cz/F/?func=find-b&request=001031947&find_code=SYS&local_base=nkc
2001 @ 11 @ 59 @ Zpravodaj vojenské farmacie @ http://aleph.nkp.cz/F/?func=find-b&request=001030557&find_code=SYS&local_base=nkc
2001 @ 11 @ 60 @ Zprávy (Společnost Fr. Bílka) @ http://aleph.nkp.cz/F/?func=find-b&request=001030242&find_code=SYS&local_base=nkc
2001 @ 12 @ 01 @ 3x s dobrým koncem @ http://aleph.nkp.cz/F/?func=find-b&request=001032949&find_code=SYS&local_base=nkc
2001 @ 12 @ 02 @ Aqaristické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001035154&find_code=SYS&local_base=nkc
2001 @ 12 @ 03 @ Benvenuti a Praga @ http://aleph.nkp.cz/F/?func=find-b&request=001033468&find_code=SYS&local_base=nkc
2001 @ 12 @ 04 @ Bety @ http://aleph.nkp.cz/F/?func=find-b&request=001035376&find_code=SYS&local_base=nkc
2001 @ 12 @ 05 @ Bienvenidos a Praga @ http://aleph.nkp.cz/F/?func=find-b&request=001033443&find_code=SYS&local_base=nkc
2001 @ 12 @ 06 @ Bienvenue a Prague @ http://aleph.nkp.cz/F/?func=find-b&request=001033439&find_code=SYS&local_base=nkc
2001 @ 12 @ 07 @ Biker news @ http://aleph.nkp.cz/F/?func=find-b&request=001034872&find_code=SYS&local_base=nkc
2001 @ 12 @ 08 @ Bítovák @ http://aleph.nkp.cz/F/?func=find-b&request=001035325&find_code=SYS&local_base=nkc
2001 @ 12 @ 09 @ Citrusy @ http://aleph.nkp.cz/F/?func=find-b&request=001033494&find_code=SYS&local_base=nkc
2001 @ 12 @ 10 @ Classic Rock @ http://aleph.nkp.cz/F/?func=find-b&request=001035620&find_code=SYS&local_base=nkc
2001 @ 12 @ 11 @ Czech Phycology @ http://aleph.nkp.cz/F/?func=find-b&request=001033776&find_code=SYS&local_base=nkc
2001 @ 12 @ 12 @ Č.P. servis @ http://aleph.nkp.cz/F/?func=find-b&request=001033568&find_code=SYS&local_base=nkc
2001 @ 12 @ 13 @ Čučický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001033567&find_code=SYS&local_base=nkc
2001 @ 12 @ 14 @ Dermatologie @ http://aleph.nkp.cz/F/?func=find-b&request=001033946&find_code=SYS&local_base=nkc
2001 @ 12 @ 15 @ Dobro požalovať v Pragu @ http://aleph.nkp.cz/F/?func=find-b&request=001033435&find_code=SYS&local_base=nkc
2001 @ 12 @ 16 @ E-government @ http://aleph.nkp.cz/F/?func=find-b&request=001034683&find_code=SYS&local_base=nkc
2001 @ 12 @ 17 @ Echo @ http://aleph.nkp.cz/F/?func=find-b&request=001034368&find_code=SYS&local_base=nkc
2001 @ 12 @ 18 @ Inter Journal @ http://aleph.nkp.cz/F/?func=find-b&request=001034844&find_code=SYS&local_base=nkc
2001 @ 12 @ 19 @ Jindřichohradecký speciál @ http://aleph.nkp.cz/F/?func=find-b&request=001035163&find_code=SYS&local_base=nkc
2001 @ 12 @ 20 @ Kominický měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=001035320&find_code=SYS&local_base=nkc
2001 @ 12 @ 21 @ Korea dnes @ http://aleph.nkp.cz/F/?func=find-b&request=001033608&find_code=SYS&local_base=nkc
2001 @ 12 @ 22 @ Kukadlo @ http://aleph.nkp.cz/F/?func=find-b&request=001034354&find_code=SYS&local_base=nkc
2001 @ 12 @ 23 @ Kupontip @ http://aleph.nkp.cz/F/?func=find-b&request=001034186&find_code=SYS&local_base=nkc
2001 @ 12 @ 24 @ Lipoltické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001035328&find_code=SYS&local_base=nkc
2001 @ 12 @ 25 @ Listy kroniky @ http://aleph.nkp.cz/F/?func=find-b&request=001034656&find_code=SYS&local_base=nkc
2001 @ 12 @ 26 @ Lušti a vyhraj @ http://aleph.nkp.cz/F/?func=find-b&request=001033949&find_code=SYS&local_base=nkc
2001 @ 12 @ 27 @ Lysický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001034653&find_code=SYS&local_base=nkc
2001 @ 12 @ 28 @ Lysolajský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001033633&find_code=SYS&local_base=nkc
2001 @ 12 @ 29 @ Makeup magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001034829&find_code=SYS&local_base=nkc
2001 @ 12 @ 30 @ maXtreme @ http://aleph.nkp.cz/F/?func=find-b&request=001034688&find_code=SYS&local_base=nkc
2001 @ 12 @ 31 @ Měsíčník Zbirožsko @ http://aleph.nkp.cz/F/?func=find-b&request=001033503&find_code=SYS&local_base=nkc
2001 @ 12 @ 32 @ Metodické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001035625&find_code=SYS&local_base=nkc
2001 @ 12 @ 33 @ Mezinárodní právní revue @ http://aleph.nkp.cz/F/?func=find-b&request=001033583&find_code=SYS&local_base=nkc
2001 @ 12 @ 34 @ Mini max nemovitostí (Jičín) @ http://aleph.nkp.cz/F/?func=find-b&request=001033427&find_code=SYS&local_base=nkc
2001 @ 12 @ 35 @ Mini max nemovitostí (Náchod) @ http://aleph.nkp.cz/F/?func=find-b&request=001033422&find_code=SYS&local_base=nkc
2001 @ 12 @ 36 @ Mini max nemovitostí (Poděbrady) @ http://aleph.nkp.cz/F/?func=find-b&request=001033426&find_code=SYS&local_base=nkc
2001 @ 12 @ 37 @ Moravský sociální demokrat @ http://aleph.nkp.cz/F/?func=find-b&request=001035142&find_code=SYS&local_base=nkc
2001 @ 12 @ 38 @ Národohospodářský obzor @ http://aleph.nkp.cz/F/?func=find-b&request=001034334&find_code=SYS&local_base=nkc
2001 @ 12 @ 39 @ Nekořský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001035207&find_code=SYS&local_base=nkc
2001 @ 12 @ 40 @ Nemovitosti @ http://aleph.nkp.cz/F/?func=find-b&request=001034883&find_code=SYS&local_base=nkc
2001 @ 12 @ 41 @ Nové srdce @ http://aleph.nkp.cz/F/?func=find-b&request=001033785&find_code=SYS&local_base=nkc
2001 @ 12 @ 42 @ Nučický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001034201&find_code=SYS&local_base=nkc
2001 @ 12 @ 43 @ Obecní zpravodaj (Laškov) @ http://aleph.nkp.cz/F/?func=find-b&request=001032971&find_code=SYS&local_base=nkc
2001 @ 12 @ 44 @ Onemocnění prostaty @ http://aleph.nkp.cz/F/?func=find-b&request=001033944&find_code=SYS&local_base=nkc
2001 @ 12 @ 45 @ Osmisměrky ke kávě @ http://aleph.nkp.cz/F/?func=find-b&request=001033961&find_code=SYS&local_base=nkc
2001 @ 12 @ 46 @ Osmisměrky pele-mele @ http://aleph.nkp.cz/F/?func=find-b&request=001033990&find_code=SYS&local_base=nkc
2001 @ 12 @ 47 @ Osmisměrky plné vtipů @ http://aleph.nkp.cz/F/?func=find-b&request=001033998&find_code=SYS&local_base=nkc
2001 @ 12 @ 48 @ Osmisměrky pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=001034001&find_code=SYS&local_base=nkc
2001 @ 12 @ 49 @ Osmisměrky tajemno @ http://aleph.nkp.cz/F/?func=find-b&request=001033958&find_code=SYS&local_base=nkc
2001 @ 12 @ 50 @ Osmisměrky za bůra @ http://aleph.nkp.cz/F/?func=find-b&request=001034000&find_code=SYS&local_base=nkc
2001 @ 12 @ 51 @ Osmisměrky za lidovou cenu @ http://aleph.nkp.cz/F/?func=find-b&request=001033996&find_code=SYS&local_base=nkc
2001 @ 12 @ 52 @ Ostopovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001034835&find_code=SYS&local_base=nkc
2001 @ 12 @ 53 @ Papoušci @ http://aleph.nkp.cz/F/?func=find-b&request=001033788&find_code=SYS&local_base=nkc
2001 @ 12 @ 54 @ Pecínovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001032046&find_code=SYS&local_base=nkc
2001 @ 12 @ 55 @ Pravda Pravoslaví @ http://aleph.nkp.cz/F/?func=find-b&request=001034152&find_code=SYS&local_base=nkc
2001 @ 12 @ 56 @ Pro milovníky osmisměrek @ http://aleph.nkp.cz/F/?func=find-b&request=001034008&find_code=SYS&local_base=nkc
2001 @ 12 @ 57 @ Radniční listy (Havířov) @ http://aleph.nkp.cz/F/?func=find-b&request=001032967&find_code=SYS&local_base=nkc
2001 @ 12 @ 58 @ Radniční listy (Olomouc) @ http://aleph.nkp.cz/F/?func=find-b&request=001033278&find_code=SYS&local_base=nkc
2001 @ 12 @ 59 @ Region @ http://aleph.nkp.cz/F/?func=find-b&request=001033109&find_code=SYS&local_base=nkc
2001 @ 12 @ 60 @ Renault revue @ http://aleph.nkp.cz/F/?func=find-b&request=001034634&find_code=SYS&local_base=nkc
2001 @ 12 @ 61 @ Revmatologie @ http://aleph.nkp.cz/F/?func=find-b&request=001033941&find_code=SYS&local_base=nkc
2001 @ 12 @ 62 @ Rodinný život @ http://aleph.nkp.cz/F/?func=find-b&request=001033102&find_code=SYS&local_base=nkc
2001 @ 12 @ 63 @ Řeznické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001032931&find_code=SYS&local_base=nkc
2001 @ 12 @ 64 @ SATmagazín @ http://aleph.nkp.cz/F/?func=find-b&request=001033309&find_code=SYS&local_base=nkc
2001 @ 12 @ 65 @ Sázavské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001033104&find_code=SYS&local_base=nkc
2001 @ 12 @ 66 @ Scripta bioethica @ http://aleph.nkp.cz/F/?func=find-b&request=001033419&find_code=SYS&local_base=nkc
2001 @ 12 @ 67 @ Strážničan @ http://aleph.nkp.cz/F/?func=find-b&request=001034317&find_code=SYS&local_base=nkc
2001 @ 12 @ 68 @ Šipkáč @ http://aleph.nkp.cz/F/?func=find-b&request=001033291&find_code=SYS&local_base=nkc
2001 @ 12 @ 69 @ Švédské křížovky za bůra @ http://aleph.nkp.cz/F/?func=find-b&request=001034017&find_code=SYS&local_base=nkc
2001 @ 12 @ 70 @ Švédské křížovky za lidovou cenu @ http://aleph.nkp.cz/F/?func=find-b&request=001034013&find_code=SYS&local_base=nkc
2001 @ 12 @ 71 @ Ťip ťop (České Budějovice) @ http://aleph.nkp.cz/F/?func=find-b&request=001035352&find_code=SYS&local_base=nkc
2001 @ 12 @ 72 @ Ťip ťop (Táborsko) @ http://aleph.nkp.cz/F/?func=find-b&request=001035349&find_code=SYS&local_base=nkc
2001 @ 12 @ 73 @ Top reality @ http://aleph.nkp.cz/F/?func=find-b&request=001032958&find_code=SYS&local_base=nkc
2001 @ 12 @ 74 @ Trendy ve farmakoterapii @ http://aleph.nkp.cz/F/?func=find-b&request=001032975&find_code=SYS&local_base=nkc
2001 @ 12 @ 75 @ Valnehromady.cz @ http://aleph.nkp.cz/F/?func=find-b&request=001033114&find_code=SYS&local_base=nkc
2001 @ 12 @ 76 @ Veltruské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001034364&find_code=SYS&local_base=nkc
2001 @ 12 @ 77 @ Video Domácí Kino @ http://aleph.nkp.cz/F/?func=find-b&request=001034669&find_code=SYS&local_base=nkc
2001 @ 12 @ 78 @ Vtipné švédské křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001034011&find_code=SYS&local_base=nkc
2001 @ 12 @ 79 @ Vtipy a osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001034010&find_code=SYS&local_base=nkc
2001 @ 12 @ 80 @ Výherní křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001034357&find_code=SYS&local_base=nkc
2001 @ 12 @ 81 @ Weles @ http://aleph.nkp.cz/F/?func=find-b&request=001033713&find_code=SYS&local_base=nkc
2001 @ 12 @ 82 @ Xgen @ http://aleph.nkp.cz/F/?func=find-b&request=001035695&find_code=SYS&local_base=nkc
2001 @ 12 @ 83 @ Yachting @ http://aleph.nkp.cz/F/?func=find-b&request=001033324&find_code=SYS&local_base=nkc
2001 @ 12 @ 84 @ Zajímavosti v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=001034623&find_code=SYS&local_base=nkc
2001 @ 12 @ 85 @ Zpravodaj (Asociace muskulárních dystrofiků) @ http://aleph.nkp.cz/F/?func=find-b&request=001033628&find_code=SYS&local_base=nkc
2001 @ 12 @ 86 @ Zpravodaj (Asociace turistických informačních center ČR) @ http://aleph.nkp.cz/F/?func=find-b&request=001033145&find_code=SYS&local_base=nkc
2001 @ 12 @ 87 @ Zpravodaj (Klub britských teriérů) @ http://aleph.nkp.cz/F/?func=find-b&request=001034128&find_code=SYS&local_base=nkc
2001 @ 12 @ 88 @ Zpravodaj (Klub chovatelů naháčů) @ http://aleph.nkp.cz/F/?func=find-b&request=001033721&find_code=SYS&local_base=nkc
2001 @ 12 @ 89 @ Zpravodaj (Společnost pro trvale udržitelný rozvoj) @ http://aleph.nkp.cz/F/?func=find-b&request=001033513&find_code=SYS&local_base=nkc
2001 @ 12 @ 90 @ Zpravodaj akciové společnosti Vodovody a kanalizace Mladá Boleslav @ http://aleph.nkp.cz/F/?func=find-b&request=001034840&find_code=SYS&local_base=nkc
2001 @ 12 @ 91 @ Zpravodaj ČVS @ http://aleph.nkp.cz/F/?func=find-b&request=001033706&find_code=SYS&local_base=nkc
2001 @ 12 @ 92 @ Zpravodaj Hledající @ http://aleph.nkp.cz/F/?func=find-b&request=001034118&find_code=SYS&local_base=nkc
2001 @ 12 @ 93 @ Zpravodaj Kolpingova díla České republiky @ http://aleph.nkp.cz/F/?func=find-b&request=001035220&find_code=SYS&local_base=nkc
2001 @ 12 @ 94 @ Zpravodaj města Rájce-Jestřebí @ http://aleph.nkp.cz/F/?func=find-b&request=001033601&find_code=SYS&local_base=nkc
2001 @ 12 @ 95 @ Zpravodaj našich obcí Skorkov - Podbrahy - Otradovice @ http://aleph.nkp.cz/F/?func=find-b&request=001034026&find_code=SYS&local_base=nkc
2001 @ 12 @ 96 @ Zpravodaj obce Blatec @ http://aleph.nkp.cz/F/?func=find-b&request=001034313&find_code=SYS&local_base=nkc
2001 @ 12 @ 97 @ Zpravodaj obce Hvozdnice @ http://aleph.nkp.cz/F/?func=find-b&request=001034363&find_code=SYS&local_base=nkc
2001 @ 12 @ 98 @ Zpravodaj obecního úřadu městečka Trnávky @ http://aleph.nkp.cz/F/?func=find-b&request=001034306&find_code=SYS&local_base=nkc
2001 @ 12 @ 99 @ Zpravodaj obecního úřadu Studnice @ http://aleph.nkp.cz/F/?func=find-b&request=001033766&find_code=SYS&local_base=nkc
2001 @ 12 @ 100 @ Zprávy (Jihomoravská energetika) @ http://aleph.nkp.cz/F/?func=find-b&request=001034899&find_code=SYS&local_base=nkc
2001 @ 12 @ 101 @ Zprávy Charity @ http://aleph.nkp.cz/F/?func=find-b&request=001033733&find_code=SYS&local_base=nkc
2003 @ 02 @ 01 @ Anesteziologie a intenzivní medicína @ http://aleph.nkp.cz/F/?func=find-b&request=001239462&find_code=SYS&local_base=nkc
2003 @ 02 @ 02 @ Atletické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001239387&find_code=SYS&local_base=nkc
2003 @ 02 @ 03 @ Bělští radní informují @ http://aleph.nkp.cz/F/?func=find-b&request=001201521&find_code=SYS&local_base=nkc
2003 @ 02 @ 04 @ Bez starosti @ http://aleph.nkp.cz/F/?func=find-b&request=001201492&find_code=SYS&local_base=nkc
2003 @ 02 @ 05 @ Bohdíkovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001202871&find_code=SYS&local_base=nkc
2003 @ 02 @ 06 @ Bžanský čtvrtletník @ http://aleph.nkp.cz/F/?func=find-b&request=001239396&find_code=SYS&local_base=nkc
2003 @ 02 @ 07 @ Centres journal @ http://aleph.nkp.cz/F/?func=find-b&request=001201504&find_code=SYS&local_base=nkc
2003 @ 02 @ 08 @ DiViDi @ http://aleph.nkp.cz/F/?func=find-b&request=001203722&find_code=SYS&local_base=nkc
2003 @ 02 @ 09 @ DJKT @ http://aleph.nkp.cz/F/?func=find-b&request=001202852&find_code=SYS&local_base=nkc
2003 @ 02 @ 10 @ Dobré zprávy @ http://aleph.nkp.cz/F/?func=find-b&request=001239407&find_code=SYS&local_base=nkc
2003 @ 02 @ 11 @ Dvůr Králové nad Labem @ http://aleph.nkp.cz/F/?func=find-b&request=001239323&find_code=SYS&local_base=nkc
2003 @ 02 @ 12 @ Exota @ http://aleph.nkp.cz/F/?func=find-b&request=001203731&find_code=SYS&local_base=nkc
2003 @ 02 @ 13 @ Finance magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001239401&find_code=SYS&local_base=nkc
2003 @ 02 @ 14 @ Floor ball @ http://aleph.nkp.cz/F/?func=find-b&request=001239398&find_code=SYS&local_base=nkc
2003 @ 02 @ 15 @ Havířovský družstevník @ http://aleph.nkp.cz/F/?func=find-b&request=001239458&find_code=SYS&local_base=nkc
2003 @ 02 @ 16 @ Historia militaris @ http://aleph.nkp.cz/F/?func=find-b&request=001202874&find_code=SYS&local_base=nkc
2003 @ 02 @ 17 @ Hlava @ http://aleph.nkp.cz/F/?func=find-b&request=001201506&find_code=SYS&local_base=nkc
2003 @ 02 @ 18 @ Horoskokřížovky o lásce @ http://aleph.nkp.cz/F/?func=find-b&request=001201497&find_code=SYS&local_base=nkc
2003 @ 02 @ 19 @ Horoskokřížovky speciál @ http://aleph.nkp.cz/F/?func=find-b&request=001203734&find_code=SYS&local_base=nkc
2003 @ 02 @ 20 @ Hu-Fa úsměvy @ http://aleph.nkp.cz/F/?func=find-b&request=001239408&find_code=SYS&local_base=nkc
2003 @ 02 @ 21 @ Informační list @ http://aleph.nkp.cz/F/?func=find-b&request=001201471&find_code=SYS&local_base=nkc
2003 @ 02 @ 22 @ Informační zpravodaj Městského obvodu Plzeň 2-Slovany @ http://aleph.nkp.cz/F/?func=find-b&request=001201445&find_code=SYS&local_base=nkc
2003 @ 02 @ 23 @ Jehnické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001203586&find_code=SYS&local_base=nkc
2003 @ 02 @ 24 @ Katalog osobních automobilů @ http://aleph.nkp.cz/F/?func=find-b&request=001198774&find_code=SYS&local_base=nkc
2003 @ 02 @ 25 @ Kleiner Brünner Gassenbote @ http://aleph.nkp.cz/F/?func=find-b&request=001239371&find_code=SYS&local_base=nkc
2003 @ 02 @ 26 @ Kosmonoský horizont @ http://aleph.nkp.cz/F/?func=find-b&request=001203589&find_code=SYS&local_base=nkc
2003 @ 02 @ 27 @ Kovák @ http://aleph.nkp.cz/F/?func=find-b&request=001202562&find_code=SYS&local_base=nkc
2003 @ 02 @ 28 @ Královéhradecký benefit @ http://aleph.nkp.cz/F/?func=find-b&request=001201456&find_code=SYS&local_base=nkc
2003 @ 02 @ 29 @ Krásenský bodlák @ http://aleph.nkp.cz/F/?func=find-b&request=001239410&find_code=SYS&local_base=nkc
2003 @ 02 @ 30 @ KV oznamovatel @ http://aleph.nkp.cz/F/?func=find-b&request=001203741&find_code=SYS&local_base=nkc
2003 @ 02 @ 31 @ Lesu zdar @ http://aleph.nkp.cz/F/?func=find-b&request=001201516&find_code=SYS&local_base=nkc
2003 @ 02 @ 32 @ Litoměřický demokrat @ http://aleph.nkp.cz/F/?func=find-b&request=001201483&find_code=SYS&local_base=nkc
2003 @ 02 @ 33 @ Magazín Klubu Vltava @ http://aleph.nkp.cz/F/?func=find-b&request=001201515&find_code=SYS&local_base=nkc
2003 @ 02 @ 34 @ Malý hráč @ http://aleph.nkp.cz/F/?func=find-b&request=00123725&find_code=SYS&local_base=nkc
2003 @ 02 @ 35 @ Matiční zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001202853&find_code=SYS&local_base=nkc
2003 @ 02 @ 36 @ Mlejn @ http://aleph.nkp.cz/F/?func=find-b&request=001239345&find_code=SYS&local_base=nkc
2003 @ 02 @ 37 @ Moravskotřebovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001239378&find_code=SYS&local_base=nkc
2003 @ 02 @ 38 @ Náš Turnov @ http://aleph.nkp.cz/F/?func=find-b&request=001201485&find_code=SYS&local_base=nkc
2003 @ 02 @ 39 @ Nehemia info @ http://aleph.nkp.cz/F/?func=find-b&request=001239411&find_code=SYS&local_base=nkc
2003 @ 02 @ 40 @ Noviny SVK @ http://aleph.nkp.cz/F/?func=find-b&request=001201465&find_code=SYS&local_base=nkc
2003 @ 02 @ 41 @ Obecní listy @ http://aleph.nkp.cz/F/?func=find-b&request=001202831&find_code=SYS&local_base=nkc
2003 @ 02 @ 42 @ Obecní zpravodaj obce Hynčina @ http://aleph.nkp.cz/F/?func=find-b&request=001092665&find_code=SYS&local_base=nkc
2003 @ 02 @ 43 @ Obecníček Žilova a Stýskal @ http://aleph.nkp.cz/F/?func=find-b&request=001202784&find_code=SYS&local_base=nkc
2003 @ 02 @ 44 @ Ortur @ http://aleph.nkp.cz/F/?func=find-b&request=001202846&find_code=SYS&local_base=nkc
2003 @ 02 @ 45 @ Osmisměrky od Motýla @ http://aleph.nkp.cz/F/?func=find-b&request=001202774&find_code=SYS&local_base=nkc
2003 @ 02 @ 46 @ Osobní rádce zdravotní sestry @ http://aleph.nkp.cz/F/?func=find-b&request=001202780&find_code=SYS&local_base=nkc
2003 @ 02 @ 47 @ Pars pro toto @ http://aleph.nkp.cz/F/?func=find-b&request=001202803&find_code=SYS&local_base=nkc
2003 @ 02 @ 48 @ Pergamen Brána @ http://aleph.nkp.cz/F/?func=find-b&request=001202870&find_code=SYS&local_base=nkc
2003 @ 02 @ 49 @ Ploma info @ http://aleph.nkp.cz/F/?func=find-b&request=001203579&find_code=SYS&local_base=nkc
2003 @ 02 @ 50 @ Pohoda pojištěnce @ http://aleph.nkp.cz/F/?func=find-b&request=001202850&find_code=SYS&local_base=nkc
2003 @ 02 @ 51 @ Prestige @ http://aleph.nkp.cz/F/?func=find-b&request=001202929&find_code=SYS&local_base=nkc
2003 @ 02 @ 52 @ Provas @ http://aleph.nkp.cz/F/?func=find-b&request=001239417&find_code=SYS&local_base=nkc
2003 @ 02 @ 53 @ Průvodce do kapsy @ http://aleph.nkp.cz/F/?func=find-b&request=001202764&find_code=SYS&local_base=nkc
2003 @ 02 @ 54 @ Rádce brněnského zahrádkáře @ http://aleph.nkp.cz/F/?func=find-b&request=001202984&find_code=SYS&local_base=nkc
2003 @ 02 @ 55 @ Revue politika @ http://aleph.nkp.cz/F/?func=find-b&request=001202979&find_code=SYS&local_base=nkc
2003 @ 02 @ 56 @ S Motýlem na dovolenou @ http://aleph.nkp.cz/F/?func=find-b&request=001203584&find_code=SYS&local_base=nkc
2003 @ 02 @ 57 @ SaM vás informuje @ http://aleph.nkp.cz/F/?func=find-b&request=001202940&find_code=SYS&local_base=nkc
2003 @ 02 @ 58 @ Scientia agriculturae bohemica @ http://aleph.nkp.cz/F/?func=find-b&request=001203593&find_code=SYS&local_base=nkc
2003 @ 02 @ 59 @ Smíchovský obzor @ http://aleph.nkp.cz/F/?func=find-b&request=001203592&find_code=SYS&local_base=nkc
2003 @ 02 @ 60 @ Stavbař @ http://aleph.nkp.cz/F/?func=find-b&request=001203152&find_code=SYS&local_base=nkc
2003 @ 02 @ 61 @ Strojní kaleidoskop @ http://aleph.nkp.cz/F/?func=find-b&request=001202841&find_code=SYS&local_base=nkc
2003 @ 02 @ 62 @ Svět grálu @ http://aleph.nkp.cz/F/?func=find-b&request=001203140&find_code=SYS&local_base=nkc
2003 @ 02 @ 63 @ Tématický magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001202986&find_code=SYS&local_base=nkc
2003 @ 02 @ 64 @ Teologie a společnost @ http://aleph.nkp.cz/F/?func=find-b&request=001202952&find_code=SYS&local_base=nkc
2003 @ 02 @ 65 @ Testy a osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001202767&find_code=SYS&local_base=nkc
2003 @ 02 @ 66 @ Tik tak @ http://aleph.nkp.cz/F/?func=find-b&request=001202869&find_code=SYS&local_base=nkc
2003 @ 02 @ 67 @ Treking @ http://aleph.nkp.cz/F/?func=find-b&request=001202971&find_code=SYS&local_base=nkc
2003 @ 02 @ 68 @ Týdeník Domažlicko @ http://aleph.nkp.cz/F/?func=find-b&request=001203535&find_code=SYS&local_base=nkc
2003 @ 02 @ 69 @ Týdeník Chebsko @ http://aleph.nkp.cz/F/?func=find-b&request=001202958&find_code=SYS&local_base=nkc
2003 @ 02 @ 70 @ Tyjátr @ http://aleph.nkp.cz/F/?func=find-b&request=001202933&find_code=SYS&local_base=nkc
2003 @ 02 @ 71 @ Unes @ http://aleph.nkp.cz/F/?func=find-b&request=001203158&find_code=SYS&local_base=nkc
2003 @ 02 @ 72 @ Uničovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001203146&find_code=SYS&local_base=nkc
2003 @ 02 @ 73 @ Universal news @ http://aleph.nkp.cz/F/?func=find-b&request=001203565&find_code=SYS&local_base=nkc
2003 @ 02 @ 74 @ Velkolosinské prameny @ http://aleph.nkp.cz/F/?func=find-b&request=001203133&find_code=SYS&local_base=nkc
2003 @ 02 @ 75 @ Věstník kraje Vysočina @ http://aleph.nkp.cz/F/?func=find-b&request=001239419&find_code=SYS&local_base=nkc
2003 @ 02 @ 76 @ Výhody @ http://aleph.nkp.cz/F/?func=find-b&request=001203581&find_code=SYS&local_base=nkc
2003 @ 02 @ 77 @ z Radenínska @ http://aleph.nkp.cz/F/?func=find-b&request=001203585&find_code=SYS&local_base=nkc
2003 @ 02 @ 78 @ Zábřeh @ http://aleph.nkp.cz/F/?func=find-b&request=001202962&find_code=SYS&local_base=nkc
2003 @ 02 @ 79 @ Zbůšský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001239451&find_code=SYS&local_base=nkc
2003 @ 02 @ 80 @ Zdraví z orientu @ http://aleph.nkp.cz/F/?func=find-b&request=001202790&find_code=SYS&local_base=nkc
2003 @ 02 @ 81 @ Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001203558&find_code=SYS&local_base=nkc
2003 @ 02 @ 82 @ Zpravodaj (kraj Vysočina) @ http://aleph.nkp.cz/F/?func=find-b&request=001202924&find_code=SYS&local_base=nkc
2003 @ 02 @ 83 @ Zpravodaj (památník Terezín) @ http://aleph.nkp.cz/F/?func=find-b&request=001203575&find_code=SYS&local_base=nkc
2003 @ 02 @ 84 @ Zpravodaj služby škole Frýdek-Místek @ http://aleph.nkp.cz/F/?func=find-b&request=001193917&find_code=SYS&local_base=nkc
2003 @ 02 @ 85 @ Zpravodaj Sokolovská @ http://aleph.nkp.cz/F/?func=find-b&request=001239449&find_code=SYS&local_base=nkc
2003 @ 02 @ 86 @ Zpravodaj STOP @ http://aleph.nkp.cz/F/?func=find-b&request=001239412&find_code=SYS&local_base=nkc
2003 @ 02 @ 87 @ Zprávy - Psychologický ústav AV ČR @ http://aleph.nkp.cz/F/?func=find-b&request=001201440&find_code=SYS&local_base=nkc
2003 @ 02 @ 88 @ ZUŠkoviny @ http://aleph.nkp.cz/F/?func=find-b&request=001202794&find_code=SYS&local_base=nkc
2003 @ 03 @ 34 @ Tematický magazín : stavební a zemní stroje @ http://aleph.nkp.cz/F/?func=find-b&request=001241592&find_code=SYS&local_base=nkc
2003 @ 03 @ 35 @ Truck services @ http://aleph.nkp.cz/F/?func=find-b&request=001243509&find_code=SYS&local_base=nkc
2003 @ 03 @ 36 @ Týden na Humpolecku @ http://aleph.nkp.cz/F/?func=find-b&request=001241599&find_code=SYS&local_base=nkc
2003 @ 03 @ 37 @ Typo @ http://aleph.nkp.cz/F/?func=find-b&request=001241605&find_code=SYS&local_base=nkc
2003 @ 03 @ 38 @ Veleslavín @ http://aleph.nkp.cz/F/?func=find-b&request=001242925&find_code=SYS&local_base=nkc
2003 @ 03 @ 39 @ Výčepní list @ http://aleph.nkp.cz/F/?func=find-b&request=001243512&find_code=SYS&local_base=nkc
2003 @ 04 @ 01 @ Archives of general psychiatry @ http://aleph.nkp.cz/F/?func=find-b&request=000692136&find_code=SYS&local_base=nkc
2003 @ 04 @ 02 @ Babka kořenářka @ http://aleph.nkp.cz/F/?func=find-b&request=001247270&find_code=SYS&local_base=nkc
2003 @ 04 @ 03 @ Bukovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001247260&find_code=SYS&local_base=nkc
2003 @ 04 @ 04 @ Bulletin of GeoSciences @ http://aleph.nkp.cz/F/?func=find-b&request=001245964&find_code=SYS&local_base=nkc
2003 @ 04 @ 05 @ Čas @ http://aleph.nkp.cz/F/?func=find-b&request=001247288&find_code=SYS&local_base=nkc
2003 @ 04 @ 06 @ Česká geriatrická revue @ http://aleph.nkp.cz/F/?func=find-b&request=001244593&find_code=SYS&local_base=nkc
2003 @ 04 @ 07 @ Českobudějovický přehled @ http://aleph.nkp.cz/F/?func=find-b&request=001248161&find_code=SYS&local_base=nkc
2003 @ 04 @ 08 @ Dolnodvořišťský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001005080&find_code=SYS&local_base=nkc
2003 @ 04 @ 09 @ Dvouměsíčník zábavy @ http://aleph.nkp.cz/F/?func=find-b&request=001248219&find_code=SYS&local_base=nkc
2003 @ 04 @ 10 @ Edmundova a Divoká soutěska @ http://aleph.nkp.cz/F/?func=find-b&request=001247004&find_code=SYS&local_base=nkc
2003 @ 04 @ 11 @ Ftípky @ http://aleph.nkp.cz/F/?func=find-b&request=001248656&find_code=SYS&local_base=nkc
2003 @ 04 @ 12 @ Géčko @ http://aleph.nkp.cz/F/?func=find-b&request=001248155&find_code=SYS&local_base=nkc
2003 @ 04 @ 13 @ Hezký český Herriot @ http://aleph.nkp.cz/F/?func=find-b&request=001004970&find_code=SYS&local_base=nkc
2003 @ 04 @ 14 @ Hit @ http://aleph.nkp.cz/F/?func=find-b&request=001247278&find_code=SYS&local_base=nkc
2003 @ 04 @ 15 @ Hradecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000980980&find_code=SYS&local_base=nkc
2003 @ 04 @ 16 @ Hype @ http://aleph.nkp.cz/F/?func=find-b&request=001247266&find_code=SYS&local_base=nkc
2003 @ 04 @ 17 @ Chrustoš @ http://aleph.nkp.cz/F/?func=find-b&request=001247268&find_code=SYS&local_base=nkc
2003 @ 04 @ 18 @ Immaculata @ http://aleph.nkp.cz/F/?func=find-b&request=001186899&find_code=SYS&local_base=nkc
2003 @ 04 @ 19 @ Jackie @ http://aleph.nkp.cz/F/?func=find-b&request=001246998&find_code=SYS&local_base=nkc
2003 @ 04 @ 20 @ Jak na počítač @ http://aleph.nkp.cz/F/?func=find-b&request=001248661&find_code=SYS&local_base=nkc
2003 @ 04 @ 21 @ JITONA novin(k)y @ http://aleph.nkp.cz/F/?func=find-b&request=001247256&find_code=SYS&local_base=nkc
2003 @ 04 @ 22 @ KM - express @ http://aleph.nkp.cz/F/?func=find-b&request=001248171&find_code=SYS&local_base=nkc
2003 @ 04 @ 23 @ KOVO inzert @ http://aleph.nkp.cz/F/?func=find-b&request=001248688&find_code=SYS&local_base=nkc
2003 @ 04 @ 24 @ Kralupský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000528075&find_code=SYS&local_base=nkc
2003 @ 04 @ 25 @ Kultura a život @ http://aleph.nkp.cz/F/?func=find-b&request=001248158&find_code=SYS&local_base=nkc
2003 @ 04 @ 26 @ Lehčí luštění @ http://aleph.nkp.cz/F/?func=find-b&request=001248186&find_code=SYS&local_base=nkc
2003 @ 04 @ 27 @ Liaportér @ http://aleph.nkp.cz/F/?func=find-b&request=001246966&find_code=SYS&local_base=nkc
2003 @ 04 @ 28 @ Living @ http://aleph.nkp.cz/F/?func=find-b&request=001245517&find_code=SYS&local_base=nkc
2003 @ 04 @ 29 @ Luštitelův svět @ http://aleph.nkp.cz/F/?func=find-b&request=001248195&find_code=SYS&local_base=nkc
2003 @ 04 @ 30 @ Magazín EU @ http://aleph.nkp.cz/F/?func=find-b&request=001248665&find_code=SYS&local_base=nkc
2003 @ 04 @ 31 @ Manažer @ http://aleph.nkp.cz/F/?func=find-b&request=001247290&find_code=SYS&local_base=nkc
2003 @ 04 @ 32 @ Metropolis @ http://aleph.nkp.cz/F/?func=find-b&request=001248682&find_code=SYS&local_base=nkc
2003 @ 04 @ 33 @ Mini Max (Turnov) @ http://aleph.nkp.cz/F/?func=find-b&request=001244501&find_code=SYS&local_base=nkc
2003 @ 04 @ 34 @ MRP noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001247274&find_code=SYS&local_base=nkc
2003 @ 04 @ 35 @ Mysteria tajemna @ http://aleph.nkp.cz/F/?func=find-b&request=001246313&find_code=SYS&local_base=nkc
2003 @ 04 @ 36 @ Na východ od Aše @ http://aleph.nkp.cz/F/?func=find-b&request=001248659&find_code=SYS&local_base=nkc
2003 @ 04 @ 37 @ Náš zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001246978&find_code=SYS&local_base=nkc
2003 @ 04 @ 38 @ Notes @ http://aleph.nkp.cz/F/?func=find-b&request=001245974&find_code=SYS&local_base=nkc
2003 @ 04 @ 39 @ Phoenix @ http://aleph.nkp.cz/F/?func=find-b&request=001248152&find_code=SYS&local_base=nkc
2003 @ 04 @ 40 @ Plešák @ http://aleph.nkp.cz/F/?func=find-b&request=001247276&find_code=SYS&local_base=nkc
2003 @ 04 @ 41 @ Poličský zpravodaj a Jitřenka @ http://aleph.nkp.cz/F/?func=find-b&request=001245724&find_code=SYS&local_base=nkc
2003 @ 04 @ 42 @ Portus @ http://aleph.nkp.cz/F/?func=find-b&request=001244597&find_code=SYS&local_base=nkc
2003 @ 04 @ 43 @ Poustevenský posel @ http://aleph.nkp.cz/F/?func=find-b&request=001023105&find_code=SYS&local_base=nkc
2003 @ 04 @ 44 @ Puls @ http://aleph.nkp.cz/F/?func=find-b&request=001247019&find_code=SYS&local_base=nkc
2003 @ 04 @ 45 @ Radniční list @ http://aleph.nkp.cz/F/?func=find-b&request=001248658&find_code=SYS&local_base=nkc
2003 @ 04 @ 46 @ Region revue @ http://aleph.nkp.cz/F/?func=find-b&request=001246984&find_code=SYS&local_base=nkc
2003 @ 04 @ 47 @ Revue pro média @ http://aleph.nkp.cz/F/?func=find-b&request=001242917&find_code=SYS&local_base=nkc
2003 @ 04 @ 48 @ Rodeo švédských křížovek @ http://aleph.nkp.cz/F/?func=find-b&request=001248146&find_code=SYS&local_base=nkc
2003 @ 04 @ 49 @ Romano vodi @ http://aleph.nkp.cz/F/?func=find-b&request=001244602&find_code=SYS&local_base=nkc
2003 @ 04 @ 50 @ Russkoje slovo @ http://aleph.nkp.cz/F/?func=find-b&request=001246985&find_code=SYS&local_base=nkc
2003 @ 04 @ 51 @ Sex a luštění @ http://aleph.nkp.cz/F/?func=find-b&request=001248149&find_code=SYS&local_base=nkc
2003 @ 04 @ 52 @ Sky @ http://aleph.nkp.cz/F/?func=find-b&request=001246988&find_code=SYS&local_base=nkc
2003 @ 04 @ 53 @ Sport style @ http://aleph.nkp.cz/F/?func=find-b&request=001244600&find_code=SYS&local_base=nkc
2003 @ 04 @ 54 @ Teplicko a my @ http://aleph.nkp.cz/F/?func=find-b&request=001245719&find_code=SYS&local_base=nkc
2003 @ 04 @ 55 @ Týdeník Rožnovska @ http://aleph.nkp.cz/F/?func=find-b&request=000968603&find_code=SYS&local_base=nkc
2003 @ 04 @ 56 @ Velký atlas světa @ http://aleph.nkp.cz/F/?func=find-b&request=001246349&find_code=SYS&local_base=nkc
2003 @ 04 @ 57 @ Víno revue @ http://aleph.nkp.cz/F/?func=find-b&request=001246961&find_code=SYS&local_base=nkc
2003 @ 04 @ 58 @ Wolkerovy prostějowiny @ http://aleph.nkp.cz/F/?func=find-b&request=001244502&find_code=SYS&local_base=nkc
2003 @ 06 @ 01 @ 21. století @ http://aleph.nkp.cz/F/?func=find-b&request=001252504&find_code=SYS&local_base=nkc
2003 @ 06 @ 02 @ Buřinka @ http://aleph.nkp.cz/F/?func=find-b&request=001255654&find_code=SYS&local_base=nkc
2003 @ 06 @ 03 @ Česká hlava a svět vědy @ http://aleph.nkp.cz/F/?func=find-b&request=001255813&find_code=SYS&local_base=nkc
2003 @ 06 @ 04 @ EDB review @ http://aleph.nkp.cz/F/?func=find-b&request=001250995&find_code=SYS&local_base=nkc
2003 @ 06 @ 05 @ Eurorevue @ http://aleph.nkp.cz/F/?func=find-b&request=001251007&find_code=SYS&local_base=nkc
2003 @ 06 @ 06 @ Fox @ http://aleph.nkp.cz/F/?func=find-b&request=001253765&find_code=SYS&local_base=nkc
2003 @ 06 @ 07 @ Grafika Publishing news @ http://aleph.nkp.cz/F/?func=find-b&request=001250981&find_code=SYS&local_base=nkc
2003 @ 06 @ 08 @ Královopolské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001255652&find_code=SYS&local_base=nkc
2003 @ 06 @ 09 @ Křížovky pro osvěžení @ http://aleph.nkp.cz/F/?func=find-b&request=001253769&find_code=SYS&local_base=nkc
2003 @ 06 @ 10 @ Zpravodaj milovníků a pěstitelů růží @ http://aleph.nkp.cz/F/?func=find-b&request=001255628&find_code=SYS&local_base=nkc
2003 @ 07 @ 01 @ Adventure @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279755&local_base=nkc
2003 @ 07 @ 02 @ Aktual reality @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279722&local_base=nkc
2003 @ 07 @ 03 @ Alfa Romeo magazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257523&local_base=nkc
2003 @ 07 @ 04 @ Bedřich @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279266&local_base=nkc
2003 @ 07 @ 05 @ Belarusian review @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000693196&local_base=nkc
2003 @ 07 @ 06 @ Bertík @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256276&local_base=nkc
2003 @ 07 @ 07 @ Bohemika @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256327&local_base=nkc
2003 @ 07 @ 08 @ Březnické noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279729&local_base=nkc
2003 @ 07 @ 09 @ Cykloservis @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256717&local_base=nkc
2003 @ 07 @ 10 @ Czech business today @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257392&local_base=nkc
2003 @ 07 @ 11 @ Czech public opinion in a European context @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257391&local_base=nkc
2003 @ 07 @ 12 @ Čáslavské noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256542&local_base=nkc
2003 @ 07 @ 13 @ Česko-čínské inzertní noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257402&local_base=nkc
2003 @ 07 @ 14 @ DentalCare magazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279307&local_base=nkc
2003 @ 07 @ 15 @ Dia listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257395&local_base=nkc
2003 @ 07 @ 16 @ DIAlog @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257401&local_base=nkc
2003 @ 07 @ 17 @ Digitální foto @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257310&local_base=nkc
2003 @ 07 @ 18 @ DVD movie @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279683&local_base=nkc
2003 @ 07 @ 19 @ EMP @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257550&local_base=nkc
2003 @ 07 @ 20 @ Energie pro život @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279752&local_base=nkc
2003 @ 07 @ 21 @ Express @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256515&local_base=nkc
2003 @ 07 @ 22 @ Free magazine @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280253&local_base=nkc
2003 @ 07 @ 23 @ Gourmet @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279299&local_base=nkc
2003 @ 07 @ 24 @ Grátis (Prachatice@ Vimperk...)', 'http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256508&local_base=nkc
2003 @ 07 @ 25 @ Grátis (Strakonice@ Blatná...)', 'http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256504&local_base=nkc
2003 @ 07 @ 26 @ H.P. listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256504&local_base=nkc
2003 @ 07 @ 27 @ Hydro @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279744&local_base=nkc
2003 @ 07 @ 28 @ Impulsy Krušnohoří @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256336&local_base=nkc
2003 @ 07 @ 29 @ Informace OÚ Svijany @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256518&local_base=nkc
2003 @ 07 @ 30 @ Informační čtvrtletník občanů Velkého Beranova @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279004&local_base=nkc
2003 @ 07 @ 31 @ Informační noviny pro rodinnou inzerci @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256308&local_base=nkc
2003 @ 07 @ 32 @ Informační zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000312418&local_base=nkc
2003 @ 07 @ 33 @ Informační zpravodaj Zdounky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256303&local_base=nkc
2003 @ 07 @ 34 @ Infoservis @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000528424&local_base=nkc
2003 @ 07 @ 35 @ Inzertip @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280247&local_base=nkc
2003 @ 07 @ 36 @ Jesenický kurýr @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000660803&local_base=nkc
2003 @ 07 @ 37 @ Journal of diabetes and its complications @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279743&local_base=nkc
2003 @ 07 @ 38 @ Katalog bydlení @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281071&local_base=nkc
2003 @ 07 @ 39 @ Kateřinský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280218&local_base=nkc
2003 @ 07 @ 40 @ Kazuistiky v diabetologii @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257524&local_base=nkc
2003 @ 07 @ 41 @ Krajské noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256526&local_base=nkc
2003 @ 07 @ 42 @ Král horror @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256699&local_base=nkc
2003 @ 07 @ 43 @ Kraslické noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001278995&local_base=nkc
2003 @ 07 @ 44 @ Krásná paní @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256779&local_base=nkc
2003 @ 07 @ 45 @ Kris-krosy a osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256530&local_base=nkc
2003 @ 07 @ 46 @ Křepický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257262&local_base=nkc
2003 @ 07 @ 47 @ Křížovky Prima rádce @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257225&local_base=nkc
2003 @ 07 @ 48 @ Kublovské noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279359&local_base=nkc
2003 @ 07 @ 49 @ Kuchařka dle krevních skupin @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279358&local_base=nkc
2003 @ 07 @ 50 @ Kulturní tip @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280229&local_base=nkc
2003 @ 07 @ 51 @ Letonický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001004511&local_base=nkc
2003 @ 07 @ 52 @ Lhotecké noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280240&local_base=nkc
2003 @ 07 @ 53 @ Look magazine @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257521&local_base=nkc
2003 @ 07 @ 54 @ M inzert @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279360&local_base=nkc
2003 @ 07 @ 55 @ Magazín + plná hra @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256788&local_base=nkc
2003 @ 07 @ 56 @ Magazín ENAPO @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279351&local_base=nkc
2003 @ 07 @ 57 @ Magazín MK @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256298&local_base=nkc
2003 @ 07 @ 58 @ Media info @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279723&local_base=nkc
2003 @ 07 @ 59 @ Monarchistické listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257520&local_base=nkc
2003 @ 07 @ 60 @ Moravanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256799&local_base=nkc
2003 @ 07 @ 61 @ Moravskoslezský kraj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256536&local_base=nkc
2003 @ 07 @ 62 @ Muzejní noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279071&local_base=nkc
2003 @ 07 @ 63 @ Napínavé křížovky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279720&local_base=nkc
2003 @ 07 @ 64 @ Národní reality @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279361&local_base=nkc
2003 @ 07 @ 65 @ Naše doba @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001277344&local_base=nkc
2003 @ 07 @ 66 @ Naše Rudolecko @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280216&local_base=nkc
2003 @ 07 @ 67 @ New express Hodonínsko @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256316&local_base=nkc
2003 @ 07 @ 68 @ Newsletter (CEP) @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279303&local_base=nkc
2003 @ 07 @ 69 @ Novosedlické zrcadlo @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257515&local_base=nkc
2003 @ 07 @ 70 @ Nový polygon @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001277363&local_base=nkc
2003 @ 07 @ 71 @ Nr. 1 @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279748&local_base=nkc
2003 @ 07 @ 72 @ Občasník Horšicko @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279738&local_base=nkc
2003 @ 07 @ 73 @ Oraz speciál @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256778&local_base=nkc
2003 @ 07 @ 74 @ Ostudyum @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280173&local_base=nkc
2003 @ 07 @ 75 @ Papirius styl @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256808&local_base=nkc
2003 @ 07 @ 76 @ Perninské noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000699621&local_base=nkc
2003 @ 07 @ 77 @ Pro zvířata na jejich ochranu @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000359283&local_base=nkc
2003 @ 07 @ 78 @ Přírodní lékař @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280742&local_base=nkc
2003 @ 07 @ 79 @ Raport @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280784&local_base=nkc
2003 @ 07 @ 80 @ Recepty minulých staletí @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000607476&local_base=nkc
2003 @ 07 @ 81 @ Regiomix @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281038&local_base=nkc
2003 @ 07 @ 82 @ Sbírky Orac @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000356983&local_base=nkc
2003 @ 07 @ 83 @ Sfinga magazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257538&local_base=nkc
2003 @ 07 @ 84 @ Sokolík @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000360851&local_base=nkc
2003 @ 07 @ 85 @ Sport impuls @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279127&local_base=nkc
2003 @ 07 @ 86 @ Státní zastupitelství @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279687&local_base=nkc
2003 @ 07 @ 87 @ Stodolní noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280775&local_base=nkc
2003 @ 07 @ 88 @ Stuff @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280792&local_base=nkc
2003 @ 07 @ 89 @ Svět klasické kytary @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280756&local_base=nkc
2003 @ 07 @ 90 @ Tempo @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280763&local_base=nkc
2003 @ 07 @ 91 @ Trefa Českého hnutí za národní jednotu @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001181578&local_base=nkc
2003 @ 07 @ 92 @ Triatlon @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281082&local_base=nkc
2003 @ 07 @ 93 @ Trucking magazine @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279129&local_base=nkc
2003 @ 07 @ 94 @ Třemšínské listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281045&local_base=nkc
2003 @ 07 @ 95 @ TTG Czech Republic @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280834&local_base=nkc
2003 @ 07 @ 96 @ Tuning magazine @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281078&local_base=nkc
2003 @ 07 @ 97 @ TV Impuls @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281571&local_base=nkc
2003 @ 07 @ 98 @ TV program @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280822&local_base=nkc
2003 @ 07 @ 99 @ Týden na Pelhřimovsku @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256273&local_base=nkc
2003 @ 07 @ 100 @ U nás v Čakovicích @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279135&local_base=nkc
2003 @ 07 @ 101 @ U nás v kraji @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280667&local_base=nkc
2003 @ 07 @ 102 @ Únanovské novinky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280653&local_base=nkc
2003 @ 07 @ 103 @ Unitářské listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001189700&local_base=nkc
2003 @ 07 @ 104 @ Vacovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279679&local_base=nkc
2003 @ 07 @ 105 @ Varhaník @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281032&local_base=nkc
2003 @ 07 @ 106 @ Vědomické noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279128&local_base=nkc
2003 @ 07 @ 107 @ Vendolský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000358977&local_base=nkc
2003 @ 07 @ 108 @ Veronika @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279672&local_base=nkc
2003 @ 07 @ 109 @ Věstník Českého turfu @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279745&local_base=nkc
2003 @ 07 @ 110 @ Všehochuť @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257231&local_base=nkc
2003 @ 07 @ 111 @ Vtipálek @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279746&local_base=nkc
2003 @ 07 @ 112 @ Zábavné křížovky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279281&local_base=nkc
2003 @ 07 @ 113 @ Zdravotnické právo v praxi @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281079&local_base=nkc
2003 @ 07 @ 114 @ Zoom @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280649&local_base=nkc
2003 @ 07 @ 115 @ Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281025&local_base=nkc
2003 @ 07 @ 116 @ Zpravodaj/Newsletter (Židovské muzeum v Praze) @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279142&local_base=nkc
2003 @ 07 @ 117 @ Zpravodaj klubu AST @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279130&local_base=nkc
2003 @ 07 @ 118 @ Zpravodaj města Štětí @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279684&local_base=nkc
2003 @ 07 @ 119 @ Zpravodaj obce Hostim @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279072&local_base=nkc
2003 @ 08 @ 01 @ Adventure @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279755&local_base=nkc
2003 @ 08 @ 02 @ Aktual reality @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279722&local_base=nkc
2003 @ 08 @ 03 @ Alfa Romeo magazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257523&local_base=nkc
2003 @ 08 @ 04 @ Bedřich @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279266&local_base=nkc
2003 @ 08 @ 05 @ Belarusian review @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000693196&local_base=nkc
2003 @ 08 @ 06 @ Bertík @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256276&local_base=nkc
2003 @ 08 @ 07 @ Bohemika @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256327&local_base=nkc
2003 @ 08 @ 08 @ Březnické noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279729&local_base=nkc
2003 @ 08 @ 09 @ Cykloservis @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256717&local_base=nkc
2003 @ 08 @ 10 @ Czech business today @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257392&local_base=nkc
2003 @ 08 @ 11 @ Czech public opinion in a European context @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257391&local_base=nkc
2003 @ 08 @ 12 @ Čáslavské noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256542&local_base=nkc
2003 @ 08 @ 13 @ Česko-čínské inzertní noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257402&local_base=nkc
2003 @ 08 @ 14 @ DentalCare magazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279307&local_base=nkc
2003 @ 08 @ 15 @ Dia listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257395&local_base=nkc
2003 @ 08 @ 16 @ DIAlog @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257401&local_base=nkc
2003 @ 08 @ 17 @ Digitální foto @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257310&local_base=nkc
2003 @ 08 @ 18 @ DVD movie @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279683&local_base=nkc
2003 @ 08 @ 19 @ EMP @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257550&local_base=nkc
2003 @ 08 @ 20 @ Energie pro život @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279752&local_base=nkc
2003 @ 08 @ 21 @ Express @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256515&local_base=nkc
2003 @ 08 @ 22 @ Free magazine @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280253&local_base=nkc
2003 @ 08 @ 23 @ Gourmet @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279299&local_base=nkc
2003 @ 08 @ 24 @ Grátis (Prachatice@ Vimperk...)', 'http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256508&local_base=nkc
2003 @ 08 @ 25 @ Grátis (Strakonice@ Blatná...)', 'http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256504&local_base=nkc
2003 @ 08 @ 26 @ H.P. listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256504&local_base=nkc
2003 @ 08 @ 27 @ Hydro @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279744&local_base=nkc
2003 @ 08 @ 28 @ Impulsy Krušnohoří @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256336&local_base=nkc
2003 @ 08 @ 29 @ Informace OÚ Svijany @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256518&local_base=nkc
2003 @ 08 @ 30 @ Informační čtvrtletník občanů Velkého Beranova @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279004&local_base=nkc
2003 @ 08 @ 31 @ Informační noviny pro rodinnou inzerci @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256308&local_base=nkc
2003 @ 08 @ 32 @ Informační zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000312418&local_base=nkc
2003 @ 08 @ 33 @ Informační zpravodaj Zdounky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256303&local_base=nkc
2003 @ 08 @ 34 @ Infoservis @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000528424&local_base=nkc
2003 @ 08 @ 35 @ Inzertip @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280247&local_base=nkc
2003 @ 08 @ 36 @ Jesenický kurýr @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000660803&local_base=nkc
2003 @ 08 @ 37 @ Journal of diabetes and its complications @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279743&local_base=nkc
2003 @ 08 @ 38 @ Katalog bydlení @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281071&local_base=nkc
2003 @ 08 @ 39 @ Kateřinský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280218&local_base=nkc
2003 @ 08 @ 40 @ Kazuistiky v diabetologii @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257524&local_base=nkc
2003 @ 08 @ 41 @ Krajské noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256526&local_base=nkc
2003 @ 08 @ 42 @ Král horror @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256699&local_base=nkc
2003 @ 08 @ 43 @ Kraslické noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001278995&local_base=nkc
2003 @ 08 @ 44 @ Krásná paní @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256779&local_base=nkc
2003 @ 08 @ 45 @ Kris-krosy a osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256530&local_base=nkc
2003 @ 08 @ 46 @ Křepický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257262&local_base=nkc
2003 @ 08 @ 47 @ Křížovky Prima rádce @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257225&local_base=nkc
2003 @ 08 @ 48 @ Kublovské noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279359&local_base=nkc
2003 @ 08 @ 49 @ Kuchařka dle krevních skupin @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279358&local_base=nkc
2003 @ 08 @ 50 @ Kulturní tip @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280229&local_base=nkc
2003 @ 08 @ 51 @ Letonický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001004511&local_base=nkc
2003 @ 08 @ 52 @ Lhotecké noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280240&local_base=nkc
2003 @ 08 @ 53 @ Look magazine @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257521&local_base=nkc
2003 @ 08 @ 54 @ M inzert @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279360&local_base=nkc
2003 @ 08 @ 55 @ Magazín + plná hra @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256788&local_base=nkc
2003 @ 08 @ 56 @ Magazín ENAPO @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279351&local_base=nkc
2003 @ 08 @ 57 @ Magazín MK @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256298&local_base=nkc
2003 @ 08 @ 58 @ Media info @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279723&local_base=nkc
2003 @ 08 @ 59 @ Monarchistické listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257520&local_base=nkc
2003 @ 08 @ 60 @ Moravanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256799&local_base=nkc
2003 @ 08 @ 61 @ Moravskoslezský kraj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256536&local_base=nkc
2003 @ 08 @ 62 @ Muzejní noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279071&local_base=nkc
2003 @ 08 @ 63 @ Napínavé křížovky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279720&local_base=nkc
2003 @ 08 @ 64 @ Národní reality @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279361&local_base=nkc
2003 @ 08 @ 65 @ Naše doba @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001277344&local_base=nkc
2003 @ 08 @ 66 @ Naše Rudolecko @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280216&local_base=nkc
2003 @ 08 @ 67 @ New express Hodonínsko @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256316&local_base=nkc
2003 @ 08 @ 68 @ Newsletter (CEP) @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279303&local_base=nkc
2003 @ 08 @ 69 @ Novosedlické zrcadlo @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257515&local_base=nkc
2003 @ 08 @ 70 @ Nový polygon @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001277363&local_base=nkc
2003 @ 08 @ 71 @ Nr. 1 @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279748&local_base=nkc
2003 @ 08 @ 72 @ Občasník Horšicko @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279738&local_base=nkc
2003 @ 08 @ 73 @ Oraz speciál @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256778&local_base=nkc
2003 @ 08 @ 74 @ Ostudyum @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280173&local_base=nkc
2003 @ 08 @ 75 @ Papirius styl @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256808&local_base=nkc
2003 @ 08 @ 76 @ Perninské noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000699621&local_base=nkc
2003 @ 08 @ 77 @ Pro zvířata na jejich ochranu @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000359283&local_base=nkc
2003 @ 08 @ 78 @ Přírodní lékař @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280742&local_base=nkc
2003 @ 08 @ 79 @ Raport @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280784&local_base=nkc
2003 @ 08 @ 80 @ Recepty minulých staletí @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000607476&local_base=nkc
2003 @ 08 @ 81 @ Regiomix @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281038&local_base=nkc
2003 @ 08 @ 82 @ Sbírky Orac @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000356983&local_base=nkc
2003 @ 08 @ 83 @ Sfinga magazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257538&local_base=nkc
2003 @ 08 @ 84 @ Sokolík @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000360851&local_base=nkc
2003 @ 08 @ 85 @ Sport impuls @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279127&local_base=nkc
2003 @ 08 @ 86 @ Státní zastupitelství @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279687&local_base=nkc
2003 @ 08 @ 87 @ Stodolní noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280775&local_base=nkc
2003 @ 08 @ 88 @ Stuff @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280792&local_base=nkc
2003 @ 08 @ 89 @ Svět klasické kytary @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280756&local_base=nkc
2003 @ 08 @ 90 @ Tempo @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280763&local_base=nkc
2003 @ 08 @ 91 @ Trefa Českého hnutí za národní jednotu @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001181578&local_base=nkc
2003 @ 08 @ 92 @ Triatlon @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281082&local_base=nkc
2003 @ 08 @ 93 @ Trucking magazine @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279129&local_base=nkc
2003 @ 08 @ 94 @ Třemšínské listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281045&local_base=nkc
2003 @ 08 @ 95 @ TTG Czech Republic @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280834&local_base=nkc
2003 @ 08 @ 96 @ Tuning magazine @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281078&local_base=nkc
2003 @ 08 @ 97 @ TV Impuls @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281571&local_base=nkc
2003 @ 08 @ 98 @ TV program @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280822&local_base=nkc
2003 @ 08 @ 99 @ Týden na Pelhřimovsku @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001256273&local_base=nkc
2003 @ 08 @ 100 @ U nás v Čakovicích @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279135&local_base=nkc
2003 @ 08 @ 101 @ U nás v kraji @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280667&local_base=nkc
2003 @ 08 @ 102 @ Únanovské novinky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280653&local_base=nkc
2003 @ 08 @ 103 @ Unitářské listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001189700&local_base=nkc
2003 @ 08 @ 104 @ Vacovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279679&local_base=nkc
2003 @ 08 @ 105 @ Varhaník @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281032&local_base=nkc
2003 @ 08 @ 106 @ Vědomické noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279128&local_base=nkc
2003 @ 08 @ 107 @ Vendolský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000358977&local_base=nkc
2003 @ 08 @ 108 @ Veronika @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279672&local_base=nkc
2003 @ 08 @ 109 @ Věstník Českého turfu @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279745&local_base=nkc
2003 @ 08 @ 110 @ Všehochuť @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001257231&local_base=nkc
2003 @ 08 @ 111 @ Vtipálek @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279746&local_base=nkc
2003 @ 08 @ 112 @ Zábavné křížovky @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279281&local_base=nkc
2003 @ 08 @ 113 @ Zdravotnické právo v praxi @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281079&local_base=nkc
2003 @ 08 @ 114 @ Zoom @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001280649&local_base=nkc
2003 @ 08 @ 115 @ Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001281025&local_base=nkc
2003 @ 08 @ 116 @ Zpravodaj/Newsletter (Židovské muzeum v Praze) @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279142&local_base=nkc
2003 @ 08 @ 117 @ Zpravodaj klubu AST @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279130&local_base=nkc
2003 @ 08 @ 118 @ Zpravodaj města Štětí @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279684&local_base=nkc
2003 @ 08 @ 119 @ Zpravodaj obce Hostim @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001279072&local_base=nkc
2003 @ 09 @ 01 @ Dog trail @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=01182340&local_base=nkc
2003 @ 09 @ 02 @ Gastromagazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001285924&local_base=nkc
2003 @ 09 @ 03 @ GD @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286160&local_base=nkc
2003 @ 09 @ 04 @ Home @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001285038&local_base=nkc
2003 @ 09 @ 05 @ Info-panel @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001285250&local_base=nkc
2003 @ 09 @ 06 @ Karnevalmagazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001064627&local_base=nkc
2003 @ 09 @ 07 @ Kytara @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286121&local_base=nkc
2003 @ 09 @ 08 @ Loděnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001285457&local_base=nkc
2003 @ 09 @ 09 @ Medinews @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001285443&local_base=nkc
2003 @ 09 @ 10 @ Neon @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286151&local_base=nkc
2003 @ 09 @ 11 @ Oáza @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001285423&local_base=nkc
2003 @ 09 @ 12 @ Olomoucký týdeník @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001093255&local_base=nkc
2003 @ 09 @ 13 @ Paramo noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001284747&local_base=nkc
2003 @ 09 @ 14 @ Parlamentní listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001284628&local_base=nkc
2003 @ 09 @ 15 @ Rokycanské noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001284277&local_base=nkc
2003 @ 09 @ 16 @ Rybitví @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001285261&local_base=nkc
2003 @ 09 @ 17 @ Starodávná láska @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286138&local_base=nkc
2003 @ 09 @ 18 @ Teletip @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001284648&local_base=nkc
2003 @ 09 @ 19 @ Volmar @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286144&local_base=nkc
2003 @ 09 @ 20 @ Vranovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001285246&local_base=nkc
2003 @ 09 @ 21 @ Zaostřeno na drogy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001284280&local_base=nkc
2003 @ 09 @ 22 @ Zelené listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001004511&local_base=nkc
2003 @ 09 @ 23 @ Zpravodaj Českého svazu jachtingu @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001284750&local_base=nkc
2003 @ 09 @ 24 @ Zpravodaj o událostech v obci Zátor @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001093707&local_base=nkc
2003 @ 09 @ 25 @ Zpravodaj obce Písečná @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001180279&local_base=nkc
2003 @ 10 @ 02 @ APEL @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287222&local_base=nkc
2003 @ 10 @ 03 @ Babylon informací @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287229&local_base=nkc
2003 @ 10 @ 04 @ Bassline elektronik @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287514&local_base=nkc
2003 @ 10 @ 05 @ Bohemia sekt news @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286294&local_base=nkc
2003 @ 10 @ 06 @ Brána památek @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287523&local_base=nkc
2003 @ 10 @ 07 @ Bulletin (Umělecko historická společnost v českých zemích) @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287071&local_base=nkc
2003 @ 10 @ 08 @ Ceramics & glass @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286982&local_base=nkc
2003 @ 10 @ 09 @ Čechia segodnja @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287794&local_base=nkc
2003 @ 10 @ 10 @ Českoveský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287497&local_base=nkc
2003 @ 10 @ 11 @ Distribuce tisku impuls @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287018&local_base=nkc
2003 @ 10 @ 12 @ Éčko @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286435&local_base=nkc
2003 @ 10 @ 13 @ Farminews @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287663&local_base=nkc
2003 @ 10 @ 14 @ Hacking @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286417&local_base=nkc
2003 @ 10 @ 15 @ HYPO partner @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286777&local_base=nkc
2003 @ 10 @ 16 @ Chemopetrol noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286296&local_base=nkc
2003 @ 10 @ 17 @ Chotyňáček @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286436&local_base=nkc
2003 @ 10 @ 18 @ Imunologický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287683&local_base=nkc
2003 @ 10 @ 19 @ Informační čtvrtletník občanů Velkého Beranova @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287239&local_base=nkc
2003 @ 10 @ 20 @ ISPAT Nová Huť @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286725&local_base=nkc
2003 @ 10 @ 21 @ JLV expres @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287066&local_base=nkc
2003 @ 10 @ 22 @ K odpolední kávě @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287512&local_base=nkc
2003 @ 10 @ 23 @ KAM @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287509&local_base=nkc
2003 @ 10 @ 24 @ Kavárna @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287273&local_base=nkc
2003 @ 10 @ 25 @ Konzervativní listí @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286781&local_base=nkc
2003 @ 10 @ 26 @ Křečovické listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286470&local_base=nkc
2003 @ 10 @ 27 @ Křížovky : pranostiky@ horoskopy', 'http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286410&local_base=nkc
2003 @ 10 @ 28 @ Líbeznický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286431&local_base=nkc
2003 @ 10 @ 29 @ Listy města Neratovice @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289011&local_base=nkc
2003 @ 10 @ 30 @ Loděnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287653&local_base=nkc
2003 @ 10 @ 31 @ Magazín pro nevěsty @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000360563&local_base=nkc
2003 @ 10 @ 32 @ Mamut @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286404&local_base=nkc
2003 @ 10 @ 33 @ Mas magazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286783&local_base=nkc
2003 @ 10 @ 34 @ Město Děčín zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286782&local_base=nkc
2003 @ 10 @ 35 @ Mramor @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287004&local_base=nkc
2003 @ 10 @ 36 @ Národní myšlenka @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287063&local_base=nkc
2003 @ 10 @ 37 @ Nemocnice @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287278&local_base=nkc
2003 @ 10 @ 38 @ Noviny LT @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286400&local_base=nkc
2003 @ 10 @ 39 @ Obecňáček @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001288876&local_base=nkc
2003 @ 10 @ 40 @ Obecní drbna @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286412&local_base=nkc
2003 @ 10 @ 41 @ Obecní zpravodaj (Žatčany) @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287260&local_base=nkc
2003 @ 10 @ 42 @ Ogni @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287019&local_base=nkc
2003 @ 10 @ 43 @ Opavsko křížem krážem @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286715&local_base=nkc
2003 @ 10 @ 44 @ Pardubický kraj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287680&local_base=nkc
2003 @ 10 @ 45 @ Podlahy a interiéry @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286609&local_base=nkc
2003 @ 10 @ 46 @ Podzvičinsko @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286607&local_base=nkc
2003 @ 10 @ 47 @ Polygrafie revue @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001285436&local_base=nkc
2003 @ 10 @ 49 @ Pool Tester @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289854&local_base=nkc
2003 @ 10 @ 48 @ Poříčský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286730&local_base=nkc
2003 @ 10 @ 50 @ Postgraduální nefrologie @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287037&local_base=nkc
2003 @ 10 @ 51 @ Project & property @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286743&local_base=nkc
2003 @ 10 @ 52 @ Radonické noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287531&local_base=nkc
2003 @ 10 @ 53 @ Rokytka @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001089568&local_base=nkc
2003 @ 10 @ 54 @ Rozhledy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000649090&local_base=nkc
2003 @ 10 @ 55 @ Russkij anons @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287799&local_base=nkc
2003 @ 10 @ 56 @ S reality @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286441&local_base=nkc
2003 @ 10 @ 57 @ Senior tip @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287001&local_base=nkc
2003 @ 10 @ 58 @ Spike @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287535&local_base=nkc
2003 @ 10 @ 59 @ Stavební technika @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286421&local_base=nkc
2003 @ 10 @ 60 @ SvětLIK @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286571&local_base=nkc
2003 @ 10 @ 61 @ Tajdom @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000360642&local_base=nkc
2003 @ 10 @ 62 @ Ťápoviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286803&local_base=nkc
2003 @ 10 @ 63 @ Time in @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289837&local_base=nkc
2003 @ 10 @ 64 @ Travel in the Czech Republic @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286750&local_base=nkc
2003 @ 10 @ 65 @ Trmické noviny @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286739&local_base=nkc
2003 @ 10 @ 66 @ Urologické listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287269&local_base=nkc
2003 @ 10 @ 67 @ Včelnický cancálek @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289490&local_base=nkc
2003 @ 10 @ 68 @ Veletoč švédských křížovek @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286433&local_base=nkc
2003 @ 10 @ 69 @ Zprávičky z Chodouně aneb Chodouňský čtvrtletník @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286780&local_base=nkc
2003 @ 10 @ 70 @ Zpravodaj (Univerzita J.E.Purkyně v Ústí n.L.) @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287238&local_base=nkc
2003 @ 10 @ 71 @ Zpravodaj Choťánek @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286438&local_base=nkc
2003 @ 10 @ 72 @ Zpravodaj obce Prace @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286763&local_base=nkc
2003 @ 10 @ 73 @ Zpravodaj obce Švábenice @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286562&local_base=nkc
2003 @ 10 @ 74 @ Zpravodaj Obecního úřadu Sedlec @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286774&local_base=nkc
2003 @ 10 @ 75 @ Zpravodaj pro Suchdol a Sedlec @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289846&local_base=nkc
2003 @ 10 @ 76 @ Zpravodaj PTP @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286580&local_base=nkc
2003 @ 10 @ 77 @ Zpravodaj Skřipova a Hrabství @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001287228&local_base=nkc
2003 @ 10 @ 78 @ Zpravodaj Úřadu městského obvodu Pardubice 1 @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289572&local_base=nkc
2003 @ 10 @ 79 @ Zpravodaj Velkého Přítočna @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289575&local_base=nkc
2003 @ 10 @ 80 @ Žárové zinkování @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001286758&local_base=nkc
2003 @ 11 @ 01 @ Adamovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291735&local_base=nkc
2003 @ 11 @ 02 @ Agora @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001293098&local_base=nkc
2003 @ 11 @ 03 @ Agro-tip @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291893&local_base=nkc
2003 @ 11 @ 04 @ Apatyka @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291766&local_base=nkc
2003 @ 11 @ 05 @ Báječná neděle @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290367&local_base=nkc
2003 @ 11 @ 06 @ Blgari @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290509&local_base=nkc
2003 @ 11 @ 07 @ Campus medicorum @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290317&local_base=nkc
2003 @ 11 @ 08 @ Claudia @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290508&local_base=nkc
2003 @ 11 @ 09 @ Coloseum @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291871&local_base=nkc
2003 @ 11 @ 10 @ Čtení pro vás @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291931&local_base=nkc
2003 @ 11 @ 11 @ Doma atd. @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001293174&local_base=nkc
2003 @ 11 @ 12 @ Emaus @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290363&local_base=nkc
2003 @ 11 @ 13 @ Es passion @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290503&local_base=nkc
2003 @ 11 @ 14 @ Exportér @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290772&local_base=nkc
2003 @ 11 @ 15 @ Finanční poradce @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290729&local_base=nkc
2003 @ 11 @ 16 @ Hallo! @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291990&local_base=nkc
2003 @ 11 @ 17 @ Horeka @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291933&local_base=nkc
2003 @ 11 @ 18 @ Humor a luštění @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291932&local_base=nkc
2003 @ 11 @ 19 @ Husita @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290612&local_base=nkc
2003 @ 11 @ 20 @ Informační zpravodaj pro občany Liboše a Krnova @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291994&local_base=nkc
2003 @ 11 @ 21 @ Informilo @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291888&local_base=nkc
2003 @ 11 @ 22 @ Interní medicína pro praktické lékaře @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291762&local_base=nkc
2003 @ 11 @ 23 @ Iris @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290769&local_base=nkc
2003 @ 11 @ 24 @ Jeseník @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290280&local_base=nkc
2003 @ 11 @ 25 @ Juicy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000361038&local_base=nkc
2003 @ 11 @ 26 @ Kommerčenskije predloženija iz Čechii @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291656&local_base=nkc
2003 @ 11 @ 27 @ Kouká! @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291878&local_base=nkc
2003 @ 11 @ 28 @ LCS magazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001292000&local_base=nkc
2003 @ 11 @ 29 @ Luštění ke kávě @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290365&local_base=nkc
2003 @ 11 @ 30 @ Mf plus @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291900&local_base=nkc
2003 @ 11 @ 31 @ Moderní rostlinná výroba @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001292527&local_base=nkc
2003 @ 11 @ 32 @ Moderní živočišná výroba @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000738538&local_base=nkc
2003 @ 11 @ 33 @ Modletický věstník @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290305&local_base=nkc
2003 @ 11 @ 34 @ Moje zdraví @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291736&local_base=nkc
2003 @ 11 @ 35 @ Moravčan @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290308&local_base=nkc
2003 @ 11 @ 36 @ NISA report @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291924&local_base=nkc
2003 @ 11 @ 37 @ Noviny Děčínska @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290615&local_base=nkc
2003 @ 11 @ 38 @ Noviny Prahy 16 @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290610&local_base=nkc
2003 @ 11 @ 39 @ Obecní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289586&local_base=nkc
2003 @ 11 @ 40 @ Panel plus @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289882&local_base=nkc
2003 @ 11 @ 41 @ Patch-design @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001293660&local_base=nkc
2003 @ 11 @ 42 @ PK info servis @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290932&local_base=nkc
2003 @ 11 @ 43 @ Pohanský kruh @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000360985&local_base=nkc
2003 @ 11 @ 44 @ Pramet @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289886&local_base=nkc
2003 @ 11 @ 45 @ Press forum @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000528138&local_base=nkc
2003 @ 11 @ 46 @ Program (Opavsko) @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001293909&local_base=nkc
2003 @ 11 @ 47 @ Radniční listy @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001292552&local_base=nkc
2003 @ 11 @ 48 @ Rám @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291488&local_base=nkc
2003 @ 11 @ 49 @ Revizní a posudkové lékařství @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289587&local_base=nkc
2003 @ 11 @ 50 @ Speciál (Liberec@ Jablonec n.N., Česká Lípa ...)', 'http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001292582&local_base=nkc
2003 @ 11 @ 51 @ Speciál (Mladá Boleslav a okolí ...) @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001292580&local_base=nkc
2003 @ 11 @ 52 @ Speculum iuris @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000485755&local_base=nkc
2003 @ 11 @ 53 @ Stavebnice rodinných domů @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290124&local_base=nkc
2003 @ 11 @ 54 @ Sting magazín @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290951&local_base=nkc
2003 @ 11 @ 55 @ Student in @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291918&local_base=nkc
2003 @ 11 @ 56 @ Svět lepení @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289662&local_base=nkc
2003 @ 11 @ 57 @ Svět počítačů @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290605&local_base=nkc
2003 @ 11 @ 58 @ SYNOTtip @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290576&local_base=nkc
2003 @ 11 @ 59 @ Tip pro vás @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289884&local_base=nkc
2003 @ 11 @ 60 @ Trefa @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000980970&local_base=nkc
2003 @ 11 @ 61 @ Trn v patě @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290070&local_base=nkc
2003 @ 11 @ 62 @ Truck-inzert @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290597&local_base=nkc
2003 @ 11 @ 63 @ Třebíčský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001293727&local_base=nkc
2003 @ 11 @ 64 @ Třebívlicko zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290595&local_base=nkc
2003 @ 11 @ 65 @ UR revue @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291494&local_base=nkc
2003 @ 11 @ 66 @ Venceremos @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290953&local_base=nkc
2003 @ 11 @ 67 @ Veřejná věc @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291472&local_base=nkc
2003 @ 11 @ 68 @ Vidíte to také tak? @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290583&local_base=nkc
2003 @ 11 @ 69 @ Vítejte doma @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001293403&local_base=nkc
2003 @ 11 @ 70 @ Vizovická vrba @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290577&local_base=nkc
2003 @ 11 @ 71 @ Vočko @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290722&local_base=nkc
2003 @ 11 @ 72 @ Vojenské letectvo @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001291904&local_base=nkc
2003 @ 11 @ 73 @ Vrchlabský posel @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001289585&local_base=nkc
2003 @ 11 @ 74 @ Zaječický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290074&local_base=nkc
2003 @ 11 @ 75 @ Zdíkovsko @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001292535&local_base=nkc
2003 @ 11 @ 76 @ Zlatý pásek @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290532&local_base=nkc
2003 @ 11 @ 77 @ Zpravodaj CKPT @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000361030&local_base=nkc
2003 @ 11 @ 78 @ Zpravodaj českotřebovských živnostníků a podnikatelů @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290757&local_base=nkc
2003 @ 11 @ 79 @ Zpravodaj EGE @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290528&local_base=nkc
2003 @ 11 @ 80 @ Zpravodaj.krumlov.cz @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290514&local_base=nkc
2003 @ 11 @ 81 @ Zpravodaj Libčeveska @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=000738264&local_base=nkc
2003 @ 11 @ 82 @ Zpravodaj obce Dubné @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290060&local_base=nkc
2003 @ 11 @ 83 @ Zpravodaj Obecního úřadu Budiměřice @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290750&local_base=nkc
2003 @ 11 @ 84 @ Zpravodaj Obecního úřadu v Myslibořicích @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290755&local_base=nkc
2003 @ 11 @ 85 @ Zpravodaj Pardubického kraje @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290740&local_base=nkc
2003 @ 11 @ 86 @ Zpravodaj Uhřic @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290118&local_base=nkc
2003 @ 11 @ 87 @ Žermanický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&find_code=SYS&request=001290714&local_base=nkc
1998 @ 01 @ 28 @ Pardubický kulturní a sportovní měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000303101&find_code=SYS&local_base=nkc
1998 @ 01 @ 27 @ Orthodox revue. Sborník textů z pravoslavné theologie @ http://aleph.nkp.cz/F/?func=find-b&request=000301806&find_code=SYS&local_base=nkc
1998 @ 01 @ 26 @ Orelské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000303115&find_code=SYS&local_base=nkc
1998 @ 01 @ 24 @ Nové noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000303132&find_code=SYS&local_base=nkc
1998 @ 01 @ 25 @ Obec. Pro občany Roztok a Žalova @ http://aleph.nkp.cz/F/?func=find-b&request=000302123&find_code=SYS&local_base=nkc
1998 @ 01 @ 23 @ Net it @ http://aleph.nkp.cz/F/?func=find-b&request=000303098&find_code=SYS&local_base=nkc
2002 @ 01 @ 24 @ to be free @ http://aleph.nkp.cz/F/?func=find-b&request=001037452&find_code=SYS&local_base=nkc
2002 @ 01 @ 23 @ Telefon plus @ http://aleph.nkp.cz/F/?func=find-b&request=001064200&find_code=SYS&local_base=nkc
2002 @ 01 @ 22 @ Systémový zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001037366&find_code=SYS&local_base=nkc
2002 @ 01 @ 20 @ Severomoravská pošta @ http://aleph.nkp.cz/F/?func=find-b&request=001037332&find_code=SYS&local_base=nkc
2002 @ 01 @ 21 @ Stoma team @ http://aleph.nkp.cz/F/?func=find-b&request=001037373&find_code=SYS&local_base=nkc
2002 @ 01 @ 19 @ SC news @ http://aleph.nkp.cz/F/?func=find-b&request=001037216&find_code=SYS&local_base=nkc
2002 @ 01 @ 18 @ Rozmach @ http://aleph.nkp.cz/F/?func=find-b&request=001064324&find_code=SYS&local_base=nkc
2002 @ 01 @ 16 @ Ptačí svět @ http://aleph.nkp.cz/F/?func=find-b&request=001064377&find_code=SYS&local_base=nkc
2002 @ 01 @ 17 @ RC auta @ http://aleph.nkp.cz/F/?func=find-b&request=001037317&find_code=SYS&local_base=nkc
2002 @ 01 @ 15 @ Přívozský čtvrtletník @ http://aleph.nkp.cz/F/?func=find-b&request=001064346&find_code=SYS&local_base=nkc
2002 @ 01 @ 14 @ Paní domu @ http://aleph.nkp.cz/F/?func=find-b&request=001037183&find_code=SYS&local_base=nkc
2002 @ 01 @ 12 @ Moto house @ http://aleph.nkp.cz/F/?func=find-b&request=001064187&find_code=SYS&local_base=nkc
2002 @ 01 @ 13 @ Olomoucké listy @ http://aleph.nkp.cz/F/?func=find-b&request=001036129&find_code=SYS&local_base=nkc
2002 @ 01 @ 11 @ Modrá pyramida @ http://aleph.nkp.cz/F/?func=find-b&request=001064162&find_code=SYS&local_base=nkc
2002 @ 01 @ 10 @ Maminka @ http://aleph.nkp.cz/F/?func=find-b&request=001037434&find_code=SYS&local_base=nkc
2002 @ 01 @ 09 @ Luštík @ http://aleph.nkp.cz/F/?func=find-b&request=001036272&find_code=SYS&local_base=nkc
2002 @ 01 @ 07 @ Grantis @ http://aleph.nkp.cz/F/?func=find-b&request=001064041&find_code=SYS&local_base=nkc
2002 @ 01 @ 08 @ Lettre Wallonie-Bruxelles a Prague @ http://aleph.nkp.cz/F/?func=find-b&request=001035198&find_code=SYS&local_base=nkc
2002 @ 01 @ 06 @ Gastronom @ http://aleph.nkp.cz/F/?func=find-b&request=001063836&find_code=SYS&local_base=nkc
2002 @ 01 @ 05 @ Čára života @ http://aleph.nkp.cz/F/?func=find-b&request=001037463&find_code=SYS&local_base=nkc
2002 @ 01 @ 04 @ Bulletin (Sklostroj) @ http://aleph.nkp.cz/F/?func=find-b&request=001036116&find_code=SYS&local_base=nkc
2002 @ 01 @ 03 @ Besedník @ http://aleph.nkp.cz/F/?func=find-b&request=001036126&find_code=SYS&local_base=nkc
2002 @ 01 @ 02 @ Basar @ http://aleph.nkp.cz/F/?func=find-b&request=001064419&find_code=SYS&local_base=nkc
2002 @ 01 @ 01 @ Auto-moto speciál @ http://aleph.nkp.cz/F/?func=find-b&request=001064050&find_code=SYS&local_base=nkc
2002 @ 02 @ 01 @ Ašsko-Ascherländchen @ http://aleph.nkp.cz/F/?func=find-b&request=1067308&find_code=SYS&local_base=nkc
2002 @ 02 @ 02 @ Auto inzert @ http://aleph.nkp.cz/F/?func=find-b&request=1064882&find_code=SYS&local_base=nkc
2002 @ 02 @ 03 @ Autoškola info @ http://aleph.nkp.cz/F/?func=find-b&request=1064627&find_code=SYS&local_base=nkc
2002 @ 02 @ 04 @ Azyl @ http://aleph.nkp.cz/F/?func=find-b&request=1064632&find_code=SYS&local_base=nkc
2002 @ 02 @ 05 @ Beton @ http://aleph.nkp.cz/F/?func=find-b&request=1066383&find_code=SYS&local_base=nkc
2002 @ 02 @ 06 @ Divadelní zpravodaj Městského divadla v Karlových Varech @ http://aleph.nkp.cz/F/?func=find-b&request=1067294&find_code=SYS&local_base=nkc
2002 @ 02 @ 07 @ Dnešní Ralsko @ http://aleph.nkp.cz/F/?func=find-b&request=1067238&find_code=SYS&local_base=nkc
2002 @ 02 @ 08 @ Edukafarm @ http://aleph.nkp.cz/F/?func=find-b&request=1065893&find_code=SYS&local_base=nkc
2002 @ 02 @ 09 @ Enika @ http://aleph.nkp.cz/F/?func=find-b&request=1064531&find_code=SYS&local_base=nkc
2002 @ 02 @ 10 @ Erotika v křížovkách @ http://aleph.nkp.cz/F/?func=find-b&request=1067057&find_code=SYS&local_base=nkc
2002 @ 02 @ 11 @ Fantastická fakta plus @ http://aleph.nkp.cz/F/?func=find-b&request=1067043&find_code=SYS&local_base=nkc
2002 @ 02 @ 12 @ Forum @ http://aleph.nkp.cz/F/?func=find-b&request=1066184&find_code=SYS&local_base=nkc
2002 @ 02 @ 13 @ Františkolázeňské listy @ http://aleph.nkp.cz/F/?func=find-b&request=1066888&find_code=SYS&local_base=nkc
2002 @ 02 @ 14 @ Grand reality @ http://aleph.nkp.cz/F/?func=find-b&request=1067050&find_code=SYS&local_base=nkc
2002 @ 02 @ 15 @ Haťský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=1067052&find_code=SYS&local_base=nkc
2002 @ 02 @ 16 @ Holické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=1067311&find_code=SYS&local_base=nkc
2002 @ 02 @ 17 @ Info magneton @ http://aleph.nkp.cz/F/?func=find-b&request=1065372&find_code=SYS&local_base=nkc
2002 @ 02 @ 18 @ Info regio @ http://aleph.nkp.cz/F/?func=find-b&request=1064570&find_code=SYS&local_base=nkc
2002 @ 02 @ 19 @ Je libo švédské křížovky? @ http://aleph.nkp.cz/F/?func=find-b&request=1067056&find_code=SYS&local_base=nkc
2002 @ 02 @ 20 @ Kamelot press @ http://aleph.nkp.cz/F/?func=find-b&request=1064574&find_code=SYS&local_base=nkc
2002 @ 02 @ 21 @ Karolinský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=1066879&find_code=SYS&local_base=nkc
2002 @ 02 @ 22 @ Kolínský servis @ http://aleph.nkp.cz/F/?func=find-b&request=1064578&find_code=SYS&local_base=nkc
2002 @ 02 @ 23 @ Kralovický obzor @ http://aleph.nkp.cz/F/?func=find-b&request=1066868&find_code=SYS&local_base=nkc
2002 @ 02 @ 24 @ Kuropění @ http://aleph.nkp.cz/F/?func=find-b&request=1064576&find_code=SYS&local_base=nkc
2002 @ 02 @ 25 @ Kvalita potravin @ http://aleph.nkp.cz/F/?func=find-b&request=1067059&find_code=SYS&local_base=nkc
2002 @ 02 @ 26 @ Květy olejnin @ http://aleph.nkp.cz/F/?func=find-b&request=1064879&find_code=SYS&local_base=nkc
2002 @ 02 @ 27 @ Matýsek @ http://aleph.nkp.cz/F/?func=find-b&request=1067010&find_code=SYS&local_base=nkc
2002 @ 02 @ 28 @ Muzejní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=1064580&find_code=SYS&local_base=nkc
2002 @ 02 @ 29 @ Naše Mutěnice @ http://aleph.nkp.cz/F/?func=find-b&request=1066875&find_code=SYS&local_base=nkc
2002 @ 02 @ 30 @ Nintendo Pokémon magazín @ http://aleph.nkp.cz/F/?func=find-b&request=1066050&find_code=SYS&local_base=nkc
2002 @ 02 @ 31 @ Notes @ http://aleph.nkp.cz/F/?func=find-b&request=1067201&find_code=SYS&local_base=nkc
2002 @ 02 @ 32 @ Nová exota @ http://aleph.nkp.cz/F/?func=find-b&request=1067020&find_code=SYS&local_base=nkc
2002 @ 02 @ 33 @ Novinky … nejen ze světa modelářství @ http://aleph.nkp.cz/F/?func=find-b&request=1067249&find_code=SYS&local_base=nkc
2002 @ 02 @ 34 @ Nový horizont @ http://aleph.nkp.cz/F/?func=find-b&request=1067313&find_code=SYS&local_base=nkc
2002 @ 02 @ 35 @ Obchodní zpravodaj Holdingu Agropol Group @ http://aleph.nkp.cz/F/?func=find-b&request=1066369&find_code=SYS&local_base=nkc
2002 @ 02 @ 36 @ Osmisměrky plné humoru @ http://aleph.nkp.cz/F/?func=find-b&request=1064667&find_code=SYS&local_base=nkc
2002 @ 02 @ 37 @ Osmisměrky pro všechny @ http://aleph.nkp.cz/F/?func=find-b&request=1065347&find_code=SYS&local_base=nkc
2002 @ 02 @ 38 @ Patriot @ http://aleph.nkp.cz/F/?func=find-b&request=1066880&find_code=SYS&local_base=nkc
2002 @ 02 @ 39 @ Planeta Země @ http://aleph.nkp.cz/F/?func=find-b&request=1064686&find_code=SYS&local_base=nkc
2002 @ 02 @ 40 @ Poetrie @ http://aleph.nkp.cz/F/?func=find-b&request=1065017&find_code=SYS&local_base=nkc
2002 @ 02 @ 41 @ Portýr @ http://aleph.nkp.cz/F/?func=find-b&request=1066171&find_code=SYS&local_base=nkc
2002 @ 02 @ 42 @ Pot @ http://aleph.nkp.cz/F/?func=find-b&request=1064857&find_code=SYS&local_base=nkc
2002 @ 02 @ 43 @ Pražská technika @ http://aleph.nkp.cz/F/?func=find-b&request=1064827&find_code=SYS&local_base=nkc
2002 @ 02 @ 44 @ Profifoto @ http://aleph.nkp.cz/F/?func=find-b&request=1064812&find_code=SYS&local_base=nkc
2002 @ 02 @ 45 @ Překročit hranice @ http://aleph.nkp.cz/F/?func=find-b&request=1066097&find_code=SYS&local_base=nkc
2002 @ 02 @ 46 @ Rady pro celou rodinu v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=1065335&find_code=SYS&local_base=nkc
2002 @ 02 @ 47 @ Rapotínské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=1065360&find_code=SYS&local_base=nkc
2002 @ 02 @ 48 @ Reality inzert @ http://aleph.nkp.cz/F/?func=find-b&request=1066618&find_code=SYS&local_base=nkc
2002 @ 02 @ 49 @ Riskuj s milionářem v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=1065343&find_code=SYS&local_base=nkc
2002 @ 02 @ 50 @ Rotavský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=1064351&find_code=SYS&local_base=nkc
2002 @ 02 @ 51 @ Rozpravy o minulosti a přítomnosti českého národa @ http://aleph.nkp.cz/F/?func=find-b&request=1066176&find_code=SYS&local_base=nkc
2002 @ 02 @ 52 @ Safari @ http://aleph.nkp.cz/F/?func=find-b&request=1066290&find_code=SYS&local_base=nkc
2002 @ 02 @ 53 @ Sekerské novinky @ http://aleph.nkp.cz/F/?func=find-b&request=1065073&find_code=SYS&local_base=nkc
2002 @ 02 @ 54 @ Staňkovsko @ http://aleph.nkp.cz/F/?func=find-b&request=1065884&find_code=SYS&local_base=nkc
2002 @ 02 @ 55 @ Student press @ http://aleph.nkp.cz/F/?func=find-b&request=1064618&find_code=SYS&local_base=nkc
2002 @ 02 @ 56 @ Transgas @ http://aleph.nkp.cz/F/?func=find-b&request=1064662&find_code=SYS&local_base=nkc
2002 @ 02 @ 57 @ Trefa českého sociálně demokratického hnutí @ http://aleph.nkp.cz/F/?func=find-b&request=1066062&find_code=SYS&local_base=nkc
2002 @ 02 @ 58 @ Trestněprávní revue @ http://aleph.nkp.cz/F/?func=find-b&request=1064365&find_code=SYS&local_base=nkc
2002 @ 02 @ 59 @ Účetnictví nevýdělečných organizací a obcí @ http://aleph.nkp.cz/F/?func=find-b&request=1065056&find_code=SYS&local_base=nkc
2002 @ 02 @ 60 @ Univerzitní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=1064869&find_code=SYS&local_base=nkc
2002 @ 02 @ 61 @ Veterán @ http://aleph.nkp.cz/F/?func=find-b&request=1065039&find_code=SYS&local_base=nkc
2002 @ 02 @ 62 @ Vilcacora @ http://aleph.nkp.cz/F/?func=find-b&request=1064522&find_code=SYS&local_base=nkc
2002 @ 02 @ 63 @ Zábava pro všechny @ http://aleph.nkp.cz/F/?func=find-b&request=1064664&find_code=SYS&local_base=nkc
2002 @ 02 @ 64 @ Zahradnictví @ http://aleph.nkp.cz/F/?func=find-b&request=1066913&find_code=SYS&local_base=nkc
2002 @ 02 @ 65 @ Zetkalák @ http://aleph.nkp.cz/F/?func=find-b&request=1065889&find_code=SYS&local_base=nkc
2002 @ 02 @ 66 @ Znojemský servis @ http://aleph.nkp.cz/F/?func=find-b&request=1066876&find_code=SYS&local_base=nkc
2002 @ 02 @ 67 @ Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=1065045&find_code=SYS&local_base=nkc
2002 @ 02 @ 68 @ Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=1064676&find_code=SYS&local_base=nkc
2002 @ 02 @ 69 @ Zpravodaj (Český Krumlov) @ http://aleph.nkp.cz/F/?func=find-b&request=1065413&find_code=SYS&local_base=nkc
2002 @ 02 @ 70 @ Zpravodaj AVZO ČR @ http://aleph.nkp.cz/F/?func=find-b&request=1066179&find_code=SYS&local_base=nkc
2002 @ 02 @ 71 @ Zpravodaj Benátecka @ http://aleph.nkp.cz/F/?func=find-b&request=1065024&find_code=SYS&local_base=nkc
2002 @ 02 @ 72 @ Zpravodaj Klubu přátel výtvarného umění Brno @ http://aleph.nkp.cz/F/?func=find-b&request=1065357&find_code=SYS&local_base=nkc
2002 @ 02 @ 73 @ Zpravodaj města Mýta @ http://aleph.nkp.cz/F/?func=find-b&request=1065063&find_code=SYS&local_base=nkc
2002 @ 02 @ 74 @ Zpravodaj městského úřadu ve Valašském Meziříčí @ http://aleph.nkp.cz/F/?func=find-b&request=1065410&find_code=SYS&local_base=nkc
2002 @ 02 @ 75 @ Zpravodaj Národního divadla moravskoslezského @ http://aleph.nkp.cz/F/?func=find-b&request=1066854&find_code=SYS&local_base=nkc
2002 @ 02 @ 76 @ Zpravodaj obce Prostřední Bečva @ http://aleph.nkp.cz/F/?func=find-b&request=1024216&find_code=SYS&local_base=nkc
2002 @ 03 @ 87 @ Trhák @ http://aleph.nkp.cz/F/?func=find-b&request=001088656&find_code=SYS&local_base=nkc
2002 @ 03 @ 86 @ TipStation @ http://aleph.nkp.cz/F/?func=find-b&request=001088593&find_code=SYS&local_base=nkc
2002 @ 03 @ 85 @ Svět DHL @ http://aleph.nkp.cz/F/?func=find-b&request=001088324&find_code=SYS&local_base=nkc
2002 @ 03 @ 84 @ Svět čerpadel @ http://aleph.nkp.cz/F/?func=find-b&request=001089015&find_code=SYS&local_base=nkc
2002 @ 03 @ 83 @ Studentský plátek @ http://aleph.nkp.cz/F/?func=find-b&request=001088628&find_code=SYS&local_base=nkc
2002 @ 03 @ 82 @ Studentská pochodeň @ http://aleph.nkp.cz/F/?func=find-b&request=001088989&find_code=SYS&local_base=nkc
2002 @ 03 @ 81 @ Student life @ http://aleph.nkp.cz/F/?func=find-b&request=001088231&find_code=SYS&local_base=nkc
2002 @ 03 @ 80 @ Střekov @ http://aleph.nkp.cz/F/?func=find-b&request=001088772&find_code=SYS&local_base=nkc
2002 @ 03 @ 79 @ Společenství a život @ http://aleph.nkp.cz/F/?func=find-b&request=001088765&find_code=SYS&local_base=nkc
2002 @ 03 @ 78 @ Sovík @ http://aleph.nkp.cz/F/?func=find-b&request=001088739&find_code=SYS&local_base=nkc
2002 @ 03 @ 77 @ Snadné křížovky a jiná zábava @ http://aleph.nkp.cz/F/?func=find-b&request=001088209&find_code=SYS&local_base=nkc
2002 @ 03 @ 76 @ Slovo kamene @ http://aleph.nkp.cz/F/?func=find-b&request=001088662&find_code=SYS&local_base=nkc
2002 @ 03 @ 75 @ Slivenecký mramor @ http://aleph.nkp.cz/F/?func=find-b&request=001090339&find_code=SYS&local_base=nkc
2002 @ 03 @ 74 @ Slavkovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001089606&find_code=SYS&local_base=nkc
2002 @ 03 @ 73 @ Skvělé osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001088205&find_code=SYS&local_base=nkc
2002 @ 03 @ 72 @ Sirius @ http://aleph.nkp.cz/F/?func=find-b&request=001089178&find_code=SYS&local_base=nkc
2002 @ 03 @ 71 @ Severočeská pochodeň @ http://aleph.nkp.cz/F/?func=find-b&request=001088769&find_code=SYS&local_base=nkc
2002 @ 03 @ 70 @ Russkaja Čechija @ http://aleph.nkp.cz/F/?func=find-b&request=001089641&find_code=SYS&local_base=nkc
2002 @ 03 @ 69 @ Rudolfinum revue @ http://aleph.nkp.cz/F/?func=find-b&request=001088059&find_code=SYS&local_base=nkc
2002 @ 03 @ 68 @ Rock & heavy metal encyclopedia @ http://aleph.nkp.cz/F/?func=find-b&request=001090294&find_code=SYS&local_base=nkc
2002 @ 03 @ 67 @ Retail Biz @ http://aleph.nkp.cz/F/?func=find-b&request=001088278&find_code=SYS&local_base=nkc
2002 @ 03 @ 66 @ Region Podbořanska @ http://aleph.nkp.cz/F/?func=find-b&request=001088614&find_code=SYS&local_base=nkc
2002 @ 03 @ 65 @ Region @ http://aleph.nkp.cz/F/?func=find-b&request=001067982&find_code=SYS&local_base=nkc
2002 @ 03 @ 64 @ Reflektor @ http://aleph.nkp.cz/F/?func=find-b&request=001088674&find_code=SYS&local_base=nkc
2002 @ 03 @ 63 @ Ramovák @ http://aleph.nkp.cz/F/?func=find-b&request=001090312&find_code=SYS&local_base=nkc
2002 @ 03 @ 62 @ Railvolution @ http://aleph.nkp.cz/F/?func=find-b&request=001089370&find_code=SYS&local_base=nkc
2002 @ 03 @ 61 @ Radíkovský informační zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001090323&find_code=SYS&local_base=nkc
2002 @ 03 @ 60 @ Radiační onkologie @ http://aleph.nkp.cz/F/?func=find-b&request=001090304&find_code=SYS&local_base=nkc
2002 @ 03 @ 59 @ Quantum report @ http://aleph.nkp.cz/F/?func=find-b&request=001089126&find_code=SYS&local_base=nkc
2002 @ 03 @ 58 @ PSM2 @ http://aleph.nkp.cz/F/?func=find-b&request=001088784&find_code=SYS&local_base=nkc
2002 @ 03 @ 57 @ Přerovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001090526&find_code=SYS&local_base=nkc
2002 @ 03 @ 56 @ Průvodce náhradní rodinnou péčí @ http://aleph.nkp.cz/F/?func=find-b&request=001090702&find_code=SYS&local_base=nkc
2002 @ 03 @ 55 @ Program(me) @ http://aleph.nkp.cz/F/?func=find-b&request=001090524&find_code=SYS&local_base=nkc
2002 @ 03 @ 54 @ Prameny @ http://aleph.nkp.cz/F/?func=find-b&request=001090490&find_code=SYS&local_base=nkc
2002 @ 03 @ 53 @ Prague Events @ http://aleph.nkp.cz/F/?func=find-b&request=001090513&find_code=SYS&local_base=nkc
2002 @ 03 @ 52 @ Prague Courier @ http://aleph.nkp.cz/F/?func=find-b&request=001090706&find_code=SYS&local_base=nkc
2002 @ 03 @ 51 @ Pragoeduca @ http://aleph.nkp.cz/F/?func=find-b&request=001088081&find_code=SYS&local_base=nkc
2002 @ 03 @ 50 @ Pozitivní plus @ http://aleph.nkp.cz/F/?func=find-b&request=001090697&find_code=SYS&local_base=nkc
2002 @ 03 @ 49 @ Povětroň @ http://aleph.nkp.cz/F/?func=find-b&request=001090710&find_code=SYS&local_base=nkc
2002 @ 03 @ 48 @ Poštovní inzertní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001090520&find_code=SYS&local_base=nkc
2002 @ 03 @ 47 @ Podiatrické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001088498&find_code=SYS&local_base=nkc
2002 @ 03 @ 46 @ Place @ http://aleph.nkp.cz/F/?func=find-b&request=001088746&find_code=SYS&local_base=nkc
2002 @ 03 @ 45 @ Peněžní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001090521&find_code=SYS&local_base=nkc
2002 @ 03 @ 44 @ Pardon @ http://aleph.nkp.cz/F/?func=find-b&request=001089152&find_code=SYS&local_base=nkc
2002 @ 03 @ 43 @ Osmisměrky plné smíchu @ http://aleph.nkp.cz/F/?func=find-b&request=001088206&find_code=SYS&local_base=nkc
2002 @ 03 @ 42 @ Opavský inzert @ http://aleph.nkp.cz/F/?func=find-b&request=001089034&find_code=SYS&local_base=nkc
2002 @ 03 @ 41 @ Obrana národa @ http://aleph.nkp.cz/F/?func=find-b&request=001089345&find_code=SYS&local_base=nkc
2002 @ 03 @ 40 @ Objektiv @ http://aleph.nkp.cz/F/?func=find-b&request=001090384&find_code=SYS&local_base=nkc
2002 @ 03 @ 39 @ Obecní zpravodaj Ostrožské Lhoty @ http://aleph.nkp.cz/F/?func=find-b&request=001090363&find_code=SYS&local_base=nkc
2002 @ 03 @ 38 @ Oáza (Krnov-Bruntál) @ http://aleph.nkp.cz/F/?func=find-b&request=001090372&find_code=SYS&local_base=nkc
2002 @ 03 @ 37 @ Novinky @ http://aleph.nkp.cz/F/?func=find-b&request=001089637&find_code=SYS&local_base=nkc
2002 @ 03 @ 36 @ Naše ves @ http://aleph.nkp.cz/F/?func=find-b&request=001090386&find_code=SYS&local_base=nkc
2002 @ 03 @ 35 @ Mrákotínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001090482&find_code=SYS&local_base=nkc
2002 @ 03 @ 34 @ Modrý reportér @ http://aleph.nkp.cz/F/?func=find-b&request=001090677&find_code=SYS&local_base=nkc
2002 @ 03 @ 33 @ MiniMax (Mladá Boleslav) @ http://aleph.nkp.cz/F/?func=find-b&request=001068125&find_code=SYS&local_base=nkc
2002 @ 03 @ 32 @ MiniMax (Dvůr Králové n.L.) @ http://aleph.nkp.cz/F/?func=find-b&request=001068121&find_code=SYS&local_base=nkc
2002 @ 03 @ 31 @ Lomikámen @ http://aleph.nkp.cz/F/?func=find-b&request=001032061&find_code=SYS&local_base=nkc
2002 @ 03 @ 30 @ Listy Malého studia Liberec @ http://aleph.nkp.cz/F/?func=find-b&request=001090476&find_code=SYS&local_base=nkc
2002 @ 03 @ 29 @ Lipenecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001090635&find_code=SYS&local_base=nkc
2002 @ 03 @ 28 @ Kutil! @ http://aleph.nkp.cz/F/?func=find-b&request=001089476&find_code=SYS&local_base=nkc
2002 @ 03 @ 27 @ KultGurmán @ http://aleph.nkp.cz/F/?func=find-b&request=001089568&find_code=SYS&local_base=nkc
2002 @ 03 @ 26 @ Krása našeho domova @ http://aleph.nkp.cz/F/?func=find-b&request=001089182&find_code=SYS&local_base=nkc
2002 @ 03 @ 25 @ Klánovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001090661&find_code=SYS&local_base=nkc
2002 @ 03 @ 24 @ JazzTimes @ http://aleph.nkp.cz/F/?func=find-b&request=001089521&find_code=SYS&local_base=nkc
2002 @ 03 @ 23 @ Jáchymovský kulturní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001089187&find_code=SYS&local_base=nkc
2002 @ 03 @ 22 @ Informace @ http://aleph.nkp.cz/F/?func=find-b&request=001090591&find_code=SYS&local_base=nkc
2002 @ 03 @ 21 @ Horoskopy na ... @ http://aleph.nkp.cz/F/?func=find-b&request=001066871&find_code=SYS&local_base=nkc
2002 @ 03 @ 20 @ Hornické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001090616&find_code=SYS&local_base=nkc
2002 @ 03 @ 19 @ Hlas venkova @ http://aleph.nkp.cz/F/?func=find-b&request=001089933&find_code=SYS&local_base=nkc
2002 @ 03 @ 18 @ Hlas mučedníků @ http://aleph.nkp.cz/F/?func=find-b&request=001087802&find_code=SYS&local_base=nkc
2002 @ 03 @ 17 @ Flóra na zahradě @ http://aleph.nkp.cz/F/?func=find-b&request=001087792&find_code=SYS&local_base=nkc
2002 @ 03 @ 16 @ Doprava a cesty @ http://aleph.nkp.cz/F/?func=find-b&request=001090561&find_code=SYS&local_base=nkc
2002 @ 03 @ 15 @ Deutsch junior @ http://aleph.nkp.cz/F/?func=find-b&request=001088954&find_code=SYS&local_base=nkc
2002 @ 03 @ 14 @ Ďáblický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001089598&find_code=SYS&local_base=nkc
2002 @ 03 @ 13 @ České stavebnictví @ http://aleph.nkp.cz/F/?func=find-b&request=001089577&find_code=SYS&local_base=nkc
2002 @ 03 @ 12 @ České právo životního prostředí @ http://aleph.nkp.cz/F/?func=find-b&request=001089185&find_code=SYS&local_base=nkc
2002 @ 03 @ 11 @ Česká hudební společnost @ http://aleph.nkp.cz/F/?func=find-b&request=001089391&find_code=SYS&local_base=nkc
2002 @ 03 @ 10 @ Čas na lásku @ http://aleph.nkp.cz/F/?func=find-b&request=001089524&find_code=SYS&local_base=nkc
2002 @ 03 @ 09 @ Čarodějky = Witch @ http://aleph.nkp.cz/F/?func=find-b&request=001088761&find_code=SYS&local_base=nkc
2002 @ 03 @ 08 @ Cigare & pipe style @ http://aleph.nkp.cz/F/?func=find-b&request=001090643&find_code=SYS&local_base=nkc
2002 @ 03 @ 07 @ Cevro @ http://aleph.nkp.cz/F/?func=find-b&request=001089653&find_code=SYS&local_base=nkc
2002 @ 03 @ 06 @ Benvenuti a Praga @ http://aleph.nkp.cz/F/?func=find-b&request=001089615&find_code=SYS&local_base=nkc
2002 @ 03 @ 05 @ AutoCar @ http://aleph.nkp.cz/F/?func=find-b&request=001088007&find_code=SYS&local_base=nkc
2002 @ 03 @ 04 @ Abeceda bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=001090688&find_code=SYS&local_base=nkc
2002 @ 03 @ 02 @ 3. pól @ http://aleph.nkp.cz/F/?func=find-b&request=001088470&find_code=SYS&local_base=nkc
2002 @ 03 @ 03 @ A News @ http://aleph.nkp.cz/F/?func=find-b&request=001090647&find_code=SYS&local_base=nkc
2002 @ 03 @ 00 @ 112 @ http://aleph.nkp.cz/F/?func=find-b&request=001087844&find_code=SYS&local_base=nkc
2002 @ 04 @ 01 @ Acupuntura Bohemo Slovaca @ http://aleph.nkp.cz/F/?func=find-b&request=001092997&find_code=SYS&local_base=nkc
2002 @ 04 @ 02 @ Auto Štangl revue @ http://aleph.nkp.cz/F/?func=find-b&request=001093855&find_code=SYS&local_base=nkc
2002 @ 04 @ 03 @ Basset telegraf @ http://aleph.nkp.cz/F/?func=find-b&request=001094290&find_code=SYS&local_base=nkc
2002 @ 04 @ 04 @ Bbarak @ http://aleph.nkp.cz/F/?func=find-b&request=001094627&find_code=SYS&local_base=nkc
2002 @ 04 @ 05 @ Beverage & Gastro @ http://aleph.nkp.cz/F/?func=find-b&request=001091221&find_code=SYS&local_base=nkc
2002 @ 04 @ 06 @ Blatenské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001093090&find_code=SYS&local_base=nkc
2002 @ 04 @ 07 @ Bowling @ http://aleph.nkp.cz/F/?func=find-b&request=001090431&find_code=SYS&local_base=nkc
2002 @ 04 @ 08 @ Bulvár @ http://aleph.nkp.cz/F/?func=find-b&request=001092742&find_code=SYS&local_base=nkc
2002 @ 04 @ 09 @ Bystřické (po)kroky @ http://aleph.nkp.cz/F/?func=find-b&request=001091331&find_code=SYS&local_base=nkc
2002 @ 04 @ 10 @ Calinews @ http://aleph.nkp.cz/F/?func=find-b&request=001092917&find_code=SYS&local_base=nkc
2002 @ 04 @ 11 @ Ceramics art @ http://aleph.nkp.cz/F/?func=find-b&request=001092952&find_code=SYS&local_base=nkc
2002 @ 04 @ 12 @ Contact @ http://aleph.nkp.cz/F/?func=find-b&request=001094634&find_code=SYS&local_base=nkc
2002 @ 04 @ 13 @ Česká a slovenská gastroenterologie a hepatologie @ http://aleph.nkp.cz/F/?func=find-b&request=001091133&find_code=SYS&local_base=nkc
2002 @ 04 @ 14 @ Čtyřlístek CD-Romek @ http://aleph.nkp.cz/F/?func=find-b&request=001092665&find_code=SYS&local_base=nkc
2002 @ 04 @ 15 @ Detail @ http://aleph.nkp.cz/F/?func=find-b&request=001066858&find_code=SYS&local_base=nkc
2002 @ 04 @ 16 @ Development news @ http://aleph.nkp.cz/F/?func=find-b&request=001092918&find_code=SYS&local_base=nkc
2002 @ 04 @ 17 @ Dirtbiker @ http://aleph.nkp.cz/F/?func=find-b&request=001090703&find_code=SYS&local_base=nkc
2002 @ 04 @ 18 @ Dolnokralovický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001094673&find_code=SYS&local_base=nkc
2002 @ 04 @ 19 @ Doprava @ http://aleph.nkp.cz/F/?func=find-b&request=001090355&find_code=SYS&local_base=nkc
2002 @ 04 @ 20 @ Dopravní zprávy @ http://aleph.nkp.cz/F/?func=find-b&request=001092040&find_code=SYS&local_base=nkc
2002 @ 04 @ 21 @ Easy Deutsch @ http://aleph.nkp.cz/F/?func=find-b&request=001111786&find_code=SYS&local_base=nkc
2002 @ 04 @ 22 @ Easy English @ http://aleph.nkp.cz/F/?func=find-b&request=001111807&find_code=SYS&local_base=nkc
2002 @ 04 @ 23 @ era @ http://aleph.nkp.cz/F/?func=find-b&request=001091516&find_code=SYS&local_base=nkc
2002 @ 04 @ 24 @ Euro Campus @ http://aleph.nkp.cz/F/?func=find-b&request=001092537&find_code=SYS&local_base=nkc
2002 @ 04 @ 25 @ Euro Prague Times @ http://aleph.nkp.cz/F/?func=find-b&request=001093288&find_code=SYS&local_base=nkc
2002 @ 04 @ 26 @ Filumenistické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001093017&find_code=SYS&local_base=nkc
2002 @ 04 @ 27 @ Floristika @ http://aleph.nkp.cz/F/?func=find-b&request=001090685&find_code=SYS&local_base=nkc
2002 @ 04 @ 28 @ Frky @ http://aleph.nkp.cz/F/?func=find-b&request=001090656&find_code=SYS&local_base=nkc
2002 @ 04 @ 29 @ Generace @ http://aleph.nkp.cz/F/?func=find-b&request=001090656&find_code=SYS&local_base=nkc
2002 @ 04 @ 30 @ Horecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001093255&find_code=SYS&local_base=nkc
2002 @ 04 @ 31 @ Hvězdlický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001092891&find_code=SYS&local_base=nkc
2002 @ 04 @ 32 @ Chemie Sokolov @ http://aleph.nkp.cz/F/?func=find-b&request=001093849&find_code=SYS&local_base=nkc
2002 @ 04 @ 33 @ Iatrike techne @ http://aleph.nkp.cz/F/?func=find-b&request=001092049&find_code=SYS&local_base=nkc
2002 @ 04 @ 34 @ Info reality @ http://aleph.nkp.cz/F/?func=find-b&request=001093071&find_code=SYS&local_base=nkc
2002 @ 04 @ 35 @ Informační magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001093707&find_code=SYS&local_base=nkc
2002 @ 04 @ 36 @ Information magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001093716&find_code=SYS&local_base=nkc
2002 @ 04 @ 37 @ i-noviny.cz @ http://aleph.nkp.cz/F/?func=find-b&request=001093035&find_code=SYS&local_base=nkc
2002 @ 04 @ 38 @ Interní auditor @ http://aleph.nkp.cz/F/?func=find-b&request=001094116&find_code=SYS&local_base=nkc
2002 @ 04 @ 39 @ Jihomoravský knírač @ http://aleph.nkp.cz/F/?func=find-b&request=001091228&find_code=SYS&local_base=nkc
2002 @ 04 @ 40 @ Klepadlo @ http://aleph.nkp.cz/F/?func=find-b&request=001091848&find_code=SYS&local_base=nkc
2002 @ 04 @ 41 @ Kondice @ http://aleph.nkp.cz/F/?func=find-b&request=001093278&find_code=SYS&local_base=nkc
2002 @ 04 @ 42 @ Kukátko @ http://aleph.nkp.cz/F/?func=find-b&request=001092215&find_code=SYS&local_base=nkc
2002 @ 04 @ 43 @ Kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=001092346&find_code=SYS&local_base=nkc
2002 @ 04 @ 44 @ Lidé a stavby PSJ @ http://aleph.nkp.cz/F/?func=find-b&request=001090497&find_code=SYS&local_base=nkc
2002 @ 04 @ 45 @ Listy (Brno-Tuřany) @ http://aleph.nkp.cz/F/?func=find-b&request=001091217&find_code=SYS&local_base=nkc
2002 @ 04 @ 46 @ Litoměřický servis @ http://aleph.nkp.cz/F/?func=find-b&request=001092255&find_code=SYS&local_base=nkc
2002 @ 04 @ 47 @ Magazín ze Šumavy @ http://aleph.nkp.cz/F/?func=find-b&request=001091266&find_code=SYS&local_base=nkc
2002 @ 04 @ 48 @ Modré z nebe @ http://aleph.nkp.cz/F/?func=find-b&request=001093841&find_code=SYS&local_base=nkc
2002 @ 04 @ 49 @ Moravský list @ http://aleph.nkp.cz/F/?func=find-b&request=001093295&find_code=SYS&local_base=nkc
2002 @ 04 @ 50 @ Mozaika @ http://aleph.nkp.cz/F/?func=find-b&request=001092214&find_code=SYS&local_base=nkc
2002 @ 04 @ 51 @ Nová energie @ http://aleph.nkp.cz/F/?func=find-b&request=001091262&find_code=SYS&local_base=nkc
2002 @ 04 @ 52 @ Nový hlas @ http://aleph.nkp.cz/F/?func=find-b&request=001092060&find_code=SYS&local_base=nkc
2002 @ 04 @ 53 @ Nový průvodce @ http://aleph.nkp.cz/F/?func=find-b&request=001092500&find_code=SYS&local_base=nkc
2002 @ 04 @ 54 @ Obecní zpravodaj (Brantice a Radim) @ http://aleph.nkp.cz/F/?func=find-b&request=001093366&find_code=SYS&local_base=nkc
2002 @ 04 @ 55 @ Opavský inzert @ http://aleph.nkp.cz/F/?func=find-b&request=001093858&find_code=SYS&local_base=nkc
2002 @ 04 @ 56 @ Osobní finance @ http://aleph.nkp.cz/F/?func=find-b&request=001091845&find_code=SYS&local_base=nkc
2002 @ 04 @ 57 @ Posázavské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001092462&find_code=SYS&local_base=nkc
2002 @ 04 @ 58 @ Praktický rádce zadavatele tisku @ http://aleph.nkp.cz/F/?func=find-b&request=001090518&find_code=SYS&local_base=nkc
2002 @ 04 @ 59 @ Premiere mini @ http://aleph.nkp.cz/F/?func=find-b&request=001090487&find_code=SYS&local_base=nkc
2002 @ 04 @ 60 @ Prosperita @ http://aleph.nkp.cz/F/?func=find-b&request=001092881&find_code=SYS&local_base=nkc
2002 @ 04 @ 61 @ Q news @ http://aleph.nkp.cz/F/?func=find-b&request=001092327&find_code=SYS&local_base=nkc
2002 @ 04 @ 62 @ Ralsko @ http://aleph.nkp.cz/F/?func=find-b&request=001093688&find_code=SYS&local_base=nkc
2002 @ 04 @ 63 @ Receptář prima nápadů @ http://aleph.nkp.cz/F/?func=find-b&request=001093291&find_code=SYS&local_base=nkc
2002 @ 04 @ 64 @ Remarx @ http://aleph.nkp.cz/F/?func=find-b&request=001091618&find_code=SYS&local_base=nkc
2002 @ 04 @ 65 @ Report @ http://aleph.nkp.cz/F/?func=find-b&request=001091644&find_code=SYS&local_base=nkc
2002 @ 04 @ 66 @ Rozvoj Šlapanic @ http://aleph.nkp.cz/F/?func=find-b&request=001093353&find_code=SYS&local_base=nkc
2002 @ 04 @ 67 @ Svinovský hlasatel @ http://aleph.nkp.cz/F/?func=find-b&request=001092735&find_code=SYS&local_base=nkc
2002 @ 04 @ 68 @ Telegraf @ http://aleph.nkp.cz/F/?func=find-b&request=001091643&find_code=SYS&local_base=nkc
2002 @ 04 @ 69 @ Tip reklama @ http://aleph.nkp.cz/F/?func=find-b&request=001093388&find_code=SYS&local_base=nkc
2002 @ 04 @ 70 @ Trh nemovitostí @ http://aleph.nkp.cz/F/?func=find-b&request=001093823&find_code=SYS&local_base=nkc
2002 @ 04 @ 71 @ Tribe @ http://aleph.nkp.cz/F/?func=find-b&request=001093730&find_code=SYS&local_base=nkc
2002 @ 04 @ 72 @ Trips @ http://aleph.nkp.cz/F/?func=find-b&request=001093820&find_code=SYS&local_base=nkc
2002 @ 04 @ 73 @ Trojský kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=001091552&find_code=SYS&local_base=nkc
2002 @ 04 @ 74 @ U nás doma @ http://aleph.nkp.cz/F/?func=find-b&request=001065413&find_code=SYS&local_base=nkc
2002 @ 04 @ 75 @ Účetnictví@ daně a právo v praxi fyzických a právnických osob', 'http://aleph.nkp.cz/F/?func=find-b&request=001092489&find_code=SYS&local_base=nkc
2002 @ 04 @ 76 @ Větrušák @ http://aleph.nkp.cz/F/?func=find-b&request=001091847&find_code=SYS&local_base=nkc
2002 @ 04 @ 77 @ Vítkovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001093829&find_code=SYS&local_base=nkc
2002 @ 04 @ 78 @ Výstavní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001091480&find_code=SYS&local_base=nkc
2002 @ 04 @ 79 @ Vyšebrodský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001091529&find_code=SYS&local_base=nkc
2002 @ 04 @ 80 @ Xadonia @ http://aleph.nkp.cz/F/?func=find-b&request=001093364&find_code=SYS&local_base=nkc
2002 @ 04 @ 81 @ Zaza @ http://aleph.nkp.cz/F/?func=find-b&request=001092716&find_code=SYS&local_base=nkc
2002 @ 04 @ 82 @ Zpravodaj (Beagle Club ČR) @ http://aleph.nkp.cz/F/?func=find-b&request=001091623&find_code=SYS&local_base=nkc
2002 @ 04 @ 83 @ Zpravodaj (Dr. Bubeníček) @ http://aleph.nkp.cz/F/?func=find-b&request=001091636&find_code=SYS&local_base=nkc
2002 @ 04 @ 84 @ Zpravodaj (Hradištko pod Medníkem) @ http://aleph.nkp.cz/F/?func=find-b&request=001093339&find_code=SYS&local_base=nkc
2002 @ 04 @ 85 @ Zpravodaj (Kladruby) @ http://aleph.nkp.cz/F/?func=find-b&request=001091826&find_code=SYS&local_base=nkc
2002 @ 04 @ 86 @ Zpravodaj (Konfederace politických vězňů ČR) @ http://aleph.nkp.cz/F/?func=find-b&request=001091641&find_code=SYS&local_base=nkc
2002 @ 04 @ 87 @ Zpravodaj (Sdružení absolventů a přátel lesnických škol píseckých) @ http://aleph.nkp.cz/F/?func=find-b&request=001091819&find_code=SYS&local_base=nkc
2002 @ 04 @ 88 @ Zpravodaj obce Kožušany - Tážaly @ http://aleph.nkp.cz/F/?func=find-b&request=001091775&find_code=SYS&local_base=nkc
2002 @ 04 @ 89 @ Zpravodaj obce Olšany u Prostějova @ http://aleph.nkp.cz/F/?func=find-b&request=001093260&find_code=SYS&local_base=nkc
2002 @ 04 @ 90 @ Zpravodaj obce Strání @ http://aleph.nkp.cz/F/?func=find-b&request=001091835&find_code=SYS&local_base=nkc
2002 @ 04 @ 91 @ Zpravodaj WTA CZ @ http://aleph.nkp.cz/F/?func=find-b&request=001091763&find_code=SYS&local_base=nkc
2002 @ 04 @ 92 @ Zuberské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001092747&find_code=SYS&local_base=nkc
2002 @ 06 @ 01 @ Ahoj Evropo @ http://aleph.nkp.cz/F/?func=find-b&request=001122687&find_code=SYS&local_base=nkc
2002 @ 06 @ 02 @ Bulletin (Sdružení pro alergické a astmatické děti) @ http://aleph.nkp.cz/F/?func=find-b&request=001123666&find_code=SYS&local_base=nkc
2002 @ 06 @ 03 @ Czech Environment towards the European Union @ http://aleph.nkp.cz/F/?func=find-b&request=001124114&find_code=SYS&local_base=nkc
2002 @ 06 @ 04 @ Focus @ http://aleph.nkp.cz/F/?func=find-b&request=001122220&find_code=SYS&local_base=nkc
2002 @ 06 @ 05 @ Grand Business @ http://aleph.nkp.cz/F/?func=find-b&request=001122639&find_code=SYS&local_base=nkc
2002 @ 06 @ 06 @ H noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001122639&find_code=SYS&local_base=nkc
2002 @ 06 @ 07 @ Hlas Jitky @ http://aleph.nkp.cz/F/?func=find-b&request=001122704&find_code=SYS&local_base=nkc
2002 @ 06 @ 08 @ Holcim @ http://aleph.nkp.cz/F/?func=find-b&request=001122594&find_code=SYS&local_base=nkc
2002 @ 06 @ 09 @ Hřensko @ http://aleph.nkp.cz/F/?func=find-b&request=001122621&find_code=SYS&local_base=nkc
2002 @ 06 @ 10 @ Informační bulletin (Asociace vystavářských firem) @ http://aleph.nkp.cz/F/?func=find-b&request=001122869&find_code=SYS&local_base=nkc
2002 @ 06 @ 11 @ Informační list (Ekologický právní servis) @ http://aleph.nkp.cz/F/?func=find-b&request=001120996&find_code=SYS&local_base=nkc
2002 @ 06 @ 12 @ Informační zpravodaj obce (Horní Dubenky) @ http://aleph.nkp.cz/F/?func=find-b&request=001122216&find_code=SYS&local_base=nkc
2002 @ 06 @ 13 @ Keramika a sklo @ http://aleph.nkp.cz/F/?func=find-b&request=001122628&find_code=SYS&local_base=nkc
2002 @ 06 @ 14 @ Kobeřické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001124161&find_code=SYS&local_base=nkc
2002 @ 06 @ 15 @ Kolorektální karcinom @ http://aleph.nkp.cz/F/?func=find-b&request=001124112&find_code=SYS&local_base=nkc
2002 @ 06 @ 16 @ Komorník @ http://aleph.nkp.cz/F/?func=find-b&request=001124292&find_code=SYS&local_base=nkc
2002 @ 06 @ 17 @ Ledňáček @ http://aleph.nkp.cz/F/?func=find-b&request=001122202&find_code=SYS&local_base=nkc
2002 @ 06 @ 18 @ Listy hlavního města Prahy @ http://aleph.nkp.cz/F/?func=find-b&request=001122171&find_code=SYS&local_base=nkc
2002 @ 06 @ 19 @ Luna @ http://aleph.nkp.cz/F/?func=find-b&request=001122707&find_code=SYS&local_base=nkc
2002 @ 06 @ 20 @ Megasex @ http://aleph.nkp.cz/F/?func=find-b&request=001122872&find_code=SYS&local_base=nkc
2002 @ 06 @ 21 @ Michálkovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001122205&find_code=SYS&local_base=nkc
2002 @ 06 @ 22 @ Mini Max (Jindřichův Hradec) @ http://aleph.nkp.cz/F/?func=find-b&request=001124104&find_code=SYS&local_base=nkc
2002 @ 06 @ 23 @ Mini Max (Kolín) @ http://aleph.nkp.cz/F/?func=find-b&request=001124100&find_code=SYS&local_base=nkc
2002 @ 06 @ 24 @ Na doma @ http://aleph.nkp.cz/F/?func=find-b&request=001124122&find_code=SYS&local_base=nkc
2002 @ 06 @ 25 @ Národ sobě @ http://aleph.nkp.cz/F/?func=find-b&request=001122690&find_code=SYS&local_base=nkc
2002 @ 06 @ 26 @ Naše jihočeské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001121153&find_code=SYS&local_base=nkc
2002 @ 06 @ 27 @ Nejlepší bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=001122682&find_code=SYS&local_base=nkc
2002 @ 06 @ 28 @ Network computing @ http://aleph.nkp.cz/F/?func=find-b&request=001123100&find_code=SYS&local_base=nkc
2002 @ 06 @ 29 @ N.O.S. @ http://aleph.nkp.cz/F/?func=find-b&request=001124159&find_code=SYS&local_base=nkc
2002 @ 06 @ 30 @ Oáza @ http://aleph.nkp.cz/F/?func=find-b&request=001122713&find_code=SYS&local_base=nkc
2002 @ 06 @ 31 @ Otázky a odpovědi @ http://aleph.nkp.cz/F/?func=find-b&request=001139101&find_code=SYS&local_base=nkc
2002 @ 06 @ 32 @ Podnikatelský servis @ http://aleph.nkp.cz/F/?func=find-b&request=001122717&find_code=SYS&local_base=nkc
2002 @ 06 @ 33 @ Pontium @ http://aleph.nkp.cz/F/?func=find-b&request=001122881&find_code=SYS&local_base=nkc
2002 @ 06 @ 34 @ Practicus @ http://aleph.nkp.cz/F/?func=find-b&request=001122936&find_code=SYS&local_base=nkc
2002 @ 06 @ 35 @ Prague @ http://aleph.nkp.cz/F/?func=find-b&request=001139163&find_code=SYS&local_base=nkc
2002 @ 06 @ 36 @ Protimluv @ http://aleph.nkp.cz/F/?func=find-b&request=001124141&find_code=SYS&local_base=nkc
2002 @ 06 @ 37 @ Psychiatrie @ http://aleph.nkp.cz/F/?func=find-b&request=001122103&find_code=SYS&local_base=nkc
2002 @ 06 @ 38 @ Quarterly @ http://aleph.nkp.cz/F/?func=find-b&request=001124140&find_code=SYS&local_base=nkc
2002 @ 06 @ 39 @ Roden glas @ http://aleph.nkp.cz/F/?func=find-b&request=001122946&find_code=SYS&local_base=nkc
2002 @ 06 @ 40 @ Rozum národa @ http://aleph.nkp.cz/F/?func=find-b&request=001122825&find_code=SYS&local_base=nkc
2002 @ 06 @ 41 @ Současná klinická praxe @ http://aleph.nkp.cz/F/?func=find-b&request=001122879&find_code=SYS&local_base=nkc
2002 @ 06 @ 42 @ Soutěsky @ http://aleph.nkp.cz/F/?func=find-b&request=001122874&find_code=SYS&local_base=nkc
2002 @ 06 @ 43 @ Sova @ http://aleph.nkp.cz/F/?func=find-b&request=001124120&find_code=SYS&local_base=nkc
2002 @ 06 @ 44 @ STEN magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001139139&find_code=SYS&local_base=nkc
2002 @ 06 @ 45 @ Šupiňák @ http://aleph.nkp.cz/F/?func=find-b&request=001122819&find_code=SYS&local_base=nkc
2002 @ 06 @ 46 @ TipCars @ http://aleph.nkp.cz/F/?func=find-b&request=001122788&find_code=SYS&local_base=nkc
2002 @ 06 @ 47 @ Třebechovické haló @ http://aleph.nkp.cz/F/?func=find-b&request=001122799&find_code=SYS&local_base=nkc
2002 @ 06 @ 48 @ Van&pickup @ http://aleph.nkp.cz/F/?func=find-b&request=001122799&find_code=SYS&local_base=nkc
2002 @ 06 @ 49 @ Vaříme levně v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=001122868&find_code=SYS&local_base=nkc
2002 @ 06 @ 50 @ Vesti @ http://aleph.nkp.cz/F/?func=find-b&request=001092014&find_code=SYS&local_base=nkc
2002 @ 06 @ 51 @ Vitaland @ http://aleph.nkp.cz/F/?func=find-b&request=001122709&find_code=SYS&local_base=nkc
2002 @ 06 @ 52 @ Vokovický obzor @ http://aleph.nkp.cz/F/?func=find-b&request=001139166&find_code=SYS&local_base=nkc
2002 @ 06 @ 53 @ Zpravodaj (Kunčina a Nová Ves) @ http://aleph.nkp.cz/F/?func=find-b&request=001124165&find_code=SYS&local_base=nkc
2002 @ 06 @ 54 @ Zpravodaj (školství olomouckého kraje) @ http://aleph.nkp.cz/F/?func=find-b&request=001122925&find_code=SYS&local_base=nkc
2002 @ 06 @ 55 @ Zpravodaj města Mirotic @ http://aleph.nkp.cz/F/?func=find-b&request=001124212&find_code=SYS&local_base=nkc
2002 @ 06 @ 56 @ Zpravodaj nemocnice Rudolfa a Stefanie Benešov @ http://aleph.nkp.cz/F/?func=find-b&request=001124209&find_code=SYS&local_base=nkc
2002 @ 06 @ 57 @ Zpravodaj občanského sdružení Český granát a MěÚ v Třebenicích @ http://aleph.nkp.cz/F/?func=find-b&request=001124130&find_code=SYS&local_base=nkc
2002 @ 06 @ 58 @ Zpravodaj Sdružení Čechů z Volyně a jejich přátel @ http://aleph.nkp.cz/F/?func=find-b&request=001124217&find_code=SYS&local_base=nkc
2002 @ 06 @ 59 @ Zpravodaj sdružení orlovských občanů @ http://aleph.nkp.cz/F/?func=find-b&request=001139113&find_code=SYS&local_base=nkc
2002 @ 06 @ 60 @ Zprávy České společnosti rukopisné @ http://aleph.nkp.cz/F/?func=find-b&request=001123905&find_code=SYS&local_base=nkc
2002 @ 06 @ 61 @ Zrcadlo @ http://aleph.nkp.cz/F/?func=find-b&request=001123918&find_code=SYS&local_base=nkc
2002 @ 06 @ 62 @ Zvolské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001123908&find_code=SYS&local_base=nkc
2002 @ 07 @ 01 @ Andragogika @ http://aleph.nkp.cz/F/?func=find-b&request=001161495&find_code=SYS&local_base=nkc
2002 @ 07 @ 02 @ Apríl @ http://aleph.nkp.cz/F/?func=find-b&request=001139856&find_code=SYS&local_base=nkc
2002 @ 07 @ 03 @ Art&antiques @ http://aleph.nkp.cz/F/?func=find-b&request=001139871&find_code=SYS&local_base=nkc
2002 @ 07 @ 04 @ Autobox @ http://aleph.nkp.cz/F/?func=find-b&request=001182067&find_code=SYS&local_base=nkc
2002 @ 07 @ 05 @ Bílopotocké listy @ http://aleph.nkp.cz/F/?func=find-b&request=001181392&find_code=SYS&local_base=nkc
2002 @ 07 @ 06 @ Bulletin (Česko izraelská smíšená obchodní komora) @ http://aleph.nkp.cz/F/?func=find-b&request=001181356&find_code=SYS&local_base=nkc
2002 @ 07 @ 07 @ Bulletin Manželská setkání @ http://aleph.nkp.cz/F/?func=find-b&request=001181576&find_code=SYS&local_base=nkc
2002 @ 07 @ 08 @ Cenydnes @ http://aleph.nkp.cz/F/?func=find-b&request=001181578&find_code=SYS&local_base=nkc
2002 @ 07 @ 09 @ České veřejné mínění v evropských souvislostech @ http://aleph.nkp.cz/F/?func=find-b&request=001182030&find_code=SYS&local_base=nkc
2002 @ 07 @ 10 @ Dechovka @ http://aleph.nkp.cz/F/?func=find-b&request=001182368&find_code=SYS&local_base=nkc
2002 @ 07 @ 11 @ Developer @ http://aleph.nkp.cz/F/?func=find-b&request=001182363&find_code=SYS&local_base=nkc
2002 @ 07 @ 12 @ Disk @ http://aleph.nkp.cz/F/?func=find-b&request=001180676&find_code=SYS&local_base=nkc
2002 @ 07 @ 13 @ Dobřany @ http://aleph.nkp.cz/F/?func=find-b&request=001182049&find_code=SYS&local_base=nkc
2002 @ 07 @ 14 @ Domácí lékař @ http://aleph.nkp.cz/F/?func=find-b&request=001139842&find_code=SYS&local_base=nkc
2002 @ 07 @ 15 @ Dopravní magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001181291&find_code=SYS&local_base=nkc
2002 @ 07 @ 16 @ DVD-X @ http://aleph.nkp.cz/F/?func=find-b&request=001160951&find_code=SYS&local_base=nkc
2002 @ 07 @ 17 @ Enterprise @ http://aleph.nkp.cz/F/?func=find-b&request=001182337&find_code=SYS&local_base=nkc
2002 @ 07 @ 18 @ Free time @ http://aleph.nkp.cz/F/?func=find-b&request=001180279&find_code=SYS&local_base=nkc
2002 @ 07 @ 19 @ Freestyler @ http://aleph.nkp.cz/F/?func=find-b&request=001182340&find_code=SYS&local_base=nkc
2002 @ 07 @ 20 @ Game over @ http://aleph.nkp.cz/F/?func=find-b&request=001181295&find_code=SYS&local_base=nkc
2002 @ 07 @ 21 @ Golempress (okresy Hradec Králové@ Rychnov n.K., Náchod)', 'http://aleph.nkp.cz/F/?func=find-b&request=001181563&find_code=SYS&local_base=nkc
2002 @ 07 @ 22 @ Golempress (okresy Chrudim a Pardubice) @ http://aleph.nkp.cz/F/?func=find-b&request=001181561&find_code=SYS&local_base=nkc
2002 @ 07 @ 23 @ Golempress (okres Svitavy) @ http://aleph.nkp.cz/F/?func=find-b&request=001181567&find_code=SYS&local_base=nkc
2002 @ 07 @ 24 @ Golempress (okres Ústí nad Orlicí) @ http://aleph.nkp.cz/F/?func=find-b&request=001181557&find_code=SYS&local_base=nkc
2002 @ 07 @ 25 @ Hostomické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001181397&find_code=SYS&local_base=nkc
2002 @ 07 @ 26 @ Hradecký lev @ http://aleph.nkp.cz/F/?func=find-b&request=001180694&find_code=SYS&local_base=nkc
2002 @ 07 @ 27 @ Informace (Pozemní stavby Liberec) @ http://aleph.nkp.cz/F/?func=find-b&request=001182027&find_code=SYS&local_base=nkc
2002 @ 07 @ 28 @ Informační bulletin (Česká manažerská asociace) @ http://aleph.nkp.cz/F/?func=find-b&request=001181387&find_code=SYS&local_base=nkc
2002 @ 07 @ 29 @ Intervenční a akutní kardiologie @ http://aleph.nkp.cz/F/?func=find-b&request=001139814&find_code=SYS&local_base=nkc
2002 @ 07 @ 30 @ Journal of the American College of Cardiology @ http://aleph.nkp.cz/F/?func=find-b&request=001139873&find_code=SYS&local_base=nkc
2002 @ 07 @ 31 @ Kamelot @ http://aleph.nkp.cz/F/?func=find-b&request=001182600&find_code=SYS&local_base=nkc
2002 @ 07 @ 32 @ KEIMinfo magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001182055&find_code=SYS&local_base=nkc
2002 @ 07 @ 33 @ Klokan @ http://aleph.nkp.cz/F/?func=find-b&request=001182607&find_code=SYS&local_base=nkc
2002 @ 07 @ 34 @ Komunikace @ http://aleph.nkp.cz/F/?func=find-b&request=001181358&find_code=SYS&local_base=nkc
2002 @ 07 @ 35 @ Krok @ http://aleph.nkp.cz/F/?func=find-b&request=001139868&find_code=SYS&local_base=nkc
2002 @ 07 @ 36 @ Kruh @ http://aleph.nkp.cz/F/?func=find-b&request=001182346&find_code=SYS&local_base=nkc
2002 @ 07 @ 37 @ Křesťanská pedagogika @ http://aleph.nkp.cz/F/?func=find-b&request=001182610&find_code=SYS&local_base=nkc
2002 @ 07 @ 38 @ Kunratický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001160581&find_code=SYS&local_base=nkc
2002 @ 07 @ 39 @ KyberMyš @ http://aleph.nkp.cz/F/?func=find-b&request=001139824&find_code=SYS&local_base=nkc
2002 @ 07 @ 40 @ Lekov news @ http://aleph.nkp.cz/F/?func=find-b&request=001181579&find_code=SYS&local_base=nkc
2002 @ 07 @ 41 @ Made in Shell @ http://aleph.nkp.cz/F/?func=find-b&request=001182335&find_code=SYS&local_base=nkc
2002 @ 07 @ 42 @ Machovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001181570&find_code=SYS&local_base=nkc
2002 @ 07 @ 43 @ Matice Čech@ Moravy a Slezska', 'http://aleph.nkp.cz/F/?func=find-b&request=001181349&find_code=SYS&local_base=nkc
2002 @ 07 @ 44 @ Metropolitan magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001161510&find_code=SYS&local_base=nkc
2002 @ 07 @ 45 @ Mini horoskopy do kapsy @ http://aleph.nkp.cz/F/?func=find-b&request=001182034&find_code=SYS&local_base=nkc
2002 @ 07 @ 46 @ Mix @ http://aleph.nkp.cz/F/?func=find-b&request=001182353&find_code=SYS&local_base=nkc
2002 @ 07 @ 47 @ Moravský demokrat @ http://aleph.nkp.cz/F/?func=find-b&request=001181296&find_code=SYS&local_base=nkc
2002 @ 07 @ 48 @ Motokros @ http://aleph.nkp.cz/F/?func=find-b&request=001180269&find_code=SYS&local_base=nkc
2002 @ 07 @ 49 @ Náš zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001181366&find_code=SYS&local_base=nkc
2002 @ 07 @ 50 @ Nebuželský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001181352&find_code=SYS&local_base=nkc
2002 @ 07 @ 51 @ Nové ústecké přehledy @ http://aleph.nkp.cz/F/?func=find-b&request=001179994&find_code=SYS&local_base=nkc
2002 @ 07 @ 52 @ Okružní dopis @ http://aleph.nkp.cz/F/?func=find-b&request=001179987&find_code=SYS&local_base=nkc
2002 @ 07 @ 53 @ Pandora @ http://aleph.nkp.cz/F/?func=find-b&request=001180006&find_code=SYS&local_base=nkc
2002 @ 07 @ 54 @ Polytechné @ http://aleph.nkp.cz/F/?func=find-b&request=001161380&find_code=SYS&local_base=nkc
2002 @ 07 @ 55 @ ProBrno @ http://aleph.nkp.cz/F/?func=find-b&request=001139798&find_code=SYS&local_base=nkc
2002 @ 07 @ 56 @ Professional @ http://aleph.nkp.cz/F/?func=find-b&request=001139782&find_code=SYS&local_base=nkc
2002 @ 07 @ 57 @ Rady z Receptáře @ http://aleph.nkp.cz/F/?func=find-b&request=001180111&find_code=SYS&local_base=nkc
2002 @ 07 @ 58 @ Realitní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001179983&find_code=SYS&local_base=nkc
2002 @ 07 @ 59 @ Reklamní produkce @ http://aleph.nkp.cz/F/?func=find-b&request=001180148&find_code=SYS&local_base=nkc
2002 @ 07 @ 60 @ Rokycanský servis @ http://aleph.nkp.cz/F/?func=find-b&request=001180019&find_code=SYS&local_base=nkc
2002 @ 07 @ 61 @ Sergei @ http://aleph.nkp.cz/F/?func=find-b&request=001161385&find_code=SYS&local_base=nkc
2002 @ 07 @ 62 @ Sexrande @ http://aleph.nkp.cz/F/?func=find-b&request=001139403&find_code=SYS&local_base=nkc
2002 @ 07 @ 63 @ Svět kolem nás @ http://aleph.nkp.cz/F/?func=find-b&request=001161499&find_code=SYS&local_base=nkc
2002 @ 07 @ 64 @ Synchron @ http://aleph.nkp.cz/F/?func=find-b&request=001139408&find_code=SYS&local_base=nkc
2002 @ 07 @ 65 @ Synthesia @ http://aleph.nkp.cz/F/?func=find-b&request=001180036&find_code=SYS&local_base=nkc
2002 @ 07 @ 66 @ Trnem v oku @ http://aleph.nkp.cz/F/?func=find-b&request=001139407&find_code=SYS&local_base=nkc
2002 @ 07 @ 67 @ TV tip seriál @ http://aleph.nkp.cz/F/?func=find-b&request=001180133&find_code=SYS&local_base=nkc
2002 @ 07 @ 68 @ Týdeník Břeclavsko @ http://aleph.nkp.cz/F/?func=find-b&request=001180024&find_code=SYS&local_base=nkc
2002 @ 07 @ 69 @ Věstník Jihočeského kraje @ http://aleph.nkp.cz/F/?func=find-b&request=001139773&find_code=SYS&local_base=nkc
2002 @ 07 @ 70 @ Záhady & okultismus @ http://aleph.nkp.cz/F/?func=find-b&request=001179979&find_code=SYS&local_base=nkc
2002 @ 07 @ 71 @ Zámeček @ http://aleph.nkp.cz/F/?func=find-b&request=001180009&find_code=SYS&local_base=nkc
2002 @ 07 @ 72 @ Zpravodaj Společnosti Beno Blachuta @ http://aleph.nkp.cz/F/?func=find-b&request=001180031&find_code=SYS&local_base=nkc
2002 @ 07 @ 73 @ Zpravodaj státní báňské správy ČR @ http://aleph.nkp.cz/F/?func=find-b&request=001180649&find_code=SYS&local_base=nkc
2002 @ 07 @ 74 @ Zpravodaj US-DEU @ http://aleph.nkp.cz/F/?func=find-b&request=001179998&find_code=SYS&local_base=nkc
2002 @ 08 @ 01 @ Andragogika @ http://aleph.nkp.cz/F/?func=find-b&request=001161495&find_code=SYS&local_base=nkc
2002 @ 08 @ 02 @ Apríl @ http://aleph.nkp.cz/F/?func=find-b&request=001139856&find_code=SYS&local_base=nkc
2002 @ 08 @ 03 @ Art&antiques @ http://aleph.nkp.cz/F/?func=find-b&request=001139871&find_code=SYS&local_base=nkc
2002 @ 08 @ 04 @ Autobox @ http://aleph.nkp.cz/F/?func=find-b&request=001182067&find_code=SYS&local_base=nkc
2002 @ 08 @ 05 @ Bílopotocké listy @ http://aleph.nkp.cz/F/?func=find-b&request=001181392&find_code=SYS&local_base=nkc
2002 @ 08 @ 06 @ Bulletin (Česko izraelská smíšená obchodní komora) @ http://aleph.nkp.cz/F/?func=find-b&request=001181356&find_code=SYS&local_base=nkc
2002 @ 08 @ 07 @ Bulletin Manželská setkání @ http://aleph.nkp.cz/F/?func=find-b&request=001181576&find_code=SYS&local_base=nkc
2002 @ 08 @ 08 @ Cenydnes @ http://aleph.nkp.cz/F/?func=find-b&request=001181578&find_code=SYS&local_base=nkc
2002 @ 08 @ 09 @ České veřejné mínění v evropských souvislostech @ http://aleph.nkp.cz/F/?func=find-b&request=001182030&find_code=SYS&local_base=nkc
2002 @ 08 @ 10 @ Dechovka @ http://aleph.nkp.cz/F/?func=find-b&request=001182368&find_code=SYS&local_base=nkc
2002 @ 08 @ 11 @ Developer @ http://aleph.nkp.cz/F/?func=find-b&request=001182363&find_code=SYS&local_base=nkc
2002 @ 08 @ 12 @ Disk @ http://aleph.nkp.cz/F/?func=find-b&request=001180676&find_code=SYS&local_base=nkc
2002 @ 08 @ 13 @ Dobřany @ http://aleph.nkp.cz/F/?func=find-b&request=001182049&find_code=SYS&local_base=nkc
2002 @ 08 @ 14 @ Domácí lékař @ http://aleph.nkp.cz/F/?func=find-b&request=001139842&find_code=SYS&local_base=nkc
2002 @ 08 @ 15 @ Dopravní magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001181291&find_code=SYS&local_base=nkc
2002 @ 08 @ 16 @ DVD-X @ http://aleph.nkp.cz/F/?func=find-b&request=001160951&find_code=SYS&local_base=nkc
2002 @ 08 @ 17 @ Enterprise @ http://aleph.nkp.cz/F/?func=find-b&request=001182337&find_code=SYS&local_base=nkc
2002 @ 08 @ 18 @ Free time @ http://aleph.nkp.cz/F/?func=find-b&request=001180279&find_code=SYS&local_base=nkc
2002 @ 08 @ 19 @ Freestyler @ http://aleph.nkp.cz/F/?func=find-b&request=001182340&find_code=SYS&local_base=nkc
2002 @ 08 @ 20 @ Game over @ http://aleph.nkp.cz/F/?func=find-b&request=001181295&find_code=SYS&local_base=nkc
2002 @ 08 @ 21 @ Golempress (okresy Hradec Králové@ Rychnov n.K., Náchod)', 'http://aleph.nkp.cz/F/?func=find-b&request=001181563&find_code=SYS&local_base=nkc
2002 @ 08 @ 22 @ Golempress (okresy Chrudim a Pardubice) @ http://aleph.nkp.cz/F/?func=find-b&request=001181561&find_code=SYS&local_base=nkc
2002 @ 08 @ 23 @ Golempress (okres Svitavy) @ http://aleph.nkp.cz/F/?func=find-b&request=001181567&find_code=SYS&local_base=nkc
2002 @ 08 @ 24 @ Golempress (okres Ústí nad Orlicí) @ http://aleph.nkp.cz/F/?func=find-b&request=001181557&find_code=SYS&local_base=nkc
2002 @ 08 @ 25 @ Hostomické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001181397&find_code=SYS&local_base=nkc
2002 @ 08 @ 26 @ Hradecký lev @ http://aleph.nkp.cz/F/?func=find-b&request=001180694&find_code=SYS&local_base=nkc
2002 @ 08 @ 27 @ Informace (Pozemní stavby Liberec) @ http://aleph.nkp.cz/F/?func=find-b&request=001182027&find_code=SYS&local_base=nkc
2002 @ 08 @ 28 @ Informační bulletin (Česká manažerská asociace) @ http://aleph.nkp.cz/F/?func=find-b&request=001181387&find_code=SYS&local_base=nkc
2002 @ 08 @ 29 @ Intervenční a akutní kardiologie @ http://aleph.nkp.cz/F/?func=find-b&request=001139814&find_code=SYS&local_base=nkc
2002 @ 08 @ 30 @ Journal of the American College of Cardiology @ http://aleph.nkp.cz/F/?func=find-b&request=001139873&find_code=SYS&local_base=nkc
2002 @ 08 @ 31 @ Kamelot @ http://aleph.nkp.cz/F/?func=find-b&request=001182600&find_code=SYS&local_base=nkc
2002 @ 08 @ 32 @ KEIMinfo magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001182055&find_code=SYS&local_base=nkc
2002 @ 08 @ 33 @ Klokan @ http://aleph.nkp.cz/F/?func=find-b&request=001182607&find_code=SYS&local_base=nkc
2002 @ 08 @ 34 @ Komunikace @ http://aleph.nkp.cz/F/?func=find-b&request=001181358&find_code=SYS&local_base=nkc
2002 @ 08 @ 35 @ Krok @ http://aleph.nkp.cz/F/?func=find-b&request=001139868&find_code=SYS&local_base=nkc
2002 @ 08 @ 36 @ Kruh @ http://aleph.nkp.cz/F/?func=find-b&request=001182346&find_code=SYS&local_base=nkc
2002 @ 08 @ 37 @ Křesťanská pedagogika @ http://aleph.nkp.cz/F/?func=find-b&request=001182610&find_code=SYS&local_base=nkc
2002 @ 08 @ 38 @ Kunratický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001160581&find_code=SYS&local_base=nkc
2002 @ 08 @ 39 @ KyberMyš @ http://aleph.nkp.cz/F/?func=find-b&request=001139824&find_code=SYS&local_base=nkc
2002 @ 08 @ 40 @ Lekov news @ http://aleph.nkp.cz/F/?func=find-b&request=001181579&find_code=SYS&local_base=nkc
2002 @ 08 @ 41 @ Made in Shell @ http://aleph.nkp.cz/F/?func=find-b&request=001182335&find_code=SYS&local_base=nkc
2002 @ 08 @ 42 @ Machovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001181570&find_code=SYS&local_base=nkc
2002 @ 08 @ 43 @ Matice Čech@ Moravy a Slezska', 'http://aleph.nkp.cz/F/?func=find-b&request=001181349&find_code=SYS&local_base=nkc
2002 @ 08 @ 44 @ Metropolitan magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001161510&find_code=SYS&local_base=nkc
2002 @ 08 @ 45 @ Mini horoskopy do kapsy @ http://aleph.nkp.cz/F/?func=find-b&request=001182034&find_code=SYS&local_base=nkc
2002 @ 08 @ 46 @ Mix @ http://aleph.nkp.cz/F/?func=find-b&request=001182353&find_code=SYS&local_base=nkc
2002 @ 08 @ 47 @ Moravský demokrat @ http://aleph.nkp.cz/F/?func=find-b&request=001181296&find_code=SYS&local_base=nkc
2002 @ 08 @ 48 @ Motokros @ http://aleph.nkp.cz/F/?func=find-b&request=001180269&find_code=SYS&local_base=nkc
2002 @ 08 @ 49 @ Náš zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001181366&find_code=SYS&local_base=nkc
2002 @ 08 @ 50 @ Nebuželský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001181352&find_code=SYS&local_base=nkc
2002 @ 08 @ 51 @ Nové ústecké přehledy @ http://aleph.nkp.cz/F/?func=find-b&request=001179994&find_code=SYS&local_base=nkc
2002 @ 08 @ 52 @ Okružní dopis @ http://aleph.nkp.cz/F/?func=find-b&request=001179987&find_code=SYS&local_base=nkc
2002 @ 08 @ 53 @ Pandora @ http://aleph.nkp.cz/F/?func=find-b&request=001180006&find_code=SYS&local_base=nkc
2002 @ 08 @ 54 @ Polytechné @ http://aleph.nkp.cz/F/?func=find-b&request=001161380&find_code=SYS&local_base=nkc
2002 @ 08 @ 55 @ ProBrno @ http://aleph.nkp.cz/F/?func=find-b&request=001139798&find_code=SYS&local_base=nkc
2002 @ 08 @ 56 @ Professional @ http://aleph.nkp.cz/F/?func=find-b&request=001139782&find_code=SYS&local_base=nkc
2002 @ 08 @ 57 @ Rady z Receptáře @ http://aleph.nkp.cz/F/?func=find-b&request=001180111&find_code=SYS&local_base=nkc
2002 @ 08 @ 58 @ Realitní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001179983&find_code=SYS&local_base=nkc
2002 @ 08 @ 59 @ Reklamní produkce @ http://aleph.nkp.cz/F/?func=find-b&request=001180148&find_code=SYS&local_base=nkc
2002 @ 08 @ 60 @ Rokycanský servis @ http://aleph.nkp.cz/F/?func=find-b&request=001180019&find_code=SYS&local_base=nkc
2002 @ 08 @ 61 @ Sergei @ http://aleph.nkp.cz/F/?func=find-b&request=001161385&find_code=SYS&local_base=nkc
2002 @ 08 @ 62 @ Sexrande @ http://aleph.nkp.cz/F/?func=find-b&request=001139403&find_code=SYS&local_base=nkc
2002 @ 08 @ 63 @ Svět kolem nás @ http://aleph.nkp.cz/F/?func=find-b&request=001161499&find_code=SYS&local_base=nkc
2002 @ 08 @ 64 @ Synchron @ http://aleph.nkp.cz/F/?func=find-b&request=001139408&find_code=SYS&local_base=nkc
2002 @ 08 @ 65 @ Synthesia @ http://aleph.nkp.cz/F/?func=find-b&request=001180036&find_code=SYS&local_base=nkc
2002 @ 08 @ 66 @ Trnem v oku @ http://aleph.nkp.cz/F/?func=find-b&request=001139407&find_code=SYS&local_base=nkc
2002 @ 08 @ 67 @ TV tip seriál @ http://aleph.nkp.cz/F/?func=find-b&request=001180133&find_code=SYS&local_base=nkc
2002 @ 08 @ 68 @ Týdeník Břeclavsko @ http://aleph.nkp.cz/F/?func=find-b&request=001180024&find_code=SYS&local_base=nkc
2002 @ 08 @ 69 @ Věstník Jihočeského kraje @ http://aleph.nkp.cz/F/?func=find-b&request=001139773&find_code=SYS&local_base=nkc
2002 @ 08 @ 70 @ Záhady & okultismus @ http://aleph.nkp.cz/F/?func=find-b&request=001179979&find_code=SYS&local_base=nkc
2002 @ 08 @ 71 @ Zámeček @ http://aleph.nkp.cz/F/?func=find-b&request=001180009&find_code=SYS&local_base=nkc
2002 @ 08 @ 72 @ Zpravodaj Společnosti Beno Blachuta @ http://aleph.nkp.cz/F/?func=find-b&request=001180031&find_code=SYS&local_base=nkc
2002 @ 08 @ 73 @ Zpravodaj státní báňské správy ČR @ http://aleph.nkp.cz/F/?func=find-b&request=001180649&find_code=SYS&local_base=nkc
2002 @ 08 @ 74 @ Zpravodaj US-DEU @ http://aleph.nkp.cz/F/?func=find-b&request=001179998&find_code=SYS&local_base=nkc
1999 @ 01 @ 11 @ ZPS. Kovák @ http://aleph.nkp.cz/F/?func=find-b&request=000738220&find_code=SYS&local_base=nkc
1999 @ 01 @ 10 @ Zpravodaj pro mzdové účetní a personalisty @ http://aleph.nkp.cz/F/?func=find-b&request=000642364&find_code=SYS&local_base=nkc
1999 @ 01 @ 09 @ Zabezpečení a kriminalita + SAFE @ http://aleph.nkp.cz/F/?func=find-b&request=000605269&find_code=SYS&local_base=nkc
1999 @ 01 @ 08 @ Velo. Revue o životě s kolem @ http://aleph.nkp.cz/F/?func=find-b&request=000605241&find_code=SYS&local_base=nkc
1999 @ 01 @ 07 @ Trefa. Šipky@ sport a mnohem více', 'http://aleph.nkp.cz/F/?func=find-b&request=000699201&find_code=SYS&local_base=nkc
1999 @ 01 @ 06 @ Spy @ http://aleph.nkp.cz/F/?func=find-b&request=000606788&find_code=SYS&local_base=nkc
2002 @ 09 @ 27 @ Program (Frýdecko-Místecko) @ http://aleph.nkp.cz/F/?func=find-b&request=001185613&find_code=SYS&local_base=nkc
2002 @ 09 @ 26 @ Prevence sociálně patologických jevů @ http://aleph.nkp.cz/F/?func=find-b&request=001185634&find_code=SYS&local_base=nkc
2002 @ 09 @ 25 @ Poličský nezávislý občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001185062&find_code=SYS&local_base=nkc
2002 @ 09 @ 24 @ Pardubický inzertní týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=001185618&find_code=SYS&local_base=nkc
2002 @ 09 @ 23 @ Osmisměrky trošku jinak @ http://aleph.nkp.cz/F/?func=find-b&request=001185470&find_code=SYS&local_base=nkc
2002 @ 09 @ 22 @ Osmisměrky pro hravé @ http://aleph.nkp.cz/F/?func=find-b&request=001185407&find_code=SYS&local_base=nkc
2002 @ 09 @ 21 @ Osmisměrky o rekordech @ http://aleph.nkp.cz/F/?func=find-b&request=001185456&find_code=SYS&local_base=nkc
2002 @ 09 @ 20 @ Osmisměrky a výhry @ http://aleph.nkp.cz/F/?func=find-b&request=001185454&find_code=SYS&local_base=nkc
2002 @ 09 @ 19 @ OP trend @ http://aleph.nkp.cz/F/?func=find-b&request=001187303&find_code=SYS&local_base=nkc
2002 @ 09 @ 18 @ Okno do neziskového sektoru @ http://aleph.nkp.cz/F/?func=find-b&request=001185224&find_code=SYS&local_base=nkc
2002 @ 09 @ 17 @ Nenuďte se@ luštěte!', 'http://aleph.nkp.cz/F/?func=find-b&request=001185439&find_code=SYS&local_base=nkc
2002 @ 09 @ 16 @ National Geographic @ http://aleph.nkp.cz/F/?func=find-b&request=001187993&find_code=SYS&local_base=nkc
2002 @ 09 @ 15 @ Levné osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001185450&find_code=SYS&local_base=nkc
2002 @ 09 @ 14 @ Levná zábava @ http://aleph.nkp.cz/F/?func=find-b&request=001185461&find_code=SYS&local_base=nkc
2002 @ 09 @ 12 @ Křížovky proti nudě @ http://aleph.nkp.cz/F/?func=find-b&request=001185458&find_code=SYS&local_base=nkc
2002 @ 09 @ 13 @ Květiny našich babiček @ http://aleph.nkp.cz/F/?func=find-b&request=001185471&find_code=SYS&local_base=nkc
2002 @ 09 @ 11 @ Křížovky pro zdravý život @ http://aleph.nkp.cz/F/?func=find-b&request=001185469&find_code=SYS&local_base=nkc
2002 @ 09 @ 10 @ Křížovky a výhry @ http://aleph.nkp.cz/F/?func=find-b&request=001185459&find_code=SYS&local_base=nkc
2002 @ 09 @ 08 @ Horizont @ http://aleph.nkp.cz/F/?func=find-b&request=001187314&find_code=SYS&local_base=nkc
2002 @ 09 @ 09 @ Hromada osmisměrek @ http://aleph.nkp.cz/F/?func=find-b&request=001185436&find_code=SYS&local_base=nkc
2002 @ 09 @ 07 @ Homeopatický bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=001185237&find_code=SYS&local_base=nkc
2002 @ 09 @ 06 @ Fotograf @ http://aleph.nkp.cz/F/?func=find-b&request=001186136&find_code=SYS&local_base=nkc
2002 @ 09 @ 03 @ Bulletin ČSNS @ http://aleph.nkp.cz/F/?func=find-b&request=001187298&find_code=SYS&local_base=nkc
2002 @ 09 @ 04 @ DanceTime @ http://aleph.nkp.cz/F/?func=find-b&request=001187305&find_code=SYS&local_base=nkc
2002 @ 09 @ 05 @ European Element @ http://aleph.nkp.cz/F/?func=find-b&request=001185640&find_code=SYS&local_base=nkc
2002 @ 09 @ 02 @ BaSys news @ http://aleph.nkp.cz/F/?func=find-b&request=001187300&find_code=SYS&local_base=nkc
2002 @ 09 @ 01 @ Akvárium živě @ http://aleph.nkp.cz/F/?func=find-b&request=001185233&find_code=SYS&local_base=nkc
2002 @ 10 @ 01 @ Autocar @ http://aleph.nkp.cz/F/?func=find-b&request=001188891&find_code=SYS&local_base=nkc
2002 @ 10 @ 02 @ Centrum @ http://aleph.nkp.cz/F/?func=find-b&request=001188901&find_code=SYS&local_base=nkc
2002 @ 10 @ 03 @ České byty @ http://aleph.nkp.cz/F/?func=find-b&request=001188878&find_code=SYS&local_base=nkc
2002 @ 10 @ 04 @ České noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001189076&find_code=SYS&local_base=nkc
2002 @ 10 @ 05 @ Dejvický obzor @ http://aleph.nkp.cz/F/?func=find-b&request=001191006&find_code=SYS&local_base=nkc
2002 @ 10 @ 06 @ Deseňáček @ http://aleph.nkp.cz/F/?func=find-b&request=000968145&find_code=SYS&local_base=nkc
2002 @ 10 @ 07 @ Dětské křížovky s omalovánkami @ http://aleph.nkp.cz/F/?func=find-b&request=001189483&find_code=SYS&local_base=nkc
2002 @ 10 @ 08 @ Dobrá lékárna @ http://aleph.nkp.cz/F/?func=find-b&request=001189015&find_code=SYS&local_base=nkc
2002 @ 10 @ 09 @ Energy @ http://aleph.nkp.cz/F/?func=find-b&request=001189618&find_code=SYS&local_base=nkc
2002 @ 10 @ 10 @ Fidlovačka @ http://aleph.nkp.cz/F/?func=find-b&request=001190660&find_code=SYS&local_base=nkc
2002 @ 10 @ 11 @ Kralovicko @ http://aleph.nkp.cz/F/?func=find-b&request=001190669&find_code=SYS&local_base=nkc
2002 @ 10 @ 12 @ Křížovky a osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001190665&find_code=SYS&local_base=nkc
2002 @ 10 @ 13 @ Kulturní magazín (Vimperk) @ http://aleph.nkp.cz/F/?func=find-b&request=001191005&find_code=SYS&local_base=nkc
2002 @ 10 @ 14 @ Mini křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001190027&find_code=SYS&local_base=nkc
2002 @ 10 @ 15 @ Mini osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001190023&find_code=SYS&local_base=nkc
2002 @ 10 @ 16 @ Modlitby matek @ http://aleph.nkp.cz/F/?func=find-b&request=001190042&find_code=SYS&local_base=nkc
2002 @ 10 @ 17 @ Olympia noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001190702&find_code=SYS&local_base=nkc
2002 @ 10 @ 18 @ Osmisměrky pro zdraví  @ http://aleph.nkp.cz/F/?func=find-b&request=001189453&find_code=SYS&local_base=nkc
2002 @ 10 @ 19 @ Plzeňský metropol @ http://aleph.nkp.cz/F/?func=find-b&request=001189453&find_code=SYS&local_base=nkc
2002 @ 10 @ 20 @ Plž @ http://aleph.nkp.cz/F/?func=find-b&request=001188394&find_code=SYS&local_base=nkc
2002 @ 10 @ 21 @ Pražan @ http://aleph.nkp.cz/F/?func=find-b&request=001189278&find_code=SYS&local_base=nkc
2002 @ 10 @ 22 @ Prokopské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001190363&find_code=SYS&local_base=nkc
2002 @ 10 @ 23 @ Radostné stáří @ http://aleph.nkp.cz/F/?func=find-b&request=001189084&find_code=SYS&local_base=nkc
2002 @ 10 @ 24 @ Real-City @ http://aleph.nkp.cz/F/?func=find-b&request=001190676&find_code=SYS&local_base=nkc
2002 @ 10 @ 25 @ Report @ http://aleph.nkp.cz/F/?func=find-b&request=001189299&find_code=SYS&local_base=nkc
2002 @ 10 @ 26 @ Rudenské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001190378&find_code=SYS&local_base=nkc
2002 @ 10 @ 27 @ Teletubbies @ http://aleph.nkp.cz/F/?func=find-b&request=001190358&find_code=SYS&local_base=nkc
2002 @ 10 @ 28 @ Top profesional @ http://aleph.nkp.cz/F/?func=find-b&request=001190376&find_code=SYS&local_base=nkc
2002 @ 10 @ 29 @ V-style @ http://aleph.nkp.cz/F/?func=find-b&request=001188604&find_code=SYS&local_base=nkc
2002 @ 10 @ 30 @ Zase to @ http://aleph.nkp.cz/F/?func=find-b&request=001189285&find_code=SYS&local_base=nkc
2002 @ 10 @ 31 @ Zdravotní politika a ekonomika @ http://aleph.nkp.cz/F/?func=find-b&request=001190998&find_code=SYS&local_base=nkc
2002 @ 10 @ 32 @ Zprávy České společnosti ornitologické @ http://aleph.nkp.cz/F/?func=find-b&request=001190004&find_code=SYS&local_base=nkc
2002 @ 10 @ 33 @ Žandovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001189088&find_code=SYS&local_base=nkc
2002 @ 11 @ 01 @ @ magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001192754&find_code=SYS&local_base=nkc
2002 @ 11 @ 02 @ Aktual inzert @ http://aleph.nkp.cz/F/?func=find-b&request=001192723&find_code=SYS&local_base=nkc
2002 @ 11 @ 03 @ Animma.x @ http://aleph.nkp.cz/F/?func=find-b&request=001192123&find_code=SYS&local_base=nkc
2002 @ 11 @ 04 @ Anna @ http://aleph.nkp.cz/F/?func=find-b&request=001191040&find_code=SYS&local_base=nkc
2002 @ 11 @ 05 @ Appian @ http://aleph.nkp.cz/F/?func=find-b&request=001192050&find_code=SYS&local_base=nkc
2002 @ 11 @ 06 @ Aquasport-triatlon-běhání @ http://aleph.nkp.cz/F/?func=find-b&request=001192763&find_code=SYS&local_base=nkc
2002 @ 11 @ 07 @ Autohifi @ http://aleph.nkp.cz/F/?func=find-b&request=001193189&find_code=SYS&local_base=nkc
2002 @ 11 @ 08 @ BM @ http://aleph.nkp.cz/F/?func=find-b&request=001193189&find_code=SYS&local_base=nkc
2002 @ 11 @ 09 @ Bulletin ekologického zemědělství @ http://aleph.nkp.cz/F/?func=find-b&request=001193915&find_code=SYS&local_base=nkc
2002 @ 11 @ 10 @ Bulletin Institutu Svazu účetních @ http://aleph.nkp.cz/F/?func=find-b&request=001193399&find_code=SYS&local_base=nkc
2002 @ 11 @ 11 @ Club magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001192030&find_code=SYS&local_base=nkc
2002 @ 11 @ 12 @ Controlling @ http://aleph.nkp.cz/F/?func=find-b&request=001191392&find_code=SYS&local_base=nkc
2002 @ 11 @ 13 @ Czech Defence & Aviation Industry Review @ http://aleph.nkp.cz/F/?func=find-b&request=001192046&find_code=SYS&local_base=nkc
2002 @ 11 @ 14 @ Čechofracht revue @ http://aleph.nkp.cz/F/?func=find-b&request=001192810&find_code=SYS&local_base=nkc
2002 @ 11 @ 15 @ Čtení pro mladé @ http://aleph.nkp.cz/F/?func=find-b&request=001193379&find_code=SYS&local_base=nkc
2002 @ 11 @ 16 @ Daně@ účetnictví : vzory a případy', 'http://aleph.nkp.cz/F/?func=find-b&request=001193377&find_code=SYS&local_base=nkc
2002 @ 11 @ 17 @ Donna @ http://aleph.nkp.cz/F/?func=find-b&request=001193177&find_code=SYS&local_base=nkc
2002 @ 11 @ 18 @ Eurotruck @ http://aleph.nkp.cz/F/?func=find-b&request=001193198&find_code=SYS&local_base=nkc
2002 @ 11 @ 19 @ Fulnecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001193166&find_code=SYS&local_base=nkc
2002 @ 11 @ 20 @ Hodonínsko @ http://aleph.nkp.cz/F/?func=find-b&request=001192124&find_code=SYS&local_base=nkc
2002 @ 11 @ 21 @ Informátor obce Košařiska - Biuletin gminy Košařiska @ http://aleph.nkp.cz/F/?func=find-b&request=001191318&find_code=SYS&local_base=nkc
2002 @ 11 @ 22 @ JAMA Dermatology @ http://aleph.nkp.cz/F/?func=find-b&request=001193204&find_code=SYS&local_base=nkc
2002 @ 11 @ 23 @ Jídlo@ pití, žití', 'http://aleph.nkp.cz/F/?func=find-b&request=001191394&find_code=SYS&local_base=nkc
2002 @ 11 @ 24 @ Kahan @ http://aleph.nkp.cz/F/?func=find-b&request=001193197&find_code=SYS&local_base=nkc
2002 @ 11 @ 25 @ Křivsoudovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001193159&find_code=SYS&local_base=nkc
2002 @ 11 @ 26 @ Lancet Oncology @ http://aleph.nkp.cz/F/?func=find-b&request=001193395&find_code=SYS&local_base=nkc
2002 @ 11 @ 27 @ Mamita @ http://aleph.nkp.cz/F/?func=find-b&request=001193222&find_code=SYS&local_base=nkc
2002 @ 11 @ 28 @ Mostecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001193402&find_code=SYS&local_base=nkc
2002 @ 11 @ 29 @ Netvořicko @ http://aleph.nkp.cz/F/?func=find-b&request=001192806&find_code=SYS&local_base=nkc
2002 @ 11 @ 30 @ Nohejbal @ http://aleph.nkp.cz/F/?func=find-b&request=001193384&find_code=SYS&local_base=nkc
2002 @ 11 @ 31 @ Nové Bratrské Listy @ http://aleph.nkp.cz/F/?func=find-b&request=001191327&find_code=SYS&local_base=nkc
2002 @ 11 @ 32 @ Plzeňská teplárenská @ http://aleph.nkp.cz/F/?func=find-b&request=001192133&find_code=SYS&local_base=nkc
2002 @ 11 @ 33 @ Promenade @ http://aleph.nkp.cz/F/?func=find-b&request=001193883&find_code=SYS&local_base=nkc
2002 @ 11 @ 34 @ Radnice @ http://aleph.nkp.cz/F/?func=find-b&request=001192141&find_code=SYS&local_base=nkc
2002 @ 11 @ 35 @ Reality magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001192137&find_code=SYS&local_base=nkc
2002 @ 11 @ 36 @ Referátový výběr z dermatovenerologie @ http://aleph.nkp.cz/F/?func=find-b&request=001192966&find_code=SYS&local_base=nkc
2002 @ 11 @ 37 @ Snow @ http://aleph.nkp.cz/F/?func=find-b&request=001193869&find_code=SYS&local_base=nkc
2002 @ 11 @ 38 @ Techologies & Prosperity @ http://aleph.nkp.cz/F/?func=find-b&request=001190353&find_code=SYS&local_base=nkc
2002 @ 11 @ 39 @ Teologické studie @ http://aleph.nkp.cz/F/?func=find-b&request=001193909&find_code=SYS&local_base=nkc
2002 @ 11 @ 40 @ Transfuze a hematologie dnes @ http://aleph.nkp.cz/F/?func=find-b&request=001193196&find_code=SYS&local_base=nkc
2002 @ 11 @ 41 @ Třebichovický měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=001192802&find_code=SYS&local_base=nkc
2002 @ 11 @ 42 @ Ultramix @ http://aleph.nkp.cz/F/?func=find-b&request=001193309&find_code=SYS&local_base=nkc
2002 @ 11 @ 43 @ Vyhrejte s křížovkami! @ http://aleph.nkp.cz/F/?func=find-b&request=001193218&find_code=SYS&local_base=nkc
2002 @ 11 @ 44 @ Vyhrejte s osmisměrkami! @ http://aleph.nkp.cz/F/?func=find-b&request=001193217&find_code=SYS&local_base=nkc
2002 @ 11 @ 45 @ Zdislavický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001193914&find_code=SYS&local_base=nkc
2002 @ 11 @ 46 @ Zpravodaj Městského divadla v Karlových Varech @ http://aleph.nkp.cz/F/?func=find-b&request=001193405&find_code=SYS&local_base=nkc
2002 @ 11 @ 47 @ Zpravodaj OSA @ http://aleph.nkp.cz/F/?func=find-b&request=001193316&find_code=SYS&local_base=nkc
2002 @ 12 @ 01 @ Alive @ http://aleph.nkp.cz/F/?func=find-b&request=001197820&find_code=SYS&local_base=nkc
2002 @ 12 @ 02 @ Aperio @ http://aleph.nkp.cz/F/?func=find-b&request=001197392&find_code=SYS&local_base=nkc
2002 @ 12 @ 03 @ Brněnský program @ http://aleph.nkp.cz/F/?func=find-b&request=001197422&find_code=SYS&local_base=nkc
2002 @ 12 @ 04 @ Electrolux news @ http://aleph.nkp.cz/F/?func=find-b&request=001197420&find_code=SYS&local_base=nkc
2002 @ 12 @ 05 @ ElektroniCAD @ http://aleph.nkp.cz/F/?func=find-b&request=001197409&find_code=SYS&local_base=nkc
2002 @ 12 @ 06 @ Fórum A&D @ http://aleph.nkp.cz/F/?func=find-b&request=001197404&find_code=SYS&local_base=nkc
2002 @ 12 @ 07 @ Inzerce Morava @ http://aleph.nkp.cz/F/?func=find-b&request=001197397&find_code=SYS&local_base=nkc
2002 @ 12 @ 08 @ lef02 @ http://aleph.nkp.cz/F/?func=find-b&request=001197108&find_code=SYS&local_base=nkc
2002 @ 12 @ 09 @ Mini Max (Znojmo) @ http://aleph.nkp.cz/F/?func=find-b&request=001197816&find_code=SYS&local_base=nkc
2002 @ 12 @ 10 @ Nanumto @ http://aleph.nkp.cz/F/?func=find-b&request=001195336&find_code=SYS&local_base=nkc
2002 @ 12 @ 11 @ Naš anons @ http://aleph.nkp.cz/F/?func=find-b&request=001196209&find_code=SYS&local_base=nkc
2002 @ 12 @ 12 @ Pardubický benefit @ http://aleph.nkp.cz/F/?func=find-b&request=001197274&find_code=SYS&local_base=nkc
2002 @ 12 @ 13 @ Písecký infoservis @ http://aleph.nkp.cz/F/?func=find-b&request=001197277&find_code=SYS&local_base=nkc
2002 @ 12 @ 14 @ Praděd @ http://aleph.nkp.cz/F/?func=find-b&request=001195327&find_code=SYS&local_base=nkc
2002 @ 12 @ 15 @ Rodičovství @ http://aleph.nkp.cz/F/?func=find-b&request=001196192&find_code=SYS&local_base=nkc
2002 @ 12 @ 16 @ Sem-tam @ http://aleph.nkp.cz/F/?func=find-b&request=001197837&find_code=SYS&local_base=nkc
2002 @ 12 @ 17 @ Studia pneumologica et phthiseologica @ http://aleph.nkp.cz/F/?func=find-b&request=001197852&find_code=SYS&local_base=nkc
2002 @ 12 @ 18 @ Svět cigaret @ http://aleph.nkp.cz/F/?func=find-b&request=001195328&find_code=SYS&local_base=nkc
2002 @ 12 @ 19 @ Teletip @ http://aleph.nkp.cz/F/?func=find-b&request=001196729&find_code=SYS&local_base=nkc
2002 @ 12 @ 20 @ Top rock @ http://aleph.nkp.cz/F/?func=find-b&request=001197375&find_code=SYS&local_base=nkc
2002 @ 12 @ 21 @ Vlaštovka @ http://aleph.nkp.cz/F/?func=find-b&request=001197836&find_code=SYS&local_base=nkc
2002 @ 12 @ 22 @ Vřesovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001195331&find_code=SYS&local_base=nkc
2002 @ 12 @ 23 @ Zpravodaj obce ketkovické @ http://aleph.nkp.cz/F/?func=find-b&request=001197847&find_code=SYS&local_base=nkc
2002 @ 05 @ 01 @ ALCEDO @ http://aleph.nkp.cz/F/?func=find-b&request=001122160&find_code=SYS&local_base=nkc
2002 @ 05 @ 02 @ Arcana @ http://aleph.nkp.cz/F/?func=find-b&request=001120971&find_code=SYS&local_base=nkc
2002 @ 05 @ 03 @ ATOK revue @ http://aleph.nkp.cz/F/?func=find-b&request=001112671&find_code=SYS&local_base=nkc
2002 @ 05 @ 04 @ Barňák @ http://aleph.nkp.cz/F/?func=find-b&request=001120932&find_code=SYS&local_base=nkc
2002 @ 05 @ 05 @ Bonifác @ http://aleph.nkp.cz/F/?func=find-b&request=001121064&find_code=SYS&local_base=nkc
2002 @ 05 @ 06 @ Bořek stavitel @ http://aleph.nkp.cz/F/?func=find-b&request=001119936&find_code=SYS&local_base=nkc
2002 @ 05 @ 07 @ Bouzovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001120928&find_code=SYS&local_base=nkc
2002 @ 05 @ 08 @ Circulation @ http://aleph.nkp.cz/F/?func=find-b&request=001120045&find_code=SYS&local_base=nkc
2002 @ 05 @ 09 @ České Švýcarsko @ http://aleph.nkp.cz/F/?func=find-b&request=001119704&find_code=SYS&local_base=nkc
2002 @ 05 @ 10 @ Dašické ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=001120918&find_code=SYS&local_base=nkc
2002 @ 05 @ 11 @ Dolcevita @ http://aleph.nkp.cz/F/?func=find-b&request=001121009&find_code=SYS&local_base=nkc
2002 @ 05 @ 12 @ Duha @ http://aleph.nkp.cz/F/?func=find-b&request=001121615&find_code=SYS&local_base=nkc
2002 @ 05 @ 13 @ e-pedagogium @ http://aleph.nkp.cz/F/?func=find-b&request=001119657&find_code=SYS&local_base=nkc
2002 @ 05 @ 14 @ Fíkovník @ http://aleph.nkp.cz/F/?func=find-b&request=001119722&find_code=SYS&local_base=nkc
2002 @ 05 @ 15 @ Herbář našich babiček @ http://aleph.nkp.cz/F/?func=find-b&request=001121066&find_code=SYS&local_base=nkc
2002 @ 05 @ 16 @ HIT týdeník Kroměřížska @ http://aleph.nkp.cz/F/?func=find-b&request=001119650&find_code=SYS&local_base=nkc
2002 @ 05 @ 17 @ Horoskokřížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001121150&find_code=SYS&local_base=nkc
2002 @ 05 @ 18 @ Hučák @ http://aleph.nkp.cz/F/?func=find-b&request=001121030&find_code=SYS&local_base=nkc
2002 @ 05 @ 19 @ Humoreska @ http://aleph.nkp.cz/F/?func=find-b&request=001121133&find_code=SYS&local_base=nkc
2002 @ 05 @ 20 @ in magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001120055&find_code=SYS&local_base=nkc
2002 @ 05 @ 21 @ Instinkt @ http://aleph.nkp.cz/F/?func=find-b&request=001120060&find_code=SYS&local_base=nkc
2002 @ 05 @ 22 @ Justiční praxe @ http://aleph.nkp.cz/F/?func=find-b&request=001120734&find_code=SYS&local_base=nkc
2002 @ 05 @ 23 @ Konstrukce @ http://aleph.nkp.cz/F/?func=find-b&request=001092214&find_code=SYS&local_base=nkc
2002 @ 05 @ 24 @ Kostelec nad Orlicí @ http://aleph.nkp.cz/F/?func=find-b&request=001122054&find_code=SYS&local_base=nkc
2002 @ 05 @ 25 @ Křesťanské informační listy @ http://aleph.nkp.cz/F/?func=find-b&request=001112925&find_code=SYS&local_base=nkc
2002 @ 05 @ 26 @ Křížovka Sfinga @ http://aleph.nkp.cz/F/?func=find-b&request=001120832&find_code=SYS&local_base=nkc
2002 @ 05 @ 27 @ Křížovky s horoskopy @ http://aleph.nkp.cz/F/?func=find-b&request=001121089&find_code=SYS&local_base=nkc
2002 @ 05 @ 28 @ Křížovky s recepty @ http://aleph.nkp.cz/F/?func=find-b&request=001121109&find_code=SYS&local_base=nkc
2002 @ 05 @ 29 @ Kuchyňka našich babiček @ http://aleph.nkp.cz/F/?func=find-b&request=001121024&find_code=SYS&local_base=nkc
2002 @ 05 @ 30 @ Lavina @ http://aleph.nkp.cz/F/?func=find-b&request=001120997&find_code=SYS&local_base=nkc
2002 @ 05 @ 31 @ Lazinovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001120999&find_code=SYS&local_base=nkc
2002 @ 05 @ 32 @ Linhartice @ http://aleph.nkp.cz/F/?func=find-b&request=001112926&find_code=SYS&local_base=nkc
2002 @ 05 @ 33 @ Mahagon magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001119713&find_code=SYS&local_base=nkc
2002 @ 05 @ 34 @ Metabolík @ http://aleph.nkp.cz/F/?func=find-b&request=001120035&find_code=SYS&local_base=nkc
2002 @ 05 @ 35 @ Mini Max (Dvůr Králové n.L.) @ http://aleph.nkp.cz/F/?func=find-b&request=001068121&find_code=SYS&local_base=nkc
2002 @ 05 @ 36 @ Mini Max (Kutná Hora) @ http://aleph.nkp.cz/F/?func=find-b&request=001119929&find_code=SYS&local_base=nkc
2002 @ 05 @ 37 @ Mini Max (Pelhřimov) @ http://aleph.nkp.cz/F/?func=find-b&request=001119931&find_code=SYS&local_base=nkc
2002 @ 05 @ 38 @ Mini recepty @ http://aleph.nkp.cz/F/?func=find-b&request=001121083&find_code=SYS&local_base=nkc
2002 @ 05 @ 39 @ Mistr kuchař @ http://aleph.nkp.cz/F/?func=find-b&request=001121021&find_code=SYS&local_base=nkc
2002 @ 05 @ 40 @ Největší zločinci světa @ http://aleph.nkp.cz/F/?func=find-b&request=001121073&find_code=SYS&local_base=nkc
2002 @ 05 @ 41 @ Obzory @ http://aleph.nkp.cz/F/?func=find-b&request=001120016&find_code=SYS&local_base=nkc
2002 @ 05 @ 42 @ Odhadce a oceňování majetku @ http://aleph.nkp.cz/F/?func=find-b&request=001120042&find_code=SYS&local_base=nkc
2002 @ 05 @ 43 @ Olomoucký kraj @ http://aleph.nkp.cz/F/?func=find-b&request=001120903&find_code=SYS&local_base=nkc
2002 @ 05 @ 44 @ Osvěžení @ http://aleph.nkp.cz/F/?func=find-b&request=001120883&find_code=SYS&local_base=nkc
2002 @ 05 @ 45 @ Panelstory @ http://aleph.nkp.cz/F/?func=find-b&request=001112342&find_code=SYS&local_base=nkc
2002 @ 05 @ 46 @ Pevnost @ http://aleph.nkp.cz/F/?func=find-b&request=001122037&find_code=SYS&local_base=nkc
2002 @ 05 @ 47 @ PLASTelegraf @ http://aleph.nkp.cz/F/?func=find-b&request=001120895&find_code=SYS&local_base=nkc
2002 @ 05 @ 48 @ Produktové noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001122078&find_code=SYS&local_base=nkc
2002 @ 05 @ 49 @ Profi nehty @ http://aleph.nkp.cz/F/?func=find-b&request=001120872&find_code=SYS&local_base=nkc
2002 @ 05 @ 50 @ Proměny Vysočiny @ http://aleph.nkp.cz/F/?func=find-b&request=001120843&find_code=SYS&local_base=nkc
2002 @ 05 @ 51 @ Příjemné Hranice @ http://aleph.nkp.cz/F/?func=find-b&request=001122013&find_code=SYS&local_base=nkc
2002 @ 05 @ 52 @ Quo Vadis @ http://aleph.nkp.cz/F/?func=find-b&request=001120028&find_code=SYS&local_base=nkc
2002 @ 05 @ 53 @ Real city @ http://aleph.nkp.cz/F/?func=find-b&request=001120034&find_code=SYS&local_base=nkc
2002 @ 05 @ 54 @ Recepty do kapsy @ http://aleph.nkp.cz/F/?func=find-b&request=001120873&find_code=SYS&local_base=nkc
2002 @ 05 @ 55 @ Scientific American @ http://aleph.nkp.cz/F/?func=find-b&request=001122189&find_code=SYS&local_base=nkc
2002 @ 05 @ 56 @ Scholl style @ http://aleph.nkp.cz/F/?func=find-b&request=001120855&find_code=SYS&local_base=nkc
2002 @ 05 @ 57 @ Sklostroj @ http://aleph.nkp.cz/F/?func=find-b&request=001121148&find_code=SYS&local_base=nkc
2002 @ 05 @ 58 @ Spektrum Rožnovska @ http://aleph.nkp.cz/F/?func=find-b&request=001120815&find_code=SYS&local_base=nkc
2002 @ 05 @ 59 @ Sport plus @ http://aleph.nkp.cz/F/?func=find-b&request=001121955&find_code=SYS&local_base=nkc
2002 @ 05 @ 60 @ Squash @ http://aleph.nkp.cz/F/?func=find-b&request=001112910&find_code=SYS&local_base=nkc
2002 @ 05 @ 61 @ Strojař @ http://aleph.nkp.cz/F/?func=find-b&request=001121975&find_code=SYS&local_base=nkc
2002 @ 05 @ 62 @ Svět motorek @ http://aleph.nkp.cz/F/?func=find-b&request=001112317&find_code=SYS&local_base=nkc
2002 @ 05 @ 63 @ Svět svaru @ http://aleph.nkp.cz/F/?func=find-b&request=001120840&find_code=SYS&local_base=nkc
2002 @ 05 @ 64 @ Svět ženy @ http://aleph.nkp.cz/F/?func=find-b&request=001112773&find_code=SYS&local_base=nkc
2002 @ 05 @ 65 @ Tv Instinkt @ http://aleph.nkp.cz/F/?func=find-b&request=001120180&find_code=SYS&local_base=nkc
2002 @ 05 @ 66 @ Upolín @ http://aleph.nkp.cz/F/?func=find-b&request=001120019&find_code=SYS&local_base=nkc
2002 @ 05 @ 67 @ V @ http://aleph.nkp.cz/F/?func=find-b&request=001119937&find_code=SYS&local_base=nkc
2002 @ 05 @ 68 @ Začínáme se šitím @ http://aleph.nkp.cz/F/?func=find-b&request=001112751&find_code=SYS&local_base=nkc
2002 @ 05 @ 69 @ Země světa @ http://aleph.nkp.cz/F/?func=find-b&request=001120866&find_code=SYS&local_base=nkc
2002 @ 05 @ 70 @ Zločin & trest @ http://aleph.nkp.cz/F/?func=find-b&request=001120771&find_code=SYS&local_base=nkc
2002 @ 05 @ 71 @ Zpravodaj (KEZ) @ http://aleph.nkp.cz/F/?func=find-b&request=001120014&find_code=SYS&local_base=nkc
2002 @ 05 @ 72 @ Zpravodaj (regionální stavební) @ http://aleph.nkp.cz/F/?func=find-b&request=001093858&find_code=SYS&local_base=nkc
2002 @ 05 @ 73 @ Zpravodaj FOD @ http://aleph.nkp.cz/F/?func=find-b&request=001119962&find_code=SYS&local_base=nkc
2002 @ 05 @ 74 @ Zpravodaj obce Jiříkovice @ http://aleph.nkp.cz/F/?func=find-b&request=001112316&find_code=SYS&local_base=nkc
2002 @ 05 @ 75 @ Zvěrokruh @ http://aleph.nkp.cz/F/?func=find-b&request=001120914&find_code=SYS&local_base=nkc
2002 @ 05 @ 76 @ Život farnosti @ http://aleph.nkp.cz/F/?func=find-b&request=001120032&find_code=SYS&local_base=nkc
1998 @ 01 @ 29 @ Personální a sociálně právní kartotéka @ http://aleph.nkp.cz/F/?func=find-b&request=000303099&find_code=SYS&local_base=nkc
1998 @ 01 @ 22 @ Neratovické turistické perličky @ http://aleph.nkp.cz/F/?func=find-b&request=000303126&find_code=SYS&local_base=nkc
1998 @ 01 @ 21 @ MM Průmyslové spektrum @ http://aleph.nkp.cz/F/?func=find-b&request=000645323&find_code=SYS&local_base=nkc
1998 @ 01 @ 20 @ Měřínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000303120&find_code=SYS&local_base=nkc
1998 @ 01 @ 19 @ Mašovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000303106&find_code=SYS&local_base=nkc
1998 @ 01 @ 18 @ Lučanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000303108&find_code=SYS&local_base=nkc
1998 @ 01 @ 17 @ Lipovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000303129&find_code=SYS&local_base=nkc
1998 @ 01 @ 16 @ Křižanovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000303122&find_code=SYS&local_base=nkc
1998 @ 01 @ 15 @ Kodap váš přítel @ http://aleph.nkp.cz/F/?func=find-b&request=000303112&find_code=SYS&local_base=nkc
1998 @ 01 @ 14 @ Jimramovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000302967&find_code=SYS&local_base=nkc
1998 @ 01 @ 13 @ Janovské echo. Informační a kulturní občasník Janova nad Nisou @ http://aleph.nkp.cz/F/?func=find-b&request=000302101&find_code=SYS&local_base=nkc
1998 @ 01 @ 12 @ Informační zpravodaj pro obce Bohdalov@ Chroustov', 'http://aleph.nkp.cz/F/?func=find-b&request=000303116&find_code=SYS&local_base=nkc
1998 @ 01 @ 11 @ Informační servis Divadelního ústavu @ http://aleph.nkp.cz/F/?func=find-b&request=000303118&find_code=SYS&local_base=nkc
1998 @ 01 @ 10 @ Chcete nás ? Měsíčník pro přátele všech zvířat @ http://aleph.nkp.cz/F/?func=find-b&request=000303133&find_code=SYS&local_base=nkc
1998 @ 01 @ 09 @ Hypertenze. Bulletin České společnosti pro hypertenzi @ http://aleph.nkp.cz/F/?func=find-b&request=000303134&find_code=SYS&local_base=nkc
1998 @ 01 @ 08 @ Hláska. Zpravodaj magistrátu města Ostravy @ http://aleph.nkp.cz/F/?func=find-b&request=000303109&find_code=SYS&local_base=nkc
1998 @ 01 @ 07 @ Domácí rádce v křížovkách @ http://aleph.nkp.cz/F/?func=find-b&request=000303124&find_code=SYS&local_base=nkc
1998 @ 01 @ 06 @ Dobrá voda. Nová vodní revue @ http://aleph.nkp.cz/F/?func=find-b&request=000302121&find_code=SYS&local_base=nkc
1998 @ 01 @ 05 @ Delfín. Časopis pro mladé @ http://aleph.nkp.cz/F/?func=find-b&request=000303102&find_code=SYS&local_base=nkc
1998 @ 01 @ 04 @ Daňový zpravodaj DaZ. Odborný týdeník pro daně@ právo a finance', 'http://aleph.nkp.cz/F/?func=find-b&request=000303127&find_code=SYS&local_base=nkc
1998 @ 01 @ 03 @ Českobratské horácko @ http://aleph.nkp.cz/F/?func=find-b&request=000303117&find_code=SYS&local_base=nkc
1998 @ 01 @ 02 @ Borský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000303121&find_code=SYS&local_base=nkc
1998 @ 01 @ 01 @ BC kontakt @ http://aleph.nkp.cz/F/?func=find-b&request=000303123&find_code=SYS&local_base=nkc
1998 @ 09 @ 08 @ Fakta X. Odhalení@ paranormální jevy, záhady, UFO', 'http://aleph.nkp.cz/F/?func=find-b&request=00390102&find_code=SYS&local_base=nkc
1998 @ 09 @ 07 @ Euro. Ekonomický týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=00528586&find_code=SYS&local_base=nkc
1998 @ 09 @ 06 @ Doteky štěstí. Příběhy českých dívek a žen@ které potkaly toho pravého', 'http://aleph.nkp.cz/F/?func=find-b&request=00528126&find_code=SYS&local_base=nkc
1998 @ 09 @ 05 @ Dentální trh. Měsíčník pro stomatology a dentální laboratoře @ http://aleph.nkp.cz/F/?func=find-b&request=00528571&find_code=SYS&local_base=nkc
1998 @ 09 @ 04 @ AUTO exclusive @ http://aleph.nkp.cz/F/?func=find-b&request=00528847&find_code=SYS&local_base=nkc
1998 @ 09 @ 03 @ AudioVideo Tip @ http://aleph.nkp.cz/F/?func=find-b&request=00386273&find_code=SYS&local_base=nkc
1998 @ 09 @ 02 @ Anna. Měsíčník pro přátele ručních prací @ http://aleph.nkp.cz/F/?func=find-b&request=00486021&find_code=SYS&local_base=nkc
1998 @ 09 @ 01 @ Almanach začínajících autorů @ http://aleph.nkp.cz/F/?func=find-b&request=00386268&find_code=SYS&local_base=nkc
1998 @ 08 @ 12 @ Z rozhodnutí a stanovisek Ústavního soudu ČR (Výběr) @ http://aleph.nkp.cz/F/?func=find-b&request=00386048&find_code=SYS&local_base=nkc
1998 @ 08 @ 11 @ Přehled rozsudků Evropského soudu pro lidská práva @ http://aleph.nkp.cz/F/?func=find-b&request=00385840&find_code=SYS&local_base=nkc
1998 @ 08 @ 09 @ Levná luštírna. @ http://aleph.nkp.cz/F/?func=find-b&request=00385855&find_code=SYS&local_base=nkc
1998 @ 08 @ 10 @ Prima recepty v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=00386036&find_code=SYS&local_base=nkc
1998 @ 08 @ 08 @ Kolumbus. Měsíčník o cestování @ http://aleph.nkp.cz/F/?func=find-b&request=00386059&find_code=SYS&local_base=nkc
1998 @ 08 @ 06 @ Spot. Měsíčník o reklamě a médiích @ http://aleph.nkp.cz/F/?func=find-b&request=00386062&find_code=SYS&local_base=nkc
1998 @ 08 @ 07 @ Kancelář @ http://aleph.nkp.cz/F/?func=find-b&request=00385873&find_code=SYS&local_base=nkc
1998 @ 08 @ 05 @ Dítě. Měsíčník o malých i velkých dětech @ http://aleph.nkp.cz/F/?func=find-b&request=00385860&find_code=SYS&local_base=nkc
1998 @ 08 @ 04 @ Delvita novinky. Měsíčník pro zákazníky našich supermarketů @ http://aleph.nkp.cz/F/?func=find-b&request=00386041&find_code=SYS&local_base=nkc
1998 @ 08 @ 02 @ Babočka. Luštěnky pro všechny děti @ http://aleph.nkp.cz/F/?func=find-b&request=003886087&find_code=SYS&local_base=nkc
1998 @ 08 @ 03 @ Bělečský kurýr. Zpravodaj obecního úřadu Běleč @ http://aleph.nkp.cz/F/?func=find-b&request=00386028&find_code=SYS&local_base=nkc
1998 @ 08 @ 01 @ Auto moto box. Časopis motoristů@ motosportu, cestování a pohostinství', 'http://aleph.nkp.cz/F/?func=find-b&request=00385883&find_code=SYS&local_base=nkc
1999 @ 02 @ 05 @ Heavy World. Rockové noviny do každé rodiny!? @ http://aleph.nkp.cz/F/?func=find-b&request=000646160&find_code=SYS&local_base=nkc
1999 @ 02 @ 06 @ Minerva. Časopis zaměstnanců akciové společnosti Minerva Boskovice @ http://aleph.nkp.cz/F/?func=find-b&request=000642812&find_code=SYS&local_base=nkc
1999 @ 02 @ 07 @ Oficiální český PlayStation magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000646395&find_code=SYS&local_base=nkc
1999 @ 02 @ 08 @ Zpravodaj Mariánských hor a Hulvák @ http://aleph.nkp.cz/F/?func=find-b&request=000643175&find_code=SYS&local_base=nkc
1999 @ 02 @ 09 @ Zpravodaj ústavů sociální péče ČR @ http://aleph.nkp.cz/F/?func=find-b&request=000645595&find_code=SYS&local_base=nkc
1999 @ 03 @ 20 @ Mladá fronta Dnes. Českomoravská vrchovina @ http://aleph.nkp.cz/F/?func=find-b&request=000649369&find_code=SYS&local_base=nkc
1999 @ 03 @ 21 @ Niva (dobrovolný svazek obcí). @ http://aleph.nkp.cz/F/?func=find-b&request=000649138&find_code=SYS&local_base=nkc
1999 @ 03 @ 22 @ Oddechové křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=000648363&find_code=SYS&local_base=nkc
1999 @ 03 @ 23 @ Olomoucký den. Noviny pro okres Olomouc @ http://aleph.nkp.cz/F/?func=find-b&request=000658168&find_code=SYS&local_base=nkc
1999 @ 03 @ 24 @ Pelhřimovské noviny. Zpravodaj Městského úřadu a kulturního střediska... @ http://aleph.nkp.cz/F/?func=find-b&request=000648652&find_code=SYS&local_base=nkc
1999 @ 03 @ 25 @ Podlahy od A do Z @ http://aleph.nkp.cz/F/?func=find-b&request=000648585&find_code=SYS&local_base=nkc
1999 @ 03 @ 26 @ Polygrafie @ http://aleph.nkp.cz/F/?func=find-b&request=000648848&find_code=SYS&local_base=nkc
1999 @ 03 @ 27 @ Pro Hockey. Magazín o NHL @ http://aleph.nkp.cz/F/?func=find-b&request=000648542&find_code=SYS&local_base=nkc
1999 @ 03 @ 28 @ Rádce pro rodinné finance @ http://aleph.nkp.cz/F/?func=find-b&request=000649882&find_code=SYS&local_base=nkc
1999 @ 03 @ 29 @ Romano hangos. Romský hlas @ http://aleph.nkp.cz/F/?func=find-b&request=000648830&find_code=SYS&local_base=nkc
1999 @ 03 @ 30 @ Svět tisku. Měsíčník o předtiskové přípravě @ http://aleph.nkp.cz/F/?func=find-b&request=000648589&find_code=SYS&local_base=nkc
1999 @ 03 @ 31 @ Sychrov. Čtvrtletník obecního úřadu Sychrov @ http://aleph.nkp.cz/F/?func=find-b&request=000648816&find_code=SYS&local_base=nkc
1999 @ 03 @ 32 @ System @ http://aleph.nkp.cz/F/?func=find-b&request=000648673&find_code=SYS&local_base=nkc
1999 @ 03 @ 33 @ Šotek. Muzejní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000649150&find_code=SYS&local_base=nkc
1999 @ 03 @ 34 @ Táborský Gejzír. Čtvrtletník táborska @ http://aleph.nkp.cz/F/?func=find-b&request=000648282&find_code=SYS&local_base=nkc
1999 @ 03 @ 35 @ Tepelná ochrana budov.Odborný časopis pro úspory... @ http://aleph.nkp.cz/F/?func=find-b&request=000648840&find_code=SYS&local_base=nkc
1999 @ 03 @ 36 @ Účetnictví v zemědělství @ http://aleph.nkp.cz/F/?func=find-b&request=000648821&find_code=SYS&local_base=nkc
1999 @ 03 @ 37 @ Veřejná správa on-line. Příloha časopisu Obec a finance @ http://aleph.nkp.cz/F/?func=find-b&request=000648049&find_code=SYS&local_base=nkc
1999 @ 03 @ 38 @ Výběr. Časopis managementu obchodu @ http://aleph.nkp.cz/F/?func=find-b&request=000649073&find_code=SYS&local_base=nkc
1999 @ 03 @ 39 @ Výherní křížovky s příběhy @ http://aleph.nkp.cz/F/?func=find-b&request=000648445&find_code=SYS&local_base=nkc
1999 @ 03 @ 40 @ Zpravodaj (Teplárenské sdružení) @ http://aleph.nkp.cz/F/?func=find-b&request=000649450&find_code=SYS&local_base=nkc
1999 @ 04 @ 05 @ Novodobé fortifikace @ http://aleph.nkp.cz/F/?func=find-b&request=000648018&find_code=SYS&local_base=nkc
1999 @ 04 @ 06 @ Ostravský Měšťák. Bezplatný reklamní časopis @ http://aleph.nkp.cz/F/?func=find-b&request=0006521987&find_code=SYS&local_base=nkc
1999 @ 04 @ 07 @ Sezemické noviny. Dvojměsíčník pro občany Sezemic... @ http://aleph.nkp.cz/F/?func=find-b&request=000652053&find_code=SYS&local_base=nkc
1999 @ 04 @ 08 @ Talent. Měsíčník pro učitele a příznivce základních uměleckých škol @ http://aleph.nkp.cz/F/?func=find-b&request=000652244&find_code=SYS&local_base=nkc
1999 @ 05 @ 20 @ KIZOB. Kulturní a informační zpravodaj občanů Brandýska @ http://aleph.nkp.cz/F/?func=find-b&request=000655320&find_code=SYS&local_base=nkc
1999 @ 05 @ 21 @ Kladenský expres. Týdeník pro Kladno a Slaný @ http://aleph.nkp.cz/F/?func=find-b&request=000654125&find_code=SYS&local_base=nkc
1999 @ 05 @ 22 @ Klinická farmakologie a farmacie @ http://aleph.nkp.cz/F/?func=find-b&request=000655416&find_code=SYS&local_base=nkc
1999 @ 05 @ 23 @ Krimi povídky@ soudničky, příběhy', 'http://aleph.nkp.cz/F/?func=find-b&request=000658125&find_code=SYS&local_base=nkc
1999 @ 05 @ 24 @ Křížovky Reader´s Digest výběru @ http://aleph.nkp.cz/F/?func=find-b&request=000658531&find_code=SYS&local_base=nkc
1999 @ 05 @ 25 @ Kuchyně pro labužníky @ http://aleph.nkp.cz/F/?func=find-b&request=000655440&find_code=SYS&local_base=nkc
1999 @ 05 @ 26 @ Magic. Společnost nejen pro dámy... @ http://aleph.nkp.cz/F/?func=find-b&request=000657180&find_code=SYS&local_base=nkc
1999 @ 05 @ 27 @ Mladovožicko @ http://aleph.nkp.cz/F/?func=find-b&request=000654539&find_code=SYS&local_base=nkc
1999 @ 05 @ 28 @ Motor classic. Magazín o automobilech i motocyklech minulých let @ http://aleph.nkp.cz/F/?func=find-b&request=000655465&find_code=SYS&local_base=nkc
1999 @ 05 @ 29 @ Náš útulný byt @ http://aleph.nkp.cz/F/?func=find-b&request=000654659&find_code=SYS&local_base=nkc
1999 @ 05 @ 30 @ Nový zeměměřič plus @ http://aleph.nkp.cz/F/?func=find-b&request=000658437&find_code=SYS&local_base=nkc
1999 @ 05 @ 31 @ Ostrovský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000655443&find_code=SYS&local_base=nkc
1999 @ 05 @ 32 @ Rolling Stone @ http://aleph.nkp.cz/F/?func=find-b&request=000658525&find_code=SYS&local_base=nkc
1999 @ 05 @ 33 @ Speed @ http://aleph.nkp.cz/F/?func=find-b&request=000656276&find_code=SYS&local_base=nkc
1999 @ 05 @ 34 @ Sranda. Pohodově laděný časopis @ http://aleph.nkp.cz/F/?func=find-b&request=000654350&find_code=SYS&local_base=nkc
1999 @ 05 @ 35 @ Svět na dlani. Časopis o cestování po Čechách@ Moravě, Slezku a zbytku světa', 'http://aleph.nkp.cz/F/?func=find-b&request=000658482&find_code=SYS&local_base=nkc
1999 @ 05 @ 36 @ Šumický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000657187&find_code=SYS&local_base=nkc
1999 @ 05 @ 37 @ Tisíc řešení. Daně z příjmů-DPH-účetnictví-mzdy-odvody-... @ http://aleph.nkp.cz/F/?func=find-b&request=000657162&find_code=SYS&local_base=nkc
1999 @ 05 @ 38 @ Zahradní magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000658502&find_code=SYS&local_base=nkc
1999 @ 05 @ 39 @ Zručský a senecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000657173&find_code=SYS&local_base=nkc
1999 @ 05 @ 40 @ Zubní technik. Časopis Federace zubních techniků ČR @ http://aleph.nkp.cz/F/?func=find-b&request=000658486&find_code=SYS&local_base=nkc
1999 @ 06 @ 08 @ Kynšperský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000692102&find_code=SYS&local_base=nkc
1999 @ 06 @ 09 @ Landes-Zeitung. Zeitung der Deutschen in Böhmen@ Mähren und Schlesien', 'http://aleph.nkp.cz/F/?func=find-b&request=000693146&find_code=SYS&local_base=nkc
1999 @ 06 @ 10 @ Regionální automax. Noviny s maximální inzercí @ http://aleph.nkp.cz/F/?func=find-b&request=000662776&find_code=SYS&local_base=nkc
1999 @ 06 @ 11 @ Regionální noviny. Nezávislý týdeník blanenského okresu @ http://aleph.nkp.cz/F/?func=find-b&request=000662694&find_code=SYS&local_base=nkc
1999 @ 06 @ 12 @ Top auto & motor sport @ http://aleph.nkp.cz/F/?func=find-b&request=000692467&find_code=SYS&local_base=nkc
1999 @ 06 @ 13 @ Týden v Českém ráji. Nezávislé noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000692384&find_code=SYS&local_base=nkc
1999 @ 06 @ 14 @ Večerka @ http://aleph.nkp.cz/F/?func=find-b&request=000660717&find_code=SYS&local_base=nkc
1999 @ 07 @ 01 @ Co@ kdy v Praze', 'http://aleph.nkp.cz/F/?func=find-b&request=000693462&find_code=SYS&local_base=nkc
1999 @ 07 @ 02 @ Domažlické listy. Časopis informací a zajímavostí @ http://aleph.nkp.cz/F/?func=find-b&request=000693774&find_code=SYS&local_base=nkc
1999 @ 07 @ 03 @ Fabrika club express @ http://aleph.nkp.cz/F/?func=find-b&request=000693737&find_code=SYS&local_base=nkc
1999 @ 07 @ 04 @ Fénix @ http://aleph.nkp.cz/F/?func=find-b&request=000693771&find_code=SYS&local_base=nkc
1999 @ 07 @ 05 @ Kamelot. Týdeník okresu Frýdek-Místek @ http://aleph.nkp.cz/F/?func=find-b&request=000699337&find_code=SYS&local_base=nkc
1999 @ 07 @ 06 @ Kapitoly z kardiologie pro lékaře v praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000693631&find_code=SYS&local_base=nkc
1999 @ 07 @ 07 @ Křížovky perličky ze školy @ http://aleph.nkp.cz/F/?func=find-b&request=000693456&find_code=SYS&local_base=nkc
1999 @ 07 @ 08 @ Křížovky plné fórů @ http://aleph.nkp.cz/F/?func=find-b&request=000693628&find_code=SYS&local_base=nkc
1999 @ 07 @ 09 @ Lidská práva. Časopis Českého helsinského výboru @ http://aleph.nkp.cz/F/?func=find-b&request=000692481&find_code=SYS&local_base=nkc
1999 @ 07 @ 10 @ Móda pro drobné ženy (edice Burda-speciál) @ http://aleph.nkp.cz/F/?func=find-b&request=000699258&find_code=SYS&local_base=nkc
1999 @ 07 @ 11 @ Mzdy a personalistika v praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000693599&find_code=SYS&local_base=nkc
1999 @ 07 @ 12 @ Nejdecké radniční listy @ http://aleph.nkp.cz/F/?func=find-b&request=000693577&find_code=SYS&local_base=nkc
1999 @ 07 @ 13 @ Obec Útvina. Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000693928&find_code=SYS&local_base=nkc
1999 @ 07 @ 14 @ Osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=000693466&find_code=SYS&local_base=nkc
1999 @ 07 @ 15 @ Pasekovy listy. Občasník pro literaturu@ kulturu, umění a humor', 'http://aleph.nkp.cz/F/?func=find-b&request=000699935&find_code=SYS&local_base=nkc
1999 @ 07 @ 16 @ Pod hanáckým žudrem. Občasník pro Příkazy a Hynkov @ http://aleph.nkp.cz/F/?func=find-b&request=000703969&find_code=SYS&local_base=nkc
1999 @ 07 @ 17 @ Postgraduální medicína. Odborný časopis pro lékaře @ http://aleph.nkp.cz/F/?func=find-b&request=000699243&find_code=SYS&local_base=nkc
1999 @ 07 @ 18 @ Príma lex. Časopis na Právnické fakultě Univerzity Karlovy @ http://aleph.nkp.cz/F/?func=find-b&request=000703971&find_code=SYS&local_base=nkc
1999 @ 07 @ 19 @ Pro vás @ http://aleph.nkp.cz/F/?func=find-b&request=000699204&find_code=SYS&local_base=nkc
1999 @ 07 @ 20 @ Professional marketing & management @ http://aleph.nkp.cz/F/?func=find-b&request=000693468&find_code=SYS&local_base=nkc
1999 @ 07 @ 21 @ Region plus. Nezávislý regionální týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=000699202&find_code=SYS&local_base=nkc
1999 @ 07 @ 22 @ Reví mítink @ http://aleph.nkp.cz/F/?func=find-b&request=000693445&find_code=SYS&local_base=nkc
1999 @ 07 @ 23 @ Sklenský zpravodaj. Dvouměsíčník kulturní komise ve Sklené @ http://aleph.nkp.cz/F/?func=find-b&request=000693935&find_code=SYS&local_base=nkc
1999 @ 07 @ 24 @ Skutečnosti @ http://aleph.nkp.cz/F/?func=find-b&request=000699239&find_code=SYS&local_base=nkc
1999 @ 07 @ 25 @ Sokolovský patriot. Měsíčník sokolovské radnice @ http://aleph.nkp.cz/F/?func=find-b&request=000693932&find_code=SYS&local_base=nkc
1999 @ 07 @ 26 @ Světové křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=000699383&find_code=SYS&local_base=nkc
1999 @ 07 @ 27 @ Škoda truck. Podnikové noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000699203&find_code=SYS&local_base=nkc
1999 @ 07 @ 28 @ Ta naše hospůdka. Českomoravský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000699205&find_code=SYS&local_base=nkc
1999 @ 07 @ 29 @ Tajemno @ http://aleph.nkp.cz/F/?func=find-b&request=000703932&find_code=SYS&local_base=nkc
1999 @ 07 @ 30 @ Tempus medicorum. Časopis České lékařské komory @ http://aleph.nkp.cz/F/?func=find-b&request=000699409&find_code=SYS&local_base=nkc
1999 @ 07 @ 31 @ Tepelský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000703973&find_code=SYS&local_base=nkc
1999 @ 07 @ 32 @ U nás. Libuš a Písnice. Zpravodaj městské části @ http://aleph.nkp.cz/F/?func=find-b&request=000693568&find_code=SYS&local_base=nkc
1999 @ 07 @ 33 @ Vémyslické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000699208&find_code=SYS&local_base=nkc
1999 @ 07 @ 34 @ Věstník Národního bezpečnostního úřadu @ http://aleph.nkp.cz/F/?func=find-b&request=000693474&find_code=SYS&local_base=nkc
1999 @ 07 @ 35 @ Via revue. Průvodce cestovatele @ http://aleph.nkp.cz/F/?func=find-b&request=000703956&find_code=SYS&local_base=nkc
1999 @ 07 @ 36 @ Výběžek. Lužický týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=000704021&find_code=SYS&local_base=nkc
1999 @ 07 @ 37 @ Wellness. Žít zdravě a naplno @ http://aleph.nkp.cz/F/?func=find-b&request=000699324&find_code=SYS&local_base=nkc
1999 @ 07 @ 38 @ Zápský krajánek @ http://aleph.nkp.cz/F/?func=find-b&request=00069952&find_code=SYS&local_base=nkc
1999 @ 07 @ 39 @ Zbraně a náboje. Časopis muže@ který zná svůj cíl', 'http://aleph.nkp.cz/F/?func=find-b&request=000699926&find_code=SYS&local_base=nkc
1999 @ 07 @ 40 @ Zpravodaj města Strakonice @ http://aleph.nkp.cz/F/?func=find-b&request=000699256&find_code=SYS&local_base=nkc
1999 @ 07 @ 41 @ Zpravodaj obce Lednice @ http://aleph.nkp.cz/F/?func=find-b&request=000699971&find_code=SYS&local_base=nkc
1999 @ 07 @ 42 @ Zpravodaj od pramene. Měsíčník obce Konstantinovy Lázně a ... @ http://aleph.nkp.cz/F/?func=find-b&request=000704001&find_code=SYS&local_base=nkc
1999 @ 07 @ 43 @ Život v A & D. Časopis zaměstnanců divize Automatizace a pohony @ http://aleph.nkp.cz/F/?func=find-b&request=000699944&find_code=SYS&local_base=nkc
1999 @ 08 @ 01 @ Co@ kdy v Praze', 'http://aleph.nkp.cz/F/?func=find-b&request=000693462&find_code=SYS&local_base=nkc
1999 @ 08 @ 02 @ Domažlické listy. Časopis informací a zajímavostí @ http://aleph.nkp.cz/F/?func=find-b&request=000693774&find_code=SYS&local_base=nkc
1999 @ 08 @ 03 @ Fabrika club express @ http://aleph.nkp.cz/F/?func=find-b&request=000693737&find_code=SYS&local_base=nkc
1999 @ 08 @ 04 @ Fénix @ http://aleph.nkp.cz/F/?func=find-b&request=000693771&find_code=SYS&local_base=nkc
1999 @ 08 @ 05 @ Kamelot. Týdeník okresu Frýdek-Místek @ http://aleph.nkp.cz/F/?func=find-b&request=000699337&find_code=SYS&local_base=nkc
1999 @ 08 @ 06 @ Kapitoly z kardiologie pro lékaře v praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000693631&find_code=SYS&local_base=nkc
1999 @ 08 @ 07 @ Křížovky perličky ze školy @ http://aleph.nkp.cz/F/?func=find-b&request=000693456&find_code=SYS&local_base=nkc
1999 @ 08 @ 08 @ Křížovky plné fórů @ http://aleph.nkp.cz/F/?func=find-b&request=000693628&find_code=SYS&local_base=nkc
1999 @ 08 @ 09 @ Lidská práva. Časopis Českého helsinského výboru @ http://aleph.nkp.cz/F/?func=find-b&request=000692481&find_code=SYS&local_base=nkc
1999 @ 08 @ 10 @ Móda pro drobné ženy (edice Burda-speciál) @ http://aleph.nkp.cz/F/?func=find-b&request=000699258&find_code=SYS&local_base=nkc
1999 @ 08 @ 11 @ Mzdy a personalistika v praxi @ http://aleph.nkp.cz/F/?func=find-b&request=000693599&find_code=SYS&local_base=nkc
1999 @ 08 @ 12 @ Nejdecké radniční listy @ http://aleph.nkp.cz/F/?func=find-b&request=000693577&find_code=SYS&local_base=nkc
1999 @ 08 @ 13 @ Obec Útvina. Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000693928&find_code=SYS&local_base=nkc
1999 @ 08 @ 14 @ Osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=000693466&find_code=SYS&local_base=nkc
1999 @ 08 @ 15 @ Pasekovy listy. Občasník pro literaturu@ kulturu, umění a humor', 'http://aleph.nkp.cz/F/?func=find-b&request=000699935&find_code=SYS&local_base=nkc
1999 @ 08 @ 16 @ Pod hanáckým žudrem. Občasník pro Příkazy a Hynkov @ http://aleph.nkp.cz/F/?func=find-b&request=000703969&find_code=SYS&local_base=nkc
1999 @ 08 @ 17 @ Postgraduální medicína. Odborný časopis pro lékaře @ http://aleph.nkp.cz/F/?func=find-b&request=000699243&find_code=SYS&local_base=nkc
1999 @ 08 @ 18 @ Príma lex. Časopis na Právnické fakultě Univerzity Karlovy @ http://aleph.nkp.cz/F/?func=find-b&request=000703971&find_code=SYS&local_base=nkc
1999 @ 08 @ 19 @ Pro vás @ http://aleph.nkp.cz/F/?func=find-b&request=000699204&find_code=SYS&local_base=nkc
1999 @ 08 @ 20 @ Professional marketing & management @ http://aleph.nkp.cz/F/?func=find-b&request=000693468&find_code=SYS&local_base=nkc
1999 @ 08 @ 21 @ Region plus. Nezávislý regionální týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=000699202&find_code=SYS&local_base=nkc
1999 @ 08 @ 22 @ Reví mítink @ http://aleph.nkp.cz/F/?func=find-b&request=000693445&find_code=SYS&local_base=nkc
1999 @ 08 @ 23 @ Sklenský zpravodaj. Dvouměsíčník kulturní komise ve Sklené @ http://aleph.nkp.cz/F/?func=find-b&request=000693935&find_code=SYS&local_base=nkc
1999 @ 08 @ 24 @ Skutečnosti @ http://aleph.nkp.cz/F/?func=find-b&request=000699239&find_code=SYS&local_base=nkc
1999 @ 08 @ 25 @ Sokolovský patriot. Měsíčník sokolovské radnice @ http://aleph.nkp.cz/F/?func=find-b&request=000693932&find_code=SYS&local_base=nkc
1999 @ 08 @ 26 @ Světové křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=000699383&find_code=SYS&local_base=nkc
1999 @ 08 @ 27 @ Škoda truck. Podnikové noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000699203&find_code=SYS&local_base=nkc
1999 @ 08 @ 28 @ Ta naše hospůdka. Českomoravský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000699205&find_code=SYS&local_base=nkc
1999 @ 08 @ 29 @ Tajemno @ http://aleph.nkp.cz/F/?func=find-b&request=000703932&find_code=SYS&local_base=nkc
1999 @ 08 @ 30 @ Tempus medicorum. Časopis České lékařské komory @ http://aleph.nkp.cz/F/?func=find-b&request=000699409&find_code=SYS&local_base=nkc
1999 @ 08 @ 31 @ Tepelský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000703973&find_code=SYS&local_base=nkc
1999 @ 08 @ 32 @ U nás. Libuš a Písnice. Zpravodaj městské části @ http://aleph.nkp.cz/F/?func=find-b&request=000693568&find_code=SYS&local_base=nkc
1999 @ 08 @ 33 @ Vémyslické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000699208&find_code=SYS&local_base=nkc
1999 @ 08 @ 34 @ Věstník Národního bezpečnostního úřadu @ http://aleph.nkp.cz/F/?func=find-b&request=000693474&find_code=SYS&local_base=nkc
1999 @ 08 @ 35 @ Via revue. Průvodce cestovatele @ http://aleph.nkp.cz/F/?func=find-b&request=000703956&find_code=SYS&local_base=nkc
1999 @ 08 @ 36 @ Výběžek. Lužický týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=000704021&find_code=SYS&local_base=nkc
1999 @ 08 @ 37 @ Wellness. Žít zdravě a naplno @ http://aleph.nkp.cz/F/?func=find-b&request=000699324&find_code=SYS&local_base=nkc
1999 @ 08 @ 38 @ Zápský krajánek @ http://aleph.nkp.cz/F/?func=find-b&request=00069952&find_code=SYS&local_base=nkc
1999 @ 08 @ 39 @ Zbraně a náboje. Časopis muže@ který zná svůj cíl', 'http://aleph.nkp.cz/F/?func=find-b&request=000699926&find_code=SYS&local_base=nkc
1999 @ 08 @ 40 @ Zpravodaj města Strakonice @ http://aleph.nkp.cz/F/?func=find-b&request=000699256&find_code=SYS&local_base=nkc
1999 @ 08 @ 41 @ Zpravodaj obce Lednice @ http://aleph.nkp.cz/F/?func=find-b&request=000699971&find_code=SYS&local_base=nkc
1999 @ 08 @ 42 @ Zpravodaj od pramene. Měsíčník obce Konstantinovy Lázně a ... @ http://aleph.nkp.cz/F/?func=find-b&request=000704001&find_code=SYS&local_base=nkc
1999 @ 08 @ 43 @ Život v A & D. Časopis zaměstnanců divize Automatizace a pohony @ http://aleph.nkp.cz/F/?func=find-b&request=000699944&find_code=SYS&local_base=nkc
1998 @ 01 @ 30 @ Podnikatel @ http://aleph.nkp.cz/F/?func=find-b&request=000361112&find_code=SYS&local_base=nkc
1998 @ 01 @ 31 @ Průvodce. Kulturní a informační zpravodaj města Zábřeh @ http://aleph.nkp.cz/F/?func=find-b&request=000301782&find_code=SYS&local_base=nkc
1998 @ 01 @ 32 @ Psí víno. Časopis pro současnou poezii @ http://aleph.nkp.cz/F/?func=find-b&request=000301510&find_code=SYS&local_base=nkc
1998 @ 01 @ 33 @ Roverský kmen @ http://aleph.nkp.cz/F/?func=find-b&request=000303104&find_code=SYS&local_base=nkc
1998 @ 01 @ 34 @ Řemesla a interiér @ http://aleph.nkp.cz/F/?func=find-b&request=000303105&find_code=SYS&local_base=nkc
1998 @ 01 @ 35 @ Seniorské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000303125&find_code=SYS&local_base=nkc
1998 @ 01 @ 36 @ Sex emoce @ http://aleph.nkp.cz/F/?func=find-b&request=000302964&find_code=SYS&local_base=nkc
1998 @ 01 @ 37 @ Sisyfos. Časopis proti blbosti @ http://aleph.nkp.cz/F/?func=find-b&request=000303119&find_code=SYS&local_base=nkc
1998 @ 01 @ 38 @ Strip @ http://aleph.nkp.cz/F/?func=find-b&request=000303111&find_code=SYS&local_base=nkc
1998 @ 01 @ 39 @ Svobodné noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000303130&find_code=SYS&local_base=nkc
1998 @ 01 @ 40 @ Tributum. Časopis daňových profesionálů @ http://aleph.nkp.cz/F/?func=find-b&request=000303110&find_code=SYS&local_base=nkc
1998 @ 01 @ 41 @ Třebíčské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000303131&find_code=SYS&local_base=nkc
1998 @ 01 @ 42 @ Účetní a daně. Odborný měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000301419&find_code=SYS&local_base=nkc
1998 @ 01 @ 43 @ Uniform mail. Inzertní čtvrtletník pro Prahu a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=000301519&find_code=SYS&local_base=nkc
1998 @ 01 @ 44 @ Viselec. Převážně studentský časopis o sdílení @ http://aleph.nkp.cz/F/?func=find-b&request=000303100&find_code=SYS&local_base=nkc
1998 @ 01 @ 45 @ Zdravá rodina @ http://aleph.nkp.cz/F/?func=find-b&request=000302971&find_code=SYS&local_base=nkc
1998 @ 01 @ 46 @ Zpravodaj Benzina @ http://aleph.nkp.cz/F/?func=find-b&request=000302934&find_code=SYS&local_base=nkc
1998 @ 01 @ 47 @ Zpravodaj liberecké radnice @ http://aleph.nkp.cz/F/?func=find-b&request=000303128&find_code=SYS&local_base=nkc
1998 @ 01 @ 48 @ Zpravodaj obce Bzová @ http://aleph.nkp.cz/F/?func=find-b&request=000308366&find_code=SYS&local_base=nkc
1998 @ 01 @ 49 @ Zpravodaj Střediska pro poradenství a sociální rehabilitaci... @ http://aleph.nkp.cz/F/?func=find-b&request=000302944&find_code=SYS&local_base=nkc
1998 @ 02 @ 01 @ BC kontakt @ http://aleph.nkp.cz/F/?func=find-b&request=000303123&find_code=SYS&local_base=nkc
1998 @ 02 @ 02 @ Borský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000303121&find_code=SYS&local_base=nkc
1998 @ 02 @ 03 @ Českobratské horácko @ http://aleph.nkp.cz/F/?func=find-b&request=000303117&find_code=SYS&local_base=nkc
1998 @ 02 @ 04 @ Daňový zpravodaj DaZ. Odborný týdeník pro daně@ právo a finance', 'http://aleph.nkp.cz/F/?func=find-b&request=000303127&find_code=SYS&local_base=nkc
1998 @ 02 @ 05 @ Delfín. Časopis pro mladé @ http://aleph.nkp.cz/F/?func=find-b&request=000303102&find_code=SYS&local_base=nkc
1998 @ 02 @ 06 @ Dobrá voda. Nová vodní revue @ http://aleph.nkp.cz/F/?func=find-b&request=000302121&find_code=SYS&local_base=nkc
1998 @ 02 @ 07 @ Domácí rádce v křížovkách @ http://aleph.nkp.cz/F/?func=find-b&request=000303124&find_code=SYS&local_base=nkc
1998 @ 02 @ 08 @ Hláska. Zpravodaj magistrátu města Ostravy @ http://aleph.nkp.cz/F/?func=find-b&request=000303109&find_code=SYS&local_base=nkc
1998 @ 02 @ 09 @ Hypertenze. Bulletin České společnosti pro hypertenzi @ http://aleph.nkp.cz/F/?func=find-b&request=000303134&find_code=SYS&local_base=nkc
1998 @ 02 @ 10 @ Chcete nás ? Měsíčník pro přátele všech zvířat @ http://aleph.nkp.cz/F/?func=find-b&request=000303133&find_code=SYS&local_base=nkc
1998 @ 02 @ 11 @ Informační servis Divadelního ústavu @ http://aleph.nkp.cz/F/?func=find-b&request=000303118&find_code=SYS&local_base=nkc
1998 @ 02 @ 12 @ Informační zpravodaj pro obce Bohdalov@ Chroustov', 'http://aleph.nkp.cz/F/?func=find-b&request=000303116&find_code=SYS&local_base=nkc
1998 @ 02 @ 13 @ Janovské echo. Informační a kulturní občasník Janova nad Nisou @ http://aleph.nkp.cz/F/?func=find-b&request=000302101&find_code=SYS&local_base=nkc
1998 @ 02 @ 14 @ Jimramovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000302967&find_code=SYS&local_base=nkc
1998 @ 02 @ 15 @ Kodap váš přítel @ http://aleph.nkp.cz/F/?func=find-b&request=000303112&find_code=SYS&local_base=nkc
1998 @ 02 @ 16 @ Křižanovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000303122&find_code=SYS&local_base=nkc
1998 @ 02 @ 17 @ Lipovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000303129&find_code=SYS&local_base=nkc
1998 @ 02 @ 18 @ Lučanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000303108&find_code=SYS&local_base=nkc
1998 @ 02 @ 19 @ Mašovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000303106&find_code=SYS&local_base=nkc
1998 @ 02 @ 20 @ Měřínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000303120&find_code=SYS&local_base=nkc
1998 @ 02 @ 21 @ MM Průmyslové spektrum @ http://aleph.nkp.cz/F/?func=find-b&request=000645323&find_code=SYS&local_base=nkc
1998 @ 02 @ 22 @ Neratovické turistické perličky @ http://aleph.nkp.cz/F/?func=find-b&request=000303126&find_code=SYS&local_base=nkc
1998 @ 02 @ 23 @ Net it @ http://aleph.nkp.cz/F/?func=find-b&request=000303098&find_code=SYS&local_base=nkc
1998 @ 02 @ 24 @ Nové noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000303132&find_code=SYS&local_base=nkc
1998 @ 02 @ 25 @ Obec. Pro občany Roztok a Žalova @ http://aleph.nkp.cz/F/?func=find-b&request=000302123&find_code=SYS&local_base=nkc
1998 @ 02 @ 26 @ Orelské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000303115&find_code=SYS&local_base=nkc
1998 @ 02 @ 27 @ Orthodox revue. Sborník textů z pravoslavné theologie @ http://aleph.nkp.cz/F/?func=find-b&request=000301806&find_code=SYS&local_base=nkc
1998 @ 02 @ 28 @ Pardubický kulturní a sportovní měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000303101&find_code=SYS&local_base=nkc
1998 @ 02 @ 29 @ Personální a sociálně právní kartotéka @ http://aleph.nkp.cz/F/?func=find-b&request=000303099&find_code=SYS&local_base=nkc
1998 @ 02 @ 30 @ Podnikatel @ http://aleph.nkp.cz/F/?func=find-b&request=000361112&find_code=SYS&local_base=nkc
1998 @ 02 @ 31 @ Průvodce. Kulturní a informační zpravodaj města Zábřeh @ http://aleph.nkp.cz/F/?func=find-b&request=000301782&find_code=SYS&local_base=nkc
1998 @ 02 @ 32 @ Psí víno. Časopis pro současnou poezii @ http://aleph.nkp.cz/F/?func=find-b&request=000301510&find_code=SYS&local_base=nkc
1998 @ 02 @ 33 @ Roverský kmen @ http://aleph.nkp.cz/F/?func=find-b&request=000303104&find_code=SYS&local_base=nkc
1998 @ 02 @ 34 @ Řemesla a interiér @ http://aleph.nkp.cz/F/?func=find-b&request=000303105&find_code=SYS&local_base=nkc
1998 @ 02 @ 35 @ Seniorské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000303125&find_code=SYS&local_base=nkc
1998 @ 02 @ 36 @ Sex emoce @ http://aleph.nkp.cz/F/?func=find-b&request=000302964&find_code=SYS&local_base=nkc
1998 @ 02 @ 37 @ Sisyfos. Časopis proti blbosti @ http://aleph.nkp.cz/F/?func=find-b&request=000303119&find_code=SYS&local_base=nkc
1998 @ 02 @ 38 @ Strip @ http://aleph.nkp.cz/F/?func=find-b&request=000303111&find_code=SYS&local_base=nkc
1998 @ 02 @ 39 @ Svobodné noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000303130&find_code=SYS&local_base=nkc
1998 @ 02 @ 40 @ Tributum. Časopis daňových profesionálů @ http://aleph.nkp.cz/F/?func=find-b&request=000303110&find_code=SYS&local_base=nkc
1998 @ 02 @ 41 @ Třebíčské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000303131&find_code=SYS&local_base=nkc
1998 @ 02 @ 42 @ Účetní a daně. Odborný měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=000301419&find_code=SYS&local_base=nkc
1998 @ 02 @ 43 @ Uniform mail. Inzertní čtvrtletník pro Prahu a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=000301519&find_code=SYS&local_base=nkc
1998 @ 02 @ 44 @ Viselec. Převážně studentský časopis o sdílení @ http://aleph.nkp.cz/F/?func=find-b&request=000303100&find_code=SYS&local_base=nkc
1998 @ 02 @ 45 @ Zdravá rodina @ http://aleph.nkp.cz/F/?func=find-b&request=000302971&find_code=SYS&local_base=nkc
1998 @ 02 @ 46 @ Zpravodaj Benzina @ http://aleph.nkp.cz/F/?func=find-b&request=000302934&find_code=SYS&local_base=nkc
1998 @ 02 @ 47 @ Zpravodaj liberecké radnice @ http://aleph.nkp.cz/F/?func=find-b&request=000303128&find_code=SYS&local_base=nkc
1998 @ 02 @ 48 @ Zpravodaj obce Bzová @ http://aleph.nkp.cz/F/?func=find-b&request=000308366&find_code=SYS&local_base=nkc
1998 @ 02 @ 49 @ Zpravodaj Střediska pro poradenství a sociální rehabilitaci... @ http://aleph.nkp.cz/F/?func=find-b&request=000302944&find_code=SYS&local_base=nkc
1998 @ 03 @ 01 @ Aktuality v prevenci dětských úrazů @ http://aleph.nkp.cz/F/?func=find-b&request=000305053&find_code=SYS&local_base=nkc
1998 @ 03 @ 02 @ Billiard info. Časopis pro příznivce kulčníkového sportu. @ http://aleph.nkp.cz/F/?func=find-b&request=000305484&find_code=SYS&local_base=nkc
1998 @ 03 @ 03 @ Bulletin. Časopis Komory specialistů pro krizové řízení a insolvenci ČR @ http://aleph.nkp.cz/F/?func=find-b&request=000305746&find_code=SYS&local_base=nkc
1998 @ 03 @ 04 @ Mezinárodní katolická revue Communio @ http://aleph.nkp.cz/F/?func=find-b&request=000304071&find_code=SYS&local_base=nkc
1998 @ 03 @ 05 @ Český rybář @ http://aleph.nkp.cz/F/?func=find-b&request=000302989&find_code=SYS&local_base=nkc
1998 @ 03 @ 06 @ Čtvrtletník Prachovice @ http://aleph.nkp.cz/F/?func=find-b&request=000302989&find_code=SYS&local_base=nkc
1998 @ 03 @ 07 @ Gymnastika. Časopis gymnastických sportů @ http://aleph.nkp.cz/F/?func=find-b&request=000303561&find_code=SYS&local_base=nkc
1998 @ 03 @ 08 @ Chroustovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000305540&find_code=SYS&local_base=nkc
1998 @ 03 @ 09 @ Informační zpravodaj Svazu nuceně nasazených čs. občanů za 2. svět. ... @ http://aleph.nkp.cz/F/?func=find-b&request=000305771&find_code=SYS&local_base=nkc
1998 @ 03 @ 10 @ Koupelna. Revue moderního bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=000305480&find_code=SYS&local_base=nkc
1998 @ 03 @ 11 @ Naděje. Měsíčník ZŠ Raduň a ... @ http://aleph.nkp.cz/F/?func=find-b&request=000304127&find_code=SYS&local_base=nkc
1998 @ 03 @ 12 @ Novoměstské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000305600&find_code=SYS&local_base=nkc
1998 @ 03 @ 13 @ Obnovený energetik @ http://aleph.nkp.cz/F/?func=find-b&request=000305811&find_code=SYS&local_base=nkc
1998 @ 03 @ 14 @ Oldin. Olomoucký arcidiecézní informátor @ http://aleph.nkp.cz/F/?func=find-b&request=000304085&find_code=SYS&local_base=nkc
1998 @ 03 @ 15 @ Origami komiks @ http://aleph.nkp.cz/F/?func=find-b&request=000305641&find_code=SYS&local_base=nkc
1998 @ 03 @ 16 @ Petřvaldské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000305518&find_code=SYS&local_base=nkc
1998 @ 03 @ 17 @ Pravdivé romance @ http://aleph.nkp.cz/F/?func=find-b&request=000305477&find_code=SYS&local_base=nkc
1998 @ 03 @ 18 @ PRE forum. Časopis pro zákazníky @ http://aleph.nkp.cz/F/?func=find-b&request=000304387&find_code=SYS&local_base=nkc
1998 @ 03 @ 19 @ Radyňské listy @ http://aleph.nkp.cz/F/?func=find-b&request=000305808&find_code=SYS&local_base=nkc
1998 @ 03 @ 20 @ Světlo. Časopis pro světelnou techniku a osvětlování @ http://aleph.nkp.cz/F/?func=find-b&request=000305125&find_code=SYS&local_base=nkc
1998 @ 03 @ 21 @ Š + Š obecní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000304136&find_code=SYS&local_base=nkc
1998 @ 03 @ 22 @ Účetní. Odborný měsíčník pro účetní a daňovou veřejnost @ http://aleph.nkp.cz/F/?func=find-b&request=000304008&find_code=SYS&local_base=nkc
1998 @ 03 @ 23 @ Velkomoravský kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=000305815&find_code=SYS&local_base=nkc
1998 @ 03 @ 24 @ Zpravodaj pro akciové společnosti @ http://aleph.nkp.cz/F/?func=find-b&request=000305645&find_code=SYS&local_base=nkc
1998 @ 03 @ 25 @ Zpravodaj pro obyvatele a hosty (Kunratice@ Lipnice, Studený)', 'http://aleph.nkp.cz/F/?func=find-b&request=000305527&find_code=SYS&local_base=nkc
1998 @ 03 @ 26 @ Život farností Znojma @ http://aleph.nkp.cz/F/?func=find-b&request=000303107&find_code=SYS&local_base=nkc
1998 @ 04 @ 01 @ Akademické fórum. Časopis VŠB - Technické univerzity Ostrava @ http://aleph.nkp.cz/F/?func=find-b&request=000306365&find_code=SYS&local_base=nkc
1998 @ 04 @ 02 @ Bolest. Časopis společnosti pro studium a léčbu bolesti @ http://aleph.nkp.cz/F/?func=find-b&request=000308556&find_code=SYS&local_base=nkc
1998 @ 04 @ 03 @ Bulletin. Okresní úřad ve Žďáře nad Sázavou @ http://aleph.nkp.cz/F/?func=find-b&request=01094825&find_code=SYS&local_base=nkc
1998 @ 04 @ 04 @ Czech market @ http://aleph.nkp.cz/F/?func=find-b&request=000309921&find_code=SYS&local_base=nkc
1998 @ 04 @ 05 @ Deleatur. Časopis pro pěknou úpravu @ http://aleph.nkp.cz/F/?func=find-b&request=000307905&find_code=SYS&local_base=nkc
1998 @ 04 @ 06 @ Dingir. Časopis o sektách@ církvích a nových náboženských hnutí', 'http://aleph.nkp.cz/F/?func=find-b&request=000308547&find_code=SYS&local_base=nkc
1998 @ 04 @ 07 @ Diabetologie. Metabolismus. Endokrinologie. Výživa. Časopis pro postgraduální vzdělávání @ http://aleph.nkp.cz/F/?func=find-b&request=000306667&find_code=SYS&local_base=nkc
1998 @ 04 @ 08 @ Hamrovské listy. Občasník MěÚ Velké Hamry @ http://aleph.nkp.cz/F/?func=find-b&request=000308553&find_code=SYS&local_base=nkc
1998 @ 04 @ 09 @ Informační list obce Vnorovy @ http://aleph.nkp.cz/F/?func=find-b&request=000306352&find_code=SYS&local_base=nkc
1998 @ 04 @ 10 @ Kohoutovický kurýr. Zpravodaj místní rady Brno-Kohoutovice @ http://aleph.nkp.cz/F/?func=find-b&request=000306377&find_code=SYS&local_base=nkc
1998 @ 04 @ 11 @ Konkursní noviny. Noviny pro konkurs@ vyrovnání, likvidaci a exekuce', 'http://aleph.nkp.cz/F/?func=find-b&request=000307181&find_code=SYS&local_base=nkc
1998 @ 04 @ 12 @ Kroky. Časopis pro děti @ http://aleph.nkp.cz/F/?func=find-b&request=000307160&find_code=SYS&local_base=nkc
1998 @ 04 @ 13 @ Líšeňské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000306635&find_code=SYS&local_base=nkc
1998 @ 04 @ 14 @ Magazín dítě @ http://aleph.nkp.cz/F/?func=find-b&request=000307165&find_code=SYS&local_base=nkc
1998 @ 04 @ 15 @ Nebuď sám. Zpravodaj pro zdravotně postižené spoluobčany a jejich rodiny @ http://aleph.nkp.cz/F/?func=find-b&request=000308530&find_code=SYS&local_base=nkc
1998 @ 04 @ 16 @ Orientace 2000. Občasník poštorenské farnosti @ http://aleph.nkp.cz/F/?func=find-b&request=000306381&find_code=SYS&local_base=nkc
1998 @ 04 @ 17 @ Pohyb je život. Časopis pro cvičitele a činovníky sportu pro všechny @ http://aleph.nkp.cz/F/?func=find-b&request=000308121&find_code=SYS&local_base=nkc
1998 @ 04 @ 18 @ Program. Společník všech Ostravanů @ http://aleph.nkp.cz/F/?func=find-b&request=000306665&find_code=SYS&local_base=nkc
1998 @ 04 @ 19 @ Psychiatrie. Časopis pro moderní psychiatrii @ http://aleph.nkp.cz/F/?func=find-b&request=000308171&find_code=SYS&local_base=nkc
1998 @ 04 @ 20 @ Radio. Časopis pro radiotechniku a radiokomunikace @ http://aleph.nkp.cz/F/?func=find-b&request=000307178&find_code=SYS&local_base=nkc
1998 @ 04 @ 21 @ Sex club @ http://aleph.nkp.cz/F/?func=find-b&request=000307895&find_code=SYS&local_base=nkc
1998 @ 04 @ 22 @ Stavební a zemní stroje @ http://aleph.nkp.cz/F/?func=find-b&request=000307034&find_code=SYS&local_base=nkc
1998 @ 04 @ 23 @ Telekomunikační revue @ http://aleph.nkp.cz/F/?func=find-b&request=000306659&find_code=SYS&local_base=nkc
1998 @ 04 @ 24 @ Úhřetický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=000307171&find_code=SYS&local_base=nkc
1998 @ 04 @ 25 @ Zemědělský týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=000307173&find_code=SYS&local_base=nkc
1998 @ 04 @ 26 @ Zpravodaj lidové hvězdárny v Prostějově @ http://aleph.nkp.cz/F/?func=find-b&request=000308151&find_code=SYS&local_base=nkc
1998 @ 05 @ 01 @ Břeclavsko. Noviny okresu Břeclav @ http://aleph.nkp.cz/F/?func=find-b&request=000303107&find_code=SYS&local_base=nkc
1998 @ 05 @ 02 @ Canon. Noviny pro uživatele @ http://aleph.nkp.cz/F/?func=find-b&request=000309169&find_code=SYS&local_base=nkc
1998 @ 05 @ 03 @ Čas. Časopis pro zábavu i poučení @ http://aleph.nkp.cz/F/?func=find-b&request=000312436&find_code=SYS&local_base=nkc
1998 @ 05 @ 04 @ Česká a slovenská floristika. Odborný časopis pro floristy a květináře @ http://aleph.nkp.cz/F/?func=find-b&request=000311695&find_code=SYS&local_base=nkc
1998 @ 05 @ 05 @ DN. Důlní noviny. List pro zaměstnance Mostecké uhelné společnosti @ http://aleph.nkp.cz/F/?func=find-b&request=000311197&find_code=SYS&local_base=nkc
1998 @ 05 @ 06 @ Domino. Odborný časopis o podlahovinách a interiérech @ http://aleph.nkp.cz/F/?func=find-b&request=000309928&find_code=SYS&local_base=nkc
1998 @ 05 @ 07 @ Domo. Průvodce trhem podlahovin a interiérů @ http://aleph.nkp.cz/F/?func=find-b&request=000309309&find_code=SYS&local_base=nkc
1998 @ 05 @ 08 @ Hodos. Časopis nejen evangelický @ http://aleph.nkp.cz/F/?func=find-b&request=000318635&find_code=SYS&local_base=nkc
1998 @ 05 @ 09 @ Inter business @ http://aleph.nkp.cz/F/?func=find-b&request=000318694&find_code=SYS&local_base=nkc
1998 @ 05 @ 10 @ Jarní doteky. Časopis pro sexuální kulturu a komunikaci @ http://aleph.nkp.cz/F/?func=find-b&request=000311128&find_code=SYS&local_base=nkc
1998 @ 05 @ 11 @ Konfrontace @ http://aleph.nkp.cz/F/?func=find-b&request=000310283&find_code=SYS&local_base=nkc
1998 @ 05 @ 12 @ Lískáček. Zpravodaj městské části Brno-Nový Lískovec @ http://aleph.nkp.cz/F/?func=find-b&request=000318559&find_code=SYS&local_base=nkc
1998 @ 05 @ 13 @ Management Digest @ http://aleph.nkp.cz/F/?func=find-b&request=000311554&find_code=SYS&local_base=nkc
1998 @ 05 @ 14 @ Naše společenství. Měsíčník třebíčských farností @ http://aleph.nkp.cz/F/?func=find-b&request=000311154&find_code=SYS&local_base=nkc
1998 @ 05 @ 15 @ Neratovický čas i pro okolní obce @ http://aleph.nkp.cz/F/?func=find-b&request=000318723&find_code=SYS&local_base=nkc
1998 @ 05 @ 16 @ NoName @ http://aleph.nkp.cz/F/?func=find-b&request=000647094&find_code=SYS&local_base=nkc
1998 @ 05 @ 17 @ Okruh. Literární časopis pro mladé a začínající autory @ http://aleph.nkp.cz/F/?func=find-b&request=000311896&find_code=SYS&local_base=nkc
1998 @ 05 @ 18 @ Okruh a střed. Čtvrtletník pro náboženskou obnovu @ http://aleph.nkp.cz/F/?func=find-b&request=000311126&find_code=SYS&local_base=nkc
1998 @ 05 @ 19 @ Počítač pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=000311189&find_code=SYS&local_base=nkc
1998 @ 05 @ 20 @ Rally sport. Magazín @ http://aleph.nkp.cz/F/?func=find-b&request=000318558&find_code=SYS&local_base=nkc
1998 @ 05 @ 21 @ Svobodné rozhledy. Prostor pro liberálně-konzervativní diskusi @ http://aleph.nkp.cz/F/?func=find-b&request=0003109132&find_code=SYS&local_base=nkc
1998 @ 05 @ 22 @ Třebíčské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=000311147&find_code=SYS&local_base=nkc
1998 @ 05 @ 23 @ Tůdů. Literární měsíčník mladých začínajících autorů @ http://aleph.nkp.cz/F/?func=find-b&request=000311134&find_code=SYS&local_base=nkc
1998 @ 05 @ 24 @ Týdenní Opavsko @ http://aleph.nkp.cz/F/?func=find-b&request=000311200&find_code=SYS&local_base=nkc
1998 @ 05 @ 25 @ Varta. Zpravodaj MěÚ ve Stráži pod Ralskem @ http://aleph.nkp.cz/F/?func=find-b&request=000311192&find_code=SYS&local_base=nkc
1998 @ 05 @ 26 @ Vědma. Měsíčník pro všechny@ kteří chtějí vědět víc', 'http://aleph.nkp.cz/F/?func=find-b&request=000311114&find_code=SYS&local_base=nkc
1998 @ 05 @ 27 @ Vosa. Zpravodaj odborářů Vítkovic @ http://aleph.nkp.cz/F/?func=find-b&request=000311168&find_code=SYS&local_base=nkc
1998 @ 05 @ 28 @ Woman @ http://aleph.nkp.cz/F/?func=find-b&request=000318557&find_code=SYS&local_base=nkc
1998 @ 05 @ 29 @ Zákupský zpravodaj. Měsíčník zákupských občanů @ http://aleph.nkp.cz/F/?func=find-b&request=000318708&find_code=SYS&local_base=nkc
1998 @ 05 @ 30 @ Zpravodaj města Hrotovice @ http://aleph.nkp.cz/F/?func=find-b&request=000310274&find_code=SYS&local_base=nkc
1998 @ 05 @ 31 @ Zpravodaj Nasavrk @ http://aleph.nkp.cz/F/?func=find-b&request=000310292&find_code=SYS&local_base=nkc
1998 @ 05 @ 32 @ Zpravodaj obce Svratouch @ http://aleph.nkp.cz/F/?func=find-b&request=000310301&find_code=SYS&local_base=nkc
1998 @ 06 @ 01 @ Avicenna revue. Informace z medicíny@ farmacie a společnosti', 'http://aleph.nkp.cz/F/?func=find-b&request=00354266&find_code=SYS&local_base=nkc
1998 @ 06 @ 02 @ Boubínské jehličí @ http://aleph.nkp.cz/F/?func=find-b&request=00353028&find_code=SYS&local_base=nkc
1998 @ 06 @ 03 @ Cigár @ http://aleph.nkp.cz/F/?func=find-b&request=00353089&find_code=SYS&local_base=nkc
1998 @ 06 @ 04 @ Dáma. Zpravodaj české federace dámy @ http://aleph.nkp.cz/F/?func=find-b&request=00354218&find_code=SYS&local_base=nkc
1998 @ 06 @ 05 @ Development. International business magazin @ http://aleph.nkp.cz/F/?func=find-b&request=00354274&find_code=SYS&local_base=nkc
1998 @ 06 @ 06 @ Dobříkovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=00353095&find_code=SYS&local_base=nkc
1998 @ 06 @ 07 @ Gastro plus. Měsíčník pro gastronomii @ http://aleph.nkp.cz/F/?func=find-b&request=00353925&find_code=SYS&local_base=nkc
1998 @ 06 @ 08 @ GEOInfo. Odborný dvouměsíčník pro GIS a DPZ @ http://aleph.nkp.cz/F/?func=find-b&request=00353002&find_code=SYS&local_base=nkc
1998 @ 06 @ 09 @ HSW info. Zpravodaj pro oblast signmakingu @ http://aleph.nkp.cz/F/?func=find-b&request=00354250&find_code=SYS&local_base=nkc
1998 @ 06 @ 10 @ Jamenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00353691&find_code=SYS&local_base=nkc
1998 @ 06 @ 11 @ Kereka. Časopis nejen pro romské děti @ http://aleph.nkp.cz/F/?func=find-b&request=00354182&find_code=SYS&local_base=nkc
1998 @ 06 @ 12 @ Knižní občasník @ http://aleph.nkp.cz/F/?func=find-b&request=00353274&find_code=SYS&local_base=nkc
1998 @ 06 @ 13 @ Libchavský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00353015&find_code=SYS&local_base=nkc
1998 @ 06 @ 14 @ Magna @ http://aleph.nkp.cz/F/?func=find-b&request=00353971&find_code=SYS&local_base=nkc
1998 @ 06 @ 15 @ Medvídek Pú @ http://aleph.nkp.cz/F/?func=find-b&request=00353159&find_code=SYS&local_base=nkc
1998 @ 06 @ 16 @ Mladá pravda. Časopis Komunistického svazu mládeže @ http://aleph.nkp.cz/F/?func=find-b&request=00353209&find_code=SYS&local_base=nkc
1998 @ 06 @ 17 @ Opavský patriot @ http://aleph.nkp.cz/F/?func=find-b&request=00353279&find_code=SYS&local_base=nkc
1998 @ 06 @ 18 @ Orlický kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=00353283&find_code=SYS&local_base=nkc
1998 @ 06 @ 19 @ Pedagogicko-výchovný bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=00353093&find_code=SYS&local_base=nkc
1998 @ 06 @ 20 @ Pozdrav. Časopis občanského sdružení Naděje @ http://aleph.nkp.cz/F/?func=find-b&request=00353223&find_code=SYS&local_base=nkc
1998 @ 06 @ 21 @ Rybnický čtvrtletník @ http://aleph.nkp.cz/F/?func=find-b&request=00353097&find_code=SYS&local_base=nkc
1998 @ 06 @ 22 @ Scansolar revue @ http://aleph.nkp.cz/F/?func=find-b&request=00353220&find_code=SYS&local_base=nkc
1998 @ 06 @ 23 @ Squash revue @ http://aleph.nkp.cz/F/?func=find-b&request=00353702&find_code=SYS&local_base=nkc
1998 @ 06 @ 24 @ Srandy fůra @ http://aleph.nkp.cz/F/?func=find-b&request=00353267&find_code=SYS&local_base=nkc
1998 @ 06 @ 25 @ Tvář. Čtrnáctideník. Noviny pro Blansko a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=00353032&find_code=SYS&local_base=nkc
1998 @ 06 @ 26 @ Učíme se spolu @ http://aleph.nkp.cz/F/?func=find-b&request=00353744&find_code=SYS&local_base=nkc
1998 @ 06 @ 27 @ Vokno 2000. Trip and trans. Kultura třetího tisíciletí @ http://aleph.nkp.cz/F/?func=find-b&request=00352980&find_code=SYS&local_base=nkc
1998 @ 06 @ 28 @ Volání uprostřed noci. Mezinárodní časopis o biblických proroctvích @ http://aleph.nkp.cz/F/?func=find-b&request=00353217&find_code=SYS&local_base=nkc
1998 @ 06 @ 29 @ Zpravodaj československého sdružení uživatelů TEXu @ http://aleph.nkp.cz/F/?func=find-b&request=00353165&find_code=SYS&local_base=nkc
1998 @ 06 @ 30 @ Zpravodaj klubu LEVRET @ http://aleph.nkp.cz/F/?func=find-b&request=00353215&find_code=SYS&local_base=nkc
1998 @ 06 @ 31 @ Zpravodaj města Klášterce nad Ohří @ http://aleph.nkp.cz/F/?func=find-b&request=00353169&find_code=SYS&local_base=nkc
1998 @ 06 @ 32 @ Zpravodaj obce Záměl @ http://aleph.nkp.cz/F/?func=find-b&request=00353213&find_code=SYS&local_base=nkc
1998 @ 06 @ 33 @ Zpravodaj odborového svazu pracovníků peněžnictví a pojišťovnictví @ http://aleph.nkp.cz/F/?func=find-b&request=00353699&find_code=SYS&local_base=nkc
1998 @ 07 @ 01 @ Alternativní energie @ http://aleph.nkp.cz/F/?func=find-b&request=00365560&find_code=SYS&local_base=nkc
1998 @ 07 @ 02 @ Cargo. Časopis (nejen) o etnologii @ http://aleph.nkp.cz/F/?func=find-b&request=00365555&find_code=SYS&local_base=nkc
1998 @ 07 @ 03 @ České noviny. Týdeník litoměřického regionu @ http://aleph.nkp.cz/F/?func=find-b&request=00365558&find_code=SYS&local_base=nkc
1998 @ 07 @ 04 @ "Čtvrtletník ""Prachovice! " @ http://aleph.nkp.cz/F/?func=find-b&request=00305812&find_code=SYS&local_base=nkc
1998 @ 07 @ 05 @ Ekonomika Společenství @ http://aleph.nkp.cz/F/?func=find-b&request=00365461&find_code=SYS&local_base=nkc
1998 @ 07 @ 06 @ Gumař @ http://aleph.nkp.cz/F/?func=find-b&request=00357399&find_code=SYS&local_base=nkc
1998 @ 07 @ 07 @ Havířovsko @ http://aleph.nkp.cz/F/?func=find-b&request=00365655&find_code=SYS&local_base=nkc
1998 @ 07 @ 08 @ Most pro lidská práva @ http://aleph.nkp.cz/F/?func=find-b&request=00365659&find_code=SYS&local_base=nkc
1998 @ 07 @ 09 @ Pohyb je život. Časopis pro cvičitele a organizátory sportu pro všechny @ http://aleph.nkp.cz/F/?func=find-b&request=00308121&find_code=SYS&local_base=nkc
1998 @ 07 @ 10 @ Rady pro hobby. Rádce a pomocník pro celou rodinu @ http://aleph.nkp.cz/F/?func=find-b&request=00365447&find_code=SYS&local_base=nkc
1998 @ 07 @ 11 @ Rally sport magazín @ http://aleph.nkp.cz/F/?func=find-b&request=00318558&find_code=SYS&local_base=nkc
1998 @ 07 @ 12 @ Říše divů. Časopis pro děti od 9 let vydávaný ve spolupráci s časopisem Koktejl @ http://aleph.nkp.cz/F/?func=find-b&request=00365549&find_code=SYS&local_base=nkc
1998 @ 07 @ 13 @ Senior žurnál. Časopis pro všechny aktivní@ kteří to nechtějí vzdát', 'http://aleph.nkp.cz/F/?func=find-b&request=00365652&find_code=SYS&local_base=nkc
1998 @ 07 @ 14 @ Spektrum. Zrcadlení plzeňské kultury @ http://aleph.nkp.cz/F/?func=find-b&request=00365650&find_code=SYS&local_base=nkc
1998 @ 07 @ 15 @ Urgentní medicína. Časopis pro neodkladnou lékařskou péči @ http://aleph.nkp.cz/F/?func=find-b&request=00365566&find_code=SYS&local_base=nkc
1998 @ 07 @ 16 @ Zpravodaj ÚVT MU. Bulletin pro zájemce o výpočetní techniku na Masarykově univerzitě @ http://aleph.nkp.cz/F/?func=find-b&request=00365551&find_code=SYS&local_base=nkc
1998 @ 07 @ 17 @ Zrcadlo doby. Společenský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=00365571&find_code=SYS&local_base=nkc
1998 @ 09 @ 09 @ Fanny. Fanclub magazine @ http://aleph.nkp.cz/F/?func=find-b&request=00485971&find_code=SYS&local_base=nkc
1998 @ 09 @ 10 @ Hospodářství. Ekonomická revue @ http://aleph.nkp.cz/F/?func=find-b&request=00528835&find_code=SYS&local_base=nkc
1998 @ 09 @ 11 @ Kamelot. Týdeník okresu Bruntál @ http://aleph.nkp.cz/F/?func=find-b&request=00528423&find_code=SYS&local_base=nkc
1998 @ 09 @ 12 @ Karlovarskije novosti @ http://aleph.nkp.cz/F/?func=find-b&request=00386260&find_code=SYS&local_base=nkc
1998 @ 09 @ 13 @ Krušnohor. Zpravodaj stavebního bytového družstva @ http://aleph.nkp.cz/F/?func=find-b&request=00528021&find_code=SYS&local_base=nkc
1998 @ 09 @ 14 @ Management of healthcare quality and economics @ http://aleph.nkp.cz/F/?func=find-b&request=00386265&find_code=SYS&local_base=nkc
1998 @ 09 @ 15 @ Meždunarodnyje mosty @ http://aleph.nkp.cz/F/?func=find-b&request=00528597&find_code=SYS&local_base=nkc
1998 @ 09 @ 16 @ Miss aneb slečna na úrovni @ http://aleph.nkp.cz/F/?func=find-b&request=00485860&find_code=SYS&local_base=nkc
1998 @ 09 @ 17 @ Modrobílá revue. Čtvrtletník BMW Auto Clubu Praha @ http://aleph.nkp.cz/F/?func=find-b&request=00390126&find_code=SYS&local_base=nkc
1998 @ 09 @ 18 @ Opavský kamelot. Týdeník okresu Opava @ http://aleph.nkp.cz/F/?func=find-b&request=00528419&find_code=SYS&local_base=nkc
1998 @ 09 @ 19 @ Povrchové úpravy. Odborný časopis pro průmysl@ stavebnictví a řemeslníky', 'http://aleph.nkp.cz/F/?func=find-b&request=00528427&find_code=SYS&local_base=nkc
1998 @ 09 @ 20 @ Taxi noviny @ http://aleph.nkp.cz/F/?func=find-b&request=00528215&find_code=SYS&local_base=nkc
1998 @ 09 @ 21 @ Tetrix. Moravský přírodovědný časopis @ http://aleph.nkp.cz/F/?func=find-b&request=00528202&find_code=SYS&local_base=nkc
1998 @ 09 @ 22 @ Velo revue @ http://aleph.nkp.cz/F/?func=find-b&request=00386272&find_code=SYS&local_base=nkc
1998 @ 10 @ 01 @ Almanach začínajících autorů @ http://aleph.nkp.cz/F/?func=find-b&request=00386268&find_code=SYS&local_base=nkc
1998 @ 10 @ 02 @ Anna. Měsíčník pro přátele ručních prací @ http://aleph.nkp.cz/F/?func=find-b&request=00486021&find_code=SYS&local_base=nkc
1998 @ 10 @ 03 @ AudioVideo Tip @ http://aleph.nkp.cz/F/?func=find-b&request=00386273&find_code=SYS&local_base=nkc
1998 @ 10 @ 04 @ AUTO exclusive @ http://aleph.nkp.cz/F/?func=find-b&request=00528847&find_code=SYS&local_base=nkc
1998 @ 10 @ 05 @ Dentální trh. Měsíčník pro stomatology a dentální laboratoře @ http://aleph.nkp.cz/F/?func=find-b&request=00528571&find_code=SYS&local_base=nkc
1998 @ 10 @ 06 @ Doteky štěstí. Příběhy českých dívek a žen@ které potkaly toho pravého', 'http://aleph.nkp.cz/F/?func=find-b&request=00528126&find_code=SYS&local_base=nkc
1998 @ 10 @ 07 @ Euro. Ekonomický týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=00528586&find_code=SYS&local_base=nkc
1998 @ 10 @ 08 @ Fakta X. Odhalení@ paranormální jevy, záhady, UFO', 'http://aleph.nkp.cz/F/?func=find-b&request=00390102&find_code=SYS&local_base=nkc
1998 @ 10 @ 09 @ Fanny. Fanclub magazine @ http://aleph.nkp.cz/F/?func=find-b&request=00485971&find_code=SYS&local_base=nkc
1998 @ 10 @ 10 @ Hospodářství. Ekonomická revue @ http://aleph.nkp.cz/F/?func=find-b&request=00528835&find_code=SYS&local_base=nkc
1998 @ 10 @ 11 @ Kamelot. Týdeník okresu Bruntál @ http://aleph.nkp.cz/F/?func=find-b&request=00528423&find_code=SYS&local_base=nkc
1998 @ 10 @ 12 @ Karlovarskije novosti @ http://aleph.nkp.cz/F/?func=find-b&request=00386260&find_code=SYS&local_base=nkc
1998 @ 10 @ 13 @ Krušnohor. Zpravodaj stavebního bytového družstva @ http://aleph.nkp.cz/F/?func=find-b&request=00528021&find_code=SYS&local_base=nkc
1998 @ 10 @ 14 @ Management of healthcare quality and economics @ http://aleph.nkp.cz/F/?func=find-b&request=00386265&find_code=SYS&local_base=nkc
1998 @ 10 @ 15 @ Meždunarodnyje mosty @ http://aleph.nkp.cz/F/?func=find-b&request=00528597&find_code=SYS&local_base=nkc
1998 @ 10 @ 16 @ Miss aneb slečna na úrovni @ http://aleph.nkp.cz/F/?func=find-b&request=00485860&find_code=SYS&local_base=nkc
1998 @ 10 @ 17 @ Modrobílá revue. Čtvrtletník BMW Auto Clubu Praha @ http://aleph.nkp.cz/F/?func=find-b&request=00390126&find_code=SYS&local_base=nkc
1998 @ 10 @ 18 @ Opavský kamelot. Týdeník okresu Opava @ http://aleph.nkp.cz/F/?func=find-b&request=00528419&find_code=SYS&local_base=nkc
1998 @ 10 @ 19 @ Povrchové úpravy. Odborný časopis pro průmysl@ stavebnictví a řemeslníky', 'http://aleph.nkp.cz/F/?func=find-b&request=00528427&find_code=SYS&local_base=nkc
1998 @ 10 @ 20 @ Taxi noviny @ http://aleph.nkp.cz/F/?func=find-b&request=00528215&find_code=SYS&local_base=nkc
1998 @ 10 @ 21 @ Tetrix. Moravský přírodovědný časopis @ http://aleph.nkp.cz/F/?func=find-b&request=00528202&find_code=SYS&local_base=nkc
1998 @ 10 @ 22 @ Velo revue @ http://aleph.nkp.cz/F/?func=find-b&request=00386272&find_code=SYS&local_base=nkc
1998 @ 11 @ 01 @ Acta musei moraviae. Scientiae biologicae @ http://aleph.nkp.cz/F/?func=find-b&request=00537987&find_code=SYS&local_base=nkc
1998 @ 11 @ 02 @ Acta musei moraviae. Scientiae geologicae @ http://aleph.nkp.cz/F/?func=find-b&request=00537932&find_code=SYS&local_base=nkc
1998 @ 11 @ 03 @ Dechovka. Měsíčník příznivců lidové hudby a folklóru @ http://aleph.nkp.cz/F/?func=find-b&request=00600688&find_code=SYS&local_base=nkc
1998 @ 11 @ 04 @ Forum medical @ http://aleph.nkp.cz/F/?func=find-b&request=00537842&find_code=SYS&local_base=nkc
1998 @ 11 @ 05 @ H.I.S. bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=00600680&find_code=SYS&local_base=nkc
1998 @ 11 @ 06 @ Kovonky. Informační a propagační měsíčník zaměstnanců Kovony Karviná @ http://aleph.nkp.cz/F/?func=find-b&request=00600682&find_code=SYS&local_base=nkc
1998 @ 11 @ 07 @ Krmiva a výživa. Odborný časopis pro výživu a krmení domácích zvířat... @ http://aleph.nkp.cz/F/?func=find-b&request=00537850&find_code=SYS&local_base=nkc
1998 @ 11 @ 08 @ NATO review @ http://aleph.nkp.cz/F/?func=find-b&request=00599871&find_code=SYS&local_base=nkc
1998 @ 11 @ 09 @ Nové listy. Regionální týdeník zpravodajství@ publicistiky a reklamy', 'http://aleph.nkp.cz/F/?func=find-b&request=00538674&find_code=SYS&local_base=nkc
1998 @ 11 @ 10 @ Pardon. Humoristická příloha deníků Bohemia @ http://aleph.nkp.cz/F/?func=find-b&request=00537282&find_code=SYS&local_base=nkc
1998 @ 11 @ 11 @ Puls Třebíčska @ http://aleph.nkp.cz/F/?func=find-b&request=00537358&find_code=SYS&local_base=nkc
1998 @ 11 @ 12 @ Radniční listy. Zpravodaj městského úřadu v Trutnově @ http://aleph.nkp.cz/F/?func=find-b&request=00599739&find_code=SYS&local_base=nkc
1998 @ 11 @ 13 @ Reality inzert @ http://aleph.nkp.cz/F/?func=find-b&request=00537391&find_code=SYS&local_base=nkc
1998 @ 11 @ 14 @ Reklama ano! Noviny pro reklamu a inzerci @ http://aleph.nkp.cz/F/?func=find-b&request=00537809&find_code=SYS&local_base=nkc
1998 @ 11 @ 15 @ Rescue report. Časopis pro integrovaný záchranný systém @ http://aleph.nkp.cz/F/?func=find-b&request=00537264&find_code=SYS&local_base=nkc
1998 @ 11 @ 16 @ Stavební strojník. Lidé-technologie-stroje @ http://aleph.nkp.cz/F/?func=find-b&request=00537474&find_code=SYS&local_base=nkc
1998 @ 11 @ 17 @ Supermoto @ http://aleph.nkp.cz/F/?func=find-b&request=00537462&find_code=SYS&local_base=nkc
1998 @ 11 @ 18 @ Šternberský mor @ http://aleph.nkp.cz/F/?func=find-b&request=00537743&find_code=SYS&local_base=nkc
1998 @ 11 @ 19 @ Véčko. Studentský časopis @ http://aleph.nkp.cz/F/?func=find-b&request=00599723&find_code=SYS&local_base=nkc
1998 @ 11 @ 20 @ Verena @ http://aleph.nkp.cz/F/?func=find-b&request=00537250&find_code=SYS&local_base=nkc
1998 @ 11 @ 21 @ Vestigář DIS ČHV. Občasník Dokumentačního a inf. střediska Českého helsinského výboru @ http://aleph.nkp.cz/F/?func=find-b&request=00537445&find_code=SYS&local_base=nkc
1998 @ 11 @ 22 @ Wüstenrot. Časopis stavební spořitelny @ http://aleph.nkp.cz/F/?func=find-b&request=00601072&find_code=SYS&local_base=nkc
1998 @ 11 @ 23 @ Zdravotnictví v České republice @ http://aleph.nkp.cz/F/?func=find-b&request=00599761&find_code=SYS&local_base=nkc
1998 @ 11 @ 24 @ Zdravotní pojištění a revizní lékařství @ http://aleph.nkp.cz/F/?func=find-b&request=00599780&find_code=SYS&local_base=nkc
1998 @ 11 @ 25 @ Zpravodaj Konice @ http://aleph.nkp.cz/F/?func=find-b&request=00601023&find_code=SYS&local_base=nkc
1998 @ 11 @ 26 @ Zpravodaj města Brandýs nad Labem - Stará Boleslav @ http://aleph.nkp.cz/F/?func=find-b&request=00537420&find_code=SYS&local_base=nkc
1998 @ 11 @ 27 @ Zpravodaj pošty @ http://aleph.nkp.cz/F/?func=find-b&request=00601082&find_code=SYS&local_base=nkc
1998 @ 11 @ 28 @ Zpravodaj Prosečné @ http://aleph.nkp.cz/F/?func=find-b&request=00599860&find_code=SYS&local_base=nkc
1998 @ 11 @ 29 @ Zprávy Centra hygieny potravinových řetězců v Brně @ http://aleph.nkp.cz/F/?func=find-b&request=00600663&find_code=SYS&local_base=nkc
1998 @ 12 @ 01 @ Bánovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00604513&find_code=SYS&local_base=nkc
1998 @ 12 @ 02 @ Bílovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00604520&find_code=SYS&local_base=nkc
1998 @ 12 @ 03 @ BOZP. Poradce bezpečnosti a ochrany zdraví pro podnikatele@ zaměstnavatele ...', 'http://aleph.nkp.cz/F/?func=find-b&request=00601373&find_code=SYS&local_base=nkc
1998 @ 12 @ 04 @ Březenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00602003&find_code=SYS&local_base=nkc
1998 @ 12 @ 05 @ Buchlovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00604404&find_code=SYS&local_base=nkc
1998 @ 12 @ 06 @ Jirkovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=00604526&find_code=SYS&local_base=nkc
1998 @ 12 @ 07 @ Kaplický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=00604530&find_code=SYS&local_base=nkc
1998 @ 12 @ 08 @ Kniha křížovek @ http://aleph.nkp.cz/F/?func=find-b&request=00601941&find_code=SYS&local_base=nkc
1998 @ 12 @ 09 @ Nivnické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=00604534&find_code=SYS&local_base=nkc
1998 @ 12 @ 10 @ Ostravský den. Noviny pro Ostravu a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=00604693&find_code=SYS&local_base=nkc
1998 @ 12 @ 11 @ Péčko. Privátní průvodce pornosvětem pro plnoleté @ http://aleph.nkp.cz/F/?func=find-b&request=00601951&find_code=SYS&local_base=nkc
1998 @ 12 @ 12 @ Pohoda. Pro ty@ kteří jsou větší. První čtvrtletník pro plnoštíhlé', 'http://aleph.nkp.cz/F/?func=find-b&request=00601978&find_code=SYS&local_base=nkc
1998 @ 12 @ 13 @ Praha na dlani @ http://aleph.nkp.cz/F/?func=find-b&request=00601986&find_code=SYS&local_base=nkc
1998 @ 12 @ 14 @ Realitní a stavební profit. Realitní a stavební měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=00604729&find_code=SYS&local_base=nkc
1998 @ 12 @ 15 @ Reality inzert. Morava. Inzertní měsíčník nemovitostí @ http://aleph.nkp.cz/F/?func=find-b&request=00601935&find_code=SYS&local_base=nkc
1998 @ 12 @ 16 @ Reality inzert. Praha a Střední Čechy. Inzertní měsíčník nemovitostí @ http://aleph.nkp.cz/F/?func=find-b&request=00601314&find_code=SYS&local_base=nkc
1998 @ 12 @ 17 @ Reality inzert. Východní Čechy. Inzertní měsíčník nemovitostí @ http://aleph.nkp.cz/F/?func=find-b&request=00601359&find_code=SYS&local_base=nkc
1998 @ 12 @ 18 @ Reality inzert. Západní Čechy. Inzertní měsíčník nemovitostí @ http://aleph.nkp.cz/F/?func=find-b&request=00601364&find_code=SYS&local_base=nkc
1998 @ 12 @ 19 @ Slovanská vzájemnost. Měsíčník Slovanského výboru ČR @ http://aleph.nkp.cz/F/?func=find-b&request=00602182&find_code=SYS&local_base=nkc
1998 @ 12 @ 20 @ Trutnovský posel. Čistě trutnovský list pro 12 000 domácností @ http://aleph.nkp.cz/F/?func=find-b&request=00604727&find_code=SYS&local_base=nkc
2002 @ 09 @ 28 @ Sex a křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001185405&find_code=SYS&local_base=nkc
2004 @ 01 @ 24 @ Zvěrokruh @ http://aleph.nkp.cz/F/?func=find-b&request=01300831&find_code=SYS&local_base=nkc
2004 @ 01 @ 23 @ Zpravodaj Svazku obcí při formanské cestě @ http://aleph.nkp.cz/F/?func=find-b&request=01300830&find_code=SYS&local_base=nkc
2004 @ 01 @ 22 @ VTM Science & Technology @ http://aleph.nkp.cz/F/?func=find-b&request=01298605&find_code=SYS&local_base=nkc
2004 @ 01 @ 20 @ Vožičan @ http://aleph.nkp.cz/F/?func=find-b&request=01298369&find_code=SYS&local_base=nkc
2004 @ 01 @ 21 @ VTM Science @ http://aleph.nkp.cz/F/?func=find-b&request=01298614&find_code=SYS&local_base=nkc
2004 @ 01 @ 19 @ Veterinární lékař @ http://aleph.nkp.cz/F/?func=find-b&request=01298357&find_code=SYS&local_base=nkc
2004 @ 01 @ 18 @ Týden u nás @ http://aleph.nkp.cz/F/?func=find-b&request=01298378&find_code=SYS&local_base=nkc
2004 @ 01 @ 16 @ Tismický trubadur @ http://aleph.nkp.cz/F/?func=find-b&request=01298373&find_code=SYS&local_base=nkc
2004 @ 01 @ 17 @ TV Duel @ http://aleph.nkp.cz/F/?func=find-b&request=01297399&find_code=SYS&local_base=nkc
2004 @ 01 @ 15 @ StavoMonitor @ http://aleph.nkp.cz/F/?func=find-b&request=01300823&find_code=SYS&local_base=nkc
2004 @ 01 @ 14 @ Slovácko @ http://aleph.nkp.cz/F/?func=find-b&request=01297682&find_code=SYS&local_base=nkc
2004 @ 01 @ 12 @ Receptář @ http://aleph.nkp.cz/F/?func=find-b&request=01294122&find_code=SYS&local_base=nkc
2004 @ 01 @ 13 @ Recepty prima nápadů @ http://aleph.nkp.cz/F/?func=find-b&request=01299846&find_code=SYS&local_base=nkc
2004 @ 01 @ 11 @ Poradce extra@ Veřejná správa', 'http://aleph.nkp.cz/F/?func=find-b&request=01300520&find_code=SYS&local_base=nkc
2004 @ 01 @ 10 @ Pivní magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01300825&find_code=SYS&local_base=nkc
2004 @ 01 @ 09 @ Naše obec @ http://aleph.nkp.cz/F/?func=find-b&request=01299027&find_code=SYS&local_base=nkc
2004 @ 01 @ 08 @ Mistr @ http://aleph.nkp.cz/F/?func=find-b&request=01299040&find_code=SYS&local_base=nkc
2004 @ 01 @ 07 @ Konec konců @ http://aleph.nkp.cz/F/?func=find-b&request=01299037&find_code=SYS&local_base=nkc
2004 @ 01 @ 05 @ Chodský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01300785&find_code=SYS&local_base=nkc
2004 @ 01 @ 06 @ K-servis @ http://aleph.nkp.cz/F/?func=find-b&request=01299367&find_code=SYS&local_base=nkc
2004 @ 01 @ 04 @ Fénix @ http://aleph.nkp.cz/F/?func=find-b&request=01299047&find_code=SYS&local_base=nkc
2004 @ 01 @ 03 @ Dobřanské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01000639&find_code=SYS&local_base=nkc
2004 @ 01 @ 02 @ Divadelní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01299025&find_code=SYS&local_base=nkc
2004 @ 01 @ 01 @ Daně a účetnictví @ http://aleph.nkp.cz/F/?func=find-b&request=01287653&find_code=SYS&local_base=nkc
2002 @ 09 @ 29 @ Sexy fórky @ http://aleph.nkp.cz/F/?func=find-b&request=001185431&find_code=SYS&local_base=nkc
2002 @ 09 @ 30 @ Švédské křížovky k pobavení @ http://aleph.nkp.cz/F/?func=find-b&request=001185465&find_code=SYS&local_base=nkc
2002 @ 09 @ 31 @ Vaše inzerce @ http://aleph.nkp.cz/F/?func=find-b&request=001187309&find_code=SYS&local_base=nkc
2002 @ 09 @ 32 @ Velké osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001185467&find_code=SYS&local_base=nkc
2002 @ 09 @ 33 @ Watch magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001185020&find_code=SYS&local_base=nkc
2002 @ 09 @ 34 @ X-max @ http://aleph.nkp.cz/F/?func=find-b&request=001180649&find_code=SYS&local_base=nkc
2002 @ 09 @ 35 @ Zábavné křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001185406&find_code=SYS&local_base=nkc
2002 @ 09 @ 36 @ Zábavné luštění @ http://aleph.nkp.cz/F/?func=find-b&request=001185464&find_code=SYS&local_base=nkc
2002 @ 09 @ 37 @ Zpravodaj (Český Telecom) @ http://aleph.nkp.cz/F/?func=find-b&request=001187294&find_code=SYS&local_base=nkc
2002 @ 09 @ 38 @ Zpravodaj (HeidelbergCement Group) @ http://aleph.nkp.cz/F/?func=find-b&request=001185038&find_code=SYS&local_base=nkc
2002 @ 09 @ 39 @ Zpravodaj obcí Kalek@ Načetín a Jindřichova Ves', 'http://aleph.nkp.cz/F/?func=find-b&request=001185196&find_code=SYS&local_base=nkc
2002 @ 09 @ 40 @ Zpravodaj pražské arcidiecéze @ http://aleph.nkp.cz/F/?func=find-b&request=001185186&find_code=SYS&local_base=nkc
2002 @ 09 @ 41 @ Zprávy z mraveniště @ http://aleph.nkp.cz/F/?func=find-b&request=001185186&find_code=SYS&local_base=nkc
2002 @ 01 @ 25 @ Trucker @ http://aleph.nkp.cz/F/?func=find-b&request=001037186&find_code=SYS&local_base=nkc
2002 @ 01 @ 26 @ Údolí úsměvů @ http://aleph.nkp.cz/F/?func=find-b&request=001064424&find_code=SYS&local_base=nkc
2002 @ 01 @ 27 @ Unie @ http://aleph.nkp.cz/F/?func=find-b&request=001037476&find_code=SYS&local_base=nkc
2002 @ 01 @ 28 @ Věstník Úřadu pro ochranu osobních údajů @ http://aleph.nkp.cz/F/?func=find-b&request=001064046&find_code=SYS&local_base=nkc
2002 @ 01 @ 29 @ Vojenský geografický obzor @ http://aleph.nkp.cz/F/?func=find-b&request=001037228&find_code=SYS&local_base=nkc
2002 @ 01 @ 30 @ Vteřiny Techfilmu @ http://aleph.nkp.cz/F/?func=find-b&request=001037193&find_code=SYS&local_base=nkc
2002 @ 01 @ 31 @ Výhledy @ http://aleph.nkp.cz/F/?func=find-b&request=001064336&find_code=SYS&local_base=nkc
2002 @ 01 @ 32 @ Zaměstnání @ http://aleph.nkp.cz/F/?func=find-b&request=001037233&find_code=SYS&local_base=nkc
2002 @ 01 @ 33 @ Zelená životu @ http://aleph.nkp.cz/F/?func=find-b&request=001064412&find_code=SYS&local_base=nkc
2002 @ 01 @ 34 @ Zlatý roh @ http://aleph.nkp.cz/F/?func=find-b&request=001036246&find_code=SYS&local_base=nkc
2002 @ 01 @ 35 @ Zpravodaj (OÚ Hodonín) @ http://aleph.nkp.cz/F/?func=find-b&request=001036265&find_code=SYS&local_base=nkc
2002 @ 01 @ 36 @ Zpravodaj Aldis @ http://aleph.nkp.cz/F/?func=find-b&request=001064205&find_code=SYS&local_base=nkc
2002 @ 01 @ 37 @ Zubní technik @ http://aleph.nkp.cz/F/?func=find-b&request=001064144&find_code=SYS&local_base=nkc
2002 @ 03 @ 88 @ Trutnovský inzert @ http://aleph.nkp.cz/F/?func=find-b&request=001090564&find_code=SYS&local_base=nkc
2002 @ 03 @ 89 @ Turistické noviny - Střední Polabí @ http://aleph.nkp.cz/F/?func=find-b&request=001088778&find_code=SYS&local_base=nkc
2002 @ 03 @ 90 @ Účetnictví bez chyb@ pokut a penále', 'http://aleph.nkp.cz/F/?func=find-b&request=001087847&find_code=SYS&local_base=nkc
2002 @ 03 @ 91 @ Udělej si sám @ http://aleph.nkp.cz/F/?func=find-b&request=001089495&find_code=SYS&local_base=nkc
2002 @ 03 @ 92 @ UL-servis @ http://aleph.nkp.cz/F/?func=find-b&request=001088495&find_code=SYS&local_base=nkc
2002 @ 03 @ 93 @ ÚOOÚ informuje @ http://aleph.nkp.cz/F/?func=find-b&request=001088488&find_code=SYS&local_base=nkc
2002 @ 03 @ 94 @ Ústecké ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=001089029&find_code=SYS&local_base=nkc
2002 @ 03 @ 95 @ Vyhrejte s křížovkami! @ http://aleph.nkp.cz/F/?func=find-b&request=001088210&find_code=SYS&local_base=nkc
2002 @ 03 @ 96 @ Vyhrejte s osmisměrkami! @ http://aleph.nkp.cz/F/?func=find-b&request=001088213&find_code=SYS&local_base=nkc
2002 @ 03 @ 97 @ WM magazin @ http://aleph.nkp.cz/F/?func=find-b&request=001088051&find_code=SYS&local_base=nkc
2002 @ 03 @ 98 @ Zásadský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001088605&find_code=SYS&local_base=nkc
2002 @ 03 @ 99 @ Zpravodaj městského úřadu v Kelči @ http://aleph.nkp.cz/F/?func=find-b&request=001089032&find_code=SYS&local_base=nkc
2002 @ 03 @ 100 @ Zpravodaj obce Ludmírov @ http://aleph.nkp.cz/F/?func=find-b&request=001088483&find_code=SYS&local_base=nkc
2002 @ 03 @ 101 @ Zpravodaj obecního úřadu v Dobšicích @ http://aleph.nkp.cz/F/?func=find-b&request=001087993&find_code=SYS&local_base=nkc
2002 @ 03 @ 102 @ Zpravodaj pro mzdové účetní a persionalisty Speciál @ http://aleph.nkp.cz/F/?func=find-b&request=001067309&find_code=SYS&local_base=nkc
2002 @ 03 @ 103 @ Žlutá@ modrá', 'http://aleph.nkp.cz/F/?func=find-b&request=001087983&find_code=SYS&local_base=nkc
2004 @ 02 @ 01 @ Auto report magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01295983&find_code=SYS&local_base=nkc
2004 @ 02 @ 02 @ Bryonora @ http://aleph.nkp.cz/F/?func=find-b&request=01299846&find_code=SYS&local_base=nkc
2004 @ 02 @ 03 @ Čas nad Metují @ http://aleph.nkp.cz/F/?func=find-b&request=01303176&find_code=SYS&local_base=nkc
2004 @ 02 @ 04 @ Dikobraz @ http://aleph.nkp.cz/F/?func=find-b&request=01303505&find_code=SYS&local_base=nkc
2004 @ 02 @ 05 @ Doteky štěstí speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01303507&find_code=SYS&local_base=nkc
2004 @ 02 @ 06 @ E 8 @ http://aleph.nkp.cz/F/?func=find-b&request=01301415&find_code=SYS&local_base=nkc
2004 @ 02 @ 07 @ Fasáda @ http://aleph.nkp.cz/F/?func=find-b&request=01303167&find_code=SYS&local_base=nkc
2004 @ 02 @ 08 @ Interiér @ http://aleph.nkp.cz/F/?func=find-b&request=01304333&find_code=SYS&local_base=nkc
2004 @ 02 @ 09 @ Jitřenka @ http://aleph.nkp.cz/F/?func=find-b&request=01301667&find_code=SYS&local_base=nkc
2004 @ 02 @ 10 @ Klášterecké noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01303121&find_code=SYS&local_base=nkc
2004 @ 02 @ 11 @ Konkurz & konjunktura @ http://aleph.nkp.cz/F/?func=find-b&request=01303511&find_code=SYS&local_base=nkc
2004 @ 02 @ 12 @ Královodvroský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01301143&find_code=SYS&local_base=nkc
2004 @ 02 @ 13 @ Lipské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01291553&find_code=SYS&local_base=nkc
2004 @ 02 @ 14 @ Malínské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01303169&find_code=SYS&local_base=nkc
2004 @ 02 @ 15 @ Meduňka @ http://aleph.nkp.cz/F/?func=find-b&request=01301386&find_code=SYS&local_base=nkc
2004 @ 02 @ 16 @ Nanumto + @ http://aleph.nkp.cz/F/?func=find-b&request=01304380&find_code=SYS&local_base=nkc
2004 @ 02 @ 17 @ Neon @ http://aleph.nkp.cz/F/?func=find-b&request=01303105&find_code=SYS&local_base=nkc
2004 @ 02 @ 18 @ Newsletter pro management akciových společností speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01302788&find_code=SYS&local_base=nkc
2004 @ 02 @ 19 @ Next magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01303098&find_code=SYS&local_base=nkc
2004 @ 02 @ 20 @ Noviny radnice @ http://aleph.nkp.cz/F/?func=find-b&request=01303113&find_code=SYS&local_base=nkc
2004 @ 02 @ 21 @ Novoborský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=01300982&find_code=SYS&local_base=nkc
2004 @ 02 @ 22 @ Opavský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=01304340&find_code=SYS&local_base=nkc
2004 @ 02 @ 23 @ Partner @ http://aleph.nkp.cz/F/?func=find-b&request=01304376&find_code=SYS&local_base=nkc
2004 @ 02 @ 24 @ Princezna @ http://aleph.nkp.cz/F/?func=find-b&request=01304375&find_code=SYS&local_base=nkc
2004 @ 02 @ 25 @ Průvodce @ http://aleph.nkp.cz/F/?func=find-b&request=01304224&find_code=SYS&local_base=nkc
2004 @ 02 @ 26 @ Přívozník @ http://aleph.nkp.cz/F/?func=find-b&request=01302628&find_code=SYS&local_base=nkc
2004 @ 02 @ 27 @ Rispon … @ http://aleph.nkp.cz/F/?func=find-b&request=01302469&find_code=SYS&local_base=nkc
2004 @ 02 @ 28 @ "Řestocká ""drbna""" @ http://aleph.nkp.cz/F/?func=find-b&request=01302475&find_code=SYS&local_base=nkc
2004 @ 02 @ 29 @ Salesiánský magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01302460&find_code=SYS&local_base=nkc
2004 @ 02 @ 30 @ Spektrum @ http://aleph.nkp.cz/F/?func=find-b&request=01304320&find_code=SYS&local_base=nkc
2004 @ 02 @ 31 @ Studánka @ http://aleph.nkp.cz/F/?func=find-b&request=01302620&find_code=SYS&local_base=nkc
2004 @ 02 @ 32 @ Školák @ http://aleph.nkp.cz/F/?func=find-b&request=01303501&find_code=SYS&local_base=nkc
2004 @ 02 @ 33 @ Valašský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=01304343&find_code=SYS&local_base=nkc
2004 @ 02 @ 34 @ Váš osobní lékař @ http://aleph.nkp.cz/F/?func=find-b&request=01302449&find_code=SYS&local_base=nkc
2004 @ 02 @ 35 @ Zlobice @ http://aleph.nkp.cz/F/?func=find-b&request=01302479&find_code=SYS&local_base=nkc
2004 @ 02 @ 36 @ Zpravodaj Obecního úřadu Náklo @ http://aleph.nkp.cz/F/?func=find-b&request=01303503&find_code=SYS&local_base=nkc
2004 @ 02 @ 37 @ Zvon @ http://aleph.nkp.cz/F/?func=find-b&request=01304367&find_code=SYS&local_base=nkc
2004 @ 03 @ 25 @ Pardubický sporťák @ http://aleph.nkp.cz/F/?func=find-b&request=01305850&find_code=SYS&local_base=nkc
2004 @ 03 @ 24 @ Obecní noviny Mysločovice @ http://aleph.nkp.cz/F/?func=find-b&request=01309659&find_code=SYS&local_base=nkc
2004 @ 03 @ 22 @ Nový proud @ http://aleph.nkp.cz/F/?func=find-b&request=01307555&find_code=SYS&local_base=nkc
2004 @ 03 @ 23 @ Občasník obce Hodíškov @ http://aleph.nkp.cz/F/?func=find-b&request=01305473&find_code=SYS&local_base=nkc
2004 @ 03 @ 20 @ Metro magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01307578&find_code=SYS&local_base=nkc
2004 @ 03 @ 21 @ Moderní rodina @ http://aleph.nkp.cz/F/?func=find-b&request=01308429&find_code=SYS&local_base=nkc
2004 @ 03 @ 19 @ Living kuchyně speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01306943&find_code=SYS&local_base=nkc
2004 @ 03 @ 18 @ Living koupelna speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01306948&find_code=SYS&local_base=nkc
2004 @ 03 @ 17 @ Level @ http://aleph.nkp.cz/F/?func=find-b&request=01307903&find_code=SYS&local_base=nkc
2004 @ 03 @ 16 @ Křížovky pro zdravý život speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01308341&find_code=SYS&local_base=nkc
2004 @ 03 @ 14 @ Informační servis @ http://aleph.nkp.cz/F/?func=find-b&request=01307955&find_code=SYS&local_base=nkc
2004 @ 03 @ 15 @ Karlovarský kraj @ http://aleph.nkp.cz/F/?func=find-b&request=01307548&find_code=SYS&local_base=nkc
2004 @ 03 @ 01 @ Archives of dermatology @ http://aleph.nkp.cz/F/?func=find-b&request=01307983&find_code=SYS&local_base=nkc
2004 @ 03 @ 02 @ Arteterapie @ http://aleph.nkp.cz/F/?func=find-b&request=01307977&find_code=SYS&local_base=nkc
2004 @ 03 @ 03 @ Avízo @ http://aleph.nkp.cz/F/?func=find-b&request=01307945&find_code=SYS&local_base=nkc
2004 @ 03 @ 04 @ Benešovský servis @ http://aleph.nkp.cz/F/?func=find-b&request=01307974&find_code=SYS&local_base=nkc
2004 @ 03 @ 05 @ BVV magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01307971&find_code=SYS&local_base=nkc
2004 @ 03 @ 06 @ Celebrity @ http://aleph.nkp.cz/F/?func=find-b&request=01306577&find_code=SYS&local_base=nkc
2004 @ 03 @ 07 @ Časopis pro děti a jejich rodiče @ http://aleph.nkp.cz/F/?func=find-b&request=01307343&find_code=SYS&local_base=nkc
2004 @ 03 @ 08 @ DINo @ http://aleph.nkp.cz/F/?func=find-b&request=01307937&find_code=SYS&local_base=nkc
2004 @ 03 @ 09 @ dok revue @ http://aleph.nkp.cz/F/?func=find-b&request=01307981&find_code=SYS&local_base=nkc
2004 @ 03 @ 10 @ Doubravický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01307939&find_code=SYS&local_base=nkc
2004 @ 03 @ 11 @ DVDMAG @ http://aleph.nkp.cz/F/?func=find-b&request=01307590&find_code=SYS&local_base=nkc
2004 @ 03 @ 13 @ Hvězdný víkend @ http://aleph.nkp.cz/F/?func=find-b&request=01305233&find_code=SYS&local_base=nkc
2004 @ 03 @ 12 @ forum @ http://aleph.nkp.cz/F/?func=find-b&request=01305609&find_code=SYS&local_base=nkc
2004 @ 03 @ 26 @ Play @ http://aleph.nkp.cz/F/?func=find-b&request=01309665&find_code=SYS&local_base=nkc
2004 @ 03 @ 27 @ Plzeňský kraj @ http://aleph.nkp.cz/F/?func=find-b&request=01308446&find_code=SYS&local_base=nkc
2004 @ 03 @ 28 @ Portál @ http://aleph.nkp.cz/F/?func=find-b&request=01308642&find_code=SYS&local_base=nkc
2004 @ 03 @ 29 @ Práce & sociální politika @ http://aleph.nkp.cz/F/?func=find-b&request=01305869&find_code=SYS&local_base=nkc
2004 @ 03 @ 30 @ Radniční listy @ http://aleph.nkp.cz/F/?func=find-b&request=01306035&find_code=SYS&local_base=nkc
2004 @ 03 @ 31 @ Realitní magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01307106&find_code=SYS&local_base=nkc
2004 @ 03 @ 32 @ Reklamní zpravodaj Info-Ježek @ http://aleph.nkp.cz/F/?func=find-b&request=01305478&find_code=SYS&local_base=nkc
2004 @ 03 @ 33 @ Rodinný dům @ http://aleph.nkp.cz/F/?func=find-b&request=01307110&find_code=SYS&local_base=nkc
2004 @ 03 @ 34 @ S přízí a háčkem @ http://aleph.nkp.cz/F/?func=find-b&request=01305463&find_code=SYS&local_base=nkc
2004 @ 03 @ 35 @ Sacra @ http://aleph.nkp.cz/F/?func=find-b&request=01308635&find_code=SYS&local_base=nkc
2004 @ 03 @ 36 @ Svět DVD @ http://aleph.nkp.cz/F/?func=find-b&request=01308810&find_code=SYS&local_base=nkc
2004 @ 03 @ 37 @ Školní sport @ http://aleph.nkp.cz/F/?func=find-b&request=01306328&find_code=SYS&local_base=nkc
2004 @ 03 @ 38 @ Top dívky @ http://aleph.nkp.cz/F/?func=find-b&request=01306022&find_code=SYS&local_base=nkc
2004 @ 03 @ 39 @ Viky @ http://aleph.nkp.cz/F/?func=find-b&request=01306898&find_code=SYS&local_base=nkc
2004 @ 03 @ 40 @ Výchovné poradenství @ http://aleph.nkp.cz/F/?func=find-b&request=01305489&find_code=SYS&local_base=nkc
2004 @ 03 @ 41 @ Zpravodaj (měsíčník Mnichova Hradiště) @ http://aleph.nkp.cz/F/?func=find-b&request=01308639&find_code=SYS&local_base=nkc
2004 @ 03 @ 42 @ Zpravodaj ČSCHMS @ http://aleph.nkp.cz/F/?func=find-b&request=01305225&find_code=SYS&local_base=nkc
2004 @ 04 @ 00 @ Aero Hobby @ http://aleph.nkp.cz/F/?func=find-b&request=01313885&find_code=SYS&local_base=nkc
2004 @ 04 @ 02 @ Agenda 12 @ http://aleph.nkp.cz/F/?func=find-b&request=01310025&find_code=SYS&local_base=nkc
2004 @ 04 @ 03 @ Akademický sport @ http://aleph.nkp.cz/F/?func=find-b&request=01309920&find_code=SYS&local_base=nkc
2004 @ 04 @ 04 @ Bezdězský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01313884&find_code=SYS&local_base=nkc
2004 @ 04 @ 05 @ Blesk pro ženy @ http://aleph.nkp.cz/F/?func=find-b&request=01313844&find_code=SYS&local_base=nkc
2004 @ 04 @ 06 @ Bukoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01309916&find_code=SYS&local_base=nkc
2004 @ 04 @ 07 @ Česká a slovenská hygiena @ http://aleph.nkp.cz/F/?func=find-b&request=01313713&find_code=SYS&local_base=nkc
2004 @ 04 @ 08 @ Digi @ http://aleph.nkp.cz/F/?func=find-b&request=01313871&find_code=SYS&local_base=nkc
2004 @ 04 @ 09 @ Domanínské novinky @ http://aleph.nkp.cz/F/?func=find-b&request=01309918&find_code=SYS&local_base=nkc
2004 @ 04 @ 10 @ Gymnasion @ http://aleph.nkp.cz/F/?func=find-b&request=01313873&find_code=SYS&local_base=nkc
2004 @ 04 @ 11 @ Hipo rehabilitace @ http://aleph.nkp.cz/F/?func=find-b&request=01309952&find_code=SYS&local_base=nkc
2004 @ 04 @ 12 @ Chbanské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01309921&find_code=SYS&local_base=nkc
2004 @ 04 @ 13 @ Informátor (KVIC Frýdek-Místek) @ http://aleph.nkp.cz/F/?func=find-b&request=01309825&find_code=SYS&local_base=nkc
2004 @ 04 @ 14 @ Informátor (KVIC Karviná) @ http://aleph.nkp.cz/F/?func=find-b&request=01310150&find_code=SYS&local_base=nkc
2004 @ 04 @ 15 @ In-store marketing @ http://aleph.nkp.cz/F/?func=find-b&request=01309955&find_code=SYS&local_base=nkc
2004 @ 04 @ 16 @ Kondracký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01309953&find_code=SYS&local_base=nkc
2004 @ 04 @ 17 @ Kraj Vysočina @ http://aleph.nkp.cz/F/?func=find-b&request=01310134&find_code=SYS&local_base=nkc
2004 @ 04 @ 18 @ Křížovky s bylinkami @ http://aleph.nkp.cz/F/?func=find-b&request=01310119&find_code=SYS&local_base=nkc
2004 @ 04 @ 19 @ Magazín (Sparta fotbal team) @ http://aleph.nkp.cz/F/?func=find-b&request=01309909&find_code=SYS&local_base=nkc
2004 @ 04 @ 20 @ Marianne bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=01313883&find_code=SYS&local_base=nkc
2004 @ 04 @ 21 @ Maxi obchodník @ http://aleph.nkp.cz/F/?func=find-b&request=01309946&find_code=SYS&local_base=nkc
2004 @ 04 @ 22 @ Miminko @ http://aleph.nkp.cz/F/?func=find-b&request=01309934&find_code=SYS&local_base=nkc
2004 @ 04 @ 23 @ Minerva @ http://aleph.nkp.cz/F/?func=find-b&request=01310155&find_code=SYS&local_base=nkc
2004 @ 04 @ 24 @ Myslivecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01310027&find_code=SYS&local_base=nkc
2004 @ 04 @ 25 @ Nedělní svět @ http://aleph.nkp.cz/F/?func=find-b&request=01313881&find_code=SYS&local_base=nkc
2004 @ 04 @ 26 @ Noviny českobudějovické radnice @ http://aleph.nkp.cz/F/?func=find-b&request=01310123&find_code=SYS&local_base=nkc
2004 @ 04 @ 27 @ Paseka @ http://aleph.nkp.cz/F/?func=find-b&request=01313191&find_code=SYS&local_base=nkc
2004 @ 04 @ 28 @ PHP solutions @ http://aleph.nkp.cz/F/?func=find-b&request=01312547&find_code=SYS&local_base=nkc
2004 @ 04 @ 29 @ Pojizerky @ http://aleph.nkp.cz/F/?func=find-b&request=01310108&find_code=SYS&local_base=nkc
2004 @ 04 @ 30 @ Raška @ http://aleph.nkp.cz/F/?func=find-b&request=01312836&find_code=SYS&local_base=nkc
2004 @ 04 @ 31 @ Ratibořský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01311142&find_code=SYS&local_base=nkc
2004 @ 04 @ 32 @ Real Moravia @ http://aleph.nkp.cz/F/?func=find-b&request=01311151&find_code=SYS&local_base=nkc
2004 @ 04 @ 33 @ Reload @ http://aleph.nkp.cz/F/?func=find-b&request=01311661&find_code=SYS&local_base=nkc
2004 @ 04 @ 34 @ Revue pro evropskou kulturu a náboženství @ http://aleph.nkp.cz/F/?func=find-b&request=01311652&find_code=SYS&local_base=nkc
2004 @ 04 @ 35 @ Rezidence @ http://aleph.nkp.cz/F/?func=find-b&request=01312067&find_code=SYS&local_base=nkc
2004 @ 04 @ 36 @ Robinson @ http://aleph.nkp.cz/F/?func=find-b&request=01310952&find_code=SYS&local_base=nkc
2004 @ 04 @ 37 @ Soubor trestních rozhodnutí Nejvyššího soudu @ http://aleph.nkp.cz/F/?func=find-b&request=01310371&find_code=SYS&local_base=nkc
2004 @ 04 @ 38 @ Stavebnictví v … @ http://aleph.nkp.cz/F/?func=find-b&request=01311230&find_code=SYS&local_base=nkc
2004 @ 04 @ 39 @ Stonávka @ http://aleph.nkp.cz/F/?func=find-b&request=01311218&find_code=SYS&local_base=nkc
2004 @ 04 @ 40 @ Stylová zahrada @ http://aleph.nkp.cz/F/?func=find-b&request=01312552&find_code=SYS&local_base=nkc
2004 @ 04 @ 41 @ Štěstí a nesnáze @ http://aleph.nkp.cz/F/?func=find-b&request=01310357&find_code=SYS&local_base=nkc
2004 @ 04 @ 42 @ Trendy v medicíně @ http://aleph.nkp.cz/F/?func=find-b&request=01311657&find_code=SYS&local_base=nkc
2004 @ 04 @ 43 @ Týden na severu @ http://aleph.nkp.cz/F/?func=find-b&request=01313195&find_code=SYS&local_base=nkc
2004 @ 04 @ 44 @ Úhonický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01311427&find_code=SYS&local_base=nkc
2004 @ 04 @ 45 @ Vestecké listy @ http://aleph.nkp.cz/F/?func=find-b&request=01311106&find_code=SYS&local_base=nkc
2004 @ 04 @ 46 @ Věstník vlády pro orgány krajů a orgány obcí @ http://aleph.nkp.cz/F/?func=find-b&request=01311975&find_code=SYS&local_base=nkc
2004 @ 04 @ 47 @ Veterinární klinika @ http://aleph.nkp.cz/F/?func=find-b&request=01312557&find_code=SYS&local_base=nkc
2004 @ 04 @ 48 @ Viza @ http://aleph.nkp.cz/F/?func=find-b&request=01308069&find_code=SYS&local_base=nkc
2004 @ 04 @ 49 @ Vnitřnost @ http://aleph.nkp.cz/F/?func=find-b&request=01311140&find_code=SYS&local_base=nkc
2004 @ 04 @ 50 @ Volná místa Havířov a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=01312839&find_code=SYS&local_base=nkc
2004 @ 04 @ 51 @ Zásmucký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01310937&find_code=SYS&local_base=nkc
2004 @ 04 @ 52 @ Zpravodaj českotřebovských živnostníků a podnikatelů @ http://aleph.nkp.cz/F/?func=find-b&request=01313040&find_code=SYS&local_base=nkc
2004 @ 04 @ 53 @ Zpravodaj Společnosti přátel Itálie @ http://aleph.nkp.cz/F/?func=find-b&request=01313039&find_code=SYS&local_base=nkc
2004 @ 04 @ 54 @ Žermanický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01290714&find_code=SYS&local_base=nkc
2004 @ 04 @ 55 @ ŽS Brno @ http://aleph.nkp.cz/F/?func=find-b&request=01312085&find_code=SYS&local_base=nkc
2004 @ 05 @ 00 @ Agrární obzor @ http://aleph.nkp.cz/F/?func=find-b&request=01315597&find_code=SYS&local_base=nkc
2004 @ 05 @ 02 @ Apetit @ http://aleph.nkp.cz/F/?func=find-b&request=01313990&find_code=SYS&local_base=nkc
2004 @ 05 @ 03 @ Arena @ http://aleph.nkp.cz/F/?func=find-b&request=01316113&find_code=SYS&local_base=nkc
2004 @ 05 @ 04 @ Auto 7 @ http://aleph.nkp.cz/F/?func=find-b&request=01315487&find_code=SYS&local_base=nkc
2004 @ 05 @ 05 @ Bazény a sauny @ http://aleph.nkp.cz/F/?func=find-b&request=01314857&find_code=SYS&local_base=nkc
2004 @ 05 @ 06 @ Bulletin IATCC @ http://aleph.nkp.cz/F/?func=find-b&request=01316089&find_code=SYS&local_base=nkc
2004 @ 05 @ 07 @ Byty a domy @ http://aleph.nkp.cz/F/?func=find-b&request=01316107&find_code=SYS&local_base=nkc
2004 @ 05 @ 08 @ Byty v Praze @ http://aleph.nkp.cz/F/?func=find-b&request=01316101&find_code=SYS&local_base=nkc
2004 @ 05 @ 09 @ Current opinion in allergy and clinical immunology @ http://aleph.nkp.cz/F/?func=find-b&request=01314051&find_code=SYS&local_base=nkc
2004 @ 05 @ 10 @ Current opinion in pulmonary medicine @ http://aleph.nkp.cz/F/?func=find-b&request=01314056&find_code=SYS&local_base=nkc
2004 @ 05 @ 11 @ Czech business forum @ http://aleph.nkp.cz/F/?func=find-b&request=01316124&find_code=SYS&local_base=nkc
2004 @ 05 @ 12 @ Děčínské avízo @ http://aleph.nkp.cz/F/?func=find-b&request=01316095&find_code=SYS&local_base=nkc
2004 @ 05 @ 13 @ Dialog.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01316084&find_code=SYS&local_base=nkc
2004 @ 05 @ 14 @ Dopravák @ http://aleph.nkp.cz/F/?func=find-b&request=01316116&find_code=SYS&local_base=nkc
2004 @ 05 @ 15 @ DPH aktuálně @ http://aleph.nkp.cz/F/?func=find-b&request=01315493&find_code=SYS&local_base=nkc
2004 @ 05 @ 16 @ Energie kolem nás @ http://aleph.nkp.cz/F/?func=find-b&request=01316097&find_code=SYS&local_base=nkc
2004 @ 05 @ 17 @ Expo @ http://aleph.nkp.cz/F/?func=find-b&request=01314047&find_code=SYS&local_base=nkc
2004 @ 05 @ 18 @ Hacking @ http://aleph.nkp.cz/F/?func=find-b&request=01316136&find_code=SYS&local_base=nkc
2004 @ 05 @ 19 @ Hrobický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01314033&find_code=SYS&local_base=nkc
2004 @ 05 @ 20 @ Hvozdnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01316083&find_code=SYS&local_base=nkc
2004 @ 05 @ 21 @ Judikatura Evropského soudního dvora @ http://aleph.nkp.cz/F/?func=find-b&request=01314059&find_code=SYS&local_base=nkc
2004 @ 05 @ 22 @ Kokoro @ http://aleph.nkp.cz/F/?func=find-b&request=01314016&find_code=SYS&local_base=nkc
2004 @ 05 @ 23 @ Lastauto omnibus @ http://aleph.nkp.cz/F/?func=find-b&request=01315483&find_code=SYS&local_base=nkc
2004 @ 05 @ 24 @ Lavetka @ http://aleph.nkp.cz/F/?func=find-b&request=01314843&find_code=SYS&local_base=nkc
2004 @ 05 @ 25 @ Lístky sedmikrásky @ http://aleph.nkp.cz/F/?func=find-b&request=01314027&find_code=SYS&local_base=nkc
2004 @ 05 @ 26 @ Luxury shopping guide @ http://aleph.nkp.cz/F/?func=find-b&request=01316148&find_code=SYS&local_base=nkc
2004 @ 05 @ 27 @ Magický svět @ http://aleph.nkp.cz/F/?func=find-b&request=01316092&find_code=SYS&local_base=nkc
2004 @ 05 @ 28 @ Měšický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01316120&find_code=SYS&local_base=nkc
2004 @ 05 @ 29 @ Moderní včelař @ http://aleph.nkp.cz/F/?func=find-b&request=01314837&find_code=SYS&local_base=nkc
2004 @ 05 @ 30 @ Náchodský posel @ http://aleph.nkp.cz/F/?func=find-b&request=01316123&find_code=SYS&local_base=nkc
2004 @ 05 @ 31 @ Okno okno @ http://aleph.nkp.cz/F/?func=find-b&request=01314694&find_code=SYS&local_base=nkc
2004 @ 05 @ 32 @ Podnikatelské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01314405&find_code=SYS&local_base=nkc
2004 @ 05 @ 33 @ Potštátské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01315966&find_code=SYS&local_base=nkc
2004 @ 05 @ 34 @ Professional computing @ http://aleph.nkp.cz/F/?func=find-b&request=01315344&find_code=SYS&local_base=nkc
2004 @ 05 @ 35 @ Reseller magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01315337&find_code=SYS&local_base=nkc
2004 @ 05 @ 36 @ Setkání - Stretnutie @ http://aleph.nkp.cz/F/?func=find-b&request=01314583&find_code=SYS&local_base=nkc
2004 @ 05 @ 37 @ Sign @ http://aleph.nkp.cz/F/?func=find-b&request=01314587&find_code=SYS&local_base=nkc
2004 @ 05 @ 38 @ Subterra @ http://aleph.nkp.cz/F/?func=find-b&request=01314696&find_code=SYS&local_base=nkc
2004 @ 05 @ 39 @ Svoboda zvířat @ http://aleph.nkp.cz/F/?func=find-b&request=01314401&find_code=SYS&local_base=nkc
2004 @ 05 @ 40 @ Svobodné Řepy @ http://aleph.nkp.cz/F/?func=find-b&request=01314581&find_code=SYS&local_base=nkc
2004 @ 05 @ 41 @ Zpravodaj SAM 78 @ http://aleph.nkp.cz/F/?func=find-b&request=01314397&find_code=SYS&local_base=nkc
2004 @ 06 @ 01 @ Advertip @ http://aleph.nkp.cz/F/?func=find-b&request=01324850&find_code=SYS&local_base=nkc
2004 @ 06 @ 02 @ Avízo reality @ http://aleph.nkp.cz/F/?func=find-b&request=01325188&find_code=SYS&local_base=nkc
2004 @ 06 @ 03 @ Broučci @ http://aleph.nkp.cz/F/?func=find-b&request=01367274&find_code=SYS&local_base=nkc
2004 @ 06 @ 04 @ Bruntálský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=01325396&find_code=SYS&local_base=nkc
2004 @ 06 @ 05 @ Cesty za poznáním @ http://aleph.nkp.cz/F/?func=find-b&request=01367297&find_code=SYS&local_base=nkc
2004 @ 06 @ 06 @ Halinatd @ http://aleph.nkp.cz/F/?func=find-b&request=01367262&find_code=SYS&local_base=nkc
2004 @ 06 @ 07 @ Havířovský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=01325404&find_code=SYS&local_base=nkc
2004 @ 06 @ 08 @ Já mám koně … @ http://aleph.nkp.cz/F/?func=find-b&request=01326062&find_code=SYS&local_base=nkc
2004 @ 06 @ 09 @ Kamenecké listy @ http://aleph.nkp.cz/F/?func=find-b&request=01326053&find_code=SYS&local_base=nkc
2004 @ 06 @ 10 @ Karvinský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=01325406&find_code=SYS&local_base=nkc
2004 @ 06 @ 11 @ Klíčová dírka @ http://aleph.nkp.cz/F/?func=find-b&request=01325390&find_code=SYS&local_base=nkc
2004 @ 06 @ 12 @ Kotnov @ http://aleph.nkp.cz/F/?func=find-b&request=01326056&find_code=SYS&local_base=nkc
2004 @ 06 @ 13 @ Krnovský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=01325392&find_code=SYS&local_base=nkc
2004 @ 06 @ 14 @ Krumsínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01326050&find_code=SYS&local_base=nkc
2004 @ 06 @ 15 @ Křížovky na ex! @ http://aleph.nkp.cz/F/?func=find-b&request=01326802&find_code=SYS&local_base=nkc
2004 @ 06 @ 16 @ Kupa křížovek @ http://aleph.nkp.cz/F/?func=find-b&request=01326795&find_code=SYS&local_base=nkc
2004 @ 06 @ 17 @ Kupa osmisměrek @ http://aleph.nkp.cz/F/?func=find-b&request=01326793&find_code=SYS&local_base=nkc
2004 @ 06 @ 18 @ Lipnické panorama @ http://aleph.nkp.cz/F/?func=find-b&request=01326049&find_code=SYS&local_base=nkc
2004 @ 06 @ 19 @ Luštění na každý den @ http://aleph.nkp.cz/F/?func=find-b&request=01326801&find_code=SYS&local_base=nkc
2004 @ 06 @ 20 @ Luštění o Kanáry @ http://aleph.nkp.cz/F/?func=find-b&request=01326750&find_code=SYS&local_base=nkc
2004 @ 06 @ 21 @ Luštění pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=01326799&find_code=SYS&local_base=nkc
2004 @ 06 @ 22 @ Luštění pro každou chvíli @ http://aleph.nkp.cz/F/?func=find-b&request=01326789&find_code=SYS&local_base=nkc
2004 @ 06 @ 23 @ Luštění za bůra @ http://aleph.nkp.cz/F/?func=find-b&request=01326794&find_code=SYS&local_base=nkc
2004 @ 06 @ 24 @ Měnínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01326916&find_code=SYS&local_base=nkc
2004 @ 06 @ 25 @ Novojičínský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=01326167&find_code=SYS&local_base=nkc
2004 @ 06 @ 26 @ Obchodní týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=01324831&find_code=SYS&local_base=nkc
2004 @ 06 @ 27 @ Obřííí osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=01326804&find_code=SYS&local_base=nkc
2004 @ 06 @ 28 @ Obzory @ http://aleph.nkp.cz/F/?func=find-b&request=01324826&find_code=SYS&local_base=nkc
2004 @ 06 @ 29 @ Okénko @ http://aleph.nkp.cz/F/?func=find-b&request=01367294&find_code=SYS&local_base=nkc
2004 @ 06 @ 30 @ Osmisměrky pro odvážné @ http://aleph.nkp.cz/F/?func=find-b&request=01326791&find_code=SYS&local_base=nkc
2004 @ 06 @ 31 @ Paprsky Milosrdného Ježíše @ http://aleph.nkp.cz/F/?func=find-b&request=01316394&find_code=SYS&local_base=nkc
2004 @ 06 @ 32 @ Partžurnál @ http://aleph.nkp.cz/F/?func=find-b&request=01325233&find_code=SYS&local_base=nkc
2004 @ 06 @ 33 @ Pediatrie po promoci @ http://aleph.nkp.cz/F/?func=find-b&request=01367303&find_code=SYS&local_base=nkc
2004 @ 06 @ 34 @ Plzeňská jednička @ http://aleph.nkp.cz/F/?func=find-b&request=01325384&find_code=SYS&local_base=nkc
2004 @ 06 @ 35 @ Real-city @ http://aleph.nkp.cz/F/?func=find-b&request=01326922&find_code=SYS&local_base=nkc
2004 @ 06 @ 36 @ Řícmanický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01326783&find_code=SYS&local_base=nkc
2004 @ 06 @ 37 @ Sexy luštění @ http://aleph.nkp.cz/F/?func=find-b&request=01326745&find_code=SYS&local_base=nkc
2004 @ 06 @ 38 @ Snadné luštění @ http://aleph.nkp.cz/F/?func=find-b&request=01326756&find_code=SYS&local_base=nkc
2004 @ 06 @ 39 @ Soubor civilních rozhodnutí Nejvyššího soudu @ http://aleph.nkp.cz/F/?func=find-b&request=01324858&find_code=SYS&local_base=nkc
2004 @ 06 @ 40 @ Společenství @ http://aleph.nkp.cz/F/?func=find-b&request=01367302&find_code=SYS&local_base=nkc
2004 @ 06 @ 41 @ Stoma tip @ http://aleph.nkp.cz/F/?func=find-b&request=01324829&find_code=SYS&local_base=nkc
2004 @ 06 @ 42 @ Temple @ http://aleph.nkp.cz/F/?func=find-b&request=01326158&find_code=SYS&local_base=nkc
2004 @ 06 @ 43 @ Tvořivý amos @ http://aleph.nkp.cz/F/?func=find-b&request=01326944&find_code=SYS&local_base=nkc
2004 @ 06 @ 44 @ Varex magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01317588&find_code=SYS&local_base=nkc
2004 @ 06 @ 45 @ Věstník MMR ČR @ http://aleph.nkp.cz/F/?func=find-b&request=01316509&find_code=SYS&local_base=nkc
2004 @ 06 @ 46 @ Vodní revue @ http://aleph.nkp.cz/F/?func=find-b&request=01324842&find_code=SYS&local_base=nkc
2004 @ 06 @ 47 @ Zpravodaj Jihočeské hospodářské komory @ http://aleph.nkp.cz/F/?func=find-b&request=01317609&find_code=SYS&local_base=nkc
2004 @ 06 @ 48 @ Zpravodaj obce Nová Hradečná @ http://aleph.nkp.cz/F/?func=find-b&request=01325236&find_code=SYS&local_base=nkc
2004 @ 06 @ 49 @ Zpravodaj obce Strunkovice nad Blanicí @ http://aleph.nkp.cz/F/?func=find-b&request=01315223&find_code=SYS&local_base=nkc
2004 @ 06 @ 50 @ Zpravodaj obcí Kunice@ Vidovice, Všešimy, Dolní a Horní Lomnice', 'http://aleph.nkp.cz/F/?func=find-b&request=01367305&find_code=SYS&local_base=nkc
2004 @ 06 @ 51 @ Zpravodaj opozice Rady města Frýdek-Místek @ http://aleph.nkp.cz/F/?func=find-b&request=01326786&find_code=SYS&local_base=nkc
2004 @ 06 @ 52 @ Zpravodaj pedagogicko-psychologické poradenství @ http://aleph.nkp.cz/F/?func=find-b&request=01326762&find_code=SYS&local_base=nkc
2004 @ 06 @ 53 @ Žijeme na plný plyn @ http://aleph.nkp.cz/F/?func=find-b&request=01367283&find_code=SYS&local_base=nkc
2004 @ 07 @ 01 @ Auspicia @ http://aleph.nkp.cz/F/?func=find-b&request=01410771&find_code=SYS&local_base=nkc
2004 @ 07 @ 02 @ Auta shop @ http://aleph.nkp.cz/F/?func=find-b&request=01414575&find_code=SYS&local_base=nkc
2004 @ 07 @ 03 @ Auto Data & News @ http://aleph.nkp.cz/F/?func=find-b&request=01414608&find_code=SYS&local_base=nkc
2004 @ 07 @ 04 @ Auto moto speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01409877&find_code=SYS&local_base=nkc
2004 @ 07 @ 05 @ Babyka @ http://aleph.nkp.cz/F/?func=find-b&request=01414440&find_code=SYS&local_base=nkc
2004 @ 07 @ 06 @ Bulletin Gynstart @ http://aleph.nkp.cz/F/?func=find-b&request=01414589&find_code=SYS&local_base=nkc
2004 @ 07 @ 07 @ Bydlení na Vysočině @ http://aleph.nkp.cz/F/?func=find-b&request=01414392&find_code=SYS&local_base=nkc
2004 @ 07 @ 08 @ Co s načatým večerem @ http://aleph.nkp.cz/F/?func=find-b&request=01411062&find_code=SYS&local_base=nkc
2004 @ 07 @ 09 @ Controller news @ http://aleph.nkp.cz/F/?func=find-b&request=01414612&find_code=SYS&local_base=nkc
2004 @ 07 @ 10 @ Časopis podnikatelů @ http://aleph.nkp.cz/F/?func=find-b&request=01414593&find_code=SYS&local_base=nkc
2004 @ 07 @ 11 @ Digitální video @ http://aleph.nkp.cz/F/?func=find-b&request=01368051&find_code=SYS&local_base=nkc
2004 @ 07 @ 12 @ Evropské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01414434&find_code=SYS&local_base=nkc
2004 @ 07 @ 13 @ Farní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01367914&find_code=SYS&local_base=nkc
2004 @ 07 @ 14 @ Florbalnoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01414572&find_code=SYS&local_base=nkc
2004 @ 07 @ 15 @ Fondy EU @ http://aleph.nkp.cz/F/?func=find-b&request=01414404&find_code=SYS&local_base=nkc
2004 @ 07 @ 16 @ Formule Bosh @ http://aleph.nkp.cz/F/?func=find-b&request=01409584&find_code=SYS&local_base=nkc
2004 @ 07 @ 17 @ Fotbal v kraji @ http://aleph.nkp.cz/F/?func=find-b&request=01413401&find_code=SYS&local_base=nkc
2004 @ 07 @ 18 @ Frenštátský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01414452&find_code=SYS&local_base=nkc
2004 @ 07 @ 19 @ Galerie @ http://aleph.nkp.cz/F/?func=find-b&request=01414599&find_code=SYS&local_base=nkc
2004 @ 07 @ 20 @ Geo informace @ http://aleph.nkp.cz/F/?func=find-b&request=01411272&find_code=SYS&local_base=nkc
2004 @ 07 @ 21 @ GoCanada @ http://aleph.nkp.cz/F/?func=find-b&request=01414597&find_code=SYS&local_base=nkc
2004 @ 07 @ 22 @ Hornobřízský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01414417&find_code=SYS&local_base=nkc
2004 @ 07 @ 23 @ Hospodář @ http://aleph.nkp.cz/F/?func=find-b&request=01409872&find_code=SYS&local_base=nkc
2004 @ 07 @ 24 @ Hrdějovické listy @ http://aleph.nkp.cz/F/?func=find-b&request=01414603&find_code=SYS&local_base=nkc
2004 @ 07 @ 25 @ Informační list (Ekologický právní servis) @ http://aleph.nkp.cz/F/?func=find-b&request=01409861&find_code=SYS&local_base=nkc
2004 @ 07 @ 26 @ Informátor (OÚ Horní Domaslavice) @ http://aleph.nkp.cz/F/?func=find-b&request=01413219&find_code=SYS&local_base=nkc
2004 @ 07 @ 27 @ Infozpravodaj (Informační centrum o hluchotě FRPSP) @ http://aleph.nkp.cz/F/?func=find-b&request=01413294&find_code=SYS&local_base=nkc
2004 @ 07 @ 28 @ Jídelníček podle hvězd @ http://aleph.nkp.cz/F/?func=find-b&request=01411735&find_code=SYS&local_base=nkc
2004 @ 07 @ 29 @ Jihočeský Herold @ http://aleph.nkp.cz/F/?func=find-b&request=01409868&find_code=SYS&local_base=nkc
2004 @ 07 @ 30 @ Jihomoravské ekolisty @ http://aleph.nkp.cz/F/?func=find-b&request=01410767&find_code=SYS&local_base=nkc
2004 @ 07 @ 31 @ Kazuistiky v pneumologii @ http://aleph.nkp.cz/F/?func=find-b&request=01411410&find_code=SYS&local_base=nkc
2004 @ 07 @ 32 @ Krajánek @ http://aleph.nkp.cz/F/?func=find-b&request=01409407&find_code=SYS&local_base=nkc
2004 @ 07 @ 33 @ Krasničan @ http://aleph.nkp.cz/F/?func=find-b&request=01409873&find_code=SYS&local_base=nkc
2004 @ 07 @ 34 @ Kraťas @ http://aleph.nkp.cz/F/?func=find-b&request=01414637&find_code=SYS&local_base=nkc
2004 @ 07 @ 35 @ Křížovkářské policejní humoresky @ http://aleph.nkp.cz/F/?func=find-b&request=01413403&find_code=SYS&local_base=nkc
2004 @ 07 @ 36 @ Křížovkářské sexy noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01368055&find_code=SYS&local_base=nkc
2004 @ 07 @ 37 @ Křížovky lásky… @ http://aleph.nkp.cz/F/?func=find-b&request=01368038&find_code=SYS&local_base=nkc
2004 @ 07 @ 38 @ Křížovky od Křižáka @ http://aleph.nkp.cz/F/?func=find-b&request=01411726&find_code=SYS&local_base=nkc
2004 @ 07 @ 39 @ Liberecký kraj @ http://aleph.nkp.cz/F/?func=find-b&request=01414407&find_code=SYS&local_base=nkc
2004 @ 07 @ 40 @ Literární novinky @ http://aleph.nkp.cz/F/?func=find-b&request=01409875&find_code=SYS&local_base=nkc
2004 @ 07 @ 41 @ Morávka @ http://aleph.nkp.cz/F/?func=find-b&request=01414414&find_code=SYS&local_base=nkc
2004 @ 07 @ 42 @ Náš Cetelem @ http://aleph.nkp.cz/F/?func=find-b&request=01414621&find_code=SYS&local_base=nkc
2004 @ 07 @ 43 @ Naše společnost @ http://aleph.nkp.cz/F/?func=find-b&request=01414581&find_code=SYS&local_base=nkc
2004 @ 07 @ 44 @ Nemovitosti @ http://aleph.nkp.cz/F/?func=find-b&request=01414598&find_code=SYS&local_base=nkc
2004 @ 07 @ 45 @ Nesovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01414604&find_code=SYS&local_base=nkc
2004 @ 07 @ 46 @ Obzor @ http://aleph.nkp.cz/F/?func=find-b&request=01368065&find_code=SYS&local_base=nkc
2004 @ 07 @ 47 @ P&G Rakona listy @ http://aleph.nkp.cz/F/?func=find-b&request=01411449&find_code=SYS&local_base=nkc
2004 @ 07 @ 48 @ Papoušek @ http://aleph.nkp.cz/F/?func=find-b&request=01414446&find_code=SYS&local_base=nkc
2004 @ 07 @ 49 @ Plus pro zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01410153&find_code=SYS&local_base=nkc
2004 @ 07 @ 50 @ Prague club magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01367915&find_code=SYS&local_base=nkc
2004 @ 07 @ 51 @ Prague medical report @ http://aleph.nkp.cz/F/?func=find-b&request=01414444&find_code=SYS&local_base=nkc
2004 @ 07 @ 52 @ Právní fórum @ http://aleph.nkp.cz/F/?func=find-b&request=01413872&find_code=SYS&local_base=nkc
2004 @ 07 @ 53 @ Prvňáček @ http://aleph.nkp.cz/F/?func=find-b&request=01367895&find_code=SYS&local_base=nkc
2004 @ 07 @ 54 @ Pryskoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01413225&find_code=SYS&local_base=nkc
2004 @ 07 @ 55 @ Příchovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01410097&find_code=SYS&local_base=nkc
2004 @ 07 @ 56 @ Přímá cesta @ http://aleph.nkp.cz/F/?func=find-b&request=01413237&find_code=SYS&local_base=nkc
2004 @ 07 @ 57 @ Real-city (jižní a střední Morava) @ http://aleph.nkp.cz/F/?func=find-b&request=01411731&find_code=SYS&local_base=nkc
2004 @ 07 @ 58 @ Reality-foto @ http://aleph.nkp.cz/F/?func=find-b&request=01409878&find_code=SYS&local_base=nkc
2004 @ 07 @ 59 @ Revital @ http://aleph.nkp.cz/F/?func=find-b&request=01367910&find_code=SYS&local_base=nkc
2004 @ 07 @ 60 @ Safari @ http://aleph.nkp.cz/F/?func=find-b&request=01414447&find_code=SYS&local_base=nkc
2004 @ 07 @ 61 @ Sazovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01410107&find_code=SYS&local_base=nkc
2004 @ 07 @ 62 @ Sociální demokracie @ http://aleph.nkp.cz/F/?func=find-b&request=01411729&find_code=SYS&local_base=nkc
2004 @ 07 @ 63 @ Soused z Prahy 6 @ http://aleph.nkp.cz/F/?func=find-b&request=01367869&find_code=SYS&local_base=nkc
2004 @ 07 @ 64 @ Statistický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01414380&find_code=SYS&local_base=nkc
2004 @ 07 @ 65 @ Stavíme domov @ http://aleph.nkp.cz/F/?func=find-b&request=01410113&find_code=SYS&local_base=nkc
2004 @ 07 @ 66 @ Století fotbalu @ http://aleph.nkp.cz/F/?func=find-b&request=01410164&find_code=SYS&local_base=nkc
2004 @ 07 @ 67 @ SuperStar @ http://aleph.nkp.cz/F/?func=find-b&request=01411738&find_code=SYS&local_base=nkc
2004 @ 07 @ 68 @ Svět strojírenské techniky @ http://aleph.nkp.cz/F/?func=find-b&request=01411453&find_code=SYS&local_base=nkc
2004 @ 07 @ 69 @ Svět velké i malé železnice @ http://aleph.nkp.cz/F/?func=find-b&request=01368062&find_code=SYS&local_base=nkc
2004 @ 07 @ 70 @ Teplický servis @ http://aleph.nkp.cz/F/?func=find-b&request=01414373&find_code=SYS&local_base=nkc
2004 @ 07 @ 71 @ Tomík @ http://aleph.nkp.cz/F/?func=find-b&request=01410368&find_code=SYS&local_base=nkc
2004 @ 07 @ 72 @ TRCZ bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=01410089&find_code=SYS&local_base=nkc
2004 @ 07 @ 73 @ Ústecký týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=01413311&find_code=SYS&local_base=nkc
2004 @ 07 @ 74 @ Vinohradský inform @ http://aleph.nkp.cz/F/?func=find-b&request=01413228&find_code=SYS&local_base=nkc
2004 @ 07 @ 75 @ Yop! @ http://aleph.nkp.cz/F/?func=find-b&request=01413301&find_code=SYS&local_base=nkc
2004 @ 07 @ 76 @ Zpravodaj (Investiční společnost České spořitelny) @ http://aleph.nkp.cz/F/?func=find-b&request=01409397&find_code=SYS&local_base=nkc
2004 @ 07 @ 77 @ Zpravodaj českého camphillu @ http://aleph.nkp.cz/F/?func=find-b&request=01411422&find_code=SYS&local_base=nkc
2004 @ 07 @ 78 @ Zpravodaj obce Těšetice @ http://aleph.nkp.cz/F/?func=find-b&request=01411434&find_code=SYS&local_base=nkc
2004 @ 07 @ 79 @ Zpravodaj pro členy družstava Pokrok @ http://aleph.nkp.cz/F/?func=find-b&request=01414385&find_code=SYS&local_base=nkc
2004 @ 08 @ 01 @ Auspicia @ http://aleph.nkp.cz/F/?func=find-b&request=01410771&find_code=SYS&local_base=nkc
2004 @ 08 @ 02 @ Auta shop @ http://aleph.nkp.cz/F/?func=find-b&request=01414575&find_code=SYS&local_base=nkc
2004 @ 08 @ 03 @ Auto Data & News @ http://aleph.nkp.cz/F/?func=find-b&request=01414608&find_code=SYS&local_base=nkc
2004 @ 08 @ 04 @ Auto moto speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01409877&find_code=SYS&local_base=nkc
2004 @ 08 @ 05 @ Babyka @ http://aleph.nkp.cz/F/?func=find-b&request=01414440&find_code=SYS&local_base=nkc
2004 @ 08 @ 06 @ Bulletin Gynstart @ http://aleph.nkp.cz/F/?func=find-b&request=01414589&find_code=SYS&local_base=nkc
2004 @ 08 @ 07 @ Bydlení na Vysočině @ http://aleph.nkp.cz/F/?func=find-b&request=01414392&find_code=SYS&local_base=nkc
2004 @ 08 @ 08 @ Co s načatým večerem @ http://aleph.nkp.cz/F/?func=find-b&request=01411062&find_code=SYS&local_base=nkc
2004 @ 08 @ 09 @ Controller news @ http://aleph.nkp.cz/F/?func=find-b&request=01414612&find_code=SYS&local_base=nkc
2004 @ 08 @ 10 @ Časopis podnikatelů @ http://aleph.nkp.cz/F/?func=find-b&request=01414593&find_code=SYS&local_base=nkc
2004 @ 08 @ 11 @ Digitální video @ http://aleph.nkp.cz/F/?func=find-b&request=01368051&find_code=SYS&local_base=nkc
2004 @ 08 @ 12 @ Evropské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01414434&find_code=SYS&local_base=nkc
2004 @ 08 @ 13 @ Farní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01367914&find_code=SYS&local_base=nkc
2004 @ 08 @ 14 @ Florbalnoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01414572&find_code=SYS&local_base=nkc
2004 @ 08 @ 15 @ Fondy EU @ http://aleph.nkp.cz/F/?func=find-b&request=01414404&find_code=SYS&local_base=nkc
2004 @ 08 @ 16 @ Formule Bosh @ http://aleph.nkp.cz/F/?func=find-b&request=01409584&find_code=SYS&local_base=nkc
2004 @ 08 @ 17 @ Fotbal v kraji @ http://aleph.nkp.cz/F/?func=find-b&request=01413401&find_code=SYS&local_base=nkc
2004 @ 08 @ 18 @ Frenštátský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01414452&find_code=SYS&local_base=nkc
2004 @ 08 @ 19 @ Galerie @ http://aleph.nkp.cz/F/?func=find-b&request=01414599&find_code=SYS&local_base=nkc
2004 @ 08 @ 20 @ Geo informace @ http://aleph.nkp.cz/F/?func=find-b&request=01411272&find_code=SYS&local_base=nkc
2004 @ 08 @ 21 @ GoCanada @ http://aleph.nkp.cz/F/?func=find-b&request=01414597&find_code=SYS&local_base=nkc
2004 @ 08 @ 22 @ Hornobřízský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01414417&find_code=SYS&local_base=nkc
2004 @ 08 @ 23 @ Hospodář @ http://aleph.nkp.cz/F/?func=find-b&request=01409872&find_code=SYS&local_base=nkc
2004 @ 08 @ 24 @ Hrdějovické listy @ http://aleph.nkp.cz/F/?func=find-b&request=01414603&find_code=SYS&local_base=nkc
2004 @ 08 @ 25 @ Informační list (Ekologický právní servis) @ http://aleph.nkp.cz/F/?func=find-b&request=01409861&find_code=SYS&local_base=nkc
2004 @ 08 @ 26 @ Informátor (OÚ Horní Domaslavice) @ http://aleph.nkp.cz/F/?func=find-b&request=01413219&find_code=SYS&local_base=nkc
2004 @ 08 @ 27 @ Infozpravodaj (Informační centrum o hluchotě FRPSP) @ http://aleph.nkp.cz/F/?func=find-b&request=01413294&find_code=SYS&local_base=nkc
2004 @ 08 @ 28 @ Jídelníček podle hvězd @ http://aleph.nkp.cz/F/?func=find-b&request=01411735&find_code=SYS&local_base=nkc
2004 @ 08 @ 29 @ Jihočeský Herold @ http://aleph.nkp.cz/F/?func=find-b&request=01409868&find_code=SYS&local_base=nkc
2004 @ 08 @ 30 @ Jihomoravské ekolisty @ http://aleph.nkp.cz/F/?func=find-b&request=01410767&find_code=SYS&local_base=nkc
2004 @ 08 @ 31 @ Kazuistiky v pneumologii @ http://aleph.nkp.cz/F/?func=find-b&request=01411410&find_code=SYS&local_base=nkc
2004 @ 08 @ 32 @ Krajánek @ http://aleph.nkp.cz/F/?func=find-b&request=01409407&find_code=SYS&local_base=nkc
2004 @ 08 @ 33 @ Krasničan @ http://aleph.nkp.cz/F/?func=find-b&request=01409873&find_code=SYS&local_base=nkc
2004 @ 08 @ 34 @ Kraťas @ http://aleph.nkp.cz/F/?func=find-b&request=01414637&find_code=SYS&local_base=nkc
2004 @ 08 @ 35 @ Křížovkářské policejní humoresky @ http://aleph.nkp.cz/F/?func=find-b&request=01413403&find_code=SYS&local_base=nkc
2004 @ 08 @ 36 @ Křížovkářské sexy noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01368055&find_code=SYS&local_base=nkc
2004 @ 08 @ 37 @ Křížovky lásky… @ http://aleph.nkp.cz/F/?func=find-b&request=01368038&find_code=SYS&local_base=nkc
2004 @ 08 @ 38 @ Křížovky od Křižáka @ http://aleph.nkp.cz/F/?func=find-b&request=01411726&find_code=SYS&local_base=nkc
2004 @ 08 @ 39 @ Liberecký kraj @ http://aleph.nkp.cz/F/?func=find-b&request=01414407&find_code=SYS&local_base=nkc
2004 @ 08 @ 40 @ Literární novinky @ http://aleph.nkp.cz/F/?func=find-b&request=01409875&find_code=SYS&local_base=nkc
2004 @ 08 @ 41 @ Morávka @ http://aleph.nkp.cz/F/?func=find-b&request=01414414&find_code=SYS&local_base=nkc
2004 @ 08 @ 42 @ Náš Cetelem @ http://aleph.nkp.cz/F/?func=find-b&request=01414621&find_code=SYS&local_base=nkc
2004 @ 08 @ 43 @ Naše společnost @ http://aleph.nkp.cz/F/?func=find-b&request=01414581&find_code=SYS&local_base=nkc
2004 @ 08 @ 44 @ Nemovitosti @ http://aleph.nkp.cz/F/?func=find-b&request=01414598&find_code=SYS&local_base=nkc
2004 @ 08 @ 45 @ Nesovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01414604&find_code=SYS&local_base=nkc
2004 @ 08 @ 46 @ Obzor @ http://aleph.nkp.cz/F/?func=find-b&request=01368065&find_code=SYS&local_base=nkc
2004 @ 08 @ 47 @ P&G Rakona listy @ http://aleph.nkp.cz/F/?func=find-b&request=01411449&find_code=SYS&local_base=nkc
2004 @ 08 @ 48 @ Papoušek @ http://aleph.nkp.cz/F/?func=find-b&request=01414446&find_code=SYS&local_base=nkc
2004 @ 08 @ 49 @ Plus pro zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01410153&find_code=SYS&local_base=nkc
2004 @ 08 @ 50 @ Prague club magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01367915&find_code=SYS&local_base=nkc
2004 @ 08 @ 51 @ Prague medical report @ http://aleph.nkp.cz/F/?func=find-b&request=01414444&find_code=SYS&local_base=nkc
2004 @ 08 @ 52 @ Právní fórum @ http://aleph.nkp.cz/F/?func=find-b&request=01413872&find_code=SYS&local_base=nkc
2004 @ 08 @ 53 @ Prvňáček @ http://aleph.nkp.cz/F/?func=find-b&request=01367895&find_code=SYS&local_base=nkc
2004 @ 08 @ 54 @ Pryskoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01413225&find_code=SYS&local_base=nkc
2004 @ 08 @ 55 @ Příchovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01410097&find_code=SYS&local_base=nkc
2004 @ 08 @ 56 @ Přímá cesta @ http://aleph.nkp.cz/F/?func=find-b&request=01413237&find_code=SYS&local_base=nkc
2004 @ 08 @ 57 @ Real-city (jižní a střední Morava) @ http://aleph.nkp.cz/F/?func=find-b&request=01411731&find_code=SYS&local_base=nkc
2004 @ 08 @ 58 @ Reality-foto @ http://aleph.nkp.cz/F/?func=find-b&request=01409878&find_code=SYS&local_base=nkc
2004 @ 08 @ 59 @ Revital @ http://aleph.nkp.cz/F/?func=find-b&request=01367910&find_code=SYS&local_base=nkc
2004 @ 08 @ 60 @ Safari @ http://aleph.nkp.cz/F/?func=find-b&request=01414447&find_code=SYS&local_base=nkc
2004 @ 08 @ 61 @ Sazovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01410107&find_code=SYS&local_base=nkc
2004 @ 08 @ 62 @ Sociální demokracie @ http://aleph.nkp.cz/F/?func=find-b&request=01411729&find_code=SYS&local_base=nkc
2004 @ 08 @ 63 @ Soused z Prahy 6 @ http://aleph.nkp.cz/F/?func=find-b&request=01367869&find_code=SYS&local_base=nkc
2004 @ 08 @ 64 @ Statistický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01414380&find_code=SYS&local_base=nkc
2004 @ 08 @ 65 @ Stavíme domov @ http://aleph.nkp.cz/F/?func=find-b&request=01410113&find_code=SYS&local_base=nkc
2004 @ 08 @ 66 @ Století fotbalu @ http://aleph.nkp.cz/F/?func=find-b&request=01410164&find_code=SYS&local_base=nkc
2004 @ 08 @ 67 @ SuperStar @ http://aleph.nkp.cz/F/?func=find-b&request=01411738&find_code=SYS&local_base=nkc
2004 @ 08 @ 68 @ Svět strojírenské techniky @ http://aleph.nkp.cz/F/?func=find-b&request=01411453&find_code=SYS&local_base=nkc
2004 @ 08 @ 69 @ Svět velké i malé železnice @ http://aleph.nkp.cz/F/?func=find-b&request=01368062&find_code=SYS&local_base=nkc
2004 @ 08 @ 70 @ Teplický servis @ http://aleph.nkp.cz/F/?func=find-b&request=01414373&find_code=SYS&local_base=nkc
2004 @ 08 @ 71 @ Tomík @ http://aleph.nkp.cz/F/?func=find-b&request=01410368&find_code=SYS&local_base=nkc
2004 @ 08 @ 72 @ TRCZ bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=01410089&find_code=SYS&local_base=nkc
2004 @ 08 @ 73 @ Ústecký týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=01413311&find_code=SYS&local_base=nkc
2004 @ 08 @ 74 @ Vinohradský inform @ http://aleph.nkp.cz/F/?func=find-b&request=01413228&find_code=SYS&local_base=nkc
2004 @ 08 @ 75 @ Yop! @ http://aleph.nkp.cz/F/?func=find-b&request=01413301&find_code=SYS&local_base=nkc
2004 @ 08 @ 76 @ Zpravodaj (Investiční společnost České spořitelny) @ http://aleph.nkp.cz/F/?func=find-b&request=01409397&find_code=SYS&local_base=nkc
2004 @ 08 @ 77 @ Zpravodaj českého camphillu @ http://aleph.nkp.cz/F/?func=find-b&request=01411422&find_code=SYS&local_base=nkc
2004 @ 08 @ 78 @ Zpravodaj obce Těšetice @ http://aleph.nkp.cz/F/?func=find-b&request=01411434&find_code=SYS&local_base=nkc
2004 @ 08 @ 79 @ Zpravodaj pro členy družstava Pokrok @ http://aleph.nkp.cz/F/?func=find-b&request=01414385&find_code=SYS&local_base=nkc
2004 @ 09 @ 01 @ 51 pro @ http://aleph.nkp.cz/F/?func=find-b&request=01414726&find_code=SYS&local_base=nkc
2004 @ 09 @ 02 @ Alternativa @ http://aleph.nkp.cz/F/?func=find-b&request=01417543&find_code=SYS&local_base=nkc
2004 @ 09 @ 03 @ AUA update series @ http://aleph.nkp.cz/F/?func=find-b&request=01414919&find_code=SYS&local_base=nkc
2004 @ 09 @ 04 @ Bulletin informační medicíny @ http://aleph.nkp.cz/F/?func=find-b&request=01414910&find_code=SYS&local_base=nkc
2004 @ 09 @ 05 @ Czech business weekly @ http://aleph.nkp.cz/F/?func=find-b&request=01416984&find_code=SYS&local_base=nkc
2004 @ 09 @ 06 @ Českotěšínský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=01416944&find_code=SYS&local_base=nkc
2004 @ 09 @ 07 @ Daně v podnikání aktuálně @ http://aleph.nkp.cz/F/?func=find-b&request=01414657&find_code=SYS&local_base=nkc
2004 @ 09 @ 08 @ Dějiny-teorie-kritika @ http://aleph.nkp.cz/F/?func=find-b&request=01416978&find_code=SYS&local_base=nkc
2004 @ 09 @ 09 @ Echo (Technolgické centrum AV ČR) @ http://aleph.nkp.cz/F/?func=find-b&request=01415931&find_code=SYS&local_base=nkc
2004 @ 09 @ 10 @ Echo (T-Mobile) @ http://aleph.nkp.cz/F/?func=find-b&request=01414904&find_code=SYS&local_base=nkc
2004 @ 09 @ 11 @ Filmové listy @ http://aleph.nkp.cz/F/?func=find-b&request=01417633&find_code=SYS&local_base=nkc
2004 @ 09 @ 12 @ Katolík @ http://aleph.nkp.cz/F/?func=find-b&request=01415533&find_code=SYS&local_base=nkc
2004 @ 09 @ 13 @ Křížovkářské horoskopičiny @ http://aleph.nkp.cz/F/?func=find-b&request=01416947&find_code=SYS&local_base=nkc
2004 @ 09 @ 14 @ Kukátko do Charity Hlučín @ http://aleph.nkp.cz/F/?func=find-b&request=01414644&find_code=SYS&local_base=nkc
2004 @ 09 @ 15 @ Kulturní měsíčník města Mladé Boleslavi @ http://aleph.nkp.cz/F/?func=find-b&request=01414906&find_code=SYS&local_base=nkc
2004 @ 09 @ 16 @ Mladý sběratel @ http://aleph.nkp.cz/F/?func=find-b&request=01415148&find_code=SYS&local_base=nkc
2004 @ 09 @ 17 @ Moderní babictví @ http://aleph.nkp.cz/F/?func=find-b&request=01414924&find_code=SYS&local_base=nkc
2004 @ 09 @ 18 @ Moderní výrobní technologie @ http://aleph.nkp.cz/F/?func=find-b&request=01414897&find_code=SYS&local_base=nkc
2004 @ 09 @ 19 @ Nabídka práce @ http://aleph.nkp.cz/F/?func=find-b&request=01417542&find_code=SYS&local_base=nkc
2004 @ 09 @ 20 @ Piňovské Hanák @ http://aleph.nkp.cz/F/?func=find-b&request=01413219&find_code=SYS&local_base=nkc
2004 @ 09 @ 21 @ Potravinářská revue @ http://aleph.nkp.cz/F/?func=find-b&request=01414798&find_code=SYS&local_base=nkc
2004 @ 09 @ 22 @ Prevence @ http://aleph.nkp.cz/F/?func=find-b&request=01414817&find_code=SYS&local_base=nkc
2004 @ 09 @ 23 @ Revue České lékařské společnosti J. E. Purkyně @ http://aleph.nkp.cz/F/?func=find-b&request=01414745&find_code=SYS&local_base=nkc
2004 @ 09 @ 24 @ S tebou mě baví svět @ http://aleph.nkp.cz/F/?func=find-b&request=01414885&find_code=SYS&local_base=nkc
2004 @ 09 @ 25 @ Sexystars @ http://aleph.nkp.cz/F/?func=find-b&request=01414827&find_code=SYS&local_base=nkc
2004 @ 09 @ 26 @ Street @ http://aleph.nkp.cz/F/?func=find-b&request=01415306&find_code=SYS&local_base=nkc
2004 @ 09 @ 27 @ Transformotor @ http://aleph.nkp.cz/F/?func=find-b&request=01414750&find_code=SYS&local_base=nkc
2004 @ 09 @ 28 @ Triatlon @ http://aleph.nkp.cz/F/?func=find-b&request=01415075&find_code=SYS&local_base=nkc
2004 @ 09 @ 29 @ Visus Motoli @ http://aleph.nkp.cz/F/?func=find-b&request=01414742&find_code=SYS&local_base=nkc
2004 @ 09 @ 30 @ Zrcadlo @ http://aleph.nkp.cz/F/?func=find-b&request=01409861&find_code=SYS&local_base=nkc
2004 @ 10 @ 01 @ Acta geodynamica et geomaterialia @ http://aleph.nkp.cz/F/?func=find-b&request=01448316&find_code=SYS&local_base=nkc
2004 @ 10 @ 02 @ Architektura@ stavebnictví, bydlení', 'http://aleph.nkp.cz/F/?func=find-b&request=01445919&find_code=SYS&local_base=nkc
2004 @ 10 @ 03 @ BarLife @ http://aleph.nkp.cz/F/?func=find-b&request=01446351&find_code=SYS&local_base=nkc
2004 @ 10 @ 04 @ Bruntálský a krnovský deník @ http://aleph.nkp.cz/F/?func=find-b&request=01448503&find_code=SYS&local_base=nkc
2004 @ 10 @ 05 @ Business Spotlight @ http://aleph.nkp.cz/F/?func=find-b&request=01448307&find_code=SYS&local_base=nkc
2004 @ 10 @ 06 @ Deník Blanenska @ http://aleph.nkp.cz/F/?func=find-b&request=01448256&find_code=SYS&local_base=nkc
2004 @ 10 @ 07 @ Deník Břeclavska @ http://aleph.nkp.cz/F/?func=find-b&request=01448293&find_code=SYS&local_base=nkc
2004 @ 10 @ 08 @ Deník Slovácka @ http://aleph.nkp.cz/F/?func=find-b&request=01448277&find_code=SYS&local_base=nkc
2004 @ 10 @ 09 @ Deník Vyškovska @ http://aleph.nkp.cz/F/?func=find-b&request=01448280&find_code=SYS&local_base=nkc
2004 @ 10 @ 10 @ Deník Znojemska @ http://aleph.nkp.cz/F/?func=find-b&request=01448283&find_code=SYS&local_base=nkc
2004 @ 10 @ 11 @ Fajn život @ http://aleph.nkp.cz/F/?func=find-b&request=01446440&find_code=SYS&local_base=nkc
2004 @ 10 @ 12 @ Fontána esotera @ http://aleph.nkp.cz/F/?func=find-b&request=01448638&find_code=SYS&local_base=nkc
2004 @ 10 @ 13 @ Frýdecko-místecký a třinecký deník @ http://aleph.nkp.cz/F/?func=find-b&request=01448522&find_code=SYS&local_base=nkc
2004 @ 10 @ 14 @ Grand zdraví a krása @ http://aleph.nkp.cz/F/?func=find-b&request=01448633&find_code=SYS&local_base=nkc
2004 @ 10 @ 15 @ Havířovský deník @ http://aleph.nkp.cz/F/?func=find-b&request=01448521&find_code=SYS&local_base=nkc
2004 @ 10 @ 16 @ Hurá @ http://aleph.nkp.cz/F/?func=find-b&request=01448258&find_code=SYS&local_base=nkc
2004 @ 10 @ 17 @ Karvinský deník @ http://aleph.nkp.cz/F/?func=find-b&request=01448520&find_code=SYS&local_base=nkc
2004 @ 10 @ 18 @ Křižovatky zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01446206&find_code=SYS&local_base=nkc
2004 @ 10 @ 19 @ Kurýr jihovýchodní Prahy @ http://aleph.nkp.cz/F/?func=find-b&request=01446513&find_code=SYS&local_base=nkc
2004 @ 10 @ 20 @ Lidé & hory @ http://aleph.nkp.cz/F/?func=find-b&request=01448628&find_code=SYS&local_base=nkc
2004 @ 10 @ 21 @ Netboys @ http://aleph.nkp.cz/F/?func=find-b&request=01446391&find_code=SYS&local_base=nkc
2004 @ 10 @ 22 @ Novojičínský deník @ http://aleph.nkp.cz/F/?func=find-b&request=01448518&find_code=SYS&local_base=nkc
2004 @ 10 @ 23 @ Opavský a hlučínský deník @ http://aleph.nkp.cz/F/?func=find-b&request=01448514&find_code=SYS&local_base=nkc
2004 @ 10 @ 24 @ Pestrý svět @ http://aleph.nkp.cz/F/?func=find-b&request=01445954&find_code=SYS&local_base=nkc
2004 @ 10 @ 25 @ Šlápota @ http://aleph.nkp.cz/F/?func=find-b&request=01446219&find_code=SYS&local_base=nkc
2004 @ 10 @ 26 @ Vanessa @ http://aleph.nkp.cz/F/?func=find-b&request=01417590&find_code=SYS&local_base=nkc
2004 @ 10 @ 27 @ Vše pro dům - byt - zahradu - hobby @ http://aleph.nkp.cz/F/?func=find-b&request=01446213&find_code=SYS&local_base=nkc
2004 @ 10 @ 28 @ Zpravodaj (Lhota u Vsetína) @ http://aleph.nkp.cz/F/?func=find-b&request=01446843&find_code=SYS&local_base=nkc
2004 @ 11 @ 01 @ Aha! @ http://aleph.nkp.cz/F/?func=find-b&request=01488511&find_code=SYS&local_base=nkc
2004 @ 11 @ 02 @ Airport mix @ http://aleph.nkp.cz/F/?func=find-b&request=01488093&find_code=SYS&local_base=nkc
2004 @ 11 @ 03 @ Broumovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01488641&find_code=SYS&local_base=nkc
2004 @ 11 @ 04 @ Cuatro inzert @ http://aleph.nkp.cz/F/?func=find-b&request=01488851&find_code=SYS&local_base=nkc
2004 @ 11 @ 05 @ Čili chili @ http://aleph.nkp.cz/F/?func=find-b&request=01488409&find_code=SYS&local_base=nkc
2004 @ 11 @ 06 @ Egerer Anzeiger @ http://aleph.nkp.cz/F/?func=find-b&request=01472133&find_code=SYS&local_base=nkc
2004 @ 11 @ 07 @ Halina @ http://aleph.nkp.cz/F/?func=find-b&request=01488100&find_code=SYS&local_base=nkc
2004 @ 11 @ 08 @ Hlas racka @ http://aleph.nkp.cz/F/?func=find-b&request=01488783&find_code=SYS&local_base=nkc
2004 @ 11 @ 09 @ Chov skotu @ http://aleph.nkp.cz/F/?func=find-b&request=01472010&find_code=SYS&local_base=nkc
2004 @ 11 @ 10 @ Imperium @ http://aleph.nkp.cz/F/?func=find-b&request=01472021&find_code=SYS&local_base=nkc
2004 @ 11 @ 11 @ Kaliméra @ http://aleph.nkp.cz/F/?func=find-b&request=01488827&find_code=SYS&local_base=nkc
2004 @ 11 @ 12 @ Karlovarský žurnál @ http://aleph.nkp.cz/F/?func=find-b&request=01488645&find_code=SYS&local_base=nkc
2004 @ 11 @ 13 @ Komfort @ http://aleph.nkp.cz/F/?func=find-b&request=01472203&find_code=SYS&local_base=nkc
2004 @ 11 @ 14 @ Maratonoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01488791&find_code=SYS&local_base=nkc
2004 @ 11 @ 15 @ Novobělský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01488050&find_code=SYS&local_base=nkc
2004 @ 11 @ 16 @ Osmisměrky … @ http://aleph.nkp.cz/F/?func=find-b&request=01488980&find_code=SYS&local_base=nkc
2004 @ 11 @ 17 @ Pecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01488317&find_code=SYS&local_base=nkc
2004 @ 11 @ 18 @ Planeta zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01488631&find_code=SYS&local_base=nkc
2004 @ 11 @ 19 @ Psárský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01488617&find_code=SYS&local_base=nkc
2004 @ 11 @ 20 @ RC monitor @ http://aleph.nkp.cz/F/?func=find-b&request=01488325&find_code=SYS&local_base=nkc
2004 @ 11 @ 21 @ Reality kontakt @ http://aleph.nkp.cz/F/?func=find-b&request=01488095&find_code=SYS&local_base=nkc
2004 @ 11 @ 22 @ Revue České lékařské akademie @ http://aleph.nkp.cz/F/?func=find-b&request=01488988&find_code=SYS&local_base=nkc
2004 @ 11 @ 23 @ Sféra @ http://aleph.nkp.cz/F/?func=find-b&request=01488314&find_code=SYS&local_base=nkc
2004 @ 11 @ 24 @ Šarovec @ http://aleph.nkp.cz/F/?func=find-b&request=01488847&find_code=SYS&local_base=nkc
2004 @ 11 @ 25 @ Štěpánovinky @ http://aleph.nkp.cz/F/?func=find-b&request=01488649&find_code=SYS&local_base=nkc
2004 @ 11 @ 26 @ Top marketing @ http://aleph.nkp.cz/F/?func=find-b&request=01488282&find_code=SYS&local_base=nkc
2004 @ 11 @ 27 @ Tout Prague @ http://aleph.nkp.cz/F/?func=find-b&request=01488594&find_code=SYS&local_base=nkc
2004 @ 11 @ 28 @ Velká kniha pro malé luštitele @ http://aleph.nkp.cz/F/?func=find-b&request=01488600&find_code=SYS&local_base=nkc
2004 @ 11 @ 29 @ VLNAP style @ http://aleph.nkp.cz/F/?func=find-b&request=01488312&find_code=SYS&local_base=nkc
2004 @ 11 @ 30 @ Volejbal @ http://aleph.nkp.cz/F/?func=find-b&request=01488097&find_code=SYS&local_base=nkc
2004 @ 11 @ 31 @ Yellow @ http://aleph.nkp.cz/F/?func=find-b&request=01488428&find_code=SYS&local_base=nkc
2004 @ 11 @ 32 @ Zrcadlení - Zrkadlenie @ http://aleph.nkp.cz/F/?func=find-b&request=01488611&find_code=SYS&local_base=nkc
2004 @ 12 @ 01 @ Autoshow revue @ http://aleph.nkp.cz/F/?func=find-b&request=01491173&find_code=SYS&local_base=nkc
2004 @ 12 @ 02 @ BIZ @ http://aleph.nkp.cz/F/?func=find-b&request=01493893&find_code=SYS&local_base=nkc
2004 @ 12 @ 03 @ Bedeman @ http://aleph.nkp.cz/F/?func=find-b&request=01471809&find_code=SYS&local_base=nkc
2004 @ 12 @ 04 @ Bulletin (NSČU) @ http://aleph.nkp.cz/F/?func=find-b&request=01471790&find_code=SYS&local_base=nkc
2004 @ 12 @ 05 @ Dieta @ http://aleph.nkp.cz/F/?func=find-b&request=01491502&find_code=SYS&local_base=nkc
2004 @ 12 @ 06 @ Doupě @ http://aleph.nkp.cz/F/?func=find-b&request=01492932&find_code=SYS&local_base=nkc
2004 @ 12 @ 07 @ Hambáč @ http://aleph.nkp.cz/F/?func=find-b&request=01492916&find_code=SYS&local_base=nkc
2004 @ 12 @ 08 @ Hardcore international @ http://aleph.nkp.cz/F/?func=find-b&request=01472144&find_code=SYS&local_base=nkc
2004 @ 12 @ 09 @ Helena v krabici @ http://aleph.nkp.cz/F/?func=find-b&request=01491501&find_code=SYS&local_base=nkc
2004 @ 12 @ 10 @ IM6 @ http://aleph.nkp.cz/F/?func=find-b&request=01491167&find_code=SYS&local_base=nkc
2004 @ 12 @ 11 @ Info@hudy @ http://aleph.nkp.cz/F/?func=find-b&request=01492924&find_code=SYS&local_base=nkc
2004 @ 12 @ 12 @ Internetové tipy @ http://aleph.nkp.cz/F/?func=find-b&request=01491500&find_code=SYS&local_base=nkc
2004 @ 12 @ 13 @ Labužník @ http://aleph.nkp.cz/F/?func=find-b&request=01472001&find_code=SYS&local_base=nkc
2004 @ 12 @ 14 @ Lidé města @ http://aleph.nkp.cz/F/?func=find-b&request=01493891&find_code=SYS&local_base=nkc
2004 @ 12 @ 15 @ Listy Univerzity obrany @ http://aleph.nkp.cz/F/?func=find-b&request=01471772&find_code=SYS&local_base=nkc
2004 @ 12 @ 16 @ Malování jehlou @ http://aleph.nkp.cz/F/?func=find-b&request=01492905&find_code=SYS&local_base=nkc
2004 @ 12 @ 17 @ Modrá planeta @ http://aleph.nkp.cz/F/?func=find-b&request=01491163&find_code=SYS&local_base=nkc
2004 @ 12 @ 18 @ Osmisměrky velkého luštitele @ http://aleph.nkp.cz/F/?func=find-b&request=01492644&find_code=SYS&local_base=nkc
2004 @ 12 @ 19 @ Periskop @ http://aleph.nkp.cz/F/?func=find-b&request=01492662&find_code=SYS&local_base=nkc
2004 @ 12 @ 20 @ Perspektivy jakosti @ http://aleph.nkp.cz/F/?func=find-b&request=01491499&find_code=SYS&local_base=nkc
2004 @ 12 @ 21 @ PRÚVAN @ http://aleph.nkp.cz/F/?func=find-b&request=01492668&find_code=SYS&local_base=nkc
2004 @ 12 @ 22 @ Srdce @ http://aleph.nkp.cz/F/?func=find-b&request=01492659&find_code=SYS&local_base=nkc
2004 @ 12 @ 23 @ Sulický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01492663&find_code=SYS&local_base=nkc
2004 @ 12 @ 24 @ Svět kuriozit a rekordů v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=01492647&find_code=SYS&local_base=nkc
2004 @ 12 @ 25 @ Tvoříme s květinami @ http://aleph.nkp.cz/F/?func=find-b&request=01488307&find_code=SYS&local_base=nkc
2004 @ 12 @ 26 @ VPK Tambor - Nymbursko @ http://aleph.nkp.cz/F/?func=find-b&request=01493907&find_code=SYS&local_base=nkc
2004 @ 12 @ 27 @ Zpravodaj Svazu chovatelů a plemenné knihy českého strakatého skotu @ http://aleph.nkp.cz/F/?func=find-b&request=01491922&find_code=SYS&local_base=nkc
2005 @ 01 @ 01 @ 97 stran bezva křížovek @ http://aleph.nkp.cz/F/?func=find-b&request=01497506&find_code=SYS&local_base=nkc
2005 @ 01 @ 02 @ 97 stran osmisměrek @ http://aleph.nkp.cz/F/?func=find-b&request=01497501&find_code=SYS&local_base=nkc
2005 @ 01 @ 03 @ Berounský sportík @ http://aleph.nkp.cz/F/?func=find-b&request=01497933&find_code=SYS&local_base=nkc
2005 @ 01 @ 04 @ Boleradické zprávy a informace @ http://aleph.nkp.cz/F/?func=find-b&request=01495860&find_code=SYS&local_base=nkc
2005 @ 01 @ 05 @ Budějovická hvězda @ http://aleph.nkp.cz/F/?func=find-b&request=01496093&find_code=SYS&local_base=nkc
2005 @ 01 @ 06 @ Budislavský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01495091&find_code=SYS&local_base=nkc
2005 @ 01 @ 07 @ Carauto @ http://aleph.nkp.cz/F/?func=find-b&request=01496059&find_code=SYS&local_base=nkc
2005 @ 01 @ 08 @ Cesty psychotroniky @ http://aleph.nkp.cz/F/?func=find-b&request=01497544&find_code=SYS&local_base=nkc
2005 @ 01 @ 09 @ Cigare & vine style @ http://aleph.nkp.cz/F/?func=find-b&request=01497475&find_code=SYS&local_base=nkc
2005 @ 01 @ 10 @ Czech industry magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01495871&find_code=SYS&local_base=nkc
2005 @ 01 @ 11 @ Čedok revue @ http://aleph.nkp.cz/F/?func=find-b&request=01497550&find_code=SYS&local_base=nkc
2005 @ 01 @ 12 @ Daikin magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01497578&find_code=SYS&local_base=nkc
2005 @ 01 @ 13 @ Doubravecké listy @ http://aleph.nkp.cz/F/?func=find-b&request=01497547&find_code=SYS&local_base=nkc
2005 @ 01 @ 14 @ Easy riders @ http://aleph.nkp.cz/F/?func=find-b&request=01495106&find_code=SYS&local_base=nkc
2005 @ 01 @ 15 @ Ekoton @ http://aleph.nkp.cz/F/?func=find-b&request=01496444&find_code=SYS&local_base=nkc
2005 @ 01 @ 16 @ Europort @ http://aleph.nkp.cz/F/?func=find-b&request=01496218&find_code=SYS&local_base=nkc
2005 @ 01 @ 17 @ Evangelicus @ http://aleph.nkp.cz/F/?func=find-b&request=01497542&find_code=SYS&local_base=nkc
2005 @ 01 @ 18 @ Ftipy pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=01497512&find_code=SYS&local_base=nkc
2005 @ 01 @ 19 @ Houbař @ http://aleph.nkp.cz/F/?func=find-b&request=01497925&find_code=SYS&local_base=nkc
2005 @ 01 @ 20 @ Jaderný odpad? Děkujeme@ nechceme.', 'http://aleph.nkp.cz/F/?func=find-b&request=01496226&find_code=SYS&local_base=nkc
2005 @ 01 @ 21 @ Kdo luští@ nezlobí!', 'http://aleph.nkp.cz/F/?func=find-b&request=01497537&find_code=SYS&local_base=nkc
2005 @ 01 @ 22 @ Kestřanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01496074&find_code=SYS&local_base=nkc
2005 @ 01 @ 23 @ Krůčky @ http://aleph.nkp.cz/F/?func=find-b&request=01495990&find_code=SYS&local_base=nkc
2005 @ 01 @ 24 @ Literární kukátko Čáslavi @ http://aleph.nkp.cz/F/?func=find-b&request=01495100&find_code=SYS&local_base=nkc
2005 @ 01 @ 25 @ Louskáček @ http://aleph.nkp.cz/F/?func=find-b&request=01495980&find_code=SYS&local_base=nkc
2005 @ 01 @ 26 @ Lumen @ http://aleph.nkp.cz/F/?func=find-b&request=01496229&find_code=SYS&local_base=nkc
2005 @ 01 @ 27 @ Luštěná pro všechny @ http://aleph.nkp.cz/F/?func=find-b&request=01497490&find_code=SYS&local_base=nkc
2005 @ 01 @ 28 @ Luštěte a luštěte! @ http://aleph.nkp.cz/F/?func=find-b&request=01497535&find_code=SYS&local_base=nkc
2005 @ 01 @ 29 @ Měsíčník Těšínska @ http://aleph.nkp.cz/F/?func=find-b&request=01496437&find_code=SYS&local_base=nkc
2005 @ 01 @ 30 @ Motoexpress @ http://aleph.nkp.cz/F/?func=find-b&request=01495855&find_code=SYS&local_base=nkc
2005 @ 01 @ 31 @ MyStandard @ http://aleph.nkp.cz/F/?func=find-b&request=01496067&find_code=SYS&local_base=nkc
2005 @ 01 @ 32 @ Nailpro & salon @ http://aleph.nkp.cz/F/?func=find-b&request=01495867&find_code=SYS&local_base=nkc
2005 @ 01 @ 33 @ Oznamovatel Obce unitářů z Plzni @ http://aleph.nkp.cz/F/?func=find-b&request=01495071&find_code=SYS&local_base=nkc
2005 @ 01 @ 34 @ Poznání @ http://aleph.nkp.cz/F/?func=find-b&request=01494996&find_code=SYS&local_base=nkc
2005 @ 01 @ 35 @ Praha 1 @ http://aleph.nkp.cz/F/?func=find-b&request=01495080&find_code=SYS&local_base=nkc
2005 @ 01 @ 36 @ Právě 18 @ http://aleph.nkp.cz/F/?func=find-b&request=01497556&find_code=SYS&local_base=nkc
2005 @ 01 @ 37 @ Proskovický Florián @ http://aleph.nkp.cz/F/?func=find-b&request=01494979&find_code=SYS&local_base=nkc
2005 @ 01 @ 38 @ Přemyslovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01494992&find_code=SYS&local_base=nkc
2005 @ 01 @ 39 @ Přes hranice@ předsudky, lhostejnost', 'http://aleph.nkp.cz/F/?func=find-b&request=01495070&find_code=SYS&local_base=nkc
2005 @ 01 @ 40 @ Radim @ http://aleph.nkp.cz/F/?func=find-b&request=01495082&find_code=SYS&local_base=nkc
2005 @ 01 @ 41 @ Recepty dobrou chuť! @ http://aleph.nkp.cz/F/?func=find-b&request=01497483&find_code=SYS&local_base=nkc
2005 @ 01 @ 42 @ Recepty pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=01497487&find_code=SYS&local_base=nkc
2005 @ 01 @ 43 @ Rozárka @ http://aleph.nkp.cz/F/?func=find-b&request=01497603&find_code=SYS&local_base=nkc
2005 @ 01 @ 44 @ Senior křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=01495851&find_code=SYS&local_base=nkc
2005 @ 01 @ 45 @ Setkání @ http://aleph.nkp.cz/F/?func=find-b&request=01495084&find_code=SYS&local_base=nkc
2005 @ 01 @ 46 @ Sexy humor @ http://aleph.nkp.cz/F/?func=find-b&request=01497500&find_code=SYS&local_base=nkc
2005 @ 01 @ 47 @ Speciál AD @ http://aleph.nkp.cz/F/?func=find-b&request=01493574&find_code=SYS&local_base=nkc
2005 @ 01 @ 48 @ Sputnik turista @ http://aleph.nkp.cz/F/?func=find-b&request=01495595&find_code=SYS&local_base=nkc
2005 @ 01 @ 49 @ Staropražské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01497594&find_code=SYS&local_base=nkc
2005 @ 01 @ 50 @ Super! Spy @ http://aleph.nkp.cz/F/?func=find-b&request=01496449&find_code=SYS&local_base=nkc
2005 @ 01 @ 51 @ Svět vědy @ http://aleph.nkp.cz/F/?func=find-b&request=01496003&find_code=SYS&local_base=nkc
2005 @ 01 @ 52 @ Užívej si @ http://aleph.nkp.cz/F/?func=find-b&request=01495996&find_code=SYS&local_base=nkc
2005 @ 01 @ 53 @ Vlkošský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01495077&find_code=SYS&local_base=nkc
2005 @ 01 @ 54 @ Vraňanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01495826&find_code=SYS&local_base=nkc
2005 @ 01 @ 55 @ Vysokomýtský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01497917&find_code=SYS&local_base=nkc
2005 @ 01 @ 56 @ Xstream @ http://aleph.nkp.cz/F/?func=find-b&request=01494965&find_code=SYS&local_base=nkc
2005 @ 01 @ 57 @ Zpravodaj (ČMMJ Jihlava) @ http://aleph.nkp.cz/F/?func=find-b&request=01494968&find_code=SYS&local_base=nkc
2005 @ 01 @ 58 @ Zpravodaj (Městská nemocnice Ostrava) @ http://aleph.nkp.cz/F/?func=find-b&request=01494994&find_code=SYS&local_base=nkc
2005 @ 01 @ 59 @ Zpravodaj obce Radimovice @ http://aleph.nkp.cz/F/?func=find-b&request=01494971&find_code=SYS&local_base=nkc
2005 @ 01 @ 60 @ Zpravodaj obce Topolany @ http://aleph.nkp.cz/F/?func=find-b&request=01495078&find_code=SYS&local_base=nkc
2005 @ 01 @ 61 @ Zpravodaj obce Veřovice @ http://aleph.nkp.cz/F/?func=find-b&request=01495075&find_code=SYS&local_base=nkc
2005 @ 01 @ 62 @ Zpravodaj Obecního úřadu v Panoším Újezdě @ http://aleph.nkp.cz/F/?func=find-b&request=01495808&find_code=SYS&local_base=nkc
2005 @ 01 @ 63 @ Zpravodaj Spolku textilních chemiků a koloristů @ http://aleph.nkp.cz/F/?func=find-b&request=01495086&find_code=SYS&local_base=nkc
2005 @ 01 @ 64 @ Žurnál UP @ http://aleph.nkp.cz/F/?func=find-b&request=01495854&find_code=SYS&local_base=nkc
2005 @ 02 @ 00 @ Akva tera fórum @ http://aleph.nkp.cz/F/?func=find-b&request=01501590&find_code=SYS&local_base=nkc
2005 @ 02 @ 02 @ Cestopisy @ http://aleph.nkp.cz/F/?func=find-b&request=01498712&find_code=SYS&local_base=nkc
2005 @ 02 @ 03 @ Cucina italiana @ http://aleph.nkp.cz/F/?func=find-b&request=01498688&find_code=SYS&local_base=nkc
2005 @ 02 @ 04 @ ČEZ news @ http://aleph.nkp.cz/F/?func=find-b&request=01498705&find_code=SYS&local_base=nkc
2005 @ 02 @ 05 @ Destinace @ http://aleph.nkp.cz/F/?func=find-b&request=01498707&find_code=SYS&local_base=nkc
2005 @ 02 @ 06 @ Fotbal AZ @ http://aleph.nkp.cz/F/?func=find-b&request=01501571&find_code=SYS&local_base=nkc
2005 @ 02 @ 07 @ Golempress @ http://aleph.nkp.cz/F/?func=find-b&request=01501218&find_code=SYS&local_base=nkc
2005 @ 02 @ 08 @ GRAND auto-moto @ http://aleph.nkp.cz/F/?func=find-b&request=01501225&find_code=SYS&local_base=nkc
2005 @ 02 @ 09 @ Info reality @ http://aleph.nkp.cz/F/?func=find-b&request=01501592&find_code=SYS&local_base=nkc
2005 @ 02 @ 10 @ Katka @ 
2005 @ 02 @ 11 @ Křížovky - hrady @ http://aleph.nkp.cz/F/?func=find-b&request=01501582&find_code=SYS&local_base=nkc
2005 @ 02 @ 12 @ Křížovky - města @ http://aleph.nkp.cz/F/?func=find-b&request=01501577&find_code=SYS&local_base=nkc
2005 @ 02 @ 13 @ Křížovky - zámky @ http://aleph.nkp.cz/F/?func=find-b&request=01501579&find_code=SYS&local_base=nkc
2005 @ 02 @ 14 @ L+K speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01498868&find_code=SYS&local_base=nkc
2005 @ 02 @ 15 @ Malovicko @ http://aleph.nkp.cz/F/?func=find-b&request=01498714&find_code=SYS&local_base=nkc
2005 @ 02 @ 16 @ Medical tribune @ http://aleph.nkp.cz/F/?func=find-b&request=01498693&find_code=SYS&local_base=nkc
2005 @ 02 @ 17 @ Mobil hry @ http://aleph.nkp.cz/F/?func=find-b&request=01501565&find_code=SYS&local_base=nkc
2005 @ 02 @ 18 @ Obec Chvalčov oznamuje @ http://aleph.nkp.cz/F/?func=find-b&request=01501371&find_code=SYS&local_base=nkc
2005 @ 02 @ 19 @ Originality @ http://aleph.nkp.cz/F/?func=find-b&request=01501209&find_code=SYS&local_base=nkc
2005 @ 02 @ 20 @ Osmisměrky horoskopičiny @ http://aleph.nkp.cz/F/?func=find-b&request=01501645&find_code=SYS&local_base=nkc
2005 @ 02 @ 21 @ Osmisměrky policejní humoresky @ http://aleph.nkp.cz/F/?func=find-b&request=01501644&find_code=SYS&local_base=nkc
2005 @ 02 @ 22 @ Play mobil @ http://aleph.nkp.cz/F/?func=find-b&request=01501428&find_code=SYS&local_base=nkc
2005 @ 02 @ 23 @ Pleso @ http://aleph.nkp.cz/F/?func=find-b&request=01501207&find_code=SYS&local_base=nkc
2005 @ 02 @ 24 @ Po kapkách @ http://aleph.nkp.cz/F/?func=find-b&request=01501420&find_code=SYS&local_base=nkc
2005 @ 02 @ 25 @ Pohodář @ http://aleph.nkp.cz/F/?func=find-b&request=01501198&find_code=SYS&local_base=nkc
2005 @ 02 @ 26 @ Pošumaví @ http://aleph.nkp.cz/F/?func=find-b&request=01501636&find_code=SYS&local_base=nkc
2005 @ 02 @ 27 @ Poutník Orfeus @ http://aleph.nkp.cz/F/?func=find-b&request=01501238&find_code=SYS&local_base=nkc
2005 @ 02 @ 28 @ Pražskij express @ http://aleph.nkp.cz/F/?func=find-b&request=01501539&find_code=SYS&local_base=nkc
2005 @ 02 @ 29 @ Puls @ http://aleph.nkp.cz/F/?func=find-b&request=01501409&find_code=SYS&local_base=nkc
2005 @ 02 @ 30 @ Radegast expres @ http://aleph.nkp.cz/F/?func=find-b&request=01501244&find_code=SYS&local_base=nkc
2005 @ 02 @ 31 @ Ráj zábavy @ http://aleph.nkp.cz/F/?func=find-b&request=01498700&find_code=SYS&local_base=nkc
2005 @ 02 @ 32 @ Receptář Speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01498710&find_code=SYS&local_base=nkc
2005 @ 02 @ 33 @ Revue art @ http://aleph.nkp.cz/F/?func=find-b&request=01501403&find_code=SYS&local_base=nkc
2005 @ 02 @ 34 @ Rosnička @ http://aleph.nkp.cz/F/?func=find-b&request=01501646&find_code=SYS&local_base=nkc
2005 @ 02 @ 35 @ Sedlišťský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01501629&find_code=SYS&local_base=nkc
2005 @ 02 @ 36 @ Sex - katalog @ http://aleph.nkp.cz/F/?func=find-b&request=01501391&find_code=SYS&local_base=nkc
2005 @ 02 @ 37 @ Slovo a smysl @ http://aleph.nkp.cz/F/?func=find-b&request=01498668&find_code=SYS&local_base=nkc
2005 @ 02 @ 38 @ Solárko @ http://aleph.nkp.cz/F/?func=find-b&request=01501627&find_code=SYS&local_base=nkc
2005 @ 02 @ 39 @ Stadion & Champions life @ http://aleph.nkp.cz/F/?func=find-b&request=01501115&find_code=SYS&local_base=nkc
2005 @ 02 @ 40 @ Statistický bulletin Jihočeský kraj @ http://aleph.nkp.cz/F/?func=find-b&request=01501544&find_code=SYS&local_base=nkc
2005 @ 02 @ 41 @ Studia neoaristotelica @ http://aleph.nkp.cz/F/?func=find-b&request=01501396&find_code=SYS&local_base=nkc
2005 @ 02 @ 42 @ Svinovníček @ http://aleph.nkp.cz/F/?func=find-b&request=01501640&find_code=SYS&local_base=nkc
2005 @ 02 @ 43 @ Trend @ http://aleph.nkp.cz/F/?func=find-b&request=01498683&find_code=SYS&local_base=nkc
2005 @ 02 @ 44 @ Trend marketing @ http://aleph.nkp.cz/F/?func=find-b&request=01501417&find_code=SYS&local_base=nkc
2005 @ 02 @ 45 @ Valérie @ http://aleph.nkp.cz/F/?func=find-b&request=01498691&find_code=SYS&local_base=nkc
2005 @ 02 @ 48 @ Zpravodaj (Univerzita Hradec Králové) @ http://aleph.nkp.cz/F/?func=find-b&request=01501425&find_code=SYS&local_base=nkc
2005 @ 02 @ 46 @ Zpravodaj klubu chovatelů svatobernardských psů @ http://aleph.nkp.cz/F/?func=find-b&request=01501411&find_code=SYS&local_base=nkc
2005 @ 02 @ 47 @ Zpravodaj obce Střílky @ http://aleph.nkp.cz/F/?func=find-b&request=01501250&find_code=SYS&local_base=nkc
2005 @ 02 @ 49 @ Zpravodaj ÚZ @ http://aleph.nkp.cz/F/?func=find-b&request=01501141&find_code=SYS&local_base=nkc
2005 @ 03 @ 01 @ Bedrník @ http://aleph.nkp.cz/F/?func=find-b&request=01526326&find_code=SYS&local_base=nkc
2005 @ 03 @ 02 @ Bonsaje a japonské zahrady @ http://aleph.nkp.cz/F/?func=find-b&request=01528668&find_code=SYS&local_base=nkc
2005 @ 03 @ 03 @ Bulletin (Rosa) @ http://aleph.nkp.cz/F/?func=find-b&request=01526333&find_code=SYS&local_base=nkc
2005 @ 03 @ 04 @ Camping@ cars & caravans', 'http://aleph.nkp.cz/F/?func=find-b&request=01528693&find_code=SYS&local_base=nkc
2005 @ 03 @ 05 @ Caritas - Klára @ http://aleph.nkp.cz/F/?func=find-b&request=01526316&find_code=SYS&local_base=nkc
2005 @ 03 @ 06 @ Časopísek @ http://aleph.nkp.cz/F/?func=find-b&request=01526379&find_code=SYS&local_base=nkc
2005 @ 03 @ 07 @ Dobrý kontakt @ http://aleph.nkp.cz/F/?func=find-b&request=01528659&find_code=SYS&local_base=nkc
2005 @ 03 @ 08 @ Era21 @ http://aleph.nkp.cz/F/?func=find-b&request=01526388&find_code=SYS&local_base=nkc
2005 @ 03 @ 09 @ Gastronomický obzor @ http://aleph.nkp.cz/F/?func=find-b&request=01529064&find_code=SYS&local_base=nkc
2005 @ 03 @ 10 @ Grand Expres @ http://aleph.nkp.cz/F/?func=find-b&request=01526373&find_code=SYS&local_base=nkc
2005 @ 03 @ 11 @ Hlasy národa @ http://aleph.nkp.cz/F/?func=find-b&request=01526275&find_code=SYS&local_base=nkc
2005 @ 03 @ 12 @ Holické listy @ http://aleph.nkp.cz/F/?func=find-b&request=01526301&find_code=SYS&local_base=nkc
2005 @ 03 @ 13 @ Chebáček @ http://aleph.nkp.cz/F/?func=find-b&request=01528672&find_code=SYS&local_base=nkc
2005 @ 03 @ 14 @ Chlumčanský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01526266&find_code=SYS&local_base=nkc
2005 @ 03 @ 15 @ Informační zpravodaj města Rousínova @ http://aleph.nkp.cz/F/?func=find-b&request=01526342&find_code=SYS&local_base=nkc
2005 @ 03 @ 16 @ Jizerníček @ http://aleph.nkp.cz/F/?func=find-b&request=01526345&find_code=SYS&local_base=nkc
2005 @ 03 @ 17 @ Křemežské ostny @ http://aleph.nkp.cz/F/?func=find-b&request=01528697&find_code=SYS&local_base=nkc
2005 @ 03 @ 18 @ Křižanovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01526337&find_code=SYS&local_base=nkc
2005 @ 03 @ 19 @ Kultura @ http://aleph.nkp.cz/F/?func=find-b&request=01528683&find_code=SYS&local_base=nkc
2005 @ 03 @ 20 @ Magazín Galerie Butovice @ http://aleph.nkp.cz/F/?func=find-b&request=01528677&find_code=SYS&local_base=nkc
2005 @ 03 @ 21 @ MiniMax (Chrudim) @ http://aleph.nkp.cz/F/?func=find-b&request=01525012&find_code=SYS&local_base=nkc
2005 @ 03 @ 22 @ MiniMax (Jaroměř) @ http://aleph.nkp.cz/F/?func=find-b&request=01525006&find_code=SYS&local_base=nkc
2005 @ 03 @ 23 @ MiniMax (Nové Město n/M) @ http://aleph.nkp.cz/F/?func=find-b&request=01525004&find_code=SYS&local_base=nkc
2005 @ 03 @ 24 @ MiniMax (Strakonice) @ http://aleph.nkp.cz/F/?func=find-b&request=01525020&find_code=SYS&local_base=nkc
2005 @ 03 @ 25 @ My & spol. @ http://aleph.nkp.cz/F/?func=find-b&request=01501146&find_code=SYS&local_base=nkc
2005 @ 03 @ 26 @ Olešnické listy @ http://aleph.nkp.cz/F/?func=find-b&request=01525586&find_code=SYS&local_base=nkc
2005 @ 03 @ 27 @ Orea hotels revue @ http://aleph.nkp.cz/F/?func=find-b&request=01525603&find_code=SYS&local_base=nkc
2005 @ 03 @ 28 @ Podleský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01525605&find_code=SYS&local_base=nkc
2005 @ 03 @ 29 @ Rozhled @ http://aleph.nkp.cz/F/?func=find-b&request=01525582&find_code=SYS&local_base=nkc
2005 @ 03 @ 30 @ Z ráje do ráje @ http://aleph.nkp.cz/F/?func=find-b&request=01525590&find_code=SYS&local_base=nkc
2005 @ 03 @ 31 @ Zpravodaj (Klub přátel psů pražských krysaříků) @ http://aleph.nkp.cz/F/?func=find-b&request=01525588&find_code=SYS&local_base=nkc
2005 @ 03 @ 32 @ Zpravodaj (Mikroregion Nechanicko) @ http://aleph.nkp.cz/F/?func=find-b&request=01525198&find_code=SYS&local_base=nkc
2005 @ 03 @ 33 @ Zprávy z Doudleb nad Orlicí @ http://aleph.nkp.cz/F/?func=find-b&request=01525600&find_code=SYS&local_base=nkc
2005 @ 04 @ 26 @ Multizprávy @ http://aleph.nkp.cz/F/?func=find-b&request=01530684&find_code=SYS&local_base=nkc
2005 @ 04 @ 25 @ MotoRoute @ http://aleph.nkp.cz/F/?func=find-b&request=01531926&find_code=SYS&local_base=nkc
2005 @ 04 @ 24 @ Mlynářské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01529716&find_code=SYS&local_base=nkc
2005 @ 04 @ 23 @ Madame @ http://aleph.nkp.cz/F/?func=find-b&request=01529745&find_code=SYS&local_base=nkc
2005 @ 04 @ 22 @ Linuxexpres @ http://aleph.nkp.cz/F/?func=find-b&request=01529754&find_code=SYS&local_base=nkc
2005 @ 04 @ 21 @ Linux+DVD @ http://aleph.nkp.cz/F/?func=find-b&request=01529763&find_code=SYS&local_base=nkc
2005 @ 04 @ 20 @ Kreativ @ http://aleph.nkp.cz/F/?func=find-b&request=01529595&find_code=SYS&local_base=nkc
2005 @ 04 @ 19 @ Kotnov @ http://aleph.nkp.cz/F/?func=find-b&request=01529582&find_code=SYS&local_base=nkc
2005 @ 04 @ 18 @ Kontakt @ http://aleph.nkp.cz/F/?func=find-b&request=01529724&find_code=SYS&local_base=nkc
2005 @ 04 @ 17 @ Komorník @ http://aleph.nkp.cz/F/?func=find-b&request=01529643&find_code=SYS&local_base=nkc
2005 @ 04 @ 16 @ Jihočeská univerzita @ http://aleph.nkp.cz/F/?func=find-b&request=01530647&find_code=SYS&local_base=nkc
2005 @ 04 @ 15 @ Iron man @ http://aleph.nkp.cz/F/?func=find-b&request=01530639&find_code=SYS&local_base=nkc
2005 @ 04 @ 14 @ Inspirace @ http://aleph.nkp.cz/F/?func=find-b&request=01530641&find_code=SYS&local_base=nkc
2005 @ 04 @ 13 @ In! @ http://aleph.nkp.cz/F/?func=find-b&request=01529702&find_code=SYS&local_base=nkc
2005 @ 04 @ 12 @ Grand reality @ http://aleph.nkp.cz/F/?func=find-b&request=01529633&find_code=SYS&local_base=nkc
2005 @ 04 @ 11 @ Grand bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=01529626&find_code=SYS&local_base=nkc
2005 @ 04 @ 10 @ Glav revue @ http://aleph.nkp.cz/F/?func=find-b&request=01529579&find_code=SYS&local_base=nkc
2005 @ 04 @ 09 @ Energy : klubový zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01530676&find_code=SYS&local_base=nkc
2005 @ 04 @ 08 @ Dobře jíst@ dobře pít', 'http://aleph.nkp.cz/F/?func=find-b&request=01530889&find_code=SYS&local_base=nkc
2005 @ 04 @ 07 @ Češskij raj @ http://aleph.nkp.cz/F/?func=find-b&request=01531554&find_code=SYS&local_base=nkc
2005 @ 04 @ 06 @ Černá kočka @ http://aleph.nkp.cz/F/?func=find-b&request=01530703&find_code=SYS&local_base=nkc
2005 @ 04 @ 05 @ Bulletin of applied mechanics @ http://aleph.nkp.cz/F/?func=find-b&request=01530665&find_code=SYS&local_base=nkc
2005 @ 04 @ 04 @ Building world magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01530697&find_code=SYS&local_base=nkc
2005 @ 04 @ 03 @ Bridge @ http://aleph.nkp.cz/F/?func=find-b&request=01530719&find_code=SYS&local_base=nkc
2005 @ 04 @ 02 @ Borský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01529603&find_code=SYS&local_base=nkc
2005 @ 04 @ 01 @ Alarm @ http://aleph.nkp.cz/F/?func=find-b&request=01530893&find_code=SYS&local_base=nkc
2005 @ 04 @ 27 @ Patroňáček @ http://aleph.nkp.cz/F/?func=find-b&request=01529646&find_code=SYS&local_base=nkc
2005 @ 04 @ 28 @ Věrni zůstali @ http://aleph.nkp.cz/F/?func=find-b&request=01529619&find_code=SYS&local_base=nkc
2005 @ 04 @ 29 @ Víkend magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01531945&find_code=SYS&local_base=nkc
2005 @ 04 @ 30 @ Žába na prameni @ http://aleph.nkp.cz/F/?func=find-b&request=01529585&find_code=SYS&local_base=nkc
2005 @ 05 @ 10 @ Domo architekt @ http://aleph.nkp.cz/F/?func=find-b&request=01534296&find_code=SYS&local_base=nkc
2005 @ 05 @ 09 @ Diagnóza v ošetřovatelství @ http://aleph.nkp.cz/F/?func=find-b&request=01533491&find_code=SYS&local_base=nkc
2005 @ 05 @ 08 @ Dětský český komiks a luštění @ http://aleph.nkp.cz/F/?func=find-b&request=01567533&find_code=SYS&local_base=nkc
2005 @ 05 @ 07 @ Detektivní příběhy @ http://aleph.nkp.cz/F/?func=find-b&request=01567658&find_code=SYS&local_base=nkc
2005 @ 05 @ 06 @ Detektivky @ http://aleph.nkp.cz/F/?func=find-b&request=01567655&find_code=SYS&local_base=nkc
2005 @ 05 @ 05 @ Černošice : informační list @ http://aleph.nkp.cz/F/?func=find-b&request=01567673&find_code=SYS&local_base=nkc
2005 @ 05 @ 04 @ Click @ http://aleph.nkp.cz/F/?func=find-b&request=01567522&find_code=SYS&local_base=nkc
2005 @ 05 @ 03 @ Bauspiegel @ http://aleph.nkp.cz/F/?func=find-b&request=01567477&find_code=SYS&local_base=nkc
2005 @ 05 @ 02 @ Bar Times @ http://aleph.nkp.cz/F/?func=find-b&request=01533477&find_code=SYS&local_base=nkc
2005 @ 05 @ 01 @ AZ inzert @ http://aleph.nkp.cz/F/?func=find-b&request=01567543&find_code=SYS&local_base=nkc
2005 @ 05 @ 11 @ Dovolená … @ http://aleph.nkp.cz/F/?func=find-b&request=01567556&find_code=SYS&local_base=nkc
2005 @ 05 @ 12 @ Drive magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01567741&find_code=SYS&local_base=nkc
2005 @ 05 @ 13 @ Eternity @ http://aleph.nkp.cz/F/?func=find-b&request=01567647&find_code=SYS&local_base=nkc
2005 @ 05 @ 14 @ Filter @ http://aleph.nkp.cz/F/?func=find-b&request=01567551&find_code=SYS&local_base=nkc
2005 @ 05 @ 15 @ Fleet @ http://aleph.nkp.cz/F/?func=find-b&request=01567729&find_code=SYS&local_base=nkc
2005 @ 05 @ 16 @ Holubář @ http://aleph.nkp.cz/F/?func=find-b&request=01567526&find_code=SYS&local_base=nkc
2005 @ 05 @ 17 @ Hovězský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01567469&find_code=SYS&local_base=nkc
2005 @ 05 @ 18 @ Hujer @ http://aleph.nkp.cz/F/?func=find-b&request=01567488&find_code=SYS&local_base=nkc
2005 @ 05 @ 19 @ Jurisprudence @ http://aleph.nkp.cz/F/?func=find-b&request=01534488&find_code=SYS&local_base=nkc
2005 @ 05 @ 20 @ Katolická cesta @ http://aleph.nkp.cz/F/?func=find-b&request=01567530&find_code=SYS&local_base=nkc
2005 @ 05 @ 21 @ Krásné město @ http://aleph.nkp.cz/F/?func=find-b&request=01567744&find_code=SYS&local_base=nkc
2005 @ 05 @ 22 @ Lanžhot @ http://aleph.nkp.cz/F/?func=find-b&request=01533481&find_code=SYS&local_base=nkc
2005 @ 05 @ 23 @ Maxi tuning @ http://aleph.nkp.cz/F/?func=find-b&request=01567697&find_code=SYS&local_base=nkc
2005 @ 05 @ 24 @ MotoMarket @ http://aleph.nkp.cz/F/?func=find-b&request=01533484&find_code=SYS&local_base=nkc
2005 @ 05 @ 25 @ MotorSport @ http://aleph.nkp.cz/F/?func=find-b&request=01567679&find_code=SYS&local_base=nkc
2005 @ 05 @ 26 @ Music Life @ http://aleph.nkp.cz/F/?func=find-b&request=01567694&find_code=SYS&local_base=nkc
2005 @ 05 @ 27 @ Naše noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01567496&find_code=SYS&local_base=nkc
2005 @ 05 @ 28 @ Oftalmochirurgie @ http://aleph.nkp.cz/F/?func=find-b&request=01567434&find_code=SYS&local_base=nkc
2005 @ 05 @ 29 @ Ökologie in Tschechien @ http://aleph.nkp.cz/F/?func=find-b&request=01534310&find_code=SYS&local_base=nkc
2005 @ 05 @ 30 @ Osmisměrky města a obce @ http://aleph.nkp.cz/F/?func=find-b&request=01567715&find_code=SYS&local_base=nkc
2005 @ 05 @ 31 @ Osmisměrky politické anekdoty @ http://aleph.nkp.cz/F/?func=find-b&request=01567700&find_code=SYS&local_base=nkc
2005 @ 05 @ 32 @ Osmisměrky zámky @ http://aleph.nkp.cz/F/?func=find-b&request=01567721&find_code=SYS&local_base=nkc
2005 @ 05 @ 33 @ Prevence úrazů@ otrav a násilí', 'http://aleph.nkp.cz/F/?func=find-b&request=01567444&find_code=SYS&local_base=nkc
2005 @ 05 @ 34 @ Razdvatři @ http://aleph.nkp.cz/F/?func=find-b&request=01567508&find_code=SYS&local_base=nkc
2005 @ 05 @ 35 @ Senior revue @ http://aleph.nkp.cz/F/?func=find-b&request=01567757&find_code=SYS&local_base=nkc
2005 @ 05 @ 36 @ Stovka osmisměrek @ http://aleph.nkp.cz/F/?func=find-b&request=01567462&find_code=SYS&local_base=nkc
2005 @ 05 @ 37 @ Svět obchodu @ http://aleph.nkp.cz/F/?func=find-b&request=01533513&find_code=SYS&local_base=nkc
2005 @ 05 @ 38 @ Šach mat @ http://aleph.nkp.cz/F/?func=find-b&request=01567464&find_code=SYS&local_base=nkc
2005 @ 05 @ 39 @ Tuan tin moi @ http://aleph.nkp.cz/F/?func=find-b&request=01532642&find_code=SYS&local_base=nkc
2005 @ 05 @ 40 @ Týdeník Region press @ http://aleph.nkp.cz/F/?func=find-b&request=01533508&find_code=SYS&local_base=nkc
2005 @ 05 @ 41 @ Ústavní čtyřlístek @ http://aleph.nkp.cz/F/?func=find-b&request=01567455&find_code=SYS&local_base=nkc
2005 @ 05 @ 42 @ Vlastivědné listy Pardubického kraje @ http://aleph.nkp.cz/F/?func=find-b&request=01533502&find_code=SYS&local_base=nkc
2005 @ 06 @ 01 @ 4x doma @ http://aleph.nkp.cz/F/?func=find-b&request=01572190&find_code=SYS&local_base=nkc
2005 @ 06 @ 02 @ Dia styl @ http://aleph.nkp.cz/F/?func=find-b&request=01572247&find_code=SYS&local_base=nkc
2005 @ 06 @ 03 @ Digitální byt @ http://aleph.nkp.cz/F/?func=find-b&request=01569323&find_code=SYS&local_base=nkc
2005 @ 06 @ 04 @ Excerpta pharmaceutica @ http://aleph.nkp.cz/F/?func=find-b&request=01569652&find_code=SYS&local_base=nkc
2005 @ 06 @ 05 @ Filtráček @ http://aleph.nkp.cz/F/?func=find-b&request=01569656&find_code=SYS&local_base=nkc
2005 @ 06 @ 06 @ Hornobenešovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01572191&find_code=SYS&local_base=nkc
2005 @ 06 @ 07 @ HP Solution news @ http://aleph.nkp.cz/F/?func=find-b&request=01572155&find_code=SYS&local_base=nkc
2005 @ 06 @ 08 @ Hradecké listy Mladých konzervativců @ http://aleph.nkp.cz/F/?func=find-b&request=01569303&find_code=SYS&local_base=nkc
2005 @ 06 @ 09 @ Inzerce Mladoboleslavska a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=01569377&find_code=SYS&local_base=nkc
2005 @ 06 @ 10 @ Inzertní a informační harrachovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01569654&find_code=SYS&local_base=nkc
2005 @ 06 @ 11 @ Karlsbader Zeitung @ http://aleph.nkp.cz/F/?func=find-b&request=01569308&find_code=SYS&local_base=nkc
2005 @ 06 @ 12 @ Karosář @ http://aleph.nkp.cz/F/?func=find-b&request=01569695&find_code=SYS&local_base=nkc
2005 @ 06 @ 13 @ Kdyňsko @ http://aleph.nkp.cz/F/?func=find-b&request=01569767&find_code=SYS&local_base=nkc
2005 @ 06 @ 14 @ Knihovníci na radnici @ http://aleph.nkp.cz/F/?func=find-b&request=01569127&find_code=SYS&local_base=nkc
2005 @ 06 @ 15 @ Komenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01569294&find_code=SYS&local_base=nkc
2005 @ 06 @ 16 @ Krhanický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01569295&find_code=SYS&local_base=nkc
2005 @ 06 @ 17 @ Křížovky horoskopy @ http://aleph.nkp.cz/F/?func=find-b&request=01572200&find_code=SYS&local_base=nkc
2005 @ 06 @ 18 @ Křížovky pověsti @ http://aleph.nkp.cz/F/?func=find-b&request=01572197&find_code=SYS&local_base=nkc
2005 @ 06 @ 19 @ Křížovky s úsměvem @ http://aleph.nkp.cz/F/?func=find-b&request=01572194&find_code=SYS&local_base=nkc
2005 @ 06 @ 20 @ Křížovky speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01569661&find_code=SYS&local_base=nkc
2005 @ 06 @ 21 @ Kulturní měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=01569130&find_code=SYS&local_base=nkc
2005 @ 06 @ 22 @ Mentální retardace @ http://aleph.nkp.cz/F/?func=find-b&request=01569697&find_code=SYS&local_base=nkc
2005 @ 06 @ 23 @ Mgzn03 @ http://aleph.nkp.cz/F/?func=find-b&request=01569692&find_code=SYS&local_base=nkc
2005 @ 06 @ 24 @ MiniMax (Jčín/Turnov) @ http://aleph.nkp.cz/F/?func=find-b&request=01569991&find_code=SYS&local_base=nkc
2005 @ 06 @ 25 @ MiniMax (Strakonice-Písek) @ http://aleph.nkp.cz/F/?func=find-b&request=01569970&find_code=SYS&local_base=nkc
2005 @ 06 @ 26 @ Mittal Steel Ostrava @ http://aleph.nkp.cz/F/?func=find-b&request=01569693&find_code=SYS&local_base=nkc
2005 @ 06 @ 27 @ Muni.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01572256&find_code=SYS&local_base=nkc
2005 @ 06 @ 28 @ Na ostnu @ http://aleph.nkp.cz/F/?func=find-b&request=01569657&find_code=SYS&local_base=nkc
2005 @ 06 @ 29 @ Noviny Litvínovska @ http://aleph.nkp.cz/F/?func=find-b&request=01569649&find_code=SYS&local_base=nkc
2005 @ 06 @ 30 @ Nože a nástroje @ http://aleph.nkp.cz/F/?func=find-b&request=01572206&find_code=SYS&local_base=nkc
2005 @ 06 @ 31 @ Občasník : informační bulletin pro národnostní a etnické menšiny @ http://aleph.nkp.cz/F/?func=find-b&request=01569103&find_code=SYS&local_base=nkc
2005 @ 06 @ 32 @ Oliver revue @ http://aleph.nkp.cz/F/?func=find-b&request=01570376&find_code=SYS&local_base=nkc
2005 @ 06 @ 33 @ Orlické hory @ http://aleph.nkp.cz/F/?func=find-b&request=01569369&find_code=SYS&local_base=nkc
2005 @ 06 @ 34 @ Ostravské info @ http://aleph.nkp.cz/F/?func=find-b&request=01573045&find_code=SYS&local_base=nkc
2005 @ 06 @ 35 @ Panorama @ http://aleph.nkp.cz/F/?func=find-b&request=01573059&find_code=SYS&local_base=nkc
2005 @ 06 @ 36 @ Pharm business magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01569325&find_code=SYS&local_base=nkc
2005 @ 06 @ 37 @ Plav @ http://aleph.nkp.cz/F/?func=find-b&request=01572240&find_code=SYS&local_base=nkc
2005 @ 06 @ 38 @ Postgraduální onkologie @ http://aleph.nkp.cz/F/?func=find-b&request=01569339&find_code=SYS&local_base=nkc
2005 @ 06 @ 39 @ Pro auto @ http://aleph.nkp.cz/F/?func=find-b&request=01572187&find_code=SYS&local_base=nkc
2005 @ 06 @ 40 @ Proč ne?! @ http://aleph.nkp.cz/F/?func=find-b&request=01569118&find_code=SYS&local_base=nkc
2005 @ 06 @ 41 @ ProFem @ http://aleph.nkp.cz/F/?func=find-b&request=01572161&find_code=SYS&local_base=nkc
2005 @ 06 @ 42 @ Putimský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01569114&find_code=SYS&local_base=nkc
2005 @ 06 @ 43 @ Rohovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01569109&find_code=SYS&local_base=nkc
2005 @ 06 @ 44 @ Slovo detjam @ http://aleph.nkp.cz/F/?func=find-b&request=01573157&find_code=SYS&local_base=nkc
2005 @ 06 @ 45 @ Surfácké listy @ http://aleph.nkp.cz/F/?func=find-b&request=01572229&find_code=SYS&local_base=nkc
2005 @ 06 @ 46 @ Šternbersko @ http://aleph.nkp.cz/F/?func=find-b&request=01569632&find_code=SYS&local_base=nkc
2005 @ 06 @ 47 @ Team: Česko @ http://aleph.nkp.cz/F/?func=find-b&request=01569618&find_code=SYS&local_base=nkc
2005 @ 06 @ 48 @ Team: Energy @ http://aleph.nkp.cz/F/?func=find-b&request=01569625&find_code=SYS&local_base=nkc
2005 @ 06 @ 49 @ Tep regionu @ http://aleph.nkp.cz/F/?func=find-b&request=01569645&find_code=SYS&local_base=nkc
2005 @ 06 @ 50 @ Travel focus @ http://aleph.nkp.cz/F/?func=find-b&request=01569100&find_code=SYS&local_base=nkc
2005 @ 06 @ 51 @ Třetí oko @ http://aleph.nkp.cz/F/?func=find-b&request=01569638&find_code=SYS&local_base=nkc
2005 @ 06 @ 52 @ Třinecké a českotěšínské info @ http://aleph.nkp.cz/F/?func=find-b&request=01573042&find_code=SYS&local_base=nkc
2005 @ 06 @ 53 @ Víno&styl @ http://aleph.nkp.cz/F/?func=find-b&request=01569112&find_code=SYS&local_base=nkc
2005 @ 06 @ 54 @ Ze Štěpánova @ http://aleph.nkp.cz/F/?func=find-b&request=01569108&find_code=SYS&local_base=nkc
2005 @ 06 @ 55 @ Zpravodaj (CZP JM kraje) @ http://aleph.nkp.cz/F/?func=find-b&request=01569311&find_code=SYS&local_base=nkc
2005 @ 06 @ 56 @ Zpravodaj (Klub chovatelů psů leonbergerů ČR) @ http://aleph.nkp.cz/F/?func=find-b&request=01569320&find_code=SYS&local_base=nkc
2005 @ 06 @ 57 @ Zpravodaj městečka pod Skalkou @ http://aleph.nkp.cz/F/?func=find-b&request=01572231&find_code=SYS&local_base=nkc
2005 @ 06 @ 58 @ Zpravodaj společnosti AL INVEST Břidličná a.s. @ http://aleph.nkp.cz/F/?func=find-b&request=01572184&find_code=SYS&local_base=nkc
2005 @ 06 @ 59 @ Zpravodaj ústavů sociální péče pro management rezidenčních zařízení @ http://aleph.nkp.cz/F/?func=find-b&request=01569363&find_code=SYS&local_base=nkc
2005 @ 06 @ 60 @ Živaňák @ http://aleph.nkp.cz/F/?func=find-b&request=01572177&find_code=SYS&local_base=nkc
2005 @ 07 @ 80 @ Dolcký občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01578274&find_code=SYS&local_base=nkc
2005 @ 07 @ 79 @ team:Plynoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01580323&find_code=SYS&local_base=nkc
2005 @ 07 @ 77 @ team:SMP @ http://aleph.nkp.cz/F/?func=find-b&request=01580329&find_code=SYS&local_base=nkc
2005 @ 07 @ 78 @ team:ZČP @ http://aleph.nkp.cz/F/?func=find-b&request=01580326&find_code=SYS&local_base=nkc
2005 @ 07 @ 76 @ Bulletin pro moderní zelenou politiku @ http://aleph.nkp.cz/F/?func=find-b&request=01580334&find_code=SYS&local_base=nkc
2005 @ 07 @ 75 @ Dotoho z Vysočiny @ http://aleph.nkp.cz/F/?func=find-b&request=01580336&find_code=SYS&local_base=nkc
2005 @ 07 @ 74 @ Klášterecký samizdat @ http://aleph.nkp.cz/F/?func=find-b&request=01580339&find_code=SYS&local_base=nkc
2005 @ 07 @ 71 @ Super sex @ http://aleph.nkp.cz/F/?func=find-b&request=01579644&find_code=SYS&local_base=nkc
2005 @ 07 @ 73 @ Fitness & body building @ http://aleph.nkp.cz/F/?func=find-b&request=01580341&find_code=SYS&local_base=nkc
2005 @ 07 @ 72 @ Zpravodaj města Český Těšín @ http://aleph.nkp.cz/F/?func=find-b&request=01579631&find_code=SYS&local_base=nkc
2005 @ 07 @ 70 @ Tex : nový komiks @ http://aleph.nkp.cz/F/?func=find-b&request=01579628&find_code=SYS&local_base=nkc
2005 @ 07 @ 69 @ Regionální kamelot @ http://aleph.nkp.cz/F/?func=find-b&request=01579634&find_code=SYS&local_base=nkc
2005 @ 07 @ 68 @ Sportkař @ http://aleph.nkp.cz/F/?func=find-b&request=01579640&find_code=SYS&local_base=nkc
2005 @ 07 @ 65 @ Osmisměrky horoskopy @ http://aleph.nkp.cz/F/?func=find-b&request=01579647&find_code=SYS&local_base=nkc
2005 @ 07 @ 66 @ Osmisměrky sexy noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01579646&find_code=SYS&local_base=nkc
2005 @ 07 @ 67 @ Osmisměrky pověsti @ http://aleph.nkp.cz/F/?func=find-b&request=01579645&find_code=SYS&local_base=nkc
2005 @ 07 @ 64 @ Osmisměrky lásky @ http://aleph.nkp.cz/F/?func=find-b&request=01579655&find_code=SYS&local_base=nkc
2005 @ 07 @ 63 @ Pražský fotbalový týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=01579657&find_code=SYS&local_base=nkc
2005 @ 07 @ 61 @ Mag Real : realitní magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01578227&find_code=SYS&local_base=nkc
2005 @ 07 @ 62 @ Dřevo do domu @ http://aleph.nkp.cz/F/?func=find-b&request=01579661&find_code=SYS&local_base=nkc
2005 @ 07 @ 60 @ Jednička rad a tipů : snadné bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=01578231&find_code=SYS&local_base=nkc
2005 @ 07 @ 59 @ Jihomoravské hospodářství @ http://aleph.nkp.cz/F/?func=find-b&request=01578234&find_code=SYS&local_base=nkc
2005 @ 07 @ 57 @ mGuide : hudba do kapsy @ http://aleph.nkp.cz/F/?func=find-b&request=01578240&find_code=SYS&local_base=nkc
2005 @ 07 @ 58 @ Lišanský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01578238&find_code=SYS&local_base=nkc
2005 @ 07 @ 55 @ Contact! @ http://aleph.nkp.cz/F/?func=find-b&request=01578252&find_code=SYS&local_base=nkc
2005 @ 07 @ 56 @ Informační listy obce Krásno @ http://aleph.nkp.cz/F/?func=find-b&request=01578244&find_code=SYS&local_base=nkc
2005 @ 07 @ 53 @ E.ON Czech : časopis pro zaměstnance @ http://aleph.nkp.cz/F/?func=find-b&request=01578268&find_code=SYS&local_base=nkc
2005 @ 07 @ 54 @ Evropské listy Tomáše Zatloukala @ http://aleph.nkp.cz/F/?func=find-b&request=01578256&find_code=SYS&local_base=nkc
2005 @ 07 @ 52 @ IZIP e knížka : elektronická komunikace ve zdravotnicví @ http://aleph.nkp.cz/F/?func=find-b&request=01578270&find_code=SYS&local_base=nkc
2005 @ 07 @ 51 @ Datacentrum @ http://aleph.nkp.cz/F/?func=find-b&request=01578271&find_code=SYS&local_base=nkc
2005 @ 07 @ 50 @ Harrachovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01578273&find_code=SYS&local_base=nkc
2005 @ 07 @ 49 @ Šternberské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01578276&find_code=SYS&local_base=nkc
2005 @ 07 @ 47 @ Volný let : modelářský magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01578362&find_code=SYS&local_base=nkc
2005 @ 07 @ 48 @ Vaše pracovní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01578357&find_code=SYS&local_base=nkc
2005 @ 07 @ 46 @ Zpravodaj obce Svídnice @ http://aleph.nkp.cz/F/?func=find-b&request=01578363&find_code=SYS&local_base=nkc
2005 @ 07 @ 43 @ Zpravodaj ÚMO Pardubice III @ http://aleph.nkp.cz/F/?func=find-b&request=01578375&find_code=SYS&local_base=nkc
2005 @ 07 @ 44 @ Zpravodaj pro dobrovolníky@ hostitelské rodiny, studenty a spolupracovníky AFS Mezikulturní programy', 'http://aleph.nkp.cz/F/?func=find-b&request=01578373&find_code=SYS&local_base=nkc
2005 @ 07 @ 45 @ VCES Report @ http://aleph.nkp.cz/F/?func=find-b&request=01578366&find_code=SYS&local_base=nkc
2005 @ 07 @ 42 @ Mister NO @ http://aleph.nkp.cz/F/?func=find-b&request=01578130&find_code=SYS&local_base=nkc
2005 @ 07 @ 41 @ Dylan Dog @ http://aleph.nkp.cz/F/?func=find-b&request=01578135&find_code=SYS&local_base=nkc
2005 @ 07 @ 40 @ Nathan Never @ http://aleph.nkp.cz/F/?func=find-b&request=01578146&find_code=SYS&local_base=nkc
2005 @ 07 @ 39 @ ALD journal @ http://aleph.nkp.cz/F/?func=find-b&request=01578157&find_code=SYS&local_base=nkc
2005 @ 07 @ 38 @ AIMagazine @ http://aleph.nkp.cz/F/?func=find-b&request=01578159&find_code=SYS&local_base=nkc
2005 @ 07 @ 37 @ Auto Palace Spořilov News @ http://aleph.nkp.cz/F/?func=find-b&request=01578164&find_code=SYS&local_base=nkc
2005 @ 07 @ 36 @ Cardmag @ http://aleph.nkp.cz/F/?func=find-b&request=01578168&find_code=SYS&local_base=nkc
2005 @ 07 @ 35 @ Construct magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01578171&find_code=SYS&local_base=nkc
2005 @ 07 @ 33 @ DEKTIME : časopis společnosti Dektrade pro projektanty a architekty @ http://aleph.nkp.cz/F/?func=find-b&request=01578176&find_code=SYS&local_base=nkc
2005 @ 07 @ 34 @ Československý revital @ http://aleph.nkp.cz/F/?func=find-b&request=01578175&find_code=SYS&local_base=nkc
2005 @ 07 @ 32 @ Central reality group s.r.o. @ http://aleph.nkp.cz/F/?func=find-b&request=01578179&find_code=SYS&local_base=nkc
2005 @ 07 @ 31 @ Javornický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01578219&find_code=SYS&local_base=nkc
2005 @ 07 @ 30 @ Muzejní čtvrtletník @ http://aleph.nkp.cz/F/?func=find-b&request=01578220&find_code=SYS&local_base=nkc
2005 @ 07 @ 29 @ Aladin @ http://aleph.nkp.cz/F/?func=find-b&request=01578150&find_code=SYS&local_base=nkc
2005 @ 07 @ 28 @ Listy ODS @ http://aleph.nkp.cz/F/?func=find-b&request=01578221&find_code=SYS&local_base=nkc
2005 @ 07 @ 25 @ Écho des études Romanes @ http://aleph.nkp.cz/F/?func=find-b&request=01576294&find_code=SYS&local_base=nkc
2005 @ 07 @ 27 @ Naše vojsko @ http://aleph.nkp.cz/F/?func=find-b&request=01576300&find_code=SYS&local_base=nkc
2005 @ 07 @ 26 @ Autocesty @ http://aleph.nkp.cz/F/?func=find-b&request=01576292&find_code=SYS&local_base=nkc
2005 @ 07 @ 22 @ Nezávislý Chraštický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01576302&find_code=SYS&local_base=nkc
2005 @ 07 @ 23 @ Byty @ http://aleph.nkp.cz/F/?func=find-b&request=01576298&find_code=SYS&local_base=nkc
2005 @ 07 @ 24 @ Finanční management @ http://aleph.nkp.cz/F/?func=find-b&request=01576296&find_code=SYS&local_base=nkc
2005 @ 07 @ 21 @ Zpravodaj životního prostředí města Rakovníka @ http://aleph.nkp.cz/F/?func=find-b&request=01576306&find_code=SYS&local_base=nkc
2005 @ 07 @ 20 @ Zajímavosti v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=01576308&find_code=SYS&local_base=nkc
2005 @ 07 @ 19 @ Těžko říct @ http://aleph.nkp.cz/F/?func=find-b&request=01576314&find_code=SYS&local_base=nkc
2005 @ 07 @ 17 @ Ekologie a právo @ http://aleph.nkp.cz/F/?func=find-b&request=01576303&find_code=SYS&local_base=nkc
2005 @ 07 @ 18 @ Domažlické paradoxy @ http://aleph.nkp.cz/F/?func=find-b&request=01576305&find_code=SYS&local_base=nkc
2005 @ 07 @ 16 @ Obecní zpravodaj Horní Loděnice @ http://aleph.nkp.cz/F/?func=find-b&request=01576345&find_code=SYS&local_base=nkc
2005 @ 07 @ 15 @ Zpravodaj obecního úřadu ve Staříči @ http://aleph.nkp.cz/F/?func=find-b&request=01576346&find_code=SYS&local_base=nkc
2005 @ 07 @ 14 @ Rady a nápady @ http://aleph.nkp.cz/F/?func=find-b&request=01576347&find_code=SYS&local_base=nkc
2005 @ 07 @ 13 @ Zpravodaj : klub chovatelů německých krátkosrstých ohařů Praha @ http://aleph.nkp.cz/F/?func=find-b&request=01576349&find_code=SYS&local_base=nkc
2005 @ 07 @ 12 @ Tee time @ http://aleph.nkp.cz/F/?func=find-b&request=01576351&find_code=SYS&local_base=nkc
2005 @ 07 @ 11 @ Van Xuân @ http://aleph.nkp.cz/F/?func=find-b&request=01576343&find_code=SYS&local_base=nkc
2005 @ 07 @ 10 @ Země pohádek : nejlepší české večerníčky @ http://aleph.nkp.cz/F/?func=find-b&request=01574364&find_code=SYS&local_base=nkc
2005 @ 07 @ 09 @ Východokřesťanská studia @ http://aleph.nkp.cz/F/?func=find-b&request=01574369&find_code=SYS&local_base=nkc
2005 @ 07 @ 08 @ Imperial Life @ http://aleph.nkp.cz/F/?func=find-b&request=01574373&find_code=SYS&local_base=nkc
2005 @ 07 @ 07 @ Hnojické Expres @ http://aleph.nkp.cz/F/?func=find-b&request=01574375&find_code=SYS&local_base=nkc
2005 @ 07 @ 06 @ Hospodář : časopis o podnikání a lidech @ http://aleph.nkp.cz/F/?func=find-b&request=01574379&find_code=SYS&local_base=nkc
2005 @ 07 @ 05 @ Cestování včera a dnes @ http://aleph.nkp.cz/F/?func=find-b&request=01574399&find_code=SYS&local_base=nkc
2005 @ 07 @ 03 @ Jednička : měsíčník nejen o Praze 1 @ http://aleph.nkp.cz/F/?func=find-b&request=01574409&find_code=SYS&local_base=nkc
2005 @ 07 @ 04 @ Daňový expert : odborný daňový časopis @ http://aleph.nkp.cz/F/?func=find-b&request=01574383&find_code=SYS&local_base=nkc
2005 @ 07 @ 02 @ Havířovské info @ http://aleph.nkp.cz/F/?func=find-b&request=01574419&find_code=SYS&local_base=nkc
2005 @ 07 @ 01 @ Medicína pro praxi @ http://aleph.nkp.cz/F/?func=find-b&request=01574415&find_code=SYS&local_base=nkc
2005 @ 07 @ 81 @ Řáholníček @ http://aleph.nkp.cz/F/?func=find-b&request=01578668&find_code=SYS&local_base=nkc
2005 @ 07 @ 82 @ Aha! Sport @ http://aleph.nkp.cz/F/?func=find-b&request=01580343&find_code=SYS&local_base=nkc
2005 @ 09 @ 01 @ Beauty salon @ http://aleph.nkp.cz/F/?func=find-b&request=01583446&find_code=SYS&local_base=nkc
2005 @ 09 @ 02 @ Dějepisec @ http://aleph.nkp.cz/F/?func=find-b&request=01583456&find_code=SYS&local_base=nkc
2005 @ 09 @ 03 @ Druhý břeh @ http://aleph.nkp.cz/F/?func=find-b&request=01583459&find_code=SYS&local_base=nkc
2005 @ 09 @ 04 @ Horecké noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01583462&find_code=SYS&local_base=nkc
2005 @ 09 @ 05 @ Chodcův zprávydaj @ http://aleph.nkp.cz/F/?func=find-b&request=01583445&find_code=SYS&local_base=nkc
2005 @ 09 @ 06 @ Justiční aktuality @ http://aleph.nkp.cz/F/?func=find-b&request=01583498&find_code=SYS&local_base=nkc
2005 @ 09 @ 07 @ Luštění na léto @ http://aleph.nkp.cz/F/?func=find-b&request=01583500&find_code=SYS&local_base=nkc
2005 @ 09 @ 08 @ Pneuservis @ http://aleph.nkp.cz/F/?func=find-b&request=01581619&find_code=SYS&local_base=nkc
2005 @ 09 @ 09 @ Postgraduální psychologie @ http://aleph.nkp.cz/F/?func=find-b&request=01583510&find_code=SYS&local_base=nkc
2005 @ 09 @ 10 @ Skautský svět @ http://aleph.nkp.cz/F/?func=find-b&request=01583463&find_code=SYS&local_base=nkc
2005 @ 09 @ 11 @ SMO info @ http://aleph.nkp.cz/F/?func=find-b&request=01583507&find_code=SYS&local_base=nkc
2005 @ 09 @ 12 @ Sport v libereckém kraji @ http://aleph.nkp.cz/F/?func=find-b&request=01583453&find_code=SYS&local_base=nkc
2005 @ 09 @ 13 @ Škatulata batolata @ http://aleph.nkp.cz/F/?func=find-b&request=01583431&find_code=SYS&local_base=nkc
2005 @ 09 @ 14 @ TV pohoda @ http://aleph.nkp.cz/F/?func=find-b&request=01583438&find_code=SYS&local_base=nkc
2005 @ 09 @ 15 @ Týden v libereckém kraji @ http://aleph.nkp.cz/F/?func=find-b&request=01583452&find_code=SYS&local_base=nkc
2005 @ 09 @ 16 @ Zpravodaj české geologické společnosti @ http://aleph.nkp.cz/F/?func=find-b&request=01582736&find_code=SYS&local_base=nkc
2005 @ 10 @ 01 @ A2 @ http://aleph.nkp.cz/F/?func=find-b&request=01626828&find_code=SYS&local_base=nkc
2005 @ 10 @ 02 @ AC PRESS @ http://aleph.nkp.cz/F/?func=find-b&request=01626836&find_code=SYS&local_base=nkc
2005 @ 10 @ 03 @ AHOLD Express @ http://aleph.nkp.cz/F/?func=find-b&request=01626904&find_code=SYS&local_base=nkc
2005 @ 10 @ 04 @ Archeologie @ http://aleph.nkp.cz/F/?func=find-b&request=01584948&find_code=SYS&local_base=nkc
2005 @ 10 @ 05 @ Aura @ http://aleph.nkp.cz/F/?func=find-b&request=01584311&find_code=SYS&local_base=nkc
2005 @ 10 @ 06 @ Avízo služby a volný čas @ http://aleph.nkp.cz/F/?func=find-b&request=01627319&find_code=SYS&local_base=nkc
2005 @ 10 @ 07 @ BOZP & PO Aktuálně @ http://aleph.nkp.cz/F/?func=find-b&request=01584288&find_code=SYS&local_base=nkc
2005 @ 10 @ 08 @ Budějovický numismatik @ http://aleph.nkp.cz/F/?func=find-b&request=01628632&find_code=SYS&local_base=nkc
2005 @ 10 @ 09 @ CD Action @ http://aleph.nkp.cz/F/?func=find-b&request=01628618&find_code=SYS&local_base=nkc
2005 @ 10 @ 10 @ CIJ Central European @ http://aleph.nkp.cz/F/?func=find-b&request=01627038&find_code=SYS&local_base=nkc
2005 @ 10 @ 11 @ Cobra magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01626894&find_code=SYS&local_base=nkc
2005 @ 10 @ 12 @ Computer Business @ http://aleph.nkp.cz/F/?func=find-b&request=01584337&find_code=SYS&local_base=nkc
2005 @ 10 @ 13 @ Cykločtení @ http://aleph.nkp.cz/F/?func=find-b&request=01584333&find_code=SYS&local_base=nkc
2005 @ 10 @ 14 @ Český hasič @ http://aleph.nkp.cz/F/?func=find-b&request=01627078&find_code=SYS&local_base=nkc
2005 @ 10 @ 15 @ D-info @ http://aleph.nkp.cz/F/?func=find-b&request=01627051&find_code=SYS&local_base=nkc
2005 @ 10 @ 16 @ Dveře dělají domov @ http://aleph.nkp.cz/F/?func=find-b&request=01584278&find_code=SYS&local_base=nkc
2005 @ 10 @ 17 @ Echo @ http://aleph.nkp.cz/F/?func=find-b&request=01626833&find_code=SYS&local_base=nkc
2005 @ 10 @ 18 @ Fajn magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01627070&find_code=SYS&local_base=nkc
2005 @ 10 @ 19 @ FIRED @ http://aleph.nkp.cz/F/?func=find-b&request=01627055&find_code=SYS&local_base=nkc
2005 @ 10 @ 20 @ GameOn @ http://aleph.nkp.cz/F/?func=find-b&request=01627046&find_code=SYS&local_base=nkc
2005 @ 10 @ 21 @ Grand auto-moto @ http://aleph.nkp.cz/F/?func=find-b&request=01627195&find_code=SYS&local_base=nkc
2005 @ 10 @ 22 @ Grand bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=01628687&find_code=SYS&local_base=nkc
2005 @ 10 @ 23 @ Hadrián @ http://aleph.nkp.cz/F/?func=find-b&request=01626897&find_code=SYS&local_base=nkc
2005 @ 10 @ 24 @ Harašššení @ http://aleph.nkp.cz/F/?func=find-b&request=01628625&find_code=SYS&local_base=nkc
2005 @ 10 @ 25 @ HOCHTIEF @ http://aleph.nkp.cz/F/?func=find-b&request=01584298&find_code=SYS&local_base=nkc
2005 @ 10 @ 26 @ Hornobenešovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01627041&find_code=SYS&local_base=nkc
2005 @ 10 @ 27 @ Inter Art Bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=01584296&find_code=SYS&local_base=nkc
2005 @ 10 @ 28 @ Jihomoravské poštovní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01626866&find_code=SYS&local_base=nkc
2005 @ 10 @ 29 @ Koktejl @ http://aleph.nkp.cz/F/?func=find-b&request=01584303&find_code=SYS&local_base=nkc
2005 @ 10 @ 30 @ Koktejl special : geografický magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01628628&find_code=SYS&local_base=nkc
2005 @ 10 @ 31 @ Lucky star @ http://aleph.nkp.cz/F/?func=find-b&request=01584949&find_code=SYS&local_base=nkc
2005 @ 10 @ 32 @ Na správné cestě @ http://aleph.nkp.cz/F/?func=find-b&request=01627205&find_code=SYS&local_base=nkc
2005 @ 10 @ 33 @ Nauč mě@ maminko', 'http://aleph.nkp.cz/F/?func=find-b&request=01582732&find_code=SYS&local_base=nkc
2005 @ 10 @ 34 @ Nová naděje na každý den @ http://aleph.nkp.cz/F/?func=find-b&request=01584340&find_code=SYS&local_base=nkc
2005 @ 10 @ 35 @ Obratel @ http://aleph.nkp.cz/F/?func=find-b&request=01628788&find_code=SYS&local_base=nkc
2005 @ 10 @ 36 @ Optica moda @ http://aleph.nkp.cz/F/?func=find-b&request=01627987&find_code=SYS&local_base=nkc
2005 @ 10 @ 37 @ Praktické lékarenství @ http://aleph.nkp.cz/F/?func=find-b&request=01628253&find_code=SYS&local_base=nkc
2005 @ 10 @ 38 @ Regal : marketing a management obchodu @ http://aleph.nkp.cz/F/?func=find-b&request=01628815&find_code=SYS&local_base=nkc
2005 @ 10 @ 39 @ Reliant News @ http://aleph.nkp.cz/F/?func=find-b&request=01628278&find_code=SYS&local_base=nkc
2005 @ 10 @ 40 @ Rotary @ http://aleph.nkp.cz/F/?func=find-b&request=01628295&find_code=SYS&local_base=nkc
2005 @ 10 @ 41 @ Rozhraní : časopis sdružující třebíčské školy @ http://aleph.nkp.cz/F/?func=find-b&request=01628805&find_code=SYS&local_base=nkc
2005 @ 10 @ 42 @ Senátorský kurýr : Prostějovsko -Kojetínsko @ http://aleph.nkp.cz/F/?func=find-b&request=01628604&find_code=SYS&local_base=nkc
2005 @ 10 @ 43 @ Sirius & Naut : svět čima našich a zahraničních reportérů @ http://aleph.nkp.cz/F/?func=find-b&request=01584354&find_code=SYS&local_base=nkc
2005 @ 10 @ 44 @ Studánka : čtvrtletník pro rodiče a vychovatele předškoláků @ http://aleph.nkp.cz/F/?func=find-b&request=01627352&find_code=SYS&local_base=nkc
2005 @ 10 @ 45 @ Studio zone @ http://aleph.nkp.cz/F/?func=find-b&request=01628594&find_code=SYS&local_base=nkc
2005 @ 10 @ 46 @ Svět dinosaurů @ http://aleph.nkp.cz/F/?func=find-b&request=01627701&find_code=SYS&local_base=nkc
2005 @ 10 @ 47 @ Svobodná cesta : časopis obce unitářů v Plzni @ http://aleph.nkp.cz/F/?func=find-b&request=01626861&find_code=SYS&local_base=nkc
2005 @ 10 @ 48 @ Swiet Swietelsky @ http://aleph.nkp.cz/F/?func=find-b&request=01627206&find_code=SYS&local_base=nkc
2005 @ 10 @ 49 @ Šíp : Praha @ http://aleph.nkp.cz/F/?func=find-b&request=01627463&find_code=SYS&local_base=nkc
2005 @ 10 @ 50 @ Šťastná třináctka @ http://aleph.nkp.cz/F/?func=find-b&request=01627995&find_code=SYS&local_base=nkc
2005 @ 10 @ 51 @ Talisman pro vaše dítě @ http://aleph.nkp.cz/F/?func=find-b&request=01628796&find_code=SYS&local_base=nkc
2005 @ 10 @ 52 @ Terezka : zpravodaj občanů města Terezín @ http://aleph.nkp.cz/F/?func=find-b&request=01628599&find_code=SYS&local_base=nkc
2005 @ 10 @ 53 @ Tipy & zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01627973&find_code=SYS&local_base=nkc
2005 @ 10 @ 54 @ Trnkoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01626843&find_code=SYS&local_base=nkc
2005 @ 10 @ 55 @ TV program @ http://aleph.nkp.cz/F/?func=find-b&request=01628133&find_code=SYS&local_base=nkc
2005 @ 10 @ 56 @ Týdeník Zlínska @ http://aleph.nkp.cz/F/?func=find-b&request=01627338&find_code=SYS&local_base=nkc
2005 @ 10 @ 57 @ Včelička @ http://aleph.nkp.cz/F/?func=find-b&request=01626864&find_code=SYS&local_base=nkc
2005 @ 10 @ 58 @ Vranovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01628636&find_code=SYS&local_base=nkc
2005 @ 10 @ 59 @ Vrbecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01627209&find_code=SYS&local_base=nkc
2005 @ 10 @ 60 @ Zajímá vás? : zpravodaj Českých lupkových závodů a.s. @ http://aleph.nkp.cz/F/?func=find-b&request=01627905&find_code=SYS&local_base=nkc
2005 @ 10 @ 61 @ Zpravodaj: obec Přáslavice s osadou Kocourovec @ http://aleph.nkp.cz/F/?func=find-b&request=01627922&find_code=SYS&local_base=nkc
2005 @ 10 @ 62 @ Zpravodaj : povodí Moravy @ http://aleph.nkp.cz/F/?func=find-b&request=01628615&find_code=SYS&local_base=nkc
2005 @ 10 @ 63 @ Zpravodajství : Brniště@ Luhova, Velkého Grunova', 'http://aleph.nkp.cz/F/?func=find-b&request=01627911&find_code=SYS&local_base=nkc
2005 @ 10 @ 64 @ Žena a kuchyně @ http://aleph.nkp.cz/F/?func=find-b&request=01627786&find_code=SYS&local_base=nkc
2005 @ 11 @ 01 @ A10 Kde? @ http://aleph.nkp.cz/F/?func=find-b&request=01633043&find_code=SYS&local_base=nkc
2005 @ 11 @ 02 @ Ad architektura @ http://aleph.nkp.cz/F/?func=find-b&request=01632516&find_code=SYS&local_base=nkc
2005 @ 11 @ 03 @ Arena: sportovní měsíčník Jindřichohradecka @ http://aleph.nkp.cz/F/?func=find-b&request=01631625&find_code=SYS&local_base=nkc
2005 @ 11 @ 04 @ BB Centrum Review @ http://aleph.nkp.cz/F/?func=find-b&request=01633037&find_code=SYS&local_base=nkc
2005 @ 11 @ 05 @ BROOM : czech karting magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01629757&find_code=SYS&local_base=nkc
2005 @ 11 @ 06 @ Bydlení & styl @ http://aleph.nkp.cz/F/?func=find-b&request=01629925&find_code=SYS&local_base=nkc
2005 @ 11 @ 07 @ Czech Hospitality and Tourism Papers @ http://aleph.nkp.cz/F/?func=find-b&request=01629949&find_code=SYS&local_base=nkc
2005 @ 11 @ 08 @ Detektiv Carter @ http://aleph.nkp.cz/F/?func=find-b&request=01633263&find_code=SYS&local_base=nkc
2005 @ 11 @ 09 @ Developer @ http://aleph.nkp.cz/F/?func=find-b&request=01630668&find_code=SYS&local_base=nkc
2005 @ 11 @ 10 @ Dobrá kniha @ http://aleph.nkp.cz/F/?func=find-b&request=01632971&find_code=SYS&local_base=nkc
2005 @ 11 @ 11 @ Dům a projekt @ http://aleph.nkp.cz/F/?func=find-b&request=01629718&find_code=SYS&local_base=nkc
2005 @ 11 @ 12 @ Dvořák : obchodní dům Tábor @ http://aleph.nkp.cz/F/?func=find-b&request=01632994&find_code=SYS&local_base=nkc
2005 @ 11 @ 13 @ EDA : avaluace@ data, analýzy', 'http://aleph.nkp.cz/F/?func=find-b&request=01633033&find_code=SYS&local_base=nkc
2005 @ 11 @ 14 @ Ego @ http://aleph.nkp.cz/F/?func=find-b&request=01632986&find_code=SYS&local_base=nkc
2005 @ 11 @ 15 @ €uro babička @ http://aleph.nkp.cz/F/?func=find-b&request=01629733&find_code=SYS&local_base=nkc
2005 @ 11 @ 16 @ Expres : inzerce@ informace', 'http://aleph.nkp.cz/F/?func=find-b&request=01633203&find_code=SYS&local_base=nkc
2005 @ 11 @ 17 @ Fashion club @ http://aleph.nkp.cz/F/?func=find-b&request=01631631&find_code=SYS&local_base=nkc
2005 @ 11 @ 18 @ Florence : časopis moderního ošetřovatelství @ http://aleph.nkp.cz/F/?func=find-b&request=01632512&find_code=SYS&local_base=nkc
2005 @ 11 @ 19 @ Fresh magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01629923&find_code=SYS&local_base=nkc
2005 @ 11 @ 20 @ GEO @ http://aleph.nkp.cz/F/?func=find-b&request=01629913&find_code=SYS&local_base=nkc
2005 @ 11 @ 21 @ Gong mladoboleslavska @ http://aleph.nkp.cz/F/?func=find-b&request=01633004&find_code=SYS&local_base=nkc
2005 @ 11 @ 22 @ Green fee @ http://aleph.nkp.cz/F/?func=find-b&request=01632957&find_code=SYS&local_base=nkc
2005 @ 11 @ 23 @ Heuréka : časopis studentů Gymnázia a Střední pedagogické školy v Nové Pace @ http://aleph.nkp.cz/F/?func=find-b&request=01633015&find_code=SYS&local_base=nkc
2005 @ 11 @ 24 @ Chef gurmán @ http://aleph.nkp.cz/F/?func=find-b&request=01633229&find_code=SYS&local_base=nkc
2005 @ 11 @ 25 @ Intelektuál @ http://aleph.nkp.cz/F/?func=find-b&request=01630468&find_code=SYS&local_base=nkc
2005 @ 11 @ 26 @ Jičínský posel @ http://aleph.nkp.cz/F/?func=find-b&request=01632992&find_code=SYS&local_base=nkc
2005 @ 11 @ 27 @ Joy @ http://aleph.nkp.cz/F/?func=find-b&request=01630102&find_code=SYS&local_base=nkc
2005 @ 11 @ 28 @ Komerční reality @ http://aleph.nkp.cz/F/?func=find-b&request=01633028&find_code=SYS&local_base=nkc
2005 @ 11 @ 29 @ KOSTAL tip @ http://aleph.nkp.cz/F/?func=find-b&request=01633013&find_code=SYS&local_base=nkc
2005 @ 11 @ 30 @ Křížovkář @ http://aleph.nkp.cz/F/?func=find-b&request=01630716&find_code=SYS&local_base=nkc
2005 @ 11 @ 31 @ Křížovky lásky @ http://aleph.nkp.cz/F/?func=find-b&request=01633261&find_code=SYS&local_base=nkc
2005 @ 11 @ 32 @ Křížovky s úsměvem @ http://aleph.nkp.cz/F/?func=find-b&request=01633255&find_code=SYS&local_base=nkc
2005 @ 11 @ 33 @ Napínavé detektivky @ http://aleph.nkp.cz/F/?func=find-b&request=01633250&find_code=SYS&local_base=nkc
2005 @ 11 @ 34 @ Mobilní rádce @ http://aleph.nkp.cz/F/?func=find-b&request=01629743&find_code=SYS&local_base=nkc
2005 @ 11 @ 35 @ Novera @ http://aleph.nkp.cz/F/?func=find-b&request=01633001&find_code=SYS&local_base=nkc
2005 @ 11 @ 36 @ Obecní zpravodaj Medlov @ http://aleph.nkp.cz/F/?func=find-b&request=01629765&find_code=SYS&local_base=nkc
2005 @ 11 @ 37 @ OptoTimes @ http://aleph.nkp.cz/F/?func=find-b&request=01630110&find_code=SYS&local_base=nkc
2005 @ 11 @ 38 @ Orienteering today @ http://aleph.nkp.cz/F/?func=find-b&request=01633226&find_code=SYS&local_base=nkc
2005 @ 11 @ 39 @ Parlament vláda samospráva @ http://aleph.nkp.cz/F/?func=find-b&request=01630821&find_code=SYS&local_base=nkc
2005 @ 11 @ 40 @ Pecka! @ http://aleph.nkp.cz/F/?func=find-b&request=01630832&find_code=SYS&local_base=nkc
2005 @ 11 @ 41 @ Plemo report @ http://aleph.nkp.cz/F/?func=find-b&request=01632139&find_code=SYS&local_base=nkc
2005 @ 11 @ 42 @ Poutník : časopis obce unitářů v Brně @ http://aleph.nkp.cz/F/?func=find-b&request=01631148&find_code=SYS&local_base=nkc
2005 @ 11 @ 43 @ Popron : svět zábavy @ http://aleph.nkp.cz/F/?func=find-b&request=01630976&find_code=SYS&local_base=nkc
2005 @ 11 @ 44 @ Programová nabídka @ http://aleph.nkp.cz/F/?func=find-b&request=01632359&find_code=SYS&local_base=nkc
2005 @ 11 @ 45 @ Ražický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01633222&find_code=SYS&local_base=nkc
2005 @ 11 @ 46 @ Rozkvět @ http://aleph.nkp.cz/F/?func=find-b&request=01630968&find_code=SYS&local_base=nkc
2005 @ 11 @ 47 @ Sestra v diabetologii @ http://aleph.nkp.cz/F/?func=find-b&request=01630079&find_code=SYS&local_base=nkc
2005 @ 11 @ 48 @ Strupčický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01630984&find_code=SYS&local_base=nkc
2005 @ 11 @ 49 @ Středník : časopis studentské unie ČVUT @ http://aleph.nkp.cz/F/?func=find-b&request=01632136&find_code=SYS&local_base=nkc
2005 @ 11 @ 50 @ Svět mobilů @ http://aleph.nkp.cz/F/?func=find-b&request=01630148&find_code=SYS&local_base=nkc
2005 @ 11 @ 51 @ Šipkař : měsíčník hráčů šipek @ http://aleph.nkp.cz/F/?func=find-b&request=01630824&find_code=SYS&local_base=nkc
2005 @ 11 @ 52 @ Šumava hovoří @ http://aleph.nkp.cz/F/?func=find-b&request=01633208&find_code=SYS&local_base=nkc
2005 @ 11 @ 53 @ Team: Plynárník @ http://aleph.nkp.cz/F/?func=find-b&request=01632153&find_code=SYS&local_base=nkc
2005 @ 11 @ 54 @ Team: Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01632155&find_code=SYS&local_base=nkc
2005 @ 11 @ 55 @ Team: Transgas @ http://aleph.nkp.cz/F/?func=find-b&request=01632170&find_code=SYS&local_base=nkc
2005 @ 11 @ 56 @ Team: Ventil @ http://aleph.nkp.cz/F/?func=find-b&request=01632161&find_code=SYS&local_base=nkc
2005 @ 11 @ 57 @ The Alsoran @ http://aleph.nkp.cz/F/?func=find-b&request=01631231&find_code=SYS&local_base=nkc
2005 @ 11 @ 58 @ Stavebnice rodinných domů @ http://aleph.nkp.cz/F/?func=find-b&request=01290124&find_code=SYS&local_base=nkc
2005 @ 11 @ 59 @ Tradice @ http://aleph.nkp.cz/F/?func=find-b&request=01629749&find_code=SYS&local_base=nkc
2005 @ 11 @ 60 @ Tschechisch-deutsche Zusammenhänge @ http://aleph.nkp.cz/F/?func=find-b&request=01628265&find_code=SYS&local_base=nkc
2005 @ 11 @ 61 @ Tuân Tin @ http://aleph.nkp.cz/F/?func=find-b&request=01629447&find_code=SYS&local_base=nkc
2005 @ 11 @ 62 @ Týdeník Kroměřížska @ http://aleph.nkp.cz/F/?func=find-b&request=01632950&find_code=SYS&local_base=nkc
2005 @ 11 @ 63 @ Valašskomeziříčský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01633211&find_code=SYS&local_base=nkc
2005 @ 11 @ 64 @ Vegetarián & Vegan @ http://aleph.nkp.cz/F/?func=find-b&request=01630123&find_code=SYS&local_base=nkc
2005 @ 11 @ 65 @ Vintířovský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01627783&find_code=SYS&local_base=nkc
2005 @ 11 @ 66 @ Vlastní cestou @ http://aleph.nkp.cz/F/?func=find-b&request=01630093&find_code=SYS&local_base=nkc
2005 @ 11 @ 67 @ Výzva @ http://aleph.nkp.cz/F/?func=find-b&request=01630972&find_code=SYS&local_base=nkc
2005 @ 11 @ 68 @ Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01630817&find_code=SYS&local_base=nkc
2005 @ 11 @ 69 @ Zpravodaj ČBA @ http://aleph.nkp.cz/F/?func=find-b&request=01630816&find_code=SYS&local_base=nkc
2005 @ 11 @ 70 @ Zpravodaj Hostěnice @ http://aleph.nkp.cz/F/?func=find-b&request=01628637&find_code=SYS&local_base=nkc
2005 @ 11 @ 71 @ Zvon @ http://aleph.nkp.cz/F/?func=find-b&request=01631142&find_code=SYS&local_base=nkc
2005 @ 12 @ 07 @ VKŠ news @ http://aleph.nkp.cz/F/?func=find-b&request=01634087&find_code=SYS&local_base=nkc
2005 @ 12 @ 06 @ Tvstar @ http://aleph.nkp.cz/F/?func=find-b&request=01634084&find_code=SYS&local_base=nkc
2005 @ 12 @ 05 @ Sociální studia @ http://aleph.nkp.cz/F/?func=find-b&request=01634075&find_code=SYS&local_base=nkc
2005 @ 12 @ 02 @ Dotační věstník @ http://aleph.nkp.cz/F/?func=find-b&request=01634921&find_code=SYS&local_base=nkc
2005 @ 12 @ 03 @ HRM : human resources management @ http://aleph.nkp.cz/F/?func=find-b&request=01634092&find_code=SYS&local_base=nkc
2005 @ 12 @ 04 @ Inovace : časopis divize kompresory @ http://aleph.nkp.cz/F/?func=find-b&request=01634912&find_code=SYS&local_base=nkc
2005 @ 12 @ 01 @ Arnika @ http://aleph.nkp.cz/F/?func=find-b&request=01634080&find_code=SYS&local_base=nkc
2006 @ 02 @ 01 @ Blesk hobby @ http://aleph.nkp.cz/F/?func=find-b&request=01642885&find_code=SYS&local_base=nkc
2006 @ 01 @ 17 @ Zpravodaj moravskobudějovicka @ http://aleph.nkp.cz/F/?func=find-b&request=01638259&find_code=SYS&local_base=nkc
2006 @ 01 @ 16 @ Su-do-ku : výherní @ http://aleph.nkp.cz/F/?func=find-b&request=01637584&find_code=SYS&local_base=nkc
2006 @ 01 @ 15 @ Přehled : magazín nejen o kultuře @ http://aleph.nkp.cz/F/?func=find-b&request=01637601&find_code=SYS&local_base=nkc
2006 @ 01 @ 14 @ Porodní asistence @ http://aleph.nkp.cz/F/?func=find-b&request=01637605&find_code=SYS&local_base=nkc
2006 @ 01 @ 13 @ PhotoArt @ http://aleph.nkp.cz/F/?func=find-b&request=01637589&find_code=SYS&local_base=nkc
2006 @ 01 @ 12 @ Perfect Girls @ http://aleph.nkp.cz/F/?func=find-b&request=01637574&find_code=SYS&local_base=nkc
2006 @ 01 @ 11 @ Motorsport magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01637572&find_code=SYS&local_base=nkc
2006 @ 01 @ 10 @ Nedělní sport @ http://aleph.nkp.cz/F/?func=find-b&request=01639315&find_code=SYS&local_base=nkc
2006 @ 01 @ 09 @ Listy moravskoslezské @ http://aleph.nkp.cz/F/?func=find-b&request=01639337&find_code=SYS&local_base=nkc
2006 @ 01 @ 08 @ Krasováček : zpravodaj obce Krasov @ http://aleph.nkp.cz/F/?func=find-b&request=01639327&find_code=SYS&local_base=nkc
2006 @ 01 @ 07 @ Korytňanské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01637569&find_code=SYS&local_base=nkc
2006 @ 01 @ 06 @ Karelský dnešek @ http://aleph.nkp.cz/F/?func=find-b&request=01639316&find_code=SYS&local_base=nkc
2006 @ 01 @ 05 @ Extra čtení Bédy Trávníčka @ http://aleph.nkp.cz/F/?func=find-b&request=01637581&find_code=SYS&local_base=nkc
2006 @ 01 @ 04 @ Dnešní svět @ http://aleph.nkp.cz/F/?func=find-b&request=01639346&find_code=SYS&local_base=nkc
2006 @ 01 @ 03 @ Agronom @ http://aleph.nkp.cz/F/?func=find-b&request=01639366&find_code=SYS&local_base=nkc
2006 @ 01 @ 02 @ Agromanuál @ http://aleph.nkp.cz/F/?func=find-b&request=01639370&find_code=SYS&local_base=nkc
2006 @ 01 @ 01 @ 24 hodin @ http://aleph.nkp.cz/F/?func=find-b&request=01635947&find_code=SYS&local_base=nkc
2006 @ 02 @ 02 @ Creative Amos : inspirace pro vaši tvořivost @ http://aleph.nkp.cz/F/?func=find-b&request=01639358&find_code=SYS&local_base=nkc
2006 @ 02 @ 03 @ Daně a finance @ http://aleph.nkp.cz/F/?func=find-b&request=01642822&find_code=SYS&local_base=nkc
2006 @ 02 @ 04 @ Direkt : časopis pro Direkt marketing @ http://aleph.nkp.cz/F/?func=find-b&request=01642851&find_code=SYS&local_base=nkc
2006 @ 02 @ 05 @ Golempress : vaše barevné inzertní noviny pro oblast Trutnovska a Jičínska @ http://aleph.nkp.cz/F/?func=find-b&request=01643141&find_code=SYS&local_base=nkc
2006 @ 02 @ 06 @ Golempress : vaše barevné inzertní noviny pro oblast Šumperska @ http://aleph.nkp.cz/F/?func=find-b&request=01643139&find_code=SYS&local_base=nkc
2006 @ 02 @ 07 @ Harmonie domova @ http://aleph.nkp.cz/F/?func=find-b&request=01642899&find_code=SYS&local_base=nkc
2006 @ 02 @ 08 @ Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01642876&find_code=SYS&local_base=nkc
2006 @ 02 @ 09 @ Hustopečský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01640762&find_code=SYS&local_base=nkc
2006 @ 02 @ 10 @ Jihočeský inzert expres speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01642911&find_code=SYS&local_base=nkc
2006 @ 02 @ 11 @ Impulsy Severozápadu @ http://aleph.nkp.cz/F/?func=find-b&request=01640757&find_code=SYS&local_base=nkc
2006 @ 02 @ 12 @ Katka speciál sudoku @ http://aleph.nkp.cz/F/?func=find-b&request=01642863&find_code=SYS&local_base=nkc
2006 @ 02 @ 13 @ Konkurs a vyrovnání @ http://aleph.nkp.cz/F/?func=find-b&request=01640748&find_code=SYS&local_base=nkc
2006 @ 02 @ 14 @ Motohouse katalog @ http://aleph.nkp.cz/F/?func=find-b&request=01643230&find_code=SYS&local_base=nkc
2006 @ 02 @ 15 @ NA-MAX @ http://aleph.nkp.cz/F/?func=find-b&request=01642829&find_code=SYS&local_base=nkc
2006 @ 02 @ 16 @ Naše Slovácko @ http://aleph.nkp.cz/F/?func=find-b&request=01642842&find_code=SYS&local_base=nkc
2006 @ 02 @ 17 @ Náš úhel pohledu @ http://aleph.nkp.cz/F/?func=find-b&request=01642840&find_code=SYS&local_base=nkc
2006 @ 02 @ 18 @ Noviny VVUÚ @ http://aleph.nkp.cz/F/?func=find-b&request=01642838&find_code=SYS&local_base=nkc
2006 @ 02 @ 19 @ Nymburský demokrat @ http://aleph.nkp.cz/F/?func=find-b&request=01642833&find_code=SYS&local_base=nkc
2006 @ 02 @ 20 @ Právo pro podnikání a zaměstnání @ http://aleph.nkp.cz/F/?func=find-b&request=01640775&find_code=SYS&local_base=nkc
2006 @ 02 @ 21 @ RC cars @ http://aleph.nkp.cz/F/?func=find-b&request=01640767&find_code=SYS&local_base=nkc
2006 @ 03 @ 01 @ Active beauty @ http://aleph.nkp.cz/F/?func=find-b&request=01645736&find_code=SYS&local_base=nkc
2006 @ 03 @ 02 @ Alarm revue hasičů a záchranářů @ http://aleph.nkp.cz/F/?func=find-b&request=01644786&find_code=SYS&local_base=nkc
2006 @ 03 @ 03 @ Amatérský tenis @ http://aleph.nkp.cz/F/?func=find-b&request=01648985&find_code=SYS&local_base=nkc
2006 @ 03 @ 04 @ Apoštol Božího milosrdenství @ http://aleph.nkp.cz/F/?func=find-b&request=01648350&find_code=SYS&local_base=nkc
2006 @ 03 @ 05 @ Autodesign & styling @ http://aleph.nkp.cz/F/?func=find-b&request=01647366&find_code=SYS&local_base=nkc
2006 @ 03 @ 06 @ Benjamín Kvítko @ http://aleph.nkp.cz/F/?func=find-b&request=01645720&find_code=SYS&local_base=nkc
2006 @ 03 @ 07 @ Big kontakt @ http://aleph.nkp.cz/F/?func=find-b&request=01647560&find_code=SYS&local_base=nkc
2006 @ 03 @ 08 @ Blšanské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01648177&find_code=SYS&local_base=nkc
2006 @ 03 @ 09 @ Bohutínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01644756&find_code=SYS&local_base=nkc
2006 @ 03 @ 10 @ Boskovické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01644762&find_code=SYS&local_base=nkc
2006 @ 03 @ 11 @ Budejovice : magazín českobudějovicka @ http://aleph.nkp.cz/F/?func=find-b&request=01645654&find_code=SYS&local_base=nkc
2006 @ 03 @ 12 @ Cvikr @ http://aleph.nkp.cz/F/?func=find-b&request=01644767&find_code=SYS&local_base=nkc
2006 @ 03 @ 13 @ Českomoravský sporťák @ http://aleph.nkp.cz/F/?func=find-b&request=01644807&find_code=SYS&local_base=nkc
2006 @ 03 @ 14 @ Český pacient @ http://aleph.nkp.cz/F/?func=find-b&request=01647605&find_code=SYS&local_base=nkc
2006 @ 03 @ 15 @ Divišovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01648182&find_code=SYS&local_base=nkc
2006 @ 03 @ 16 @ Doba seniorů @ http://aleph.nkp.cz/F/?func=find-b&request=01645751&find_code=SYS&local_base=nkc
2006 @ 03 @ 17 @ Doba seniorů : první noviny českých seniorů @ http://aleph.nkp.cz/F/?func=find-b&request=01645742&find_code=SYS&local_base=nkc
2006 @ 03 @ 18 @ Dovolená pro Vás @ http://aleph.nkp.cz/F/?func=find-b&request=01644787&find_code=SYS&local_base=nkc
2006 @ 03 @ 19 @ Dvoje noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01644809&find_code=SYS&local_base=nkc
2006 @ 03 @ 20 @ ELTODO magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01645695&find_code=SYS&local_base=nkc
2006 @ 03 @ 21 @ Event & promotion @ http://aleph.nkp.cz/F/?func=find-b&request=01644753&find_code=SYS&local_base=nkc
2006 @ 03 @ 22 @ Farmakoekonomika @ http://aleph.nkp.cz/F/?func=find-b&request=01647598&find_code=SYS&local_base=nkc
2006 @ 03 @ 23 @ Farmakoterapie @ http://aleph.nkp.cz/F/?func=find-b&request=01648992&find_code=SYS&local_base=nkc
2006 @ 03 @ 24 @ Film na sobotu @ http://aleph.nkp.cz/F/?func=find-b&request=01645708&find_code=SYS&local_base=nkc
2006 @ 03 @ 25 @ Eurotel GO @ http://aleph.nkp.cz/F/?func=find-b&request=01647410&find_code=SYS&local_base=nkc
2006 @ 03 @ 26 @ Home Cinema @ http://aleph.nkp.cz/F/?func=find-b&request=01645190&find_code=SYS&local_base=nkc
2006 @ 03 @ 27 @ Hradecké noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01644811&find_code=SYS&local_base=nkc
2006 @ 03 @ 28 @ Inspirace @ http://aleph.nkp.cz/F/?func=find-b&request=01648973&find_code=SYS&local_base=nkc
2006 @ 03 @ 29 @ JIHO.ČESKÉNOVINKY.CZ @ http://aleph.nkp.cz/F/?func=find-b&request=01647562&find_code=SYS&local_base=nkc
2006 @ 03 @ 30 @ Komora CZ @ http://aleph.nkp.cz/F/?func=find-b&request=01645679&find_code=SYS&local_base=nkc
2006 @ 03 @ 31 @ Křížovky z lékárny @ http://aleph.nkp.cz/F/?func=find-b&request=01644772&find_code=SYS&local_base=nkc
2006 @ 03 @ 32 @ Křížovky koumes @ http://aleph.nkp.cz/F/?func=find-b&request=01644775&find_code=SYS&local_base=nkc
2006 @ 03 @ 33 @ Křížovky do tašky @ http://aleph.nkp.cz/F/?func=find-b&request=01644768&find_code=SYS&local_base=nkc
2006 @ 03 @ 34 @ Lege artis : odborný časopis pro právníky @ http://aleph.nkp.cz/F/?func=find-b&request=01647374&find_code=SYS&local_base=nkc
2006 @ 03 @ 35 @ Lingua viva @ http://aleph.nkp.cz/F/?func=find-b&request=01644744&find_code=SYS&local_base=nkc
2006 @ 03 @ 36 @ LINK @ http://aleph.nkp.cz/F/?func=find-b&request=01644748&find_code=SYS&local_base=nkc
2006 @ 03 @ 37 @ Listy Šance pro Duchcov @ http://aleph.nkp.cz/F/?func=find-b&request=01648966&find_code=SYS&local_base=nkc
2006 @ 03 @ 38 @ Magazín Lázně Mšené @ http://aleph.nkp.cz/F/?func=find-b&request=01645704&find_code=SYS&local_base=nkc
2006 @ 03 @ 39 @ Maxi křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=01648173&find_code=SYS&local_base=nkc
2006 @ 03 @ 40 @ Nehvizdský kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=01649375&find_code=SYS&local_base=nkc
2006 @ 03 @ 41 @ Noviny Bystřicka @ http://aleph.nkp.cz/F/?func=find-b&request=01647379&find_code=SYS&local_base=nkc
2006 @ 03 @ 42 @ Obecní čidlo @ http://aleph.nkp.cz/F/?func=find-b&request=01648998&find_code=SYS&local_base=nkc
2006 @ 03 @ 43 @ Obecní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01648368&find_code=SYS&local_base=nkc
2006 @ 03 @ 44 @ Objekt @ http://aleph.nkp.cz/F/?func=find-b&request=01645183&find_code=SYS&local_base=nkc
2006 @ 03 @ 45 @ Oddechovka @ http://aleph.nkp.cz/F/?func=find-b&request=01647557&find_code=SYS&local_base=nkc
2006 @ 03 @ 46 @ Odpich : zpravodaj Železáren Štěpánov @ http://aleph.nkp.cz/F/?func=find-b&request=01648269&find_code=SYS&local_base=nkc
2006 @ 03 @ 47 @ OffRoad Quad @ http://aleph.nkp.cz/F/?func=find-b&request=01648188&find_code=SYS&local_base=nkc
2006 @ 03 @ 48 @ OFF road revue @ http://aleph.nkp.cz/F/?func=find-b&request=01645181&find_code=SYS&local_base=nkc
2006 @ 03 @ 49 @ Ochutnejte jižní Čechy @ http://aleph.nkp.cz/F/?func=find-b&request=01647413&find_code=SYS&local_base=nkc
2006 @ 03 @ 50 @ Okno do kraje @ http://aleph.nkp.cz/F/?func=find-b&request=01645175&find_code=SYS&local_base=nkc
2006 @ 03 @ 51 @ Okno = Fenster @ http://aleph.nkp.cz/F/?func=find-b&request=01647429&find_code=SYS&local_base=nkc
2006 @ 03 @ 52 @ Ortopedická protetika @ http://aleph.nkp.cz/F/?func=find-b&request=01648237&find_code=SYS&local_base=nkc
2006 @ 03 @ 53 @ ONA Dnes @ http://aleph.nkp.cz/F/?func=find-b&request=01645671&find_code=SYS&local_base=nkc
2006 @ 03 @ 54 @ Osecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01648375&find_code=SYS&local_base=nkc
2006 @ 03 @ 55 @ Pivní telegraf @ http://aleph.nkp.cz/F/?func=find-b&request=01649206&find_code=SYS&local_base=nkc
2006 @ 03 @ 56 @ Plzeňské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01645171&find_code=SYS&local_base=nkc
2006 @ 03 @ 57 @ Pocidlinské inzertní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01648387&find_code=SYS&local_base=nkc
2006 @ 03 @ 58 @ Podroveňsko @ http://aleph.nkp.cz/F/?func=find-b&request=01648357&find_code=SYS&local_base=nkc
2006 @ 03 @ 59 @ Pokušení @ http://aleph.nkp.cz/F/?func=find-b&request=01649005&find_code=SYS&local_base=nkc
2006 @ 03 @ 60 @ Popletená planeta @ http://aleph.nkp.cz/F/?func=find-b&request=01647384&find_code=SYS&local_base=nkc
2006 @ 03 @ 61 @ Pöttinger news @ http://aleph.nkp.cz/F/?func=find-b&request=01647394&find_code=SYS&local_base=nkc
2006 @ 03 @ 62 @ Pro Brněnsko @ http://aleph.nkp.cz/F/?func=find-b&request=01648231&find_code=SYS&local_base=nkc
2006 @ 03 @ 63 @ Pro Vysočinu @ http://aleph.nkp.cz/F/?func=find-b&request=01648228&find_code=SYS&local_base=nkc
2006 @ 03 @ 64 @ Pro<files @ http://aleph.nkp.cz/F/?func=find-b&request=01648200&find_code=SYS&local_base=nkc
2006 @ 03 @ 65 @ Pro<files @ http://aleph.nkp.cz/F/?func=find-b&request=01648206&find_code=SYS&local_base=nkc
2006 @ 03 @ 66 @ Pro<files @ http://aleph.nkp.cz/F/?func=find-b&request=01648204&find_code=SYS&local_base=nkc
2006 @ 03 @ 67 @ Pro Vysočinu @ http://aleph.nkp.cz/F/?func=find-b&request=01648227&find_code=SYS&local_base=nkc
2006 @ 03 @ 68 @ Resseler Magazine CE @ http://aleph.nkp.cz/F/?func=find-b&request=01647397&find_code=SYS&local_base=nkc
2006 @ 03 @ 69 @ Rezidenční péče @ http://aleph.nkp.cz/F/?func=find-b&request=01645168&find_code=SYS&local_base=nkc
2006 @ 03 @ 70 @ Řízení školy @ http://aleph.nkp.cz/F/?func=find-b&request=01648294&find_code=SYS&local_base=nkc
2006 @ 03 @ 71 @ Skvělá @ http://aleph.nkp.cz/F/?func=find-b&request=01649344&find_code=SYS&local_base=nkc
2006 @ 03 @ 72 @ Sparta@ do toho!', 'http://aleph.nkp.cz/F/?func=find-b&request=01645187&find_code=SYS&local_base=nkc
2006 @ 03 @ 73 @ Svět koní @ http://aleph.nkp.cz/F/?func=find-b&request=01645162&find_code=SYS&local_base=nkc
2006 @ 03 @ 74 @ Te deum @ http://aleph.nkp.cz/F/?func=find-b&request=01649363&find_code=SYS&local_base=nkc
2006 @ 03 @ 75 @ Team : JMP @ http://aleph.nkp.cz/F/?func=find-b&request=01646389&find_code=SYS&local_base=nkc
2006 @ 03 @ 76 @ The messenger @ http://aleph.nkp.cz/F/?func=find-b&request=01645692&find_code=SYS&local_base=nkc
2006 @ 03 @ 77 @ The Omega Message @ http://aleph.nkp.cz/F/?func=find-b&request=01647425&find_code=SYS&local_base=nkc
2006 @ 03 @ 78 @ To nejlepší z paprik: Knihovnička Recepty @ http://aleph.nkp.cz/F/?func=find-b&request=01648977&find_code=SYS&local_base=nkc
2006 @ 03 @ 79 @ Třešnička @ http://aleph.nkp.cz/F/?func=find-b&request=01648288&find_code=SYS&local_base=nkc
2006 @ 03 @ 80 @ Týdeník Žurnál @ http://aleph.nkp.cz/F/?func=find-b&request=01647364&find_code=SYS&local_base=nkc
2006 @ 03 @ 81 @ Vaříme a pečeme @ http://aleph.nkp.cz/F/?func=find-b&request=01647402&find_code=SYS&local_base=nkc
2006 @ 03 @ 82 @ Vietnamské variace @ http://aleph.nkp.cz/F/?func=find-b&request=01645132&find_code=SYS&local_base=nkc
2006 @ 03 @ 83 @ Vitae : klubový magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01648217&find_code=SYS&local_base=nkc
2006 @ 03 @ 84 @ Vlaštovka @ http://aleph.nkp.cz/F/?func=find-b&request=01645126&find_code=SYS&local_base=nkc
2006 @ 03 @ 85 @ Výběr dokumentů EU @ http://aleph.nkp.cz/F/?func=find-b&request=01648398&find_code=SYS&local_base=nkc
2006 @ 03 @ 86 @ Youth of Europe @ http://aleph.nkp.cz/F/?func=find-b&request=01646362&find_code=SYS&local_base=nkc
2006 @ 03 @ 87 @ Zakódované obrázky : s výhrou @ http://aleph.nkp.cz/F/?func=find-b&request=01648291&find_code=SYS&local_base=nkc
2006 @ 03 @ 88 @ Zbožíznalství @ http://aleph.nkp.cz/F/?func=find-b&request=01645117&find_code=SYS&local_base=nkc
2006 @ 03 @ 89 @ Zdravotnické prostředky : Právo a ekonomika v praxi soukromého lékaře @ http://aleph.nkp.cz/F/?func=find-b&request=01645078&find_code=SYS&local_base=nkc
2006 @ 03 @ 90 @ Zdravotnictví a finance @ http://aleph.nkp.cz/F/?func=find-b&request=01645113&find_code=SYS&local_base=nkc
2006 @ 03 @ 91 @ Zpravodaj IPES @ http://aleph.nkp.cz/F/?func=find-b&request=01647405&find_code=SYS&local_base=nkc
2006 @ 03 @ 92 @ Zpravodaj mostecký @ http://aleph.nkp.cz/F/?func=find-b&request=01646380&find_code=SYS&local_base=nkc
2006 @ 03 @ 93 @ Zpravodaj obce Hutisko-Solanec @ http://aleph.nkp.cz/F/?func=find-b&request=01645122&find_code=SYS&local_base=nkc
2006 @ 03 @ 94 @ Zpravodaj Unie geologických asociací @ http://aleph.nkp.cz/F/?func=find-b&request=01649012&find_code=SYS&local_base=nkc
2006 @ 03 @ 95 @ Zubní technik @ http://aleph.nkp.cz/F/?func=find-b&request=01645102&find_code=SYS&local_base=nkc
2006 @ 03 @ 96 @ Život : revue umělecké besedy @ http://aleph.nkp.cz/F/?func=find-b&request=01646352&find_code=SYS&local_base=nkc
2006 @ 04 @ 01 @ ACRI News @ http://aleph.nkp.cz/F/?func=find-b&request=01648283&find_code=SYS&local_base=nkc
2006 @ 04 @ 02 @ Acta Iuridica Olomucensis @ http://aleph.nkp.cz/F/?func=find-b&request=01652371&find_code=SYS&local_base=nkc
2006 @ 04 @ 03 @ Blesk zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01650339&find_code=SYS&local_base=nkc
2006 @ 04 @ 04 @ Bohuslav Martinů Newsletter @ http://aleph.nkp.cz/F/?func=find-b&request=01651252&find_code=SYS&local_base=nkc
2006 @ 04 @ 05 @ Bulletin Centra pedagogického výzkumu PdF MU v Brně 2005 @ http://aleph.nkp.cz/F/?func=find-b&request=01651536&find_code=SYS&local_base=nkc
2006 @ 04 @ 06 @ Czech Travelogue @ http://aleph.nkp.cz/F/?func=find-b&request=01651243&find_code=SYS&local_base=nkc
2006 @ 04 @ 07 @ Čechija : panorama @ http://aleph.nkp.cz/F/?func=find-b&request=01648974&find_code=SYS&local_base=nkc
2006 @ 04 @ 08 @ Digi foto @ http://aleph.nkp.cz/F/?func=find-b&request=01649371&find_code=SYS&local_base=nkc
2006 @ 04 @ 09 @ Dotace @ http://aleph.nkp.cz/F/?func=find-b&request=01650332&find_code=SYS&local_base=nkc
2006 @ 04 @ 10 @ Eurotel point @ http://aleph.nkp.cz/F/?func=find-b&request=01650365&find_code=SYS&local_base=nkc
2006 @ 04 @ 11 @ ForMen @ http://aleph.nkp.cz/F/?func=find-b&request=01652392&find_code=SYS&local_base=nkc
2006 @ 04 @ 12 @ Fresh @ http://aleph.nkp.cz/F/?func=find-b&request=01651240&find_code=SYS&local_base=nkc
2006 @ 04 @ 13 @ Gaudeamus @ http://aleph.nkp.cz/F/?func=find-b&request=01650368&find_code=SYS&local_base=nkc
2006 @ 04 @ 14 @ Gazeta + @ http://aleph.nkp.cz/F/?func=find-b&request=01644956&find_code=SYS&local_base=nkc
2006 @ 04 @ 15 @ Hanspaulka týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=01651261&find_code=SYS&local_base=nkc
2006 @ 04 @ 16 @ iDenik.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01651851&find_code=SYS&local_base=nkc
2006 @ 04 @ 17 @ Kaleidoskop aneb 3 v 1 @ http://aleph.nkp.cz/F/?func=find-b&request=01650349&find_code=SYS&local_base=nkc
2006 @ 04 @ 18 @ Krajské noviny- východní Čechy @ http://aleph.nkp.cz/F/?func=find-b&request=01650318&find_code=SYS&local_base=nkc
2006 @ 04 @ 19 @ Kurs @ http://aleph.nkp.cz/F/?func=find-b&request=01652380&find_code=SYS&local_base=nkc
2006 @ 04 @ 20 @ Kurýr Praha @ http://aleph.nkp.cz/F/?func=find-b&request=01654366&find_code=SYS&local_base=nkc
2006 @ 04 @ 21 @ Luštění o známých @ http://aleph.nkp.cz/F/?func=find-b&request=01650352&find_code=SYS&local_base=nkc
2006 @ 04 @ 22 @ Luštění s úsměvem @ http://aleph.nkp.cz/F/?func=find-b&request=01650354&find_code=SYS&local_base=nkc
2006 @ 04 @ 23 @ Luštitel @ http://aleph.nkp.cz/F/?func=find-b&request=01652401&find_code=SYS&local_base=nkc
2006 @ 04 @ 24 @ MagazIn-Line : ze světa koleček @ http://aleph.nkp.cz/F/?func=find-b&request=01652387&find_code=SYS&local_base=nkc
2006 @ 04 @ 25 @ Magazín reklama @ http://aleph.nkp.cz/F/?func=find-b&request=01653059&find_code=SYS&local_base=nkc
2006 @ 04 @ 26 @ Méďa Chloupek vypráví… @ http://aleph.nkp.cz/F/?func=find-b&request=01652593&find_code=SYS&local_base=nkc
2006 @ 04 @ 27 @ Metropolitní expres @ http://aleph.nkp.cz/F/?func=find-b&request=01654149&find_code=SYS&local_base=nkc
2006 @ 04 @ 28 @ Moje dovolená @ http://aleph.nkp.cz/F/?func=find-b&request=01652621&find_code=SYS&local_base=nkc
2006 @ 04 @ 29 @ Mukařov-sko @ http://aleph.nkp.cz/F/?func=find-b&request=01651905&find_code=SYS&local_base=nkc
2006 @ 04 @ 30 @ Newsbulletin @ http://aleph.nkp.cz/F/?func=find-b&request=01651255&find_code=SYS&local_base=nkc
2006 @ 04 @ 31 @ O´chutney @ http://aleph.nkp.cz/F/?func=find-b&request=01651269&find_code=SYS&local_base=nkc
2006 @ 04 @ 32 @ Pasecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01651376&find_code=SYS&local_base=nkc
2006 @ 04 @ 33 @ Pivař @ http://aleph.nkp.cz/F/?func=find-b&request=01651272&find_code=SYS&local_base=nkc
2006 @ 04 @ 34 @ Plaza : Novodvorská Plaza @ http://aleph.nkp.cz/F/?func=find-b&request=01651370&find_code=SYS&local_base=nkc
2006 @ 04 @ 35 @ Podnikatel Českokrumlovska @ http://aleph.nkp.cz/F/?func=find-b&request=01651413&find_code=SYS&local_base=nkc
2006 @ 04 @ 36 @ Pozlovský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01651366&find_code=SYS&local_base=nkc
2006 @ 04 @ 37 @ Prague Information @ http://aleph.nkp.cz/F/?func=find-b&request=01652997&find_code=SYS&local_base=nkc
2006 @ 04 @ 38 @ Pro>files @ http://aleph.nkp.cz/F/?func=find-b&request=01652851&find_code=SYS&local_base=nkc
2006 @ 04 @ 39 @ PROstudent @ http://aleph.nkp.cz/F/?func=find-b&request=01651379&find_code=SYS&local_base=nkc
2006 @ 04 @ 40 @ Přikrytí @ http://aleph.nkp.cz/F/?func=find-b&request=01652842&find_code=SYS&local_base=nkc
2006 @ 04 @ 41 @ Příležitosti : monitoring finančních zdrojů @ http://aleph.nkp.cz/F/?func=find-b&request=01651381&find_code=SYS&local_base=nkc
2006 @ 04 @ 42 @ Rébusy @ http://aleph.nkp.cz/F/?func=find-b&request=01651276&find_code=SYS&local_base=nkc
2006 @ 04 @ 43 @ Rentgen Bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=01653013&find_code=SYS&local_base=nkc
2006 @ 04 @ 44 @ Revolution Hair & Beauty @ http://aleph.nkp.cz/F/?func=find-b&request=01653003&find_code=SYS&local_base=nkc
2006 @ 04 @ 45 @ Revue endokrinologie @ http://aleph.nkp.cz/F/?func=find-b&request=01653002&find_code=SYS&local_base=nkc
2006 @ 04 @ 46 @ Revue Kročeje @ http://aleph.nkp.cz/F/?func=find-b&request=01652999&find_code=SYS&local_base=nkc
2006 @ 04 @ 47 @ Roudnicko @ http://aleph.nkp.cz/F/?func=find-b&request=01651402&find_code=SYS&local_base=nkc
2006 @ 04 @ 48 @ Sazka tip @ http://aleph.nkp.cz/F/?func=find-b&request=01651266&find_code=SYS&local_base=nkc
2006 @ 04 @ 49 @ Srpska reč = Srbské slovo @ http://aleph.nkp.cz/F/?func=find-b&request=01648997&find_code=SYS&local_base=nkc
2006 @ 04 @ 50 @ Svět kvality @ http://aleph.nkp.cz/F/?func=find-b&request=01651411&find_code=SYS&local_base=nkc
2006 @ 04 @ 51 @ Sweet 17 @ http://aleph.nkp.cz/F/?func=find-b&request=01651182&find_code=SYS&local_base=nkc
2006 @ 04 @ 52 @ Šijeme snadno a rychle @ http://aleph.nkp.cz/F/?func=find-b&request=01650362&find_code=SYS&local_base=nkc
2006 @ 04 @ 53 @ Tschechischer Musikinstrumentenbau @ http://aleph.nkp.cz/F/?func=find-b&request=01649152&find_code=SYS&local_base=nkc
2006 @ 04 @ 54 @ Vademecum zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01651862&find_code=SYS&local_base=nkc
2006 @ 04 @ 55 @ Vaše noviny : Zpravodaj obce Hlubočky @ http://aleph.nkp.cz/F/?func=find-b&request=01651868&find_code=SYS&local_base=nkc
2006 @ 04 @ 56 @ Víly @ http://aleph.nkp.cz/F/?func=find-b&request=01652853&find_code=SYS&local_base=nkc
2006 @ 04 @ 57 @ Vzdělání @ http://aleph.nkp.cz/F/?func=find-b&request=01651368&find_code=SYS&local_base=nkc
2006 @ 04 @ 58 @ Zelený klíč @ http://aleph.nkp.cz/F/?func=find-b&request=01650442&find_code=SYS&local_base=nkc
2006 @ 04 @ 59 @ Zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01651856&find_code=SYS&local_base=nkc
2006 @ 04 @ 60 @ Zpravodaj městské části Praha- Újezd @ http://aleph.nkp.cz/F/?func=find-b&request=01652864&find_code=SYS&local_base=nkc
2006 @ 04 @ 61 @ Židovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01651885&find_code=SYS&local_base=nkc
2006 @ 05 @ 01 @ 21.století Junior @ http://aleph.nkp.cz/F/?func=find-b&request=01655714&find_code=SYS&local_base=nkc
2006 @ 05 @ 02 @ AAABYTY.CZ @ http://aleph.nkp.cz/F/?func=find-b&request=01653731&find_code=SYS&local_base=nkc
2006 @ 05 @ 03 @ AutoBazar @ http://aleph.nkp.cz/F/?func=find-b&request=01653972&find_code=SYS&local_base=nkc
2006 @ 05 @ 04 @ AutoDiesel @ http://aleph.nkp.cz/F/?func=find-b&request=01655373&find_code=SYS&local_base=nkc
2006 @ 05 @ 05 @ Automobil Industry @ http://aleph.nkp.cz/F/?func=find-b&request=01653954&find_code=SYS&local_base=nkc
2006 @ 05 @ 06 @ Bartošovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01655406&find_code=SYS&local_base=nkc
2006 @ 05 @ 07 @ Biom @ http://aleph.nkp.cz/F/?func=find-b&request=01653966&find_code=SYS&local_base=nkc
2006 @ 05 @ 08 @ Bodyart @ http://aleph.nkp.cz/F/?func=find-b&request=01653968&find_code=SYS&local_base=nkc
2006 @ 05 @ 09 @ Btway @ http://aleph.nkp.cz/F/?func=find-b&request=01656038&find_code=SYS&local_base=nkc
2006 @ 05 @ 10 @ Bulletin : umělecko historická společnost v českých zemích @ http://aleph.nkp.cz/F/?func=find-b&request=01656863&find_code=SYS&local_base=nkc
2006 @ 05 @ 11 @ CZ (ECHO) : čtvrtletní magazín českých center @ http://aleph.nkp.cz/F/?func=find-b&request=01655710&find_code=SYS&local_base=nkc
2006 @ 05 @ 12 @ Čakovský čtvrtletník @ http://aleph.nkp.cz/F/?func=find-b&request=01655388&find_code=SYS&local_base=nkc
2006 @ 05 @ 13 @ Českopis @ http://aleph.nkp.cz/F/?func=find-b&request=01653727&find_code=SYS&local_base=nkc
2006 @ 05 @ 14 @ Demokrat @ http://aleph.nkp.cz/F/?func=find-b&request=01655336&find_code=SYS&local_base=nkc
2006 @ 05 @ 15 @ Dopravní inženýrství @ http://aleph.nkp.cz/F/?func=find-b&request=01655832&find_code=SYS&local_base=nkc
2006 @ 05 @ 16 @ Dřínovská drbna @ http://aleph.nkp.cz/F/?func=find-b&request=01655343&find_code=SYS&local_base=nkc
2006 @ 05 @ 17 @ Ekologie v podnikové praxi @ http://aleph.nkp.cz/F/?func=find-b&request=01655483&find_code=SYS&local_base=nkc
2006 @ 05 @ 18 @ Eurokurýr : eurozprávy z české správy @ http://aleph.nkp.cz/F/?func=find-b&request=01655413&find_code=SYS&local_base=nkc
2006 @ 05 @ 19 @ Folia Heyrovskyana @ http://aleph.nkp.cz/F/?func=find-b&request=01656056&find_code=SYS&local_base=nkc
2006 @ 05 @ 20 @ Globetrotter Czech @ http://aleph.nkp.cz/F/?func=find-b&request=01655352&find_code=SYS&local_base=nkc
2006 @ 05 @ 21 @ Hostomický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01655378&find_code=SYS&local_base=nkc
2006 @ 05 @ 22 @ HR Tip @ http://aleph.nkp.cz/F/?func=find-b&request=01655557&find_code=SYS&local_base=nkc
2006 @ 05 @ 23 @ In Prague : english version @ http://aleph.nkp.cz/F/?func=find-b&request=01655827&find_code=SYS&local_base=nkc
2006 @ 05 @ 24 @ In Prague : deutsche version @ http://aleph.nkp.cz/F/?func=find-b&request=01655829&find_code=SYS&local_base=nkc
2006 @ 05 @ 25 @ Japan car & technologies @ http://aleph.nkp.cz/F/?func=find-b&request=01655707&find_code=SYS&local_base=nkc
2006 @ 05 @ 26 @ Jesenický týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=01655563&find_code=SYS&local_base=nkc
2006 @ 05 @ 27 @ Katka speciál kakuro @ http://aleph.nkp.cz/F/?func=find-b&request=01655476&find_code=SYS&local_base=nkc
2006 @ 05 @ 28 @ Karlovarská právní revue @ http://aleph.nkp.cz/F/?func=find-b&request=01655488&find_code=SYS&local_base=nkc
2006 @ 05 @ 29 @ Kbelské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01655470&find_code=SYS&local_base=nkc
2006 @ 05 @ 30 @ Krasec : jihočeský týdeník o životním prostředí @ http://aleph.nkp.cz/F/?func=find-b&request=01653944&find_code=SYS&local_base=nkc
2006 @ 05 @ 31 @ Líšnické ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=01655823&find_code=SYS&local_base=nkc
2006 @ 05 @ 32 @ Marks & Spencer Magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01656040&find_code=SYS&local_base=nkc
2006 @ 05 @ 33 @ Metropolis @ http://aleph.nkp.cz/F/?func=find-b&request=01653735&find_code=SYS&local_base=nkc
2006 @ 05 @ 34 @ Metujský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01655422&find_code=SYS&local_base=nkc
2006 @ 05 @ 35 @ Mundus symbolicus @ http://aleph.nkp.cz/F/?func=find-b&request=01656049&find_code=SYS&local_base=nkc
2006 @ 05 @ 36 @ Nowatron Review @ http://aleph.nkp.cz/F/?func=find-b&request=01655362&find_code=SYS&local_base=nkc
2006 @ 05 @ 37 @ Obecní zpravodaj : OÚ Hněvotín @ http://aleph.nkp.cz/F/?func=find-b&request=01655152&find_code=SYS&local_base=nkc
2006 @ 05 @ 38 @ OHL ŽS @ http://aleph.nkp.cz/F/?func=find-b&request=01653277&find_code=SYS&local_base=nkc
2006 @ 05 @ 39 @ Pich! @ http://aleph.nkp.cz/F/?func=find-b&request=01654511&find_code=SYS&local_base=nkc
2006 @ 05 @ 40 @ Plastics Production @ http://aleph.nkp.cz/F/?func=find-b&request=01655851&find_code=SYS&local_base=nkc
2006 @ 05 @ 41 @ Prague concerts @ http://aleph.nkp.cz/F/?func=find-b&request=01655143&find_code=SYS&local_base=nkc
2006 @ 05 @ 42 @ Prague information @ http://aleph.nkp.cz/F/?func=find-b&request=01653072&find_code=SYS&local_base=nkc
2006 @ 05 @ 43 @ Protivanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01656881&find_code=SYS&local_base=nkc
2006 @ 05 @ 44 @ Psych@som @ http://aleph.nkp.cz/F/?func=find-b&request=01653475&find_code=SYS&local_base=nkc
2006 @ 05 @ 45 @ Puls BIVŠ @ http://aleph.nkp.cz/F/?func=find-b&request=01653574&find_code=SYS&local_base=nkc
2006 @ 05 @ 46 @ Rakovnicko @ http://aleph.nkp.cz/F/?func=find-b&request=01655150&find_code=SYS&local_base=nkc
2006 @ 05 @ 47 @ Real-City @ http://aleph.nkp.cz/F/?func=find-b&request=01654309&find_code=SYS&local_base=nkc
2006 @ 05 @ 48 @ Region Jevíčsko @ http://aleph.nkp.cz/F/?func=find-b&request=01655134&find_code=SYS&local_base=nkc
2006 @ 05 @ 49 @ Regionální podnikatelský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01653741&find_code=SYS&local_base=nkc
2006 @ 05 @ 50 @ S plus @ http://aleph.nkp.cz/F/?func=find-b&request=01653725&find_code=SYS&local_base=nkc
2006 @ 05 @ 51 @ Santé : čtení o zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01654301&find_code=SYS&local_base=nkc
2006 @ 05 @ 52 @ Scientia & Societas @ http://aleph.nkp.cz/F/?func=find-b&request=01653724&find_code=SYS&local_base=nkc
2006 @ 05 @ 53 @ Senio.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01653719&find_code=SYS&local_base=nkc
2006 @ 05 @ 54 @ Setba pravdy @ http://aleph.nkp.cz/F/?func=find-b&request=01653594&find_code=SYS&local_base=nkc
2006 @ 05 @ 55 @ Setkání @ http://aleph.nkp.cz/F/?func=find-b&request=01653715&find_code=SYS&local_base=nkc
2006 @ 05 @ 56 @ Silnice železnice @ http://aleph.nkp.cz/F/?func=find-b&request=01655128&find_code=SYS&local_base=nkc
2006 @ 05 @ 57 @ Soil and Water Research @ http://aleph.nkp.cz/F/?func=find-b&request=01655243&find_code=SYS&local_base=nkc
2006 @ 05 @ 58 @ Speciál Jesenického týdeníku @ http://aleph.nkp.cz/F/?func=find-b&request=01655182&find_code=SYS&local_base=nkc
2006 @ 05 @ 59 @ Spolkové zprávy @ http://aleph.nkp.cz/F/?func=find-b&request=01653283&find_code=SYS&local_base=nkc
2006 @ 05 @ 60 @ Spomyšelské aktuality @ http://aleph.nkp.cz/F/?func=find-b&request=01653554&find_code=SYS&local_base=nkc
2006 @ 05 @ 61 @ Srnojedský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01653556&find_code=SYS&local_base=nkc
2006 @ 05 @ 62 @ Starobrněnské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01653557&find_code=SYS&local_base=nkc
2006 @ 05 @ 63 @ STIP.CZ @ http://aleph.nkp.cz/F/?func=find-b&request=01654300&find_code=SYS&local_base=nkc
2006 @ 05 @ 64 @ Středočeské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01653561&find_code=SYS&local_base=nkc
2006 @ 05 @ 65 @ Subaru magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01653586&find_code=SYS&local_base=nkc
2006 @ 05 @ 66 @ Sudoku @ http://aleph.nkp.cz/F/?func=find-b&request=01655331&find_code=SYS&local_base=nkc
2006 @ 05 @ 67 @ Sudoku tradiční @ http://aleph.nkp.cz/F/?func=find-b&request=01654299&find_code=SYS&local_base=nkc
2006 @ 05 @ 68 @ Svět jednatele @ http://aleph.nkp.cz/F/?func=find-b&request=01653930&find_code=SYS&local_base=nkc
2006 @ 05 @ 69 @ Tim : tourist information magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01653494&find_code=SYS&local_base=nkc
2006 @ 05 @ 70 @ Tip zahradních center CS @ http://aleph.nkp.cz/F/?func=find-b&request=01653482&find_code=SYS&local_base=nkc
2006 @ 05 @ 71 @ Top rodinné domy @ http://aleph.nkp.cz/F/?func=find-b&request=01656850&find_code=SYS&local_base=nkc
2006 @ 05 @ 72 @ Total brokers magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01655188&find_code=SYS&local_base=nkc
2006 @ 05 @ 73 @ Toyota life @ http://aleph.nkp.cz/F/?func=find-b&request=01653749&find_code=SYS&local_base=nkc
2006 @ 05 @ 74 @ Travel : service magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01653320&find_code=SYS&local_base=nkc
2006 @ 05 @ 75 @ Travel digest : časopis o cestování @ http://aleph.nkp.cz/F/?func=find-b&request=01653325&find_code=SYS&local_base=nkc
2006 @ 05 @ 76 @ Trucks profi @ http://aleph.nkp.cz/F/?func=find-b&request=01653480&find_code=SYS&local_base=nkc
2006 @ 05 @ 77 @ TV mini @ http://aleph.nkp.cz/F/?func=find-b&request=01655552&find_code=SYS&local_base=nkc
2006 @ 05 @ 78 @ Tygrův speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01653526&find_code=SYS&local_base=nkc
2006 @ 05 @ 79 @ Úrazová chirurgie @ http://aleph.nkp.cz/F/?func=find-b&request=01653315&find_code=SYS&local_base=nkc
2006 @ 05 @ 80 @ Vaše šance : Hradec králové @ http://aleph.nkp.cz/F/?func=find-b&request=01654321&find_code=SYS&local_base=nkc
2006 @ 05 @ 81 @ Vaše šance : Pardubice / Chrudim @ http://aleph.nkp.cz/F/?func=find-b&request=01654331&find_code=SYS&local_base=nkc
2006 @ 05 @ 82 @ Vesnička @ http://aleph.nkp.cz/F/?func=find-b&request=01653328&find_code=SYS&local_base=nkc
2006 @ 05 @ 83 @ Věstník pro Senimaty@ Nouzov a Hostokryje', 'http://aleph.nkp.cz/F/?func=find-b&request=01653512&find_code=SYS&local_base=nkc
2006 @ 05 @ 84 @ ViaTerea : realitní magazín pro Olomouc @ http://aleph.nkp.cz/F/?func=find-b&request=01655839&find_code=SYS&local_base=nkc
2006 @ 05 @ 85 @ ViaTerea : realitní magazín pro Plzeň @ http://aleph.nkp.cz/F/?func=find-b&request=01655834&find_code=SYS&local_base=nkc
2006 @ 05 @ 86 @ Vítaný host @ http://aleph.nkp.cz/F/?func=find-b&request=01653520&find_code=SYS&local_base=nkc
2006 @ 05 @ 87 @ VLS @ http://aleph.nkp.cz/F/?func=find-b&request=01653511&find_code=SYS&local_base=nkc
2006 @ 05 @ 88 @ Vydra : kulturna asvetnickaja gazeta @ http://aleph.nkp.cz/F/?func=find-b&request=01653730&find_code=SYS&local_base=nkc
2006 @ 05 @ 89 @ Výstavní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01653506&find_code=SYS&local_base=nkc
2006 @ 05 @ 90 @ Wind & Kite Surfing @ http://aleph.nkp.cz/F/?func=find-b&request=01655819&find_code=SYS&local_base=nkc
2006 @ 05 @ 91 @ WN Wine News @ http://aleph.nkp.cz/F/?func=find-b&request=01653503&find_code=SYS&local_base=nkc
2006 @ 05 @ 92 @ Znojemský program @ http://aleph.nkp.cz/F/?func=find-b&request=01653489&find_code=SYS&local_base=nkc
2006 @ 05 @ 93 @ ZONA : management zábavy a volného času @ http://aleph.nkp.cz/F/?func=find-b&request=01653293&find_code=SYS&local_base=nkc
2006 @ 05 @ 94 @ Zpravodaj : American Akita Klub @ http://aleph.nkp.cz/F/?func=find-b&request=01655159&find_code=SYS&local_base=nkc
2006 @ 05 @ 95 @ Zpravodaj farností Hartvíkov@ Hroby, Chýnov', 'http://aleph.nkp.cz/F/?func=find-b&request=01655168&find_code=SYS&local_base=nkc
2006 @ 05 @ 96 @ Zpravodaj : Klub švýcarských salašnických psů @ http://aleph.nkp.cz/F/?func=find-b&request=01655163&find_code=SYS&local_base=nkc
2006 @ 05 @ 97 @ Zpravodaj města Vodňany @ http://aleph.nkp.cz/F/?func=find-b&request=01655174&find_code=SYS&local_base=nkc
2006 @ 05 @ 98 @ Zpravodaj našich obcí @ http://aleph.nkp.cz/F/?func=find-b&request=01655175&find_code=SYS&local_base=nkc
2006 @ 05 @ 99 @ Životem a snem @ http://aleph.nkp.cz/F/?func=find-b&request=01653499&find_code=SYS&local_base=nkc
2006 @ 06 @ 01 @ 14 dní : České Budějovice a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=01660919&find_code=SYS&local_base=nkc
2006 @ 06 @ 02 @ 14 dní : Jindřichův Hradec a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=01660901&find_code=SYS&local_base=nkc
2006 @ 06 @ 03 @ 14 dní : Písek a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=01660922&find_code=SYS&local_base=nkc
2006 @ 06 @ 04 @ 14 dní : Tábor a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=01660916&find_code=SYS&local_base=nkc
2006 @ 06 @ 05 @ Akční Zlaté stránky : České Budějovice @ http://aleph.nkp.cz/F/?func=find-b&request=01659597&find_code=SYS&local_base=nkc
2006 @ 06 @ 06 @ Ainzert : inzertní noviny zdarma @ http://aleph.nkp.cz/F/?func=find-b&request=01658571&find_code=SYS&local_base=nkc
2006 @ 06 @ 07 @ Anti-aging @ http://aleph.nkp.cz/F/?func=find-b&request=01660308&find_code=SYS&local_base=nkc
2006 @ 06 @ 08 @ Báječné recepty @ http://aleph.nkp.cz/F/?func=find-b&request=01660555&find_code=SYS&local_base=nkc
2006 @ 06 @ 09 @ Braunoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01659129&find_code=SYS&local_base=nkc
2006 @ 06 @ 10 @ Broadband pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=01658297&find_code=SYS&local_base=nkc
2006 @ 06 @ 11 @ Buddhismus dnes @ http://aleph.nkp.cz/F/?func=find-b&request=01662344&find_code=SYS&local_base=nkc
2006 @ 06 @ 12 @ Bydlení stavby reality @ http://aleph.nkp.cz/F/?func=find-b&request=01658302&find_code=SYS&local_base=nkc
2006 @ 06 @ 13 @ České paničky @ http://aleph.nkp.cz/F/?func=find-b&request=01660559&find_code=SYS&local_base=nkc
2006 @ 06 @ 14 @ Česko-německé souvislosti @ http://aleph.nkp.cz/F/?func=find-b&request=01659138&find_code=SYS&local_base=nkc
2006 @ 06 @ 15 @ Evropa zleva @ http://aleph.nkp.cz/F/?func=find-b&request=01658665&find_code=SYS&local_base=nkc
2006 @ 06 @ 16 @ Františkovy Lázně : Zrcadlo aneb pohled z druhé strany @ http://aleph.nkp.cz/F/?func=find-b&request=01660104&find_code=SYS&local_base=nkc
2006 @ 06 @ 17 @ Hubatá černoška @ http://aleph.nkp.cz/F/?func=find-b&request=01662337&find_code=SYS&local_base=nkc
2006 @ 06 @ 18 @ Info bulletin pro klienty Diners Club International @ http://aleph.nkp.cz/F/?func=find-b&request=01658096&find_code=SYS&local_base=nkc
2006 @ 06 @ 19 @ Info noviny pro Hradec králové a Pardubice @ http://aleph.nkp.cz/F/?func=find-b&request=01658106&find_code=SYS&local_base=nkc
2006 @ 06 @ 20 @ Jihočeský Fotbal @ http://aleph.nkp.cz/F/?func=find-b&request=01658320&find_code=SYS&local_base=nkc
2006 @ 06 @ 21 @ Jindřichovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01658101&find_code=SYS&local_base=nkc
2006 @ 06 @ 22 @ Jobmaster @ http://aleph.nkp.cz/F/?func=find-b&request=01658548&find_code=SYS&local_base=nkc
2006 @ 06 @ 23 @ Joker @ http://aleph.nkp.cz/F/?func=find-b&request=01657534&find_code=SYS&local_base=nkc
2006 @ 06 @ 24 @ Kakuro @ http://aleph.nkp.cz/F/?func=find-b&request=01660532&find_code=SYS&local_base=nkc
2006 @ 06 @ 25 @ Krchlebáček @ http://aleph.nkp.cz/F/?func=find-b&request=01657411&find_code=SYS&local_base=nkc
2006 @ 06 @ 26 @ Láska a vztahy @ http://aleph.nkp.cz/F/?func=find-b&request=01658371&find_code=SYS&local_base=nkc
2006 @ 06 @ 27 @ Liberecké listy @ http://aleph.nkp.cz/F/?func=find-b&request=01662336&find_code=SYS&local_base=nkc
2006 @ 06 @ 28 @ Libinské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01658560&find_code=SYS&local_base=nkc
2006 @ 06 @ 29 @ Lovosicko @ http://aleph.nkp.cz/F/?func=find-b&request=01658563&find_code=SYS&local_base=nkc
2006 @ 06 @ 30 @ Luštění bez brýlí @ http://aleph.nkp.cz/F/?func=find-b&request=01658313&find_code=SYS&local_base=nkc
2006 @ 06 @ 31 @ Mana : měsíční aktuality naší farnosti @ http://aleph.nkp.cz/F/?func=find-b&request=01658306&find_code=SYS&local_base=nkc
2006 @ 06 @ 32 @ Matiční zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01657939&find_code=SYS&local_base=nkc
2006 @ 06 @ 33 @ MiniMax : Havlíčkův Brod@ Vlašim', 'http://aleph.nkp.cz/F/?func=find-b&request=01657665&find_code=SYS&local_base=nkc
2006 @ 06 @ 34 @ MiniMax : Kyjov @ http://aleph.nkp.cz/F/?func=find-b&request=01657944&find_code=SYS&local_base=nkc
2006 @ 06 @ 35 @ MiniMax : Hodonín @ http://aleph.nkp.cz/F/?func=find-b&request=01657942&find_code=SYS&local_base=nkc
2006 @ 06 @ 36 @ MJ Marketing journal @ http://aleph.nkp.cz/F/?func=find-b&request=01659148&find_code=SYS&local_base=nkc
2006 @ 06 @ 37 @ Mobilmania @ http://aleph.nkp.cz/F/?func=find-b&request=01659121&find_code=SYS&local_base=nkc
2006 @ 06 @ 38 @ Multidisciplinární péče @ http://aleph.nkp.cz/F/?func=find-b&request=01662325&find_code=SYS&local_base=nkc
2006 @ 06 @ 39 @ Music & Mobile @ http://aleph.nkp.cz/F/?func=find-b&request=01662341&find_code=SYS&local_base=nkc
2006 @ 06 @ 40 @ Nápady do kapsy : skalky a skalničky @ http://aleph.nkp.cz/F/?func=find-b&request=01661933&find_code=SYS&local_base=nkc
2006 @ 06 @ 41 @ Náš region @ http://aleph.nkp.cz/F/?func=find-b&request=01658569&find_code=SYS&local_base=nkc
2006 @ 06 @ 42 @ Nejpress @ http://aleph.nkp.cz/F/?func=find-b&request=01658576&find_code=SYS&local_base=nkc
2006 @ 06 @ 43 @ Němčice pod lupou @ http://aleph.nkp.cz/F/?func=find-b&request=01659118&find_code=SYS&local_base=nkc
2006 @ 06 @ 44 @ Nová legislativa @ http://aleph.nkp.cz/F/?func=find-b&request=01658584&find_code=SYS&local_base=nkc
2006 @ 06 @ 45 @ Objekt : speciál pro architekty @ http://aleph.nkp.cz/F/?func=find-b&request=01657419&find_code=SYS&local_base=nkc
2006 @ 06 @ 46 @ Obnovené tradice @ http://aleph.nkp.cz/F/?func=find-b&request=01661328&find_code=SYS&local_base=nkc
2006 @ 06 @ 47 @ Obsah @ http://aleph.nkp.cz/F/?func=find-b&request=01658092&find_code=SYS&local_base=nkc
2006 @ 06 @ 48 @ Oko Prahy 2 @ http://aleph.nkp.cz/F/?func=find-b&request=01657230&find_code=SYS&local_base=nkc
2006 @ 06 @ 49 @ Omalovánky @ http://aleph.nkp.cz/F/?func=find-b&request=01660547&find_code=SYS&local_base=nkc
2006 @ 06 @ 50 @ ONE @ http://aleph.nkp.cz/F/?func=find-b&request=01661332&find_code=SYS&local_base=nkc
2006 @ 06 @ 51 @ Ostrava @ http://aleph.nkp.cz/F/?func=find-b&request=01657265&find_code=SYS&local_base=nkc
2006 @ 06 @ 52 @ Outside @ http://aleph.nkp.cz/F/?func=find-b&request=01657241&find_code=SYS&local_base=nkc
2006 @ 06 @ 53 @ Profese @ http://aleph.nkp.cz/F/?func=find-b&request=01660544&find_code=SYS&local_base=nkc
2006 @ 06 @ 54 @ Půl na půl @ http://aleph.nkp.cz/F/?func=find-b&request=01660122&find_code=SYS&local_base=nkc
2006 @ 06 @ 55 @ Prague guide @ http://aleph.nkp.cz/F/?func=find-b&request=01657231&find_code=SYS&local_base=nkc
2006 @ 06 @ 56 @ Reality dnes @ http://aleph.nkp.cz/F/?func=find-b&request=01657261&find_code=SYS&local_base=nkc
2006 @ 06 @ 57 @ Roudenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01660109&find_code=SYS&local_base=nkc
2006 @ 06 @ 58 @ Rozrazil @ http://aleph.nkp.cz/F/?func=find-b&request=01661341&find_code=SYS&local_base=nkc
2006 @ 06 @ 59 @ Rukopis : revue o psaní @ http://aleph.nkp.cz/F/?func=find-b&request=01657236&find_code=SYS&local_base=nkc
2006 @ 06 @ 60 @ RvR Reklama v regionu @ http://aleph.nkp.cz/F/?func=find-b&request=01660093&find_code=SYS&local_base=nkc
2006 @ 06 @ 61 @ Samsonite-shop.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01660133&find_code=SYS&local_base=nkc
2006 @ 06 @ 62 @ Shops atd. @ http://aleph.nkp.cz/F/?func=find-b&request=01659861&find_code=SYS&local_base=nkc
2006 @ 06 @ 63 @ SpaMagazine @ http://aleph.nkp.cz/F/?func=find-b&request=01661119&find_code=SYS&local_base=nkc
2006 @ 06 @ 64 @ Starosta Chýně informuje @ http://aleph.nkp.cz/F/?func=find-b&request=01657239&find_code=SYS&local_base=nkc
2006 @ 06 @ 65 @ Styl @ http://aleph.nkp.cz/F/?func=find-b&request=01657951&find_code=SYS&local_base=nkc
2006 @ 06 @ 66 @ Sudoku mini @ http://aleph.nkp.cz/F/?func=find-b&request=01657263&find_code=SYS&local_base=nkc
2006 @ 06 @ 67 @ Sv. Jan Prachatický @ http://aleph.nkp.cz/F/?func=find-b&request=01657410&find_code=SYS&local_base=nkc
2006 @ 06 @ 68 @ SVJ aktuálně : společenství vlastníků jednotek @ http://aleph.nkp.cz/F/?func=find-b&request=01657244&find_code=SYS&local_base=nkc
2006 @ 06 @ 69 @ Středočeská svoboda @ http://aleph.nkp.cz/F/?func=find-b&request=01660505&find_code=SYS&local_base=nkc
2006 @ 06 @ 70 @ Sudoku @ http://aleph.nkp.cz/F/?func=find-b&request=01659880&find_code=SYS&local_base=nkc
2006 @ 06 @ 71 @ SU report @ http://aleph.nkp.cz/F/?func=find-b&request=01660883&find_code=SYS&local_base=nkc
2006 @ 06 @ 72 @ Šíp @ http://aleph.nkp.cz/F/?func=find-b&request=01658391&find_code=SYS&local_base=nkc
2006 @ 06 @ 73 @ Školní šťoural @ http://aleph.nkp.cz/F/?func=find-b&request=01660503&find_code=SYS&local_base=nkc
2006 @ 06 @ 74 @ Šumperský horizont @ http://aleph.nkp.cz/F/?func=find-b&request=01658111&find_code=SYS&local_base=nkc
2006 @ 06 @ 75 @ Today @ http://aleph.nkp.cz/F/?func=find-b&request=01657252&find_code=SYS&local_base=nkc
2006 @ 06 @ 76 @ TopGear @ http://aleph.nkp.cz/F/?func=find-b&request=01660132&find_code=SYS&local_base=nkc
2006 @ 06 @ 77 @ Trojský koník @ http://aleph.nkp.cz/F/?func=find-b&request=01660136&find_code=SYS&local_base=nkc
2006 @ 06 @ 78 @ Truck & business @ http://aleph.nkp.cz/F/?func=find-b&request=01657409&find_code=SYS&local_base=nkc
2006 @ 06 @ 79 @ TV max @ http://aleph.nkp.cz/F/?func=find-b&request=01657259&find_code=SYS&local_base=nkc
2006 @ 06 @ 80 @ Věstník @ http://aleph.nkp.cz/F/?func=find-b&request=01659897&find_code=SYS&local_base=nkc
2006 @ 06 @ 81 @ Zahrádecké listy @ http://aleph.nkp.cz/F/?func=find-b&request=01660111&find_code=SYS&local_base=nkc
2006 @ 06 @ 82 @ Zpravodaj : česká asociace námořního jachtingu @ http://aleph.nkp.cz/F/?func=find-b&request=01658107&find_code=SYS&local_base=nkc
2006 @ 06 @ 83 @ Zpravodaj euroregionu Glacensis @ http://aleph.nkp.cz/F/?func=find-b&request=01661122&find_code=SYS&local_base=nkc
2006 @ 06 @ 84 @ Zpravodaj mikroregionu obcí památkové zóny 1866 @ http://aleph.nkp.cz/F/?func=find-b&request=01657456&find_code=SYS&local_base=nkc
2006 @ 06 @ 85 @ Zpravodaj oblastní nemocnice Příbram @ http://aleph.nkp.cz/F/?func=find-b&request=01657250&find_code=SYS&local_base=nkc
2006 @ 06 @ 86 @ Zpravodaj Posázaví @ http://aleph.nkp.cz/F/?func=find-b&request=01657452&find_code=SYS&local_base=nkc
2006 @ 06 @ 87 @ Zpravodaj pro partnery @ http://aleph.nkp.cz/F/?func=find-b&request=01657462&find_code=SYS&local_base=nkc
2006 @ 06 @ 88 @ Zpravodaj skupiny SAM @ http://aleph.nkp.cz/F/?func=find-b&request=01657460&find_code=SYS&local_base=nkc
2006 @ 06 @ 89 @ Zpravodaj Středočeské Mrkvičky @ http://aleph.nkp.cz/F/?func=find-b&request=01657436&find_code=SYS&local_base=nkc
2006 @ 06 @ 90 @ Zpravodaj šumperský @ http://aleph.nkp.cz/F/?func=find-b&request=01660894&find_code=SYS&local_base=nkc
2006 @ 06 @ 91 @ Zpravodaj z Vodochod a Hoštic @ http://aleph.nkp.cz/F/?func=find-b&request=01657429&find_code=SYS&local_base=nkc
2006 @ 06 @ 92 @ Zuškoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01661347&find_code=SYS&local_base=nkc
2006 @ 06 @ 93 @ Ženská záležitost @ http://aleph.nkp.cz/F/?func=find-b&request=01659888&find_code=SYS&local_base=nkc
2006 @ 08 @ 01 @ Agri Trader @ http://aleph.nkp.cz/F/?func=find-b&request=01685480&find_code=SYS&local_base=nkc
2006 @ 08 @ 02 @ Detail @ http://aleph.nkp.cz/F/?func=find-b&request=01686174&find_code=SYS&local_base=nkc
2006 @ 08 @ 03 @ DN Dnešní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01685471&find_code=SYS&local_base=nkc
2006 @ 08 @ 04 @ Chvilka v pohodě @ http://aleph.nkp.cz/F/?func=find-b&request=01663620&find_code=SYS&local_base=nkc
2006 @ 08 @ 05 @ Inforegio News @ http://aleph.nkp.cz/F/?func=find-b&request=01686172&find_code=SYS&local_base=nkc
2006 @ 08 @ 06 @ Koně a hříbata @ http://aleph.nkp.cz/F/?func=find-b&request=01686294&find_code=SYS&local_base=nkc
2006 @ 08 @ 07 @ Krchlebský obecní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01686483&find_code=SYS&local_base=nkc
2006 @ 08 @ 08 @ Listy kulturně společenské @ http://aleph.nkp.cz/F/?func=find-b&request=01686183&find_code=SYS&local_base=nkc
2006 @ 08 @ 09 @ Máma a já @ http://aleph.nkp.cz/F/?func=find-b&request=01686192&find_code=SYS&local_base=nkc
2006 @ 08 @ 10 @ Měsíc v pohodě speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01686184&find_code=SYS&local_base=nkc
2006 @ 08 @ 11 @ Měsíčník EU aktualit @ http://aleph.nkp.cz/F/?func=find-b&request=01686173&find_code=SYS&local_base=nkc
2006 @ 08 @ 12 @ Na cestách osudu @ http://aleph.nkp.cz/F/?func=find-b&request=01685640&find_code=SYS&local_base=nkc
2006 @ 08 @ 13 @ Naše muzika @ http://aleph.nkp.cz/F/?func=find-b&request=01686175&find_code=SYS&local_base=nkc
2006 @ 08 @ 14 @ Noviny Chirš @ http://aleph.nkp.cz/F/?func=find-b&request=01686296&find_code=SYS&local_base=nkc
2006 @ 08 @ 15 @ Numero sudoku : osud v číslech @ http://aleph.nkp.cz/F/?func=find-b&request=01686292&find_code=SYS&local_base=nkc
2006 @ 08 @ 16 @ OKNO 06 : magazín pro zaměstnance společnosti České aerolinie @ http://aleph.nkp.cz/F/?func=find-b&request=01685832&find_code=SYS&local_base=nkc
2006 @ 08 @ 17 @ Plicní cirkulace @ http://aleph.nkp.cz/F/?func=find-b&request=01663554&find_code=SYS&local_base=nkc
2006 @ 08 @ 18 @ Pod střechou @ http://aleph.nkp.cz/F/?func=find-b&request=01663572&find_code=SYS&local_base=nkc
2006 @ 08 @ 19 @ Práce@ mzdy, odvody bez chyb, pokut a penále', 'http://aleph.nkp.cz/F/?func=find-b&request=01663565&find_code=SYS&local_base=nkc
2006 @ 08 @ 20 @ Prefa Brno @ http://aleph.nkp.cz/F/?func=find-b&request=01663539&find_code=SYS&local_base=nkc
2006 @ 08 @ 21 @ Pro Vysočinu @ http://aleph.nkp.cz/F/?func=find-b&request=01685639&find_code=SYS&local_base=nkc
2006 @ 08 @ 22 @ Psavci @ http://aleph.nkp.cz/F/?func=find-b&request=01663543&find_code=SYS&local_base=nkc
2006 @ 08 @ 23 @ Rodinné výherní sudoku @ http://aleph.nkp.cz/F/?func=find-b&request=01663534&find_code=SYS&local_base=nkc
2006 @ 08 @ 24 @ Růst osobnosti @ http://aleph.nkp.cz/F/?func=find-b&request=01685655&find_code=SYS&local_base=nkc
2006 @ 08 @ 25 @ Řádková inzerce @ http://aleph.nkp.cz/F/?func=find-b&request=01685645&find_code=SYS&local_base=nkc
2006 @ 08 @ 26 @ Sudoku pro radost @ http://aleph.nkp.cz/F/?func=find-b&request=01663577&find_code=SYS&local_base=nkc
2006 @ 08 @ 27 @ Svět hraček@ modelářství a sportu', 'http://aleph.nkp.cz/F/?func=find-b&request=01663584&find_code=SYS&local_base=nkc
2006 @ 08 @ 28 @ Svět realit @ http://aleph.nkp.cz/F/?func=find-b&request=01663536&find_code=SYS&local_base=nkc
2006 @ 08 @ 29 @ Tajemné tajenky @ http://aleph.nkp.cz/F/?func=find-b&request=01663593&find_code=SYS&local_base=nkc
2006 @ 08 @ 30 @ TEMA @ http://aleph.nkp.cz/F/?func=find-b&request=01663581&find_code=SYS&local_base=nkc
2006 @ 08 @ 31 @ Temelínky @ http://aleph.nkp.cz/F/?func=find-b&request=01663530&find_code=SYS&local_base=nkc
2006 @ 08 @ 32 @ Ten můj @ http://aleph.nkp.cz/F/?func=find-b&request=01663588&find_code=SYS&local_base=nkc
2006 @ 08 @ 33 @ Trhací blok sudoku @ http://aleph.nkp.cz/F/?func=find-b&request=01663532&find_code=SYS&local_base=nkc
2006 @ 08 @ 34 @ Všestarské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01663570&find_code=SYS&local_base=nkc
2006 @ 08 @ 35 @ Zjede.info @ http://aleph.nkp.cz/F/?func=find-b&request=01685643&find_code=SYS&local_base=nkc
2006 @ 08 @ 36 @ Zpravodaj obce Horní Dubňany @ http://aleph.nkp.cz/F/?func=find-b&request=01685648&find_code=SYS&local_base=nkc
2006 @ 09 @ 01 @ 33 kvadrata @ http://aleph.nkp.cz/F/?func=find-b&request=01660997&find_code=SYS&local_base=nkc
2006 @ 09 @ 02 @ Gazeta + @ http://aleph.nkp.cz/F/?func=find-b&request=01644956&find_code=SYS&local_base=nkc
2006 @ 09 @ 03 @ info chance @ http://aleph.nkp.cz/F/?func=find-b&request=01689841&find_code=SYS&local_base=nkc
2006 @ 09 @ 04 @ O.pen @ http://aleph.nkp.cz/F/?func=find-b&request=01690749&find_code=SYS&local_base=nkc
2006 @ 09 @ 05 @ Pisatež @ http://aleph.nkp.cz/F/?func=find-b&request=01690642&find_code=SYS&local_base=nkc
2006 @ 09 @ 06 @ Run @ http://aleph.nkp.cz/F/?func=find-b&request=01690874&find_code=SYS&local_base=nkc
2006 @ 09 @ 07 @ Slavjanskij lečebnik @ http://aleph.nkp.cz/F/?func=find-b&request=01663551&find_code=SYS&local_base=nkc
2006 @ 09 @ 08 @ Slovo @ http://aleph.nkp.cz/F/?func=find-b&request=01690661&find_code=SYS&local_base=nkc
2006 @ 09 @ 09 @ SMS - Společník Moravsko-Slezský @ http://aleph.nkp.cz/F/?func=find-b&request=01687640&find_code=SYS&local_base=nkc
2006 @ 09 @ 10 @ Statuss.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01690905&find_code=SYS&local_base=nkc
2006 @ 09 @ 11 @ Su-do-ku @ http://aleph.nkp.cz/F/?func=find-b&request=01690847&find_code=SYS&local_base=nkc
2006 @ 09 @ 12 @ Su-do-ku za pětku @ http://aleph.nkp.cz/F/?func=find-b&request=01690860&find_code=SYS&local_base=nkc
2006 @ 09 @ 13 @ TCHAS zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01690751&find_code=SYS&local_base=nkc
2006 @ 09 @ 14 @ Učitelský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01690887&find_code=SYS&local_base=nkc
2006 @ 09 @ 15 @ Vildův svět @ http://aleph.nkp.cz/F/?func=find-b&request=01690865&find_code=SYS&local_base=nkc
2006 @ 10 @ 44 @ Sudoku s tajenkami @ http://aleph.nkp.cz/F/?func=find-b&request=01694516&find_code=SYS&local_base=nkc
2006 @ 10 @ 43 @ SMP CZ @ http://aleph.nkp.cz/F/?func=find-b&request=01691779&find_code=SYS&local_base=nkc
2006 @ 10 @ 42 @ Samurai sudoku @ http://aleph.nkp.cz/F/?func=find-b&request=01694519&find_code=SYS&local_base=nkc
2006 @ 10 @ 41 @ Rodinné finance @ http://aleph.nkp.cz/F/?func=find-b&request=01694106&find_code=SYS&local_base=nkc
2006 @ 10 @ 40 @ Rider magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01694266&find_code=SYS&local_base=nkc
2006 @ 10 @ 39 @ Realizace staveb @ http://aleph.nkp.cz/F/?func=find-b&request=01691446&find_code=SYS&local_base=nkc
2006 @ 10 @ 38 @ Pro @ http://aleph.nkp.cz/F/?func=find-b&request=01691520&find_code=SYS&local_base=nkc
2006 @ 10 @ 37 @ Pražský deník @ http://aleph.nkp.cz/F/?func=find-b&request=01691763&find_code=SYS&local_base=nkc
2006 @ 10 @ 36 @ Podpora bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=01691314&find_code=SYS&local_base=nkc
2006 @ 10 @ 35 @ Pletená móda pro děti @ http://aleph.nkp.cz/F/?func=find-b&request=01693373&find_code=SYS&local_base=nkc
2006 @ 10 @ 34 @ Pivní listy @ http://aleph.nkp.cz/F/?func=find-b&request=01691895&find_code=SYS&local_base=nkc
2006 @ 10 @ 33 @ Partnerství @ http://aleph.nkp.cz/F/?func=find-b&request=01691942&find_code=SYS&local_base=nkc
2006 @ 10 @ 32 @ Oživení Čakoviček @ http://aleph.nkp.cz/F/?func=find-b&request=01694687&find_code=SYS&local_base=nkc
2006 @ 10 @ 31 @ Okolohradce.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01691774&find_code=SYS&local_base=nkc
2006 @ 10 @ 30 @ Nordic news @ http://aleph.nkp.cz/F/?func=find-b&request=01693933&find_code=SYS&local_base=nkc
2006 @ 10 @ 29 @ Newton College working paper (česky) @ http://aleph.nkp.cz/F/?func=find-b&request=01692277&find_code=SYS&local_base=nkc
2006 @ 10 @ 28 @ Newton College working paper (anglicky) @ http://aleph.nkp.cz/F/?func=find-b&request=01694448&find_code=SYS&local_base=nkc
2006 @ 10 @ 27 @ Naše nemocnice @ http://aleph.nkp.cz/F/?func=find-b&request=01694354&find_code=SYS&local_base=nkc
2006 @ 10 @ 26 @ Marionnaud parfumeries @ http://aleph.nkp.cz/F/?func=find-b&request=01694136&find_code=SYS&local_base=nkc
2006 @ 10 @ 25 @ Luckyboy @ http://aleph.nkp.cz/F/?func=find-b&request=01693345&find_code=SYS&local_base=nkc
2006 @ 10 @ 24 @ Lasselsberger keramik @ http://aleph.nkp.cz/F/?func=find-b&request=01693873&find_code=SYS&local_base=nkc
2006 @ 10 @ 23 @ Lafarge Cement Journal @ http://aleph.nkp.cz/F/?func=find-b&request=01693689&find_code=SYS&local_base=nkc
2006 @ 10 @ 22 @ Kuriozity @ http://aleph.nkp.cz/F/?func=find-b&request=01694432&find_code=SYS&local_base=nkc
2006 @ 10 @ 21 @ Kniha su-do-ku @ http://aleph.nkp.cz/F/?func=find-b&request=01694677&find_code=SYS&local_base=nkc
2006 @ 10 @ 20 @ Kakuro rébusy @ http://aleph.nkp.cz/F/?func=find-b&request=01694478&find_code=SYS&local_base=nkc
2006 @ 10 @ 19 @ Informátor obce Albrechtičky @ http://aleph.nkp.cz/F/?func=find-b&request=01693342&find_code=SYS&local_base=nkc
2006 @ 10 @ 18 @ Info (Cech topenářů a instalatérů ČR) @ http://aleph.nkp.cz/F/?func=find-b&request=01694241&find_code=SYS&local_base=nkc
2006 @ 10 @ 17 @ Haló magazín pro vás @ http://aleph.nkp.cz/F/?func=find-b&request=01694110&find_code=SYS&local_base=nkc
2006 @ 10 @ 16 @ Glanc @ http://aleph.nkp.cz/F/?func=find-b&request=01691224&find_code=SYS&local_base=nkc
2006 @ 10 @ 15 @ Filetové háčkování @ http://aleph.nkp.cz/F/?func=find-b&request=01693544&find_code=SYS&local_base=nkc
2006 @ 10 @ 14 @ Family Star @ http://aleph.nkp.cz/F/?func=find-b&request=01694142&find_code=SYS&local_base=nkc
2006 @ 10 @ 13 @ Extra PC @ http://aleph.nkp.cz/F/?func=find-b&request=01694243&find_code=SYS&local_base=nkc
2006 @ 10 @ 12 @ Euro zprávy @ http://aleph.nkp.cz/F/?func=find-b&request=01692241&find_code=SYS&local_base=nkc
2006 @ 10 @ 11 @ Euro kompas @ http://aleph.nkp.cz/F/?func=find-b&request=01693690&find_code=SYS&local_base=nkc
2006 @ 10 @ 10 @ Estetika @ http://aleph.nkp.cz/F/?func=find-b&request=01694085&find_code=SYS&local_base=nkc
2006 @ 10 @ 09 @ Elánplus @ http://aleph.nkp.cz/F/?func=find-b&request=01693923&find_code=SYS&local_base=nkc
2006 @ 10 @ 08 @ Easy sudoku @ http://aleph.nkp.cz/F/?func=find-b&request=01694356&find_code=SYS&local_base=nkc
2006 @ 10 @ 07 @ Diskret kontakt @ http://aleph.nkp.cz/F/?func=find-b&request=01692266&find_code=SYS&local_base=nkc
2006 @ 10 @ 05 @ Delikatesy @ http://aleph.nkp.cz/F/?func=find-b&request=01691293&find_code=SYS&local_base=nkc
2006 @ 10 @ 06 @ Dental tribune @ http://aleph.nkp.cz/F/?func=find-b&request=01694660&find_code=SYS&local_base=nkc
2006 @ 10 @ 04 @ Craz Style @ http://aleph.nkp.cz/F/?func=find-b&request=01693692&find_code=SYS&local_base=nkc
2006 @ 10 @ 03 @ Biják @ http://aleph.nkp.cz/F/?func=find-b&request=01691218&find_code=SYS&local_base=nkc
2006 @ 10 @ 02 @ Betlémář @ http://aleph.nkp.cz/F/?func=find-b&request=01693546&find_code=SYS&local_base=nkc
2006 @ 10 @ 01 @ Aha! Láska@ sex & peníze', 'http://aleph.nkp.cz/F/?func=find-b&request=01694484&find_code=SYS&local_base=nkc
2006 @ 10 @ 45 @ Total sport @ http://aleph.nkp.cz/F/?func=find-b&request=01691516&find_code=SYS&local_base=nkc
2006 @ 10 @ 46 @ Voda pro vás @ http://aleph.nkp.cz/F/?func=find-b&request=01691881&find_code=SYS&local_base=nkc
2006 @ 10 @ 47 @ Zpravodaj (International Power Opatovice @ http://aleph.nkp.cz/F/?func=find-b&request=01691931&find_code=SYS&local_base=nkc
2006 @ 10 @ 48 @ Zpravodaj (Městský ústav sociálních služeb města Plzně) @ http://aleph.nkp.cz/F/?func=find-b&request=01691931&find_code=SYS&local_base=nkc
2006 @ 10 @ 49 @ Zpravodaj (Šeberov@ Hrnčíře)', 'http://aleph.nkp.cz/F/?func=find-b&request=01691931&find_code=SYS&local_base=nkc
2006 @ 10 @ 50 @ Zpravodaj obce Chodouny - Lounky @ http://aleph.nkp.cz/F/?func=find-b&request=01694101&find_code=SYS&local_base=nkc
2006 @ 10 @ 51 @ Zpravodaj obce Prušánky @ http://aleph.nkp.cz/F/?func=find-b&request=01691932&find_code=SYS&local_base=nkc
2006 @ 10 @ 52 @ Zpravodaj obce Truskovice @ http://aleph.nkp.cz/F/?func=find-b&request=01691686&find_code=SYS&local_base=nkc
2006 @ 11 @ 40 @ Zpravodaj Smiřic@ Rodova a Holohlav', 'http://aleph.nkp.cz/F/?func=find-b&request=01175965&find_code=SYS&local_base=nkc
2006 @ 11 @ 39 @ Zpravodaj obce Budkov @ http://aleph.nkp.cz/F/?func=find-b&request=01699355&find_code=SYS&local_base=nkc
2006 @ 11 @ 37 @ Veřejnost.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01699470&find_code=SYS&local_base=nkc
2006 @ 11 @ 38 @ Zpravodaj (Asociace soukromého zemědělství ČR) @ http://aleph.nkp.cz/F/?func=find-b&request=01699377&find_code=SYS&local_base=nkc
2006 @ 11 @ 36 @ Vertigo @ http://aleph.nkp.cz/F/?func=find-b&request=01699472&find_code=SYS&local_base=nkc
2006 @ 11 @ 34 @ Tvůj svět @ http://aleph.nkp.cz/F/?func=find-b&request=01699163&find_code=SYS&local_base=nkc
2006 @ 11 @ 35 @ Vaše nemocnice@ a.s.', 'http://aleph.nkp.cz/F/?func=find-b&request=01699476&find_code=SYS&local_base=nkc
2006 @ 11 @ 33 @ Trade review @ http://aleph.nkp.cz/F/?func=find-b&request=01699296&find_code=SYS&local_base=nkc
2006 @ 11 @ 32 @ Šortky VŠFS @ http://aleph.nkp.cz/F/?func=find-b&request=01699422&find_code=SYS&local_base=nkc
2006 @ 11 @ 31 @ Škoda revue @ http://aleph.nkp.cz/F/?func=find-b&request=01699442&find_code=SYS&local_base=nkc
2006 @ 11 @ 29 @ Sports executive @ http://aleph.nkp.cz/F/?func=find-b&request=01699174&find_code=SYS&local_base=nkc
2006 @ 11 @ 30 @ Svět optiky @ http://aleph.nkp.cz/F/?func=find-b&request=01699292&find_code=SYS&local_base=nkc
2006 @ 11 @ 28 @ Spokojená rodina @ http://aleph.nkp.cz/F/?func=find-b&request=01699475&find_code=SYS&local_base=nkc
2006 @ 11 @ 25 @ Profi Ceresit @ http://aleph.nkp.cz/F/?func=find-b&request=01700123&find_code=SYS&local_base=nkc
2006 @ 11 @ 26 @ Profi Thomsit @ http://aleph.nkp.cz/F/?func=find-b&request=01700132&find_code=SYS&local_base=nkc
2006 @ 11 @ 27 @ Recepty Receptáře @ http://aleph.nkp.cz/F/?func=find-b&request=01700344&find_code=SYS&local_base=nkc
2006 @ 11 @ 24 @ Perspektivy @ http://aleph.nkp.cz/F/?func=find-b&request=01699579&find_code=SYS&local_base=nkc
2006 @ 11 @ 23 @ Paparazzi revue @ http://aleph.nkp.cz/F/?func=find-b&request=01698297&find_code=SYS&local_base=nkc
2006 @ 11 @ 22 @ Otevřený zpravodaj Zeleného předměstí @ http://aleph.nkp.cz/F/?func=find-b&request=01699801&find_code=SYS&local_base=nkc
2006 @ 11 @ 21 @ Orlovské rozhledy @ http://aleph.nkp.cz/F/?func=find-b&request=01699810&find_code=SYS&local_base=nkc
2006 @ 11 @ 20 @ Oočko @ http://aleph.nkp.cz/F/?func=find-b&request=01699639&find_code=SYS&local_base=nkc
2006 @ 11 @ 19 @ Občasník (Česká myelomová skupina) @ http://aleph.nkp.cz/F/?func=find-b&request=01699641&find_code=SYS&local_base=nkc
2006 @ 11 @ 17 @ MBéčko @ http://aleph.nkp.cz/F/?func=find-b&request=01698308&find_code=SYS&local_base=nkc
2006 @ 11 @ 18 @ Mediální studia @ http://aleph.nkp.cz/F/?func=find-b&request=01700042&find_code=SYS&local_base=nkc
2006 @ 11 @ 15 @ Kreativní doma @ http://aleph.nkp.cz/F/?func=find-b&request=01698196&find_code=SYS&local_base=nkc
2006 @ 11 @ 16 @ Mag real (Brno a okolí) @ http://aleph.nkp.cz/F/?func=find-b&request=01697767&find_code=SYS&local_base=nkc
2006 @ 11 @ 14 @ Kladno Záporno @ http://aleph.nkp.cz/F/?func=find-b&request=01700044&find_code=SYS&local_base=nkc
2006 @ 11 @ 13 @ Kardiologie v primární péči @ http://aleph.nkp.cz/F/?func=find-b&request=01700019&find_code=SYS&local_base=nkc
2006 @ 11 @ 12 @ Jihočeský kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=01698562&find_code=SYS&local_base=nkc
2006 @ 11 @ 09 @ Golem @ http://aleph.nkp.cz/F/?func=find-b&request=01697533&find_code=SYS&local_base=nkc
2006 @ 11 @ 10 @ Horydoly @ http://aleph.nkp.cz/F/?func=find-b&request=01699592&find_code=SYS&local_base=nkc
2006 @ 11 @ 11 @ Jáchymovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01698554&find_code=SYS&local_base=nkc
2006 @ 11 @ 08 @ Firemní partner @ http://aleph.nkp.cz/F/?func=find-b&request=01700416&find_code=SYS&local_base=nkc
2006 @ 11 @ 07 @ Filmag @ http://aleph.nkp.cz/F/?func=find-b&request=01697807&find_code=SYS&local_base=nkc
2006 @ 11 @ 06 @ Eva35 @ http://aleph.nkp.cz/F/?func=find-b&request=01697672&find_code=SYS&local_base=nkc
2006 @ 11 @ 05 @ Dvojlist @ http://aleph.nkp.cz/F/?func=find-b&request=01698713&find_code=SYS&local_base=nkc
2006 @ 11 @ 03 @ Body @ http://aleph.nkp.cz/F/?func=find-b&request=01699784&find_code=SYS&local_base=nkc
2006 @ 11 @ 04 @ Český inzerent @ http://aleph.nkp.cz/F/?func=find-b&request=01698087&find_code=SYS&local_base=nkc
2006 @ 11 @ 01 @ Autosalon @ http://aleph.nkp.cz/F/?func=find-b&request=01698341&find_code=SYS&local_base=nkc
2006 @ 11 @ 02 @ Bezpečnostní teorie & praxe @ http://aleph.nkp.cz/F/?func=find-b&request=01697826&find_code=SYS&local_base=nkc
2006 @ 12 @ 22 @ Ukrajinský žurnál @ http://aleph.nkp.cz/F/?func=find-b&request=01702332&find_code=SYS&local_base=nkc
2006 @ 12 @ 21 @ TÜV Cz zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01700560&find_code=SYS&local_base=nkc
2006 @ 12 @ 20 @ Těšínské zrcadlo @ http://aleph.nkp.cz/F/?func=find-b&request=01702322&find_code=SYS&local_base=nkc
2006 @ 12 @ 19 @ Školní časopis Praktik @ http://aleph.nkp.cz/F/?func=find-b&request=01702574&find_code=SYS&local_base=nkc
2006 @ 12 @ 18 @ Svět @ http://aleph.nkp.cz/F/?func=find-b&request=01700513&find_code=SYS&local_base=nkc
2006 @ 12 @ 17 @ Sunny speaks English @ http://aleph.nkp.cz/F/?func=find-b&request=01702450&find_code=SYS&local_base=nkc
2006 @ 12 @ 16 @ Sudoku trénink mozku @ http://aleph.nkp.cz/F/?func=find-b&request=01702277&find_code=SYS&local_base=nkc
2006 @ 12 @ 15 @ Sudoku speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01701854&find_code=SYS&local_base=nkc
2006 @ 12 @ 14 @ Sports Illustrated @ http://aleph.nkp.cz/F/?func=find-b&request=01702066&find_code=SYS&local_base=nkc
2006 @ 12 @ 13 @ Senior servis @ http://aleph.nkp.cz/F/?func=find-b&request=01700555&find_code=SYS&local_base=nkc
2006 @ 12 @ 12 @ Rudolecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01702064&find_code=SYS&local_base=nkc
2006 @ 12 @ 11 @ Roubenky @ http://aleph.nkp.cz/F/?func=find-b&request=01700901&find_code=SYS&local_base=nkc
2006 @ 12 @ 10 @ Referátový výběr z psychiatrie @ http://aleph.nkp.cz/F/?func=find-b&request=01701290&find_code=SYS&local_base=nkc
2006 @ 12 @ 09 @ Receptář pro zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01700898&find_code=SYS&local_base=nkc
2006 @ 12 @ 08 @ PURO-KLIMA info @ http://aleph.nkp.cz/F/?func=find-b&request=01701843&find_code=SYS&local_base=nkc
2006 @ 12 @ 07 @ PET media @ http://aleph.nkp.cz/F/?func=find-b&request=01701260&find_code=SYS&local_base=nkc
2006 @ 12 @ 06 @ Moje rodina a já @ http://aleph.nkp.cz/F/?func=find-b&request=01702597&find_code=SYS&local_base=nkc
2006 @ 12 @ 05 @ Mobil @ http://aleph.nkp.cz/F/?func=find-b&request=01701149&find_code=SYS&local_base=nkc
2006 @ 12 @ 04 @ IDOL zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01701254&find_code=SYS&local_base=nkc
2006 @ 12 @ 03 @ Florbal @ http://aleph.nkp.cz/F/?func=find-b&request=01701587&find_code=SYS&local_base=nkc
2006 @ 12 @ 02 @ Dačice info @ http://aleph.nkp.cz/F/?func=find-b&request=01701387&find_code=SYS&local_base=nkc
2006 @ 12 @ 01 @ Aukce @ http://aleph.nkp.cz/F/?func=find-b&request=01701384&find_code=SYS&local_base=nkc
2006 @ 12 @ 23 @ VisitorGuide @ http://aleph.nkp.cz/F/?func=find-b&request=01701858&find_code=SYS&local_base=nkc
2006 @ 12 @ 24 @ Zpravodaj AUČR @ http://aleph.nkp.cz/F/?func=find-b&request=01691931&find_code=SYS&local_base=nkc
2006 @ 12 @ 25 @ Zpravodaj OSBD @ http://aleph.nkp.cz/F/?func=find-b&request=01701368&find_code=SYS&local_base=nkc
2006 @ 12 @ 26 @ Žabčický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01702297&find_code=SYS&local_base=nkc
2007 @ 01 @ 56 @ Velká kniha osmisměrek @ http://aleph.nkp.cz/F/?func=find-b&request=01704561&find_code=SYS&local_base=nkc
2007 @ 01 @ 55 @ Velká kniha křížovek @ http://aleph.nkp.cz/F/?func=find-b&request=01704570&find_code=SYS&local_base=nkc
2007 @ 01 @ 54 @ Úspěch @ http://aleph.nkp.cz/F/?func=find-b&request=01706823&find_code=SYS&local_base=nkc
2007 @ 01 @ 53 @ Trendy bydlení speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01706564&find_code=SYS&local_base=nkc
2007 @ 01 @ 52 @ Tipkonto žurnál @ http://aleph.nkp.cz/F/?func=find-b&request=01704595&find_code=SYS&local_base=nkc
2007 @ 01 @ 51 @ Tera fórum @ http://aleph.nkp.cz/F/?func=find-b&request=01707363&find_code=SYS&local_base=nkc
2007 @ 01 @ 50 @ Tajenky pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=01704084&find_code=SYS&local_base=nkc
2007 @ 01 @ 49 @ Škoda magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01706981&find_code=SYS&local_base=nkc
2007 @ 01 @ 48 @ Šestajovický dostavník @ http://aleph.nkp.cz/F/?func=find-b&request=01706671&find_code=SYS&local_base=nkc
2007 @ 01 @ 47 @ Super Spy TV @ http://aleph.nkp.cz/F/?func=find-b&request=01707203&find_code=SYS&local_base=nkc
2007 @ 01 @ 46 @ Sting magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01703616&find_code=SYS&local_base=nkc
2007 @ 01 @ 45 @ Stady @ http://aleph.nkp.cz/F/?func=find-b&request=01707332&find_code=SYS&local_base=nkc
2007 @ 01 @ 44 @ Sexy křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=01703785&find_code=SYS&local_base=nkc
2007 @ 01 @ 43 @ Sedloňovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01706670&find_code=SYS&local_base=nkc
2007 @ 01 @ 42 @ SAN @ http://aleph.nkp.cz/F/?func=find-b&request=01704619&find_code=SYS&local_base=nkc
2007 @ 01 @ 41 @ Referátový výběr z onkologie @ http://aleph.nkp.cz/F/?func=find-b&request=00357806&find_code=SYS&local_base=nkc
2007 @ 01 @ 40 @ Pro mou rodinu @ http://aleph.nkp.cz/F/?func=find-b&request=01704623&find_code=SYS&local_base=nkc
2007 @ 01 @ 39 @ Podnikatelské tipy @ http://aleph.nkp.cz/F/?func=find-b&request=01706993&find_code=SYS&local_base=nkc
2007 @ 01 @ 38 @ Podlipansko @ http://aleph.nkp.cz/F/?func=find-b&request=01707312&find_code=SYS&local_base=nkc
2007 @ 01 @ 37 @ Podhorní kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=01707181&find_code=SYS&local_base=nkc
2007 @ 01 @ 36 @ Podesní @ http://aleph.nkp.cz/F/?func=find-b&request=01707648&find_code=SYS&local_base=nkc
2007 @ 01 @ 35 @ Pendolino @ http://aleph.nkp.cz/F/?func=find-b&request=01707999&find_code=SYS&local_base=nkc
2007 @ 01 @ 34 @ Pardubická šestka @ http://aleph.nkp.cz/F/?func=find-b&request=01704389&find_code=SYS&local_base=nkc
2007 @ 01 @ 33 @ Ozvěny Smidarska @ http://aleph.nkp.cz/F/?func=find-b&request=00984655&find_code=SYS&local_base=nkc
2007 @ 01 @ 32 @ Ortopedie @ http://aleph.nkp.cz/F/?func=find-b&request=01707121&find_code=SYS&local_base=nkc
2007 @ 01 @ 31 @ Obchodní deník @ http://aleph.nkp.cz/F/?func=find-b&request=01704478&find_code=SYS&local_base=nkc
2007 @ 01 @ 30 @ Obecní noviny (Židovská obec v Praze) @ http://aleph.nkp.cz/F/?func=find-b&request=01704371&find_code=SYS&local_base=nkc
2007 @ 01 @ 29 @ Občasník (Odborové sdružení Čech@ Moravy a Slezska)', 'http://aleph.nkp.cz/F/?func=find-b&request=01707684&find_code=SYS&local_base=nkc
2007 @ 01 @ 28 @ Nový kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=01707809&find_code=SYS&local_base=nkc
2007 @ 01 @ 27 @ Novartis oncology news @ http://aleph.nkp.cz/F/?func=find-b&request=01704400&find_code=SYS&local_base=nkc
2007 @ 01 @ 26 @ Modrá a voňavá tlač @ http://aleph.nkp.cz/F/?func=find-b&request=01707705&find_code=SYS&local_base=nkc
2007 @ 01 @ 25 @ Liberečák @ http://aleph.nkp.cz/F/?func=find-b&request=01702490&find_code=SYS&local_base=nkc
2007 @ 01 @ 24 @ Labský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01707806&find_code=SYS&local_base=nkc
2007 @ 01 @ 23 @ Infoservis města Jaroměře @ http://aleph.nkp.cz/F/?func=find-b&request=01707780&find_code=SYS&local_base=nkc
2007 @ 01 @ 22 @ Info inzert @ http://aleph.nkp.cz/F/?func=find-b&request=01707773&find_code=SYS&local_base=nkc
2007 @ 01 @ 21 @ In.Ghost @ http://aleph.nkp.cz/F/?func=find-b&request=01704463&find_code=SYS&local_base=nkc
2007 @ 01 @ 20 @ Hot time @ http://aleph.nkp.cz/F/?func=find-b&request=01703729&find_code=SYS&local_base=nkc
2007 @ 01 @ 19 @ Hlucké noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01706955&find_code=SYS&local_base=nkc
2007 @ 01 @ 18 @ Flash Art (Czech & Slovak Edition) @ http://aleph.nkp.cz/F/?func=find-b&request=01704236&find_code=SYS&local_base=nkc
2007 @ 01 @ 17 @ Ewin @ http://aleph.nkp.cz/F/?func=find-b&request=01707820&find_code=SYS&local_base=nkc
2007 @ 01 @ 16 @ European financial and accounting journal @ http://aleph.nkp.cz/F/?func=find-b&request=01704226&find_code=SYS&local_base=nkc
2007 @ 01 @ 15 @ Energetix news @ http://aleph.nkp.cz/F/?func=find-b&request=01704475&find_code=SYS&local_base=nkc
2007 @ 01 @ 14 @ Drahotušské novinky @ http://aleph.nkp.cz/F/?func=find-b&request=01707717&find_code=SYS&local_base=nkc
2007 @ 01 @ 13 @ Dešenický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01706959&find_code=SYS&local_base=nkc
2007 @ 01 @ 12 @ Design & Home Digest @ http://aleph.nkp.cz/F/?func=find-b&request=01706971&find_code=SYS&local_base=nkc
2007 @ 01 @ 11 @ ČEZinfo @ http://aleph.nkp.cz/F/?func=find-b&request=01707817&find_code=SYS&local_base=nkc
2007 @ 01 @ 10 @ Český finanční a účetní časopis @ http://aleph.nkp.cz/F/?func=find-b&request=01704232&find_code=SYS&local_base=nkc
2007 @ 01 @ 09 @ Časopis Stavebnictví @ http://aleph.nkp.cz/F/?func=find-b&request=01706814&find_code=SYS&local_base=nkc
2007 @ 01 @ 08 @ Cesta Vrchovinou @ http://aleph.nkp.cz/F/?func=find-b&request=01703760&find_code=SYS&local_base=nkc
2007 @ 01 @ 07 @ Bulletin Společnosti Otokara Březiny @ http://aleph.nkp.cz/F/?func=find-b&request=01702234&find_code=SYS&local_base=nkc
2007 @ 01 @ 06 @ Blesk křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=01708023&find_code=SYS&local_base=nkc
2007 @ 01 @ 05 @ Akva fórum @ http://aleph.nkp.cz/F/?func=find-b&request=01707174&find_code=SYS&local_base=nkc
2007 @ 01 @ 04 @ Aktuality obce (Prostějovičky) @ http://aleph.nkp.cz/F/?func=find-b&request=01704453&find_code=SYS&local_base=nkc
2007 @ 01 @ 03 @ Akta Fakulty filozofické Západočeské univerzity v Plzni @ http://aleph.nkp.cz/F/?func=find-b&request=01703748&find_code=SYS&local_base=nkc
2007 @ 01 @ 02 @ Agro-king @ http://aleph.nkp.cz/F/?func=find-b&request=01704437&find_code=SYS&local_base=nkc
2007 @ 01 @ 01 @ Acta Musei Naturae Paradisus Bohemicus @ http://aleph.nkp.cz/F/?func=find-b&request=01708027&find_code=SYS&local_base=nkc
2007 @ 01 @ 57 @ Velké osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=01703783&find_code=SYS&local_base=nkc
2007 @ 01 @ 58 @ Vyhrejte s luštěním @ http://aleph.nkp.cz/F/?func=find-b&request=01706806&find_code=SYS&local_base=nkc
2007 @ 01 @ 59 @ W.I.T.C.H. Styl @ http://aleph.nkp.cz/F/?func=find-b&request=01707325&find_code=SYS&local_base=nkc
2007 @ 01 @ 60 @ Znojemsko víkend @ http://aleph.nkp.cz/F/?func=find-b&request=01704639&find_code=SYS&local_base=nkc
2007 @ 01 @ 61 @ Zpravodaj hasičů okresu Praha-východ @ http://aleph.nkp.cz/F/?func=find-b&request=01706673&find_code=SYS&local_base=nkc
2007 @ 01 @ 62 @ Zpravodaj města Vidnavy @ http://aleph.nkp.cz/F/?func=find-b&request=01704573&find_code=SYS&local_base=nkc
2007 @ 01 @ 63 @ Zpravodaj obecního úřadu Pravonín @ http://aleph.nkp.cz/F/?func=find-b&request=01704477&find_code=SYS&local_base=nkc
2007 @ 01 @ 64 @ Zpravodaj pro vlastníky@ správce a přátele lesa', 'http://aleph.nkp.cz/F/?func=find-b&request=01704633&find_code=SYS&local_base=nkc
2007 @ 01 @ 65 @ Zpravodaj VÚP @ http://aleph.nkp.cz/F/?func=find-b&request=01707096&find_code=SYS&local_base=nkc
2007 @ 01 @ 66 @ Zrcadlo Blanenska a Boskovicka @ http://aleph.nkp.cz/F/?func=find-b&request=01706540&find_code=SYS&local_base=nkc
2007 @ 01 @ 67 @ Žurnál @ http://aleph.nkp.cz/F/?func=find-b&request=01706685&find_code=SYS&local_base=nkc
2007 @ 02 @ 01 @ Agrotip @ http://aleph.nkp.cz/F/?func=find-b&request=01708735&find_code=SYS&local_base=nkc
2007 @ 02 @ 02 @ Černostrakaté novinky @ http://aleph.nkp.cz/F/?func=find-b&request=01710563&find_code=SYS&local_base=nkc
2007 @ 02 @ 03 @ Dermatologie @ http://aleph.nkp.cz/F/?func=find-b&request=01710573&find_code=SYS&local_base=nkc
2007 @ 02 @ 04 @ Euro veletrhy @ http://aleph.nkp.cz/F/?func=find-b&request=01710321&find_code=SYS&local_base=nkc
2007 @ 02 @ 05 @ Haló Čakovičky @ http://aleph.nkp.cz/F/?func=find-b&request=01710502&find_code=SYS&local_base=nkc
2007 @ 02 @ 06 @ Kaleidoskop @ http://aleph.nkp.cz/F/?func=find-b&request=01709570&find_code=SYS&local_base=nkc
2007 @ 02 @ 07 @ Letiště Dnes @ http://aleph.nkp.cz/F/?func=find-b&request=01710522&find_code=SYS&local_base=nkc
2007 @ 02 @ 08 @ Libštátský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01708714&find_code=SYS&local_base=nkc
2007 @ 02 @ 09 @ LíšKa @ http://aleph.nkp.cz/F/?func=find-b&request=01710490&find_code=SYS&local_base=nkc
2007 @ 02 @ 10 @ Lovochemik @ http://aleph.nkp.cz/F/?func=find-b&request=01709540&find_code=SYS&local_base=nkc
2007 @ 02 @ 11 @ Měsíc v regionu @ http://aleph.nkp.cz/F/?func=find-b&request=01710535&find_code=SYS&local_base=nkc
2007 @ 02 @ 12 @ Mochovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01710551&find_code=SYS&local_base=nkc
2007 @ 02 @ 13 @ New EU Magazine of Medicine @ http://aleph.nkp.cz/F/?func=find-b&request=01710558&find_code=SYS&local_base=nkc
2007 @ 02 @ 14 @ Orange news @ http://aleph.nkp.cz/F/?func=find-b&request=01709716&find_code=SYS&local_base=nkc
2007 @ 02 @ 15 @ Radka - recepty čtenářů @ http://aleph.nkp.cz/F/?func=find-b&request=01709590&find_code=SYS&local_base=nkc
2007 @ 02 @ 16 @ Review @ http://aleph.nkp.cz/F/?func=find-b&request=01710664&find_code=SYS&local_base=nkc
2007 @ 02 @ 17 @ SGUNschrift @ http://aleph.nkp.cz/F/?func=find-b&request=01708727&find_code=SYS&local_base=nkc
2007 @ 02 @ 18 @ Šonovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01710299&find_code=SYS&local_base=nkc
2007 @ 02 @ 19 @ Trans Urban @ http://aleph.nkp.cz/F/?func=find-b&request=01710059&find_code=SYS&local_base=nkc
2007 @ 02 @ 20 @ Veřovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01709589&find_code=SYS&local_base=nkc
2007 @ 02 @ 21 @ Xa xu @ http://aleph.nkp.cz/F/?func=find-b&request=01710056&find_code=SYS&local_base=nkc
2007 @ 02 @ 22 @ Zpravodaj městyse Strážek a místních částí @ http://aleph.nkp.cz/F/?func=find-b&request=01708713&find_code=SYS&local_base=nkc
2007 @ 02 @ 23 @ Zvířátka @ http://aleph.nkp.cz/F/?func=find-b&request=01708703&find_code=SYS&local_base=nkc
2007 @ 02 @ 24 @ Ždírecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01710291&find_code=SYS&local_base=nkc
2007 @ 03 @ 01 @ 7 dní na jihu @ http://aleph.nkp.cz/F/?func=find-b&request=01711625&find_code=SYS&local_base=nkc
2007 @ 03 @ 02 @ Advances in military technology @ http://aleph.nkp.cz/F/?func=find-b&request=01713140&find_code=SYS&local_base=nkc
2007 @ 03 @ 03 @ Afiša @ http://aleph.nkp.cz/F/?func=find-b&request=01712069&find_code=SYS&local_base=nkc
2007 @ 03 @ 04 @ Aha reality @ http://aleph.nkp.cz/F/?func=find-b&request=01711599&find_code=SYS&local_base=nkc
2007 @ 03 @ 05 @ AHR fórum @ http://aleph.nkp.cz/F/?func=find-b&request=01713014&find_code=SYS&local_base=nkc
2007 @ 03 @ 06 @ Bistro u Rudolfa @ http://aleph.nkp.cz/F/?func=find-b&request=01713918&find_code=SYS&local_base=nkc
2007 @ 03 @ 07 @ Bystřicko @ http://aleph.nkp.cz/F/?func=find-b&request=01712034&find_code=SYS&local_base=nkc
2007 @ 03 @ 08 @ Celoplošný inzert @ http://aleph.nkp.cz/F/?func=find-b&request=01714127&find_code=SYS&local_base=nkc
2007 @ 03 @ 09 @ Czech Defence Industry & Security Review @ http://aleph.nkp.cz/F/?func=find-b&request=01712846&find_code=SYS&local_base=nkc
2007 @ 03 @ 10 @ Číselné křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=01713016&find_code=SYS&local_base=nkc
2007 @ 03 @ 11 @ Dermatologie pro praxi @ http://aleph.nkp.cz/F/?func=find-b&request=01713018&find_code=SYS&local_base=nkc
2007 @ 03 @ 12 @ Diana recepty speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01712246&find_code=SYS&local_base=nkc
2007 @ 03 @ 13 @ Elsinore @ http://aleph.nkp.cz/F/?func=find-b&request=01714115&find_code=SYS&local_base=nkc
2007 @ 03 @ 14 @ Finanční kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=01711424&find_code=SYS&local_base=nkc
2007 @ 03 @ 15 @ Grand biblio @ http://aleph.nkp.cz/F/?func=find-b&request=01712099&find_code=SYS&local_base=nkc
2007 @ 03 @ 16 @ Háčko @ http://aleph.nkp.cz/F/?func=find-b&request=01714983&find_code=SYS&local_base=nkc
2007 @ 03 @ 17 @ Chvilka pro relax @ http://aleph.nkp.cz/F/?func=find-b&request=01712097&find_code=SYS&local_base=nkc
2007 @ 03 @ 18 @ Informační bulletin SMBD @ http://aleph.nkp.cz/F/?func=find-b&request=01711857&find_code=SYS&local_base=nkc
2007 @ 03 @ 19 @ Intaxi @ http://aleph.nkp.cz/F/?func=find-b&request=01712100&find_code=SYS&local_base=nkc
2007 @ 03 @ 20 @ Klubíčko @ http://aleph.nkp.cz/F/?func=find-b&request=01713176&find_code=SYS&local_base=nkc
2007 @ 03 @ 21 @ Komunální technika @ http://aleph.nkp.cz/F/?func=find-b&request=01713149&find_code=SYS&local_base=nkc
2007 @ 03 @ 22 @ Kutnohorský úder @ http://aleph.nkp.cz/F/?func=find-b&request=01714157&find_code=SYS&local_base=nkc
2007 @ 03 @ 23 @ Libri de bibliotheca nostra @ http://aleph.nkp.cz/F/?func=find-b&request=01711458&find_code=SYS&local_base=nkc
2007 @ 03 @ 24 @ Městské listy Brandýsa nad Labem - Staré Boleslavi @ http://aleph.nkp.cz/F/?func=find-b&request=01711450&find_code=SYS&local_base=nkc
2007 @ 03 @ 25 @ Moje Lhenicko @ http://aleph.nkp.cz/F/?func=find-b&request=01710304&find_code=SYS&local_base=nkc
2007 @ 03 @ 26 @ Moje psychologie @ http://aleph.nkp.cz/F/?func=find-b&request=01709530&find_code=SYS&local_base=nkc
2007 @ 03 @ 27 @ Museum@ umění, společnost', 'http://aleph.nkp.cz/F/?func=find-b&request=01711461&find_code=SYS&local_base=nkc
2007 @ 03 @ 28 @ Náměšťské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01711608&find_code=SYS&local_base=nkc
2007 @ 03 @ 29 @ Nebezpečný náklad @ http://aleph.nkp.cz/F/?func=find-b&request=01714130&find_code=SYS&local_base=nkc
2007 @ 03 @ 30 @ Nové bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=01713909&find_code=SYS&local_base=nkc
2007 @ 03 @ 31 @ Nové perspektivy @ http://aleph.nkp.cz/F/?func=find-b&request=01712077&find_code=SYS&local_base=nkc
2007 @ 03 @ 32 @ Obecní zpravodaj obce Raková u Konice @ http://aleph.nkp.cz/F/?func=find-b&request=01714172&find_code=SYS&local_base=nkc
2007 @ 03 @ 33 @ Post red @ http://aleph.nkp.cz/F/?func=find-b&request=01712067&find_code=SYS&local_base=nkc
2007 @ 03 @ 34 @ Prášilský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01712982&find_code=SYS&local_base=nkc
2007 @ 03 @ 35 @ Profesionál @ http://aleph.nkp.cz/F/?func=find-b&request=01714382&find_code=SYS&local_base=nkc
2007 @ 03 @ 36 @ Proglas @ http://aleph.nkp.cz/F/?func=find-b&request=01714558&find_code=SYS&local_base=nkc
2007 @ 03 @ 37 @ Psalterium folia @ http://aleph.nkp.cz/F/?func=find-b&request=01714177&find_code=SYS&local_base=nkc
2007 @ 03 @ 38 @ Psí sporty @ http://aleph.nkp.cz/F/?func=find-b&request=01711869&find_code=SYS&local_base=nkc
2007 @ 03 @ 39 @ Pustokamenické listy @ http://aleph.nkp.cz/F/?func=find-b&request=01714767&find_code=SYS&local_base=nkc
2007 @ 03 @ 40 @ Rynholecké listy @ http://aleph.nkp.cz/F/?func=find-b&request=01714766&find_code=SYS&local_base=nkc
2007 @ 03 @ 41 @ Rynoltické střípky @ http://aleph.nkp.cz/F/?func=find-b&request=01711088&find_code=SYS&local_base=nkc
2007 @ 03 @ 42 @ Sabrina - pletená móda @ http://aleph.nkp.cz/F/?func=find-b&request=01712336&find_code=SYS&local_base=nkc
2007 @ 03 @ 43 @ Sabrina - pletená móda speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01712344&find_code=SYS&local_base=nkc
2007 @ 03 @ 44 @ Salon @ http://aleph.nkp.cz/F/?func=find-b&request=01711878&find_code=SYS&local_base=nkc
2007 @ 03 @ 45 @ Su-do-ku s tajenkou @ http://aleph.nkp.cz/F/?func=find-b&request=01712024&find_code=SYS&local_base=nkc
2007 @ 03 @ 46 @ Svět ženy křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=01713009&find_code=SYS&local_base=nkc
2007 @ 03 @ 47 @ Těšínské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01713011&find_code=SYS&local_base=nkc
2007 @ 03 @ 48 @ Trojúhelník @ http://aleph.nkp.cz/F/?func=find-b&request=01714980&find_code=SYS&local_base=nkc
2007 @ 03 @ 49 @ Trubač @ http://aleph.nkp.cz/F/?func=find-b&request=01711882&find_code=SYS&local_base=nkc
2007 @ 03 @ 50 @ Viva reality @ http://aleph.nkp.cz/F/?func=find-b&request=01711866&find_code=SYS&local_base=nkc
2007 @ 03 @ 51 @ Vlčické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01714537&find_code=SYS&local_base=nkc
2007 @ 03 @ 52 @ Zpravodaj OÚ Předslav @ http://aleph.nkp.cz/F/?func=find-b&request=01714979&find_code=SYS&local_base=nkc
2007 @ 03 @ 53 @ Žatecký týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=01711802&find_code=SYS&local_base=nkc
2007 @ 03 @ 54 @ Život obce Předklášteří @ http://aleph.nkp.cz/F/?func=find-b&request=01714768&find_code=SYS&local_base=nkc
2007 @ 04 @ 01 @ Bělčický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01716320&find_code=SYS&local_base=nkc
2007 @ 04 @ 02 @ Bezděkovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01715557&find_code=SYS&local_base=nkc
2007 @ 04 @ 03 @ Byty@ domy, zahrady', 'http://aleph.nkp.cz/F/?func=find-b&request=01715686&find_code=SYS&local_base=nkc
2007 @ 04 @ 04 @ Čtení pro vás @ http://aleph.nkp.cz/F/?func=find-b&request=01715319&find_code=SYS&local_base=nkc
2007 @ 04 @ 05 @ Dimenze moderního zdravotnictví @ http://aleph.nkp.cz/F/?func=find-b&request=01715586&find_code=SYS&local_base=nkc
2007 @ 04 @ 06 @ Ekologický zpravodaj Zelené Posázaví @ http://aleph.nkp.cz/F/?func=find-b&request=01716205&find_code=SYS&local_base=nkc
2007 @ 04 @ 07 @ Ekonomické rozhledy @ http://aleph.nkp.cz/F/?func=find-b&request=01716251&find_code=SYS&local_base=nkc
2007 @ 04 @ 08 @ Exclusive @ http://aleph.nkp.cz/F/?func=find-b&request=01715417&find_code=SYS&local_base=nkc
2007 @ 04 @ 09 @ Firemní partner @ http://aleph.nkp.cz/F/?func=find-b&request=01716258&find_code=SYS&local_base=nkc
2007 @ 04 @ 10 @ ForGolf @ http://aleph.nkp.cz/F/?func=find-b&request=01715565&find_code=SYS&local_base=nkc
2007 @ 04 @ 11 @ GeoBusiness @ http://aleph.nkp.cz/F/?func=find-b&request=01715548&find_code=SYS&local_base=nkc
2007 @ 04 @ 12 @ Hrušovanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01715493&find_code=SYS&local_base=nkc
2007 @ 04 @ 13 @ Hubatá černoška @ http://aleph.nkp.cz/F/?func=find-b&request=01716869&find_code=SYS&local_base=nkc
2007 @ 04 @ 14 @ Chronicle @ http://aleph.nkp.cz/F/?func=find-b&request=01715437&find_code=SYS&local_base=nkc
2007 @ 04 @ 15 @ Infolisty @ http://aleph.nkp.cz/F/?func=find-b&request=01716242&find_code=SYS&local_base=nkc
2007 @ 04 @ 16 @ Janovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01715553&find_code=SYS&local_base=nkc
2007 @ 04 @ 17 @ Kladrubský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01715609&find_code=SYS&local_base=nkc
2007 @ 04 @ 18 @ Magazín Obchodního centra Nový Smíchov @ http://aleph.nkp.cz/F/?func=find-b&request=01715458&find_code=SYS&local_base=nkc
2007 @ 04 @ 19 @ Olšanský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01715321&find_code=SYS&local_base=nkc
2007 @ 04 @ 20 @ Pam pam @ http://aleph.nkp.cz/F/?func=find-b&request=01716215&find_code=SYS&local_base=nkc
2007 @ 04 @ 21 @ Posel - kaleidoskop zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01715687&find_code=SYS&local_base=nkc
2007 @ 04 @ 22 @ Pro-energy @ http://aleph.nkp.cz/F/?func=find-b&request=01716321&find_code=SYS&local_base=nkc
2007 @ 04 @ 23 @ Přerovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01716325&find_code=SYS&local_base=nkc
2007 @ 04 @ 24 @ Psychoterapie @ http://aleph.nkp.cz/F/?func=find-b&request=01716306&find_code=SYS&local_base=nkc
2007 @ 04 @ 25 @ Radniční zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01715114&find_code=SYS&local_base=nkc
2007 @ 04 @ 26 @ Rasošský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01715453&find_code=SYS&local_base=nkc
2007 @ 04 @ 27 @ Realitní magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01716331&find_code=SYS&local_base=nkc
2007 @ 04 @ 28 @ Rosické listy @ http://aleph.nkp.cz/F/?func=find-b&request=01716261&find_code=SYS&local_base=nkc
2007 @ 04 @ 29 @ Sluneční zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01716236&find_code=SYS&local_base=nkc
2007 @ 04 @ 30 @ Snadné vaření @ http://aleph.nkp.cz/F/?func=find-b&request=01716429&find_code=SYS&local_base=nkc
2007 @ 04 @ 31 @ Štěpánovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01715564&find_code=SYS&local_base=nkc
2007 @ 04 @ 32 @ TIP společnosti T-MAPY spol. s r.o. @ http://aleph.nkp.cz/F/?func=find-b&request=01715318&find_code=SYS&local_base=nkc
2007 @ 04 @ 33 @ Vaše zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01715684&find_code=SYS&local_base=nkc
2007 @ 04 @ 34 @ Velichovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01716319&find_code=SYS&local_base=nkc
2007 @ 04 @ 35 @ Vendelín @ http://aleph.nkp.cz/F/?func=find-b&request=01715451&find_code=SYS&local_base=nkc
2007 @ 04 @ 36 @ Vyskytenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01716328&find_code=SYS&local_base=nkc
2007 @ 04 @ 37 @ Záhady a zajímavosti @ http://aleph.nkp.cz/F/?func=find-b&request=01716318&find_code=SYS&local_base=nkc
2007 @ 04 @ 38 @ Zákaznický magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01716199&find_code=SYS&local_base=nkc
2007 @ 04 @ 39 @ Zpravodaj asociace pracovníků tlakových zařízení @ http://aleph.nkp.cz/F/?func=find-b&request=01716339&find_code=SYS&local_base=nkc
2007 @ 04 @ 40 @ Zpravodaj Regionálního centra ČSOP pro Středočeský kraj @ http://aleph.nkp.cz/F/?func=find-b&request=01714766&find_code=SYS&local_base=nkc
2007 @ 04 @ 41 @ Žerotín @ http://aleph.nkp.cz/F/?func=find-b&request=01715455&find_code=SYS&local_base=nkc
2007 @ 05 @ 01 @ Brýle plus @ http://aleph.nkp.cz/F/?func=find-b&request=01718068&find_code=SYS&local_base=nkc
2007 @ 05 @ 02 @ Češskij dom @ http://aleph.nkp.cz/F/?func=find-b&request=01717714&find_code=SYS&local_base=nkc
2007 @ 05 @ 03 @ Domov @ http://aleph.nkp.cz/F/?func=find-b&request=01717508&find_code=SYS&local_base=nkc
2007 @ 05 @ 04 @ Dřínovský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01718378&find_code=SYS&local_base=nkc
2007 @ 05 @ 05 @ EEM @ http://aleph.nkp.cz/F/?func=find-b&request=01717517&find_code=SYS&local_base=nkc
2007 @ 05 @ 06 @ Echo @ http://aleph.nkp.cz/F/?func=find-b&request=01720483&find_code=SYS&local_base=nkc
2007 @ 05 @ 07 @ Ergo @ http://aleph.nkp.cz/F/?func=find-b&request=01716251&find_code=SYS&local_base=nkc
2007 @ 05 @ 08 @ Fantasy&Science Fiction @ http://aleph.nkp.cz/F/?func=find-b&request=01718193&find_code=SYS&local_base=nkc
2007 @ 05 @ 09 @ Filmag extra @ http://aleph.nkp.cz/F/?func=find-b&request=01720392&find_code=SYS&local_base=nkc
2007 @ 05 @ 10 @ Filmag speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01720390&find_code=SYS&local_base=nkc
2007 @ 05 @ 11 @ Hlas Lubenecka @ http://aleph.nkp.cz/F/?func=find-b&request=01176761&find_code=SYS&local_base=nkc
2007 @ 05 @ 12 @ Honezovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01720860&find_code=SYS&local_base=nkc
2007 @ 05 @ 13 @ Hotel&spa management @ http://aleph.nkp.cz/F/?func=find-b&request=01717563&find_code=SYS&local_base=nkc
2007 @ 05 @ 14 @ Informátor (Česká společnost pro výzkum a využití jílů) @ http://aleph.nkp.cz/F/?func=find-b&request=01720721&find_code=SYS&local_base=nkc
2007 @ 05 @ 15 @ KamPoMaturite.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01720716&find_code=SYS&local_base=nkc
2007 @ 05 @ 16 @ Klimakterická medicína @ http://aleph.nkp.cz/F/?func=find-b&request=01717119&find_code=SYS&local_base=nkc
2007 @ 05 @ 17 @ Košetický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01717547&find_code=SYS&local_base=nkc
2007 @ 05 @ 18 @ Likosáček @ http://aleph.nkp.cz/F/?func=find-b&request=01720698&find_code=SYS&local_base=nkc
2007 @ 05 @ 19 @ Lopotník @ http://aleph.nkp.cz/F/?func=find-b&request=01720714&find_code=SYS&local_base=nkc
2007 @ 05 @ 20 @ Louňovický oslavový zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01720694&find_code=SYS&local_base=nkc
2007 @ 05 @ 21 @ Louňovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01720673&find_code=SYS&local_base=nkc
2007 @ 05 @ 22 @ Lulečský čtvrtletní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01717543&find_code=SYS&local_base=nkc
2007 @ 05 @ 23 @ Malokyšické ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=01720606&find_code=SYS&local_base=nkc
2007 @ 05 @ 24 @ Manatech.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01717546&find_code=SYS&local_base=nkc
2007 @ 05 @ 25 @ Mixxx.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01720605&find_code=SYS&local_base=nkc
2007 @ 05 @ 26 @ Multikulturní časopis @ http://aleph.nkp.cz/F/?func=find-b&request=01720607&find_code=SYS&local_base=nkc
2007 @ 05 @ 27 @ Nairi @ http://aleph.nkp.cz/F/?func=find-b&request=01720592&find_code=SYS&local_base=nkc
2007 @ 05 @ 28 @ Noviny Poštovní spořitelny @ http://aleph.nkp.cz/F/?func=find-b&request=01720582&find_code=SYS&local_base=nkc
2007 @ 05 @ 29 @ Obec Dřínov @ http://aleph.nkp.cz/F/?func=find-b&request=01718327&find_code=SYS&local_base=nkc
2007 @ 05 @ 30 @ Onkologie @ http://aleph.nkp.cz/F/?func=find-b&request=01718080&find_code=SYS&local_base=nkc
2007 @ 05 @ 31 @ OVB Journal @ http://aleph.nkp.cz/F/?func=find-b&request=01720040&find_code=SYS&local_base=nkc
2007 @ 05 @ 32 @ Paceřák @ http://aleph.nkp.cz/F/?func=find-b&request=01719328&find_code=SYS&local_base=nkc
2007 @ 05 @ 33 @ Pivovarská revue @ http://aleph.nkp.cz/F/?func=find-b&request=01719360&find_code=SYS&local_base=nkc
2007 @ 05 @ 34 @ Pony club magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01717571&find_code=SYS&local_base=nkc
2007 @ 05 @ 35 @ Progulka s Alisoj @ http://aleph.nkp.cz/F/?func=find-b&request=01717703&find_code=SYS&local_base=nkc
2007 @ 05 @ 36 @ Prokone.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01719367&find_code=SYS&local_base=nkc
2007 @ 05 @ 37 @ Překvapení v kuchyni @ http://aleph.nkp.cz/F/?func=find-b&request=01717567&find_code=SYS&local_base=nkc
2007 @ 05 @ 38 @ Služebníček @ http://aleph.nkp.cz/F/?func=find-b&request=01720509&find_code=SYS&local_base=nkc
2007 @ 05 @ 39 @ Sudický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01719341&find_code=SYS&local_base=nkc
2007 @ 05 @ 40 @ Šíp extra @ http://aleph.nkp.cz/F/?func=find-b&request=01718141&find_code=SYS&local_base=nkc
2007 @ 05 @ 41 @ Šumperské a zábřežské inzertní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01718046&find_code=SYS&local_base=nkc
2007 @ 05 @ 42 @ Švadlenka @ http://aleph.nkp.cz/F/?func=find-b&request=01718054&find_code=SYS&local_base=nkc
2007 @ 05 @ 43 @ U nás @ http://aleph.nkp.cz/F/?func=find-b&request=01720047&find_code=SYS&local_base=nkc
2007 @ 05 @ 44 @ Vítaný host na Šumavě a v Českém lese @ http://aleph.nkp.cz/F/?func=find-b&request=01719345&find_code=SYS&local_base=nkc
2007 @ 05 @ 45 @ Vítejte v Srdci Evropy @ http://aleph.nkp.cz/F/?func=find-b&request=01719318&find_code=SYS&local_base=nkc
2007 @ 05 @ 46 @ Zdravý úsměv @ http://aleph.nkp.cz/F/?func=find-b&request=01717341&find_code=SYS&local_base=nkc
2007 @ 05 @ 47 @ Zebrin @ http://aleph.nkp.cz/F/?func=find-b&request=01716902&find_code=SYS&local_base=nkc
2007 @ 05 @ 48 @ Zpravodaj obce Alojzov @ http://aleph.nkp.cz/F/?func=find-b&request=01719369&find_code=SYS&local_base=nkc
2007 @ 05 @ 49 @ Zpravodaj obce Radslavice @ http://aleph.nkp.cz/F/?func=find-b&request=01717701&find_code=SYS&local_base=nkc
2007 @ 05 @ 50 @ Zpravodaj obce Tučapy @ http://aleph.nkp.cz/F/?func=find-b&request=01720488&find_code=SYS&local_base=nkc
2007 @ 05 @ 51 @ Zpravodaj Šípek @ http://aleph.nkp.cz/F/?func=find-b&request=01717706&find_code=SYS&local_base=nkc
2007 @ 05 @ 52 @ Zpravodaj Vigantic @ http://aleph.nkp.cz/F/?func=find-b&request=01717937&find_code=SYS&local_base=nkc
2007 @ 05 @ 53 @ Žabokuk @ http://aleph.nkp.cz/F/?func=find-b&request=01720386&find_code=SYS&local_base=nkc
2007 @ 05 @ 54 @ Želešický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01717127&find_code=SYS&local_base=nkc
2007 @ 06 @ 42 @ Satisfakce @ http://aleph.nkp.cz/F/?func=find-b&request=01724952&find_code=SYS&local_base=nkc
2007 @ 06 @ 41 @ Satisfaction @ http://aleph.nkp.cz/F/?func=find-b&request=01722624&find_code=SYS&local_base=nkc
2007 @ 06 @ 40 @ S úsměvem @ http://aleph.nkp.cz/F/?func=find-b&request=01724930&find_code=SYS&local_base=nkc
2007 @ 06 @ 39 @ Řádková inzerce @ http://aleph.nkp.cz/F/?func=find-b&request=01724838&find_code=SYS&local_base=nkc
2007 @ 06 @ 38 @ Rusko v globální politice @ http://aleph.nkp.cz/F/?func=find-b&request=01724249&find_code=SYS&local_base=nkc
2007 @ 06 @ 37 @ Rudimovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01725612&find_code=SYS&local_base=nkc
2007 @ 06 @ 36 @ Rohelský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01723911&find_code=SYS&local_base=nkc
2007 @ 06 @ 35 @ Reflex interview @ http://aleph.nkp.cz/F/?func=find-b&request=01725787&find_code=SYS&local_base=nkc
2007 @ 06 @ 34 @ Program kurzových sázek @ http://aleph.nkp.cz/F/?func=find-b&request=01726125&find_code=SYS&local_base=nkc
2007 @ 06 @ 33 @ Profirma @ http://aleph.nkp.cz/F/?func=find-b&request=01725000&find_code=SYS&local_base=nkc
2007 @ 06 @ 32 @ Posel židovské obce v Teplicích @ http://aleph.nkp.cz/F/?func=find-b&request=01724979&find_code=SYS&local_base=nkc
2007 @ 06 @ 31 @ Poříčský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01723959&find_code=SYS&local_base=nkc
2007 @ 06 @ 30 @ Phil @ http://aleph.nkp.cz/F/?func=find-b&request=01722885&find_code=SYS&local_base=nkc
2007 @ 06 @ 29 @ Pavlíkovská radnice @ http://aleph.nkp.cz/F/?func=find-b&request=01725981&find_code=SYS&local_base=nkc
2007 @ 06 @ 28 @ Panorama @ http://aleph.nkp.cz/F/?func=find-b&request=01724967&find_code=SYS&local_base=nkc
2007 @ 06 @ 27 @ Oudoleňské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01725165&find_code=SYS&local_base=nkc
2007 @ 06 @ 26 @ Osmisměrky - vážně a nevážně o lásce @ http://aleph.nkp.cz/F/?func=find-b&request=01725603&find_code=SYS&local_base=nkc
2007 @ 06 @ 25 @ Objektiv @ http://aleph.nkp.cz/F/?func=find-b&request=01725151&find_code=SYS&local_base=nkc
2007 @ 06 @ 24 @ Obecní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01726214&find_code=SYS&local_base=nkc
2007 @ 06 @ 23 @ Noviny Modlanska @ http://aleph.nkp.cz/F/?func=find-b&request=01724978&find_code=SYS&local_base=nkc
2007 @ 06 @ 22 @ Nedvědický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01725006&find_code=SYS&local_base=nkc
2007 @ 06 @ 21 @ Naše město @ http://aleph.nkp.cz/F/?func=find-b&request=01726174&find_code=SYS&local_base=nkc
2007 @ 06 @ 20 @ Mnetěšský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01725982&find_code=SYS&local_base=nkc
2007 @ 06 @ 19 @ Košťálovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01725001&find_code=SYS&local_base=nkc
2007 @ 06 @ 18 @ Kapka @ http://aleph.nkp.cz/F/?func=find-b&request=01725769&find_code=SYS&local_base=nkc
2007 @ 06 @ 17 @ Jičínsko inzert @ http://aleph.nkp.cz/F/?func=find-b&request=01725121&find_code=SYS&local_base=nkc
2007 @ 06 @ 16 @ Information Assurance @ http://aleph.nkp.cz/F/?func=find-b&request=01725163&find_code=SYS&local_base=nkc
2007 @ 06 @ 15 @ Informační zpravodaj (Společnost Jana Masaryka) @ http://aleph.nkp.cz/F/?func=find-b&request=01726172&find_code=SYS&local_base=nkc
2007 @ 06 @ 14 @ Informační katalog NSC @ http://aleph.nkp.cz/F/?func=find-b&request=01724984&find_code=SYS&local_base=nkc
2007 @ 06 @ 13 @ Informace z radnice @ http://aleph.nkp.cz/F/?func=find-b&request=01724831&find_code=SYS&local_base=nkc
2007 @ 06 @ 12 @ Infobulletin Nadačního fondu obětem holocaustu @ http://aleph.nkp.cz/F/?func=find-b&request=01724825&find_code=SYS&local_base=nkc
2007 @ 06 @ 11 @ Chrom&plameny @ http://aleph.nkp.cz/F/?func=find-b&request=01725724&find_code=SYS&local_base=nkc
2007 @ 06 @ 10 @ Hostěradický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01725156&find_code=SYS&local_base=nkc
2007 @ 06 @ 09 @ Horoskopy a křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=01725215&find_code=SYS&local_base=nkc
2007 @ 06 @ 08 @ Hornoživotický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01724877&find_code=SYS&local_base=nkc
2007 @ 06 @ 07 @ Habartická drbnička @ http://aleph.nkp.cz/F/?func=find-b&request=01724991&find_code=SYS&local_base=nkc
2007 @ 06 @ 06 @ Esence @ http://aleph.nkp.cz/F/?func=find-b&request=01725112&find_code=SYS&local_base=nkc
2007 @ 06 @ 05 @ Drůbežář @ http://aleph.nkp.cz/F/?func=find-b&request=01725119&find_code=SYS&local_base=nkc
2007 @ 06 @ 04 @ ČT+ @ http://aleph.nkp.cz/F/?func=find-b&request=01725241&find_code=SYS&local_base=nkc
2007 @ 06 @ 03 @ Benjamín @ http://aleph.nkp.cz/F/?func=find-b&request=01724884&find_code=SYS&local_base=nkc
2007 @ 06 @ 02 @ AV news @ http://aleph.nkp.cz/F/?func=find-b&request=01724965&find_code=SYS&local_base=nkc
2007 @ 06 @ 01 @ Alcron today @ http://aleph.nkp.cz/F/?func=find-b&request=01724940&find_code=SYS&local_base=nkc
2007 @ 06 @ 43 @ Sedm @ http://aleph.nkp.cz/F/?func=find-b&request=01722623&find_code=SYS&local_base=nkc
2007 @ 06 @ 44 @ Sokolík @ http://aleph.nkp.cz/F/?func=find-b&request=01723937&find_code=SYS&local_base=nkc
2007 @ 06 @ 45 @ Sudoměřický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01725629&find_code=SYS&local_base=nkc
2007 @ 06 @ 46 @ Štěpánovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01725979&find_code=SYS&local_base=nkc
2007 @ 06 @ 47 @ Vyžlovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01725561&find_code=SYS&local_base=nkc
2007 @ 06 @ 48 @ Zpravodaj (Moravský Písek) @ http://aleph.nkp.cz/F/?func=find-b&request=01723572&find_code=SYS&local_base=nkc
2007 @ 06 @ 49 @ Zpravodaj (Vilémov) @ http://aleph.nkp.cz/F/?func=find-b&request=01724922&find_code=SYS&local_base=nkc
2007 @ 06 @ 50 @ Zpravodaj obce Drnovice @ http://aleph.nkp.cz/F/?func=find-b&request=01725983&find_code=SYS&local_base=nkc
2007 @ 06 @ 51 @ Žena+ @ http://aleph.nkp.cz/F/?func=find-b&request=01725808&find_code=SYS&local_base=nkc
2007 @ 07 @ 01 @ Archinews @ http://aleph.nkp.cz/F/?func=find-b&request=01727365&find_code=SYS&local_base=nkc
2007 @ 07 @ 02 @ Astronews @ http://aleph.nkp.cz/F/?func=find-b&request=01727594&find_code=SYS&local_base=nkc
2007 @ 07 @ 03 @ Autoojetiny @ http://aleph.nkp.cz/F/?func=find-b&request=01727790&find_code=SYS&local_base=nkc
2007 @ 07 @ 04 @ Contemporary European Studies @ http://aleph.nkp.cz/F/?func=find-b&request=01728819&find_code=SYS&local_base=nkc
2007 @ 07 @ 05 @ Corporate Life @ http://aleph.nkp.cz/F/?func=find-b&request=01727412&find_code=SYS&local_base=nkc
2007 @ 07 @ 06 @ Current Opinion in Cardiology (české vydání) @ http://aleph.nkp.cz/F/?func=find-b&request=01729007&find_code=SYS&local_base=nkc
2007 @ 07 @ 07 @ Current Opinion in Critical Care (české vydání) @ http://aleph.nkp.cz/F/?func=find-b&request=01729005&find_code=SYS&local_base=nkc
2007 @ 07 @ 08 @ Current Opinion in Nephrology and Hypertension (české vydání) @ http://aleph.nkp.cz/F/?func=find-b&request=01729006&find_code=SYS&local_base=nkc
2007 @ 07 @ 09 @ Current Opinion in Oncology (české vydání) @ http://aleph.nkp.cz/F/?func=find-b&request=01729004&find_code=SYS&local_base=nkc
2007 @ 07 @ 10 @ Current Opinion in Organ Transplantation (české vydání) @ http://aleph.nkp.cz/F/?func=find-b&request=01729008&find_code=SYS&local_base=nkc
2007 @ 07 @ 11 @ Current Opinion in Rheumatology (české vydání) @ http://aleph.nkp.cz/F/?func=find-b&request=01729003&find_code=SYS&local_base=nkc
2007 @ 07 @ 12 @ Čimelický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01727416&find_code=SYS&local_base=nkc
2007 @ 07 @ 13 @ Děkanský hlasatel @ http://aleph.nkp.cz/F/?func=find-b&request=01729211&find_code=SYS&local_base=nkc
2007 @ 07 @ 14 @ Eghaland Bladl @ http://aleph.nkp.cz/F/?func=find-b&request=01728577&find_code=SYS&local_base=nkc
2007 @ 07 @ 15 @ Fottea @ http://aleph.nkp.cz/F/?func=find-b&request=01728851&find_code=SYS&local_base=nkc
2007 @ 07 @ 16 @ Friseur Professional @ http://aleph.nkp.cz/F/?func=find-b&request=01727334&find_code=SYS&local_base=nkc
2007 @ 07 @ 17 @ Haječan @ http://aleph.nkp.cz/F/?func=find-b&request=01727520&find_code=SYS&local_base=nkc
2007 @ 07 @ 18 @ Informační občasník pro občany Mostkovic @ http://aleph.nkp.cz/F/?func=find-b&request=01729210&find_code=SYS&local_base=nkc
2007 @ 07 @ 19 @ Kozlanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01727806&find_code=SYS&local_base=nkc
2007 @ 07 @ 20 @ Křížovky pejskoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01728693&find_code=SYS&local_base=nkc
2007 @ 07 @ 21 @ Letňanské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01728706&find_code=SYS&local_base=nkc
2007 @ 07 @ 22 @ Lifestyles magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01727525&find_code=SYS&local_base=nkc
2007 @ 07 @ 23 @ Ludvíkovické listy @ http://aleph.nkp.cz/F/?func=find-b&request=01727398&find_code=SYS&local_base=nkc
2007 @ 07 @ 24 @ Maxi Oříšek @ http://aleph.nkp.cz/F/?func=find-b&request=01728324&find_code=SYS&local_base=nkc
2007 @ 07 @ 25 @ Milujte se! @ http://aleph.nkp.cz/F/?func=find-b&request=01727424&find_code=SYS&local_base=nkc
2007 @ 07 @ 26 @ MoravskoBudějovicko @ http://aleph.nkp.cz/F/?func=find-b&request=01729549&find_code=SYS&local_base=nkc
2007 @ 07 @ 27 @ Oříšek sudoku @ http://aleph.nkp.cz/F/?func=find-b&request=01728322&find_code=SYS&local_base=nkc
2007 @ 07 @ 28 @ Pacient v obraze @ http://aleph.nkp.cz/F/?func=find-b&request=01727184&find_code=SYS&local_base=nkc
2007 @ 07 @ 29 @ Pasečnické listy @ http://aleph.nkp.cz/F/?func=find-b&request=01727326&find_code=SYS&local_base=nkc
2007 @ 07 @ 30 @ Pro život zdravější @ http://aleph.nkp.cz/F/?func=find-b&request=01728316&find_code=SYS&local_base=nkc
2007 @ 07 @ 31 @ Revers @ http://aleph.nkp.cz/F/?func=find-b&request=01727772&find_code=SYS&local_base=nkc
2007 @ 07 @ 32 @ Software Developer @ http://aleph.nkp.cz/F/?func=find-b&request=01727356&find_code=SYS&local_base=nkc
2007 @ 07 @ 33 @ Sorrel @ http://aleph.nkp.cz/F/?func=find-b&request=01727797&find_code=SYS&local_base=nkc
2007 @ 07 @ 34 @ SOS magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01727618&find_code=SYS&local_base=nkc
2007 @ 07 @ 35 @ Statistický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01729358&find_code=SYS&local_base=nkc
2007 @ 07 @ 36 @ Svět outdooru @ http://aleph.nkp.cz/F/?func=find-b&request=01727925&find_code=SYS&local_base=nkc
2007 @ 07 @ 37 @ Světová medicína stručně @ http://aleph.nkp.cz/F/?func=find-b&request=01729355&find_code=SYS&local_base=nkc
2007 @ 07 @ 38 @ Uni @ http://aleph.nkp.cz/F/?func=find-b&request=01727808&find_code=SYS&local_base=nkc
2007 @ 07 @ 39 @ Vakcinologie @ http://aleph.nkp.cz/F/?func=find-b&request=01727865&find_code=SYS&local_base=nkc
2007 @ 07 @ 40 @ Věteřský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01729198&find_code=SYS&local_base=nkc
2007 @ 07 @ 41 @ Via nostra @ http://aleph.nkp.cz/F/?func=find-b&request=01727845&find_code=SYS&local_base=nkc
2007 @ 07 @ 42 @ XBOX 360 @ http://aleph.nkp.cz/F/?func=find-b&request=01727898&find_code=SYS&local_base=nkc
2007 @ 07 @ 43 @ Zábořský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01727720&find_code=SYS&local_base=nkc
2007 @ 07 @ 44 @ Zápraží @ http://aleph.nkp.cz/F/?func=find-b&request=01726900&find_code=SYS&local_base=nkc
2007 @ 07 @ 45 @ Zpravodaj (Českomoravská záruční a rozvojová banka) @ http://aleph.nkp.cz/F/?func=find-b&request=01727186&find_code=SYS&local_base=nkc
2007 @ 07 @ 46 @ Zpravodaj (obec Lipůvka) @ http://aleph.nkp.cz/F/?func=find-b&request=01727764&find_code=SYS&local_base=nkc
2007 @ 07 @ 47 @ Zpravodaj místní akční skupiny Most Vysočiny@ o.p.s.', 'http://aleph.nkp.cz/F/?func=find-b&request=01727178&find_code=SYS&local_base=nkc
2007 @ 07 @ 48 @ Zpravodaj obce Viničné Šumice @ http://aleph.nkp.cz/F/?func=find-b&request=01727644&find_code=SYS&local_base=nkc
2007 @ 08 @ 01 @ Aha! Vařečka @ http://aleph.nkp.cz/F/?func=find-b&request=01749060&find_code=SYS&local_base=nkc
2007 @ 08 @ 02 @ Aplaus @ http://aleph.nkp.cz/F/?func=find-b&request=01748869&find_code=SYS&local_base=nkc
2007 @ 08 @ 03 @ Basket magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01750266&find_code=SYS&local_base=nkc
2007 @ 08 @ 04 @ Beskydy @ http://aleph.nkp.cz/F/?func=find-b&request=01748618&find_code=SYS&local_base=nkc
2007 @ 08 @ 05 @ Buddy @ http://aleph.nkp.cz/F/?func=find-b&request=01748048&find_code=SYS&local_base=nkc
2007 @ 08 @ 06 @ Bydlíme @ http://aleph.nkp.cz/F/?func=find-b&request=01749058&find_code=SYS&local_base=nkc
2007 @ 08 @ 07 @ Central European journal of international & security studies @ http://aleph.nkp.cz/F/?func=find-b&request=01749607&find_code=SYS&local_base=nkc
2007 @ 08 @ 08 @ Cigare & vin style @ http://aleph.nkp.cz/F/?func=find-b&request=01748466&find_code=SYS&local_base=nkc
2007 @ 08 @ 09 @ Černodolský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01747615&find_code=SYS&local_base=nkc
2007 @ 08 @ 10 @ Dental plus @ http://aleph.nkp.cz/F/?func=find-b&request=01747600&find_code=SYS&local_base=nkc
2007 @ 08 @ 11 @ Detektiv @ http://aleph.nkp.cz/F/?func=find-b&request=01750487&find_code=SYS&local_base=nkc
2007 @ 08 @ 12 @ Fórum sociální politiky @ http://aleph.nkp.cz/F/?func=find-b&request=01750315&find_code=SYS&local_base=nkc
2007 @ 08 @ 13 @ Havlíčkobrodské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01750000&find_code=SYS&local_base=nkc
2007 @ 08 @ 14 @ Holetínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01748961&find_code=SYS&local_base=nkc
2007 @ 08 @ 15 @ Chýňský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01747263&find_code=SYS&local_base=nkc
2007 @ 08 @ 16 @ Jakost@ bezpečnost, ekologie', 'http://aleph.nkp.cz/F/?func=find-b&request=01748966&find_code=SYS&local_base=nkc
2007 @ 08 @ 17 @ Jizerské hory @ http://aleph.nkp.cz/F/?func=find-b&request=01749986&find_code=SYS&local_base=nkc
2007 @ 08 @ 18 @ Kamenohorský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01747631&find_code=SYS&local_base=nkc
2007 @ 08 @ 19 @ Karsit revue @ http://aleph.nkp.cz/F/?func=find-b&request=01749161&find_code=SYS&local_base=nkc
2007 @ 08 @ 20 @ Knihovnička Zahrada @ http://aleph.nkp.cz/F/?func=find-b&request=01750287&find_code=SYS&local_base=nkc
2007 @ 08 @ 21 @ Krnovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01750012&find_code=SYS&local_base=nkc
2007 @ 08 @ 22 @ List obce (Bílov) @ http://aleph.nkp.cz/F/?func=find-b&request=01750350&find_code=SYS&local_base=nkc
2007 @ 08 @ 23 @ Magazín Lípa @ http://aleph.nkp.cz/F/?func=find-b&request=01750124&find_code=SYS&local_base=nkc
2007 @ 08 @ 24 @ MediSpo magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01750129&find_code=SYS&local_base=nkc
2007 @ 08 @ 25 @ Merklínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01747613&find_code=SYS&local_base=nkc
2007 @ 08 @ 26 @ Městský zpravodaj (Nymburk) @ http://aleph.nkp.cz/F/?func=find-b&request=01749317&find_code=SYS&local_base=nkc
2007 @ 08 @ 27 @ Mezisvěty @ http://aleph.nkp.cz/F/?func=find-b&request=01748576&find_code=SYS&local_base=nkc
2007 @ 08 @ 28 @ Moutnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01750001&find_code=SYS&local_base=nkc
2007 @ 08 @ 29 @ Nápadník @ http://aleph.nkp.cz/F/?func=find-b&request=01748866&find_code=SYS&local_base=nkc
2007 @ 08 @ 30 @ Nejdecké listy @ http://aleph.nkp.cz/F/?func=find-b&request=01747267&find_code=SYS&local_base=nkc
2007 @ 08 @ 31 @ Nepravidelný zpravodaj (Mokré) @ http://aleph.nkp.cz/F/?func=find-b&request=01749629&find_code=SYS&local_base=nkc
2007 @ 08 @ 32 @ Nížkovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01749128&find_code=SYS&local_base=nkc
2007 @ 08 @ 33 @ Nový tachograf @ http://aleph.nkp.cz/F/?func=find-b&request=01748943&find_code=SYS&local_base=nkc
2007 @ 08 @ 34 @ Občasník (Dvorce) @ http://aleph.nkp.cz/F/?func=find-b&request=01749610&find_code=SYS&local_base=nkc
2007 @ 08 @ 35 @ Obecní zpravodaj (Nová Dědina) @ http://aleph.nkp.cz/F/?func=find-b&request=01747760&find_code=SYS&local_base=nkc
2007 @ 08 @ 36 @ Oko @ http://aleph.nkp.cz/F/?func=find-b&request=01748059&find_code=SYS&local_base=nkc
2007 @ 08 @ 37 @ Orbis scholae @ http://aleph.nkp.cz/F/?func=find-b&request=01750146&find_code=SYS&local_base=nkc
2007 @ 08 @ 38 @ Outlander magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01749375&find_code=SYS&local_base=nkc
2007 @ 08 @ 39 @ Pátecký plátek @ http://aleph.nkp.cz/F/?func=find-b&request=01750298&find_code=SYS&local_base=nkc
2007 @ 08 @ 40 @ Perfect woman @ http://aleph.nkp.cz/F/?func=find-b&request=01749108&find_code=SYS&local_base=nkc
2007 @ 08 @ 41 @ Podmolský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01747627&find_code=SYS&local_base=nkc
2007 @ 08 @ 42 @ Revue 50+ @ http://aleph.nkp.cz/F/?func=find-b&request=01747070&find_code=SYS&local_base=nkc
2007 @ 08 @ 43 @ Revue endokrinologie Supplementum @ http://aleph.nkp.cz/F/?func=find-b&request=01748602&find_code=SYS&local_base=nkc
2007 @ 08 @ 44 @ Řípecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01747414&find_code=SYS&local_base=nkc
2007 @ 08 @ 45 @ Starolískovecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01747053&find_code=SYS&local_base=nkc
2007 @ 08 @ 46 @ Sudoku do kapsy @ http://aleph.nkp.cz/F/?func=find-b&request=01747880&find_code=SYS&local_base=nkc
2007 @ 08 @ 47 @ Šumenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01747618&find_code=SYS&local_base=nkc
2007 @ 08 @ 48 @ Třinecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01750444&find_code=SYS&local_base=nkc
2007 @ 08 @ 49 @ Turnovsko @ http://aleph.nkp.cz/F/?func=find-b&request=01749583&find_code=SYS&local_base=nkc
2007 @ 08 @ 50 @ Visionář @ http://aleph.nkp.cz/F/?func=find-b&request=01748591&find_code=SYS&local_base=nkc
2007 @ 08 @ 51 @ Zelené listy moravskoslezské @ http://aleph.nkp.cz/F/?func=find-b&request=01748043&find_code=SYS&local_base=nkc
2007 @ 08 @ 52 @ Zpravodaj (Slavětín) @ http://aleph.nkp.cz/F/?func=find-b&request=01749313&find_code=SYS&local_base=nkc
2007 @ 08 @ 53 @ Zpravodaj (Teplárny Brno) @ http://aleph.nkp.cz/F/?func=find-b&request=01749162&find_code=SYS&local_base=nkc
2007 @ 08 @ 54 @ Zpravodaj (Tupesy) @ http://aleph.nkp.cz/F/?func=find-b&request=01748868&find_code=SYS&local_base=nkc
2007 @ 08 @ 55 @ Zpravodaj České biblické společnosti @ http://aleph.nkp.cz/F/?func=find-b&request=01748970&find_code=SYS&local_base=nkc
2007 @ 08 @ 56 @ Zpravodaj obce Doloplazy @ http://aleph.nkp.cz/F/?func=find-b&request=01748052&find_code=SYS&local_base=nkc
2007 @ 08 @ 57 @ Zpravodaj obce Suchomasty @ http://aleph.nkp.cz/F/?func=find-b&request=01749132&find_code=SYS&local_base=nkc
2007 @ 08 @ 58 @ Živnostník @ http://aleph.nkp.cz/F/?func=find-b&request=01750177&find_code=SYS&local_base=nkc
2007 @ 09 @ 01 @ 90 dní v Praze @ http://aleph.nkp.cz/F/?func=find-b&request=01752981&find_code=SYS&local_base=nkc
2007 @ 09 @ 02 @ ArcelorMittal Ostrava @ http://aleph.nkp.cz/F/?func=find-b&request=01752818&find_code=SYS&local_base=nkc
2007 @ 09 @ 03 @ Arval life @ http://aleph.nkp.cz/F/?func=find-b&request=01753156&find_code=SYS&local_base=nkc
2007 @ 09 @ 04 @ Barové noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01752951&find_code=SYS&local_base=nkc
2007 @ 09 @ 05 @ Besico magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01757129&find_code=SYS&local_base=nkc
2007 @ 09 @ 06 @ Bestsellers @ http://aleph.nkp.cz/F/?func=find-b&request=01753087&find_code=SYS&local_base=nkc
2007 @ 09 @ 07 @ Bítovčický čtvrtletník @ http://aleph.nkp.cz/F/?func=find-b&request=01752848&find_code=SYS&local_base=nkc
2007 @ 09 @ 08 @ Brno 06 @ http://aleph.nkp.cz/F/?func=find-b&request=01751182&find_code=SYS&local_base=nkc
2007 @ 09 @ 09 @ Clinical cardiology alert @ http://aleph.nkp.cz/F/?func=find-b&request=01750670&find_code=SYS&local_base=nkc
2007 @ 09 @ 10 @ CSR fórum @ http://aleph.nkp.cz/F/?func=find-b&request=01756657&find_code=SYS&local_base=nkc
2007 @ 09 @ 11 @ Current opinion in lipidology @ http://aleph.nkp.cz/F/?func=find-b&request=01750681&find_code=SYS&local_base=nkc
2007 @ 09 @ 12 @ České realitní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01757193&find_code=SYS&local_base=nkc
2007 @ 09 @ 13 @ Čtyřka @ http://aleph.nkp.cz/F/?func=find-b&request=01757363&find_code=SYS&local_base=nkc
2007 @ 09 @ 14 @ Doma na Šumavě @ http://aleph.nkp.cz/F/?func=find-b&request=01750138&find_code=SYS&local_base=nkc
2007 @ 09 @ 15 @ Doma v Beskydech @ http://aleph.nkp.cz/F/?func=find-b&request=01750147&find_code=SYS&local_base=nkc
2007 @ 09 @ 16 @ Doma v Moravském krasu @ http://aleph.nkp.cz/F/?func=find-b&request=01750126&find_code=SYS&local_base=nkc
2007 @ 09 @ 17 @ Golf vacations @ http://aleph.nkp.cz/F/?func=find-b&request=01753000&find_code=SYS&local_base=nkc
2007 @ 09 @ 18 @ Grand Turistika @ http://aleph.nkp.cz/F/?func=find-b&request=01753084&find_code=SYS&local_base=nkc
2007 @ 09 @ 19 @ Holešovický bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=01757232&find_code=SYS&local_base=nkc
2007 @ 09 @ 20 @ Horoskopy & osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=01750220&find_code=SYS&local_base=nkc
2007 @ 09 @ 21 @ Horus @ http://aleph.nkp.cz/F/?func=find-b&request=01750274&find_code=SYS&local_base=nkc
2007 @ 09 @ 22 @ Hubatá černoška (Dobříš@ Březnice, Milín, Rožmitál p.Třemšínem)', 'http://aleph.nkp.cz/F/?func=find-b&request=01753058&find_code=SYS&local_base=nkc
2007 @ 09 @ 23 @ Informace MAS Jemnicko o.p.s. @ http://aleph.nkp.cz/F/?func=find-b&request=01750218&find_code=SYS&local_base=nkc
2007 @ 09 @ 24 @ Inforum @ http://aleph.nkp.cz/F/?func=find-b&request=01750684&find_code=SYS&local_base=nkc
2007 @ 09 @ 25 @ Korálki @ http://aleph.nkp.cz/F/?func=find-b&request=01753009&find_code=SYS&local_base=nkc
2007 @ 09 @ 26 @ Kovářovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01752942&find_code=SYS&local_base=nkc
2007 @ 09 @ 27 @ Krajkové háčkování @ http://aleph.nkp.cz/F/?func=find-b&request=01750669&find_code=SYS&local_base=nkc
2007 @ 09 @ 28 @ Krkonošská sezona @ http://aleph.nkp.cz/F/?func=find-b&request=01753082&find_code=SYS&local_base=nkc
2007 @ 09 @ 29 @ Lušti a vyhraj Sudoku speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01750219&find_code=SYS&local_base=nkc
2007 @ 09 @ 30 @ McKenzie časopis @ http://aleph.nkp.cz/F/?func=find-b&request=01753459&find_code=SYS&local_base=nkc
2007 @ 09 @ 31 @ Mecca @ http://aleph.nkp.cz/F/?func=find-b&request=01752976&find_code=SYS&local_base=nkc
2007 @ 09 @ 32 @ Měsíční noviny Elefant Vítkov a.s. @ http://aleph.nkp.cz/F/?func=find-b&request=01750301&find_code=SYS&local_base=nkc
2007 @ 09 @ 33 @ Městské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01753221&find_code=SYS&local_base=nkc
2007 @ 09 @ 34 @ Moravičanský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01753429&find_code=SYS&local_base=nkc
2007 @ 09 @ 35 @ Moravský venkov @ http://aleph.nkp.cz/F/?func=find-b&request=01756929&find_code=SYS&local_base=nkc
2007 @ 09 @ 36 @ Náš agel @ http://aleph.nkp.cz/F/?func=find-b&request=01756700&find_code=SYS&local_base=nkc
2007 @ 09 @ 37 @ Naše alternativy @ http://aleph.nkp.cz/F/?func=find-b&request=01756713&find_code=SYS&local_base=nkc
2007 @ 09 @ 38 @ Nepomucko @ http://aleph.nkp.cz/F/?func=find-b&request=01752821&find_code=SYS&local_base=nkc
2007 @ 09 @ 39 @ New publicity @ http://aleph.nkp.cz/F/?func=find-b&request=01752838&find_code=SYS&local_base=nkc
2007 @ 09 @ 40 @ Nordicmag @ http://aleph.nkp.cz/F/?func=find-b&request=01757383&find_code=SYS&local_base=nkc
2007 @ 09 @ 41 @ Nové agro @ http://aleph.nkp.cz/F/?func=find-b&request=01750167&find_code=SYS&local_base=nkc
2007 @ 09 @ 42 @ Obesity news @ http://aleph.nkp.cz/F/?func=find-b&request=01757123&find_code=SYS&local_base=nkc
2007 @ 09 @ 43 @ OutMAG @ http://aleph.nkp.cz/F/?func=find-b&request=01750695&find_code=SYS&local_base=nkc
2007 @ 09 @ 44 @ Outside digest @ http://aleph.nkp.cz/F/?func=find-b&request=01749567&find_code=SYS&local_base=nkc
2007 @ 09 @ 45 @ Panorama zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01750268&find_code=SYS&local_base=nkc
2007 @ 09 @ 46 @ Povyk @ http://aleph.nkp.cz/F/?func=find-b&request=01750805&find_code=SYS&local_base=nkc
2007 @ 09 @ 47 @ Přídolské novinky PBS @ http://aleph.nkp.cz/F/?func=find-b&request=01751135&find_code=SYS&local_base=nkc
2007 @ 09 @ 48 @ Region Opavsko @ http://aleph.nkp.cz/F/?func=find-b&request=01757097&find_code=SYS&local_base=nkc
2007 @ 09 @ 49 @ Regionální zpravodaj (mikroregion Zábřežsko) @ http://aleph.nkp.cz/F/?func=find-b&request=01757381&find_code=SYS&local_base=nkc
2007 @ 09 @ 50 @ Revue @ http://aleph.nkp.cz/F/?func=find-b&request=01751176&find_code=SYS&local_base=nkc
2007 @ 09 @ 51 @ Rodina & zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01757358&find_code=SYS&local_base=nkc
2007 @ 09 @ 52 @ Rostoklatský zvěstovatel @ http://aleph.nkp.cz/F/?func=find-b&request=01751681&find_code=SYS&local_base=nkc
2007 @ 09 @ 53 @ Semice @ http://aleph.nkp.cz/F/?func=find-b&request=01750162&find_code=SYS&local_base=nkc
2007 @ 09 @ 54 @ Sport & wellness management @ http://aleph.nkp.cz/F/?func=find-b&request=01752795&find_code=SYS&local_base=nkc
2007 @ 09 @ 55 @ Staropramen menu @ http://aleph.nkp.cz/F/?func=find-b&request=01750214&find_code=SYS&local_base=nkc
2007 @ 09 @ 56 @ Střed 01 @ http://aleph.nkp.cz/F/?func=find-b&request=01757225&find_code=SYS&local_base=nkc
2007 @ 09 @ 57 @ Tommy @ http://aleph.nkp.cz/F/?func=find-b&request=01753450&find_code=SYS&local_base=nkc
2007 @ 09 @ 58 @ Velkolepý Spider-man @ http://aleph.nkp.cz/F/?func=find-b&request=01750668&find_code=SYS&local_base=nkc
2007 @ 09 @ 59 @ Women only @ http://aleph.nkp.cz/F/?func=find-b&request=01750635&find_code=SYS&local_base=nkc
2007 @ 09 @ 60 @ Zpravodaj Občanského sdružení Rosa @ http://aleph.nkp.cz/F/?func=find-b&request=01750123&find_code=SYS&local_base=nkc
2007 @ 09 @ 61 @ Zpravodaj Pomocných tlapek o.p.s. @ http://aleph.nkp.cz/F/?func=find-b&request=01757410&find_code=SYS&local_base=nkc
2007 @ 09 @ 62 @ Žalkovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01750709&find_code=SYS&local_base=nkc
2007 @ 10 @ 01 @ Artek @ http://aleph.nkp.cz/F/?func=find-b&request=01760162&find_code=SYS&local_base=nkc
2007 @ 10 @ 02 @ Boršovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01760149&find_code=SYS&local_base=nkc
2007 @ 10 @ 03 @ Citovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01760894&find_code=SYS&local_base=nkc
2007 @ 10 @ 04 @ Credo @ http://aleph.nkp.cz/F/?func=find-b&request=01762129&find_code=SYS&local_base=nkc
2007 @ 10 @ 05 @ Člověk & obchod @ http://aleph.nkp.cz/F/?func=find-b&request=01759905&find_code=SYS&local_base=nkc
2007 @ 10 @ 06 @ Detektor revue @ http://aleph.nkp.cz/F/?func=find-b&request=01759693&find_code=SYS&local_base=nkc
2007 @ 10 @ 07 @ Disk @ http://aleph.nkp.cz/F/?func=find-b&request=01758208&find_code=SYS&local_base=nkc
2007 @ 10 @ 08 @ Domoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01762088&find_code=SYS&local_base=nkc
2007 @ 10 @ 09 @ Economics and management @ http://aleph.nkp.cz/F/?func=find-b&request=01758637&find_code=SYS&local_base=nkc
2007 @ 10 @ 10 @ Engineering mechanics @ http://aleph.nkp.cz/F/?func=find-b&request=01758115&find_code=SYS&local_base=nkc
2007 @ 10 @ 11 @ Explosia informační bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=01762311&find_code=SYS&local_base=nkc
2007 @ 10 @ 12 @ Happy day! @ http://aleph.nkp.cz/F/?func=find-b&request=01762142&find_code=SYS&local_base=nkc
2007 @ 10 @ 13 @ Horizont @ http://aleph.nkp.cz/F/?func=find-b&request=01758039&find_code=SYS&local_base=nkc
2007 @ 10 @ 14 @ Jurisprudence @ http://aleph.nkp.cz/F/?func=find-b&request=01758413&find_code=SYS&local_base=nkc
2007 @ 10 @ 15 @ Kolotoč @ http://aleph.nkp.cz/F/?func=find-b&request=01758787&find_code=SYS&local_base=nkc
2007 @ 10 @ 16 @ Krimi noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01762154&find_code=SYS&local_base=nkc
2007 @ 10 @ 17 @ Lidé in @ http://aleph.nkp.cz/F/?func=find-b&request=01762153&find_code=SYS&local_base=nkc
2007 @ 10 @ 18 @ List pro Hradec @ http://aleph.nkp.cz/F/?func=find-b&request=01759744&find_code=SYS&local_base=nkc
2007 @ 10 @ 19 @ M+ @ http://aleph.nkp.cz/F/?func=find-b&request=01758902&find_code=SYS&local_base=nkc
2007 @ 10 @ 20 @ Max @ http://aleph.nkp.cz/F/?func=find-b&request=01760736&find_code=SYS&local_base=nkc
2007 @ 10 @ 21 @ Mince & bankovky @ http://aleph.nkp.cz/F/?func=find-b&request=01758820&find_code=SYS&local_base=nkc
2007 @ 10 @ 22 @ My @ http://aleph.nkp.cz/F/?func=find-b&request=01760749&find_code=SYS&local_base=nkc
2007 @ 10 @ 23 @ Naex @ http://aleph.nkp.cz/F/?func=find-b&request=01758913&find_code=SYS&local_base=nkc
2007 @ 10 @ 24 @ Naše Ostrava.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01759869&find_code=SYS&local_base=nkc
2007 @ 10 @ 25 @ Next level @ http://aleph.nkp.cz/F/?func=find-b&request=01759014&find_code=SYS&local_base=nkc
2007 @ 10 @ 26 @ Novinky @ http://aleph.nkp.cz/F/?func=find-b&request=01758258&find_code=SYS&local_base=nkc
2007 @ 10 @ 27 @ Noviny pro obyvatele Líní a Sulkova @ http://aleph.nkp.cz/F/?func=find-b&request=01758048&find_code=SYS&local_base=nkc
2007 @ 10 @ 28 @ Opavský info @ http://aleph.nkp.cz/F/?func=find-b&request=01758590&find_code=SYS&local_base=nkc
2007 @ 10 @ 29 @ Panorama stavitelství @ http://aleph.nkp.cz/F/?func=find-b&request=01760104&find_code=SYS&local_base=nkc
2007 @ 10 @ 30 @ Praha 9 @ http://aleph.nkp.cz/F/?func=find-b&request=01759906&find_code=SYS&local_base=nkc
2007 @ 10 @ 31 @ Prima hobby @ http://aleph.nkp.cz/F/?func=find-b&request=01757192&find_code=SYS&local_base=nkc
2007 @ 10 @ 33 @ Regiony @ http://aleph.nkp.cz/F/?func=find-b&request=01758642&find_code=SYS&local_base=nkc
2007 @ 10 @ 32 @ Research in pig breeding @ http://aleph.nkp.cz/F/?func=find-b&request=01759704&find_code=SYS&local_base=nkc
2007 @ 10 @ 34 @ RoadRide @ http://aleph.nkp.cz/F/?func=find-b&request=01758626&find_code=SYS&local_base=nkc
2007 @ 10 @ 35 @ Středočeský Zelený obzor @ http://aleph.nkp.cz/F/?func=find-b&request=01758984&find_code=SYS&local_base=nkc
2007 @ 10 @ 36 @ Svět s Parapletem @ http://aleph.nkp.cz/F/?func=find-b&request=01760182&find_code=SYS&local_base=nkc
2007 @ 10 @ 37 @ Študák @ http://aleph.nkp.cz/F/?func=find-b&request=01761103&find_code=SYS&local_base=nkc
2007 @ 10 @ 38 @ Šumperské bydlení & zahrada @ http://aleph.nkp.cz/F/?func=find-b&request=01762308&find_code=SYS&local_base=nkc
2007 @ 10 @ 39 @ TopLiving @ http://aleph.nkp.cz/F/?func=find-b&request=01759086&find_code=SYS&local_base=nkc
2007 @ 10 @ 40 @ Třetí věk @ http://aleph.nkp.cz/F/?func=find-b&request=01762128&find_code=SYS&local_base=nkc
2007 @ 10 @ 41 @ Údery @ http://aleph.nkp.cz/F/?func=find-b&request=01762547&find_code=SYS&local_base=nkc
2007 @ 10 @ 42 @ Vítkovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01758046&find_code=SYS&local_base=nkc
2007 @ 10 @ 43 @ Zlonický list @ http://aleph.nkp.cz/F/?func=find-b&request=01761654&find_code=SYS&local_base=nkc
2007 @ 10 @ 44 @ Zpětný odběr @ http://aleph.nkp.cz/F/?func=find-b&request=01759084&find_code=SYS&local_base=nkc
2007 @ 10 @ 45 @ Zpravodaj Chebska a Sokolovska @ http://aleph.nkp.cz/F/?func=find-b&request=01758610&find_code=SYS&local_base=nkc
2007 @ 10 @ 46 @ Žatecký region @ http://aleph.nkp.cz/F/?func=find-b&request=01760718&find_code=SYS&local_base=nkc
2007 @ 11 @ 01 @ Abertamské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01779650&find_code=SYS&local_base=nkc
2007 @ 11 @ 02 @ Bob dance @ http://aleph.nkp.cz/F/?func=find-b&request=01780153&find_code=SYS&local_base=nkc
2007 @ 11 @ 03 @ Dekor @ http://aleph.nkp.cz/F/?func=find-b&request=01762747&find_code=SYS&local_base=nkc
2007 @ 11 @ 04 @ Dobrovodský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01764071&find_code=SYS&local_base=nkc
2007 @ 11 @ 05 @ Dotace @ http://aleph.nkp.cz/F/?func=find-b&request=01763110&find_code=SYS&local_base=nkc
2007 @ 11 @ 06 @ E15 @ http://aleph.nkp.cz/F/?func=find-b&request=01779903&find_code=SYS&local_base=nkc
2007 @ 11 @ 07 @ Enigma @ http://aleph.nkp.cz/F/?func=find-b&request=01780207&find_code=SYS&local_base=nkc
2007 @ 11 @ 08 @ Golf&style @ http://aleph.nkp.cz/F/?func=find-b&request=01762739&find_code=SYS&local_base=nkc
2007 @ 11 @ 09 @ Chovatelský magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01780162&find_code=SYS&local_base=nkc
2007 @ 11 @ 10 @ Ice magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01779757&find_code=SYS&local_base=nkc
2007 @ 11 @ 11 @ Ikona @ http://aleph.nkp.cz/F/?func=find-b&request=01779634&find_code=SYS&local_base=nkc
2007 @ 11 @ 12 @ Kynžvartské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01779750&find_code=SYS&local_base=nkc
2007 @ 11 @ 13 @ Mykologické listy @ http://aleph.nkp.cz/F/?func=find-b&request=01780510&find_code=SYS&local_base=nkc
2007 @ 11 @ 14 @ Mzdová a personální praxe @ http://aleph.nkp.cz/F/?func=find-b&request=01762787&find_code=SYS&local_base=nkc
2007 @ 11 @ 15 @ Náchodský swing @ http://aleph.nkp.cz/F/?func=find-b&request=01780188&find_code=SYS&local_base=nkc
2007 @ 11 @ 16 @ Národní 3 @ http://aleph.nkp.cz/F/?func=find-b&request=01781161&find_code=SYS&local_base=nkc
2007 @ 11 @ 17 @ Náš region @ http://aleph.nkp.cz/F/?func=find-b&request=01781154&find_code=SYS&local_base=nkc
2007 @ 11 @ 18 @ Nejlepší PC rady a návody @ http://aleph.nkp.cz/F/?func=find-b&request=01762331&find_code=SYS&local_base=nkc
2007 @ 11 @ 19 @ Nové Domažlicko @ http://aleph.nkp.cz/F/?func=find-b&request=01779619&find_code=SYS&local_base=nkc
2007 @ 11 @ 20 @ Nový Perštejn @ http://aleph.nkp.cz/F/?func=find-b&request=01763258&find_code=SYS&local_base=nkc
2007 @ 11 @ 21 @ Olovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01781190&find_code=SYS&local_base=nkc
2007 @ 11 @ 22 @ Pojď si hrát @ http://aleph.nkp.cz/F/?func=find-b&request=01781206&find_code=SYS&local_base=nkc
2007 @ 11 @ 23 @ Poradce veřejné správy @ http://aleph.nkp.cz/F/?func=find-b&request=01779834&find_code=SYS&local_base=nkc
2007 @ 11 @ 24 @ Ragby @ http://aleph.nkp.cz/F/?func=find-b&request=01780115&find_code=SYS&local_base=nkc
2007 @ 11 @ 25 @ Regio real @ http://aleph.nkp.cz/F/?func=find-b&request=01779844&find_code=SYS&local_base=nkc
2007 @ 11 @ 26 @ Starokolínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01781479&find_code=SYS&local_base=nkc
2007 @ 11 @ 27 @ Studentský Pars magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01781308&find_code=SYS&local_base=nkc
2007 @ 11 @ 28 @ Studia sportiva @ http://aleph.nkp.cz/F/?func=find-b&request=01779869&find_code=SYS&local_base=nkc
2007 @ 11 @ 29 @ Sudoku @ http://aleph.nkp.cz/F/?func=find-b&request=01781320&find_code=SYS&local_base=nkc
2007 @ 11 @ 30 @ Švédské křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=01763090&find_code=SYS&local_base=nkc
2007 @ 11 @ 31 @ TV Top info @ http://aleph.nkp.cz/F/?func=find-b&request=01779759&find_code=SYS&local_base=nkc
2007 @ 11 @ 32 @ Úspěch @ http://aleph.nkp.cz/F/?func=find-b&request=01781484&find_code=SYS&local_base=nkc
2007 @ 11 @ 33 @ Vlnika @ http://aleph.nkp.cz/F/?func=find-b&request=01779668&find_code=SYS&local_base=nkc
2007 @ 11 @ 34 @ Zpravodaj - čtvrtletník obce Újezd u Boskovic @ http://aleph.nkp.cz/F/?func=find-b&request=01764066&find_code=SYS&local_base=nkc
2007 @ 11 @ 35 @ ZVVZ @ http://aleph.nkp.cz/F/?func=find-b&request=01781349&find_code=SYS&local_base=nkc
2007 @ 12 @ 01 @ Agel academy @ http://aleph.nkp.cz/F/?func=find-b&request=01782256&find_code=SYS&local_base=nkc
2007 @ 12 @ 02 @ Applied and computational mechanics @ http://aleph.nkp.cz/F/?func=find-b&request=01783060&find_code=SYS&local_base=nkc
2007 @ 12 @ 03 @ Božejovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01784482&find_code=SYS&local_base=nkc
2007 @ 12 @ 04 @ Cargo @ http://aleph.nkp.cz/F/?func=find-b&request=01784057&find_code=SYS&local_base=nkc
2007 @ 12 @ 05 @ Čtyřlístek @ http://aleph.nkp.cz/F/?func=find-b&request=01784490&find_code=SYS&local_base=nkc
2007 @ 12 @ 06 @ Daně a účetnictví v otázkách a odpovědích @ http://aleph.nkp.cz/F/?func=find-b&request=01784634&find_code=SYS&local_base=nkc
2007 @ 12 @ 07 @ DBK magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01784633&find_code=SYS&local_base=nkc
2007 @ 12 @ 08 @ Fórum inzerce @ http://aleph.nkp.cz/F/?func=find-b&request=01784487&find_code=SYS&local_base=nkc
2007 @ 12 @ 09 @ Golf Hostivař @ http://aleph.nkp.cz/F/?func=find-b&request=01782283&find_code=SYS&local_base=nkc
2007 @ 12 @ 10 @ HD world @ http://aleph.nkp.cz/F/?func=find-b&request=01782908&find_code=SYS&local_base=nkc
2007 @ 12 @ 11 @ Kabrňák @ http://aleph.nkp.cz/F/?func=find-b&request=01784439&find_code=SYS&local_base=nkc
2007 @ 12 @ 12 @ Kapr @ http://aleph.nkp.cz/F/?func=find-b&request=01782282&find_code=SYS&local_base=nkc
2007 @ 12 @ 13 @ Kukátko @ http://aleph.nkp.cz/F/?func=find-b&request=01781845&find_code=SYS&local_base=nkc
2007 @ 12 @ 14 @ Litenky @ http://aleph.nkp.cz/F/?func=find-b&request=01783109&find_code=SYS&local_base=nkc
2007 @ 12 @ 15 @ Lovestar @ http://aleph.nkp.cz/F/?func=find-b&request=01784627&find_code=SYS&local_base=nkc
2007 @ 12 @ 16 @ Magazín Slovensko-České obchodní komory @ http://aleph.nkp.cz/F/?func=find-b&request=01782454&find_code=SYS&local_base=nkc
2007 @ 12 @ 17 @ Magazínek coop @ http://aleph.nkp.cz/F/?func=find-b&request=01783149&find_code=SYS&local_base=nkc
2007 @ 12 @ 18 @ Mercury magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01783536&find_code=SYS&local_base=nkc
2007 @ 12 @ 19 @ Reburber @ http://aleph.nkp.cz/F/?func=find-b&request=01783025&find_code=SYS&local_base=nkc
2007 @ 12 @ 20 @ Ren?e madame @ http://aleph.nkp.cz/F/?func=find-b&request=01783556&find_code=SYS&local_base=nkc
2007 @ 12 @ 21 @ Stránky našich obcí @ http://aleph.nkp.cz/F/?func=find-b&request=01783840&find_code=SYS&local_base=nkc
2007 @ 12 @ 22 @ Šabinský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01782457&find_code=SYS&local_base=nkc
2007 @ 12 @ 23 @ Šalina @ http://aleph.nkp.cz/F/?func=find-b&request=01782284&find_code=SYS&local_base=nkc
2007 @ 12 @ 24 @ Týnecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01783318&find_code=SYS&local_base=nkc
2007 @ 12 @ 25 @ Vitínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01784488&find_code=SYS&local_base=nkc
2007 @ 12 @ 26 @ VVS info @ http://aleph.nkp.cz/F/?func=find-b&request=01782458&find_code=SYS&local_base=nkc
2007 @ 12 @ 27 @ Zpravodaj města Albrechtic @ http://aleph.nkp.cz/F/?func=find-b&request=01783012&find_code=SYS&local_base=nkc
2007 @ 12 @ 28 @ Zpravodaj Ovocnářské unie ČR @ http://aleph.nkp.cz/F/?func=find-b&request=01783831&find_code=SYS&local_base=nkc
2007 @ 12 @ 29 @ Život obce @ http://aleph.nkp.cz/F/?func=find-b&request=01783141&find_code=SYS&local_base=nkc
2008 @ 01 @ 01 @ Atlantida @ http://aleph.nkp.cz/F/?func=find-b&request=01786970&find_code=SYS&local_base=nkc
2008 @ 01 @ 02 @ Citystyle @ http://aleph.nkp.cz/F/?func=find-b&request=01788775&find_code=SYS&local_base=nkc
2008 @ 01 @ 03 @ Číselné křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=01788857&find_code=SYS&local_base=nkc
2008 @ 01 @ 04 @ Domácí recepty & nápady @ http://aleph.nkp.cz/F/?func=find-b&request=01786961&find_code=SYS&local_base=nkc
2008 @ 01 @ 05 @ Halas @ http://aleph.nkp.cz/F/?func=find-b&request=01786750&find_code=SYS&local_base=nkc
2008 @ 01 @ 06 @ Hejtmanské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01785377&find_code=SYS&local_base=nkc
2008 @ 01 @ 07 @ Hojení ran @ http://aleph.nkp.cz/F/?func=find-b&request=01786741&find_code=SYS&local_base=nkc
2008 @ 01 @ 08 @ Hořovický měšťan @ http://aleph.nkp.cz/F/?func=find-b&request=01787202&find_code=SYS&local_base=nkc
2008 @ 01 @ 09 @ Lázeňské etudy @ http://aleph.nkp.cz/F/?func=find-b&request=01786987&find_code=SYS&local_base=nkc
2008 @ 01 @ 10 @ Luštění srdcem @ http://aleph.nkp.cz/F/?func=find-b&request=01788873&find_code=SYS&local_base=nkc
2008 @ 01 @ 11 @ Masaryk university journal of law and technology @ http://aleph.nkp.cz/F/?func=find-b&request=01787021&find_code=SYS&local_base=nkc
2008 @ 01 @ 12 @ Moravský region (Břeclav…) @ http://aleph.nkp.cz/F/?func=find-b&request=01788123&find_code=SYS&local_base=nkc
2008 @ 01 @ 13 @ Moravský region (Kroměříž…) @ http://aleph.nkp.cz/F/?func=find-b&request=01788126&find_code=SYS&local_base=nkc
2008 @ 01 @ 14 @ Moravský region (Nový Jičín…) @ http://aleph.nkp.cz/F/?func=find-b&request=01788118&find_code=SYS&local_base=nkc
2008 @ 01 @ 15 @ Moravský region (Olomouc…) @ http://aleph.nkp.cz/F/?func=find-b&request=01788122&find_code=SYS&local_base=nkc
2008 @ 01 @ 16 @ Moravský region (Prostějov…) @ http://aleph.nkp.cz/F/?func=find-b&request=01788117&find_code=SYS&local_base=nkc
2008 @ 01 @ 17 @ Moravský region (Uherské Hradiště…) @ http://aleph.nkp.cz/F/?func=find-b&request=01788124&find_code=SYS&local_base=nkc
2008 @ 01 @ 18 @ Moravský region (Vsetín…) @ http://aleph.nkp.cz/F/?func=find-b&request=01788120&find_code=SYS&local_base=nkc
2008 @ 01 @ 19 @ Moravský region (Zlín…) @ http://aleph.nkp.cz/F/?func=find-b&request=01788125&find_code=SYS&local_base=nkc
2008 @ 01 @ 20 @ Můj vláček @ http://aleph.nkp.cz/F/?func=find-b&request=01787837&find_code=SYS&local_base=nkc
2008 @ 01 @ 21 @ Na cestách @ http://aleph.nkp.cz/F/?func=find-b&request=01787030&find_code=SYS&local_base=nkc
2008 @ 01 @ 22 @ Obklady@ dlažba & sanita', 'http://aleph.nkp.cz/F/?func=find-b&request=01786334&find_code=SYS&local_base=nkc
2008 @ 01 @ 23 @ Olešnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01788515&find_code=SYS&local_base=nkc
2008 @ 01 @ 24 @ Osecké noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01787084&find_code=SYS&local_base=nkc
2008 @ 01 @ 25 @ Paměť a dějiny @ http://aleph.nkp.cz/F/?func=find-b&request=01788477&find_code=SYS&local_base=nkc
2008 @ 01 @ 26 @ Panenka @ http://aleph.nkp.cz/F/?func=find-b&request=01785316&find_code=SYS&local_base=nkc
2008 @ 01 @ 27 @ Partner PVZP @ http://aleph.nkp.cz/F/?func=find-b&request=01787259&find_code=SYS&local_base=nkc
2008 @ 01 @ 28 @ Perlivý svět @ http://aleph.nkp.cz/F/?func=find-b&request=01786713&find_code=SYS&local_base=nkc
2008 @ 01 @ 29 @ Playin @ http://aleph.nkp.cz/F/?func=find-b&request=01787472&find_code=SYS&local_base=nkc
2008 @ 01 @ 30 @ Politics in Central Europe @ http://aleph.nkp.cz/F/?func=find-b&request=01785623&find_code=SYS&local_base=nkc
2008 @ 01 @ 31 @ Právo @ http://aleph.nkp.cz/F/?func=find-b&request=01786669&find_code=SYS&local_base=nkc
2008 @ 01 @ 32 @ Proostravsko @ http://aleph.nkp.cz/F/?func=find-b&request=01786605&find_code=SYS&local_base=nkc
2008 @ 01 @ 33 @ Psí kusy @ http://aleph.nkp.cz/F/?func=find-b&request=01786732&find_code=SYS&local_base=nkc
2008 @ 01 @ 34 @ Radniční hlasatel @ http://aleph.nkp.cz/F/?func=find-b&request=01786749&find_code=SYS&local_base=nkc
2008 @ 01 @ 35 @ Radostníček @ http://aleph.nkp.cz/F/?func=find-b&request=01786738&find_code=SYS&local_base=nkc
2008 @ 01 @ 36 @ Rozhledy Východní Moravy @ http://aleph.nkp.cz/F/?func=find-b&request=01786743&find_code=SYS&local_base=nkc
2008 @ 01 @ 37 @ Sandra zvláštní vydání @ http://aleph.nkp.cz/F/?func=find-b&request=01787652&find_code=SYS&local_base=nkc
2008 @ 01 @ 38 @ SBB @ http://aleph.nkp.cz/F/?func=find-b&request=01787656&find_code=SYS&local_base=nkc
2008 @ 01 @ 39 @ Sedlecké listy @ http://aleph.nkp.cz/F/?func=find-b&request=01787091&find_code=SYS&local_base=nkc
2008 @ 01 @ 40 @ Studia oecologica @ http://aleph.nkp.cz/F/?func=find-b&request=01786679&find_code=SYS&local_base=nkc
2008 @ 01 @ 41 @ Studija @ http://aleph.nkp.cz/F/?func=find-b&request=01786382&find_code=SYS&local_base=nkc
2008 @ 01 @ 42 @ Synthos noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01786615&find_code=SYS&local_base=nkc
2008 @ 01 @ 43 @ Travel eye @ http://aleph.nkp.cz/F/?func=find-b&request=01788528&find_code=SYS&local_base=nkc
2008 @ 01 @ 44 @ Turf magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01787270&find_code=SYS&local_base=nkc
2008 @ 01 @ 45 @ Verve magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01785334&find_code=SYS&local_base=nkc
2008 @ 01 @ 46 @ Vital plus @ http://aleph.nkp.cz/F/?func=find-b&request=01788865&find_code=SYS&local_base=nkc
2008 @ 01 @ 47 @ X @ http://aleph.nkp.cz/F/?func=find-b&request=01785599&find_code=SYS&local_base=nkc
2008 @ 01 @ 48 @ Zpravodaj Cesty ke kořenům @ http://aleph.nkp.cz/F/?func=find-b&request=01787406&find_code=SYS&local_base=nkc
2008 @ 01 @ 49 @ Zpravodaj o rozvojové spolupráci @ http://aleph.nkp.cz/F/?func=find-b&request=01787481&find_code=SYS&local_base=nkc
2008 @ 01 @ 50 @ Zpravodaj obce Dříteň @ http://aleph.nkp.cz/F/?func=find-b&request=01786342&find_code=SYS&local_base=nkc
2008 @ 01 @ 51 @ Zpravodaj obce Krásensko @ http://aleph.nkp.cz/F/?func=find-b&request=01787039&find_code=SYS&local_base=nkc
2008 @ 01 @ 52 @ Zpravodaj obcí Horoušany a Horoušánky @ http://aleph.nkp.cz/F/?func=find-b&request=01788329&find_code=SYS&local_base=nkc
2008 @ 01 @ 53 @ Zpravodaj pro autoškoly @ http://aleph.nkp.cz/F/?func=find-b&request=01785936&find_code=SYS&local_base=nkc
2008 @ 01 @ 54 @ Zpravodaj sdružení salesiánských spolupracovníků @ http://aleph.nkp.cz/F/?func=find-b&request=01786978&find_code=SYS&local_base=nkc
2008 @ 01 @ 55 @ Zrnění @ http://aleph.nkp.cz/F/?func=find-b&request=01786999&find_code=SYS&local_base=nkc
2008 @ 02 @ 01 @ 7info @ http://aleph.nkp.cz/F/?func=find-b&request=01790970&find_code=SYS&local_base=nkc
2008 @ 02 @ 02 @ Angis revue : odborný pohled do světa lékáren @ http://aleph.nkp.cz/F/?func=find-b&request=01792268&find_code=SYS&local_base=nkc
2008 @ 02 @ 03 @ Běštínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01792907&find_code=SYS&local_base=nkc
2008 @ 02 @ 04 @ Česko-vietnamský zpravodaj = Thông tin Séc-Vi?t @ http://aleph.nkp.cz/F/?func=find-b&request=01792305&find_code=SYS&local_base=nkc
2008 @ 02 @ 05 @ Český les : příroda a historie @ http://aleph.nkp.cz/F/?func=find-b&request=01792575&find_code=SYS&local_base=nkc
2008 @ 02 @ 06 @ Čtvrtlesník : průvodce na cestu nejen lesem @ http://aleph.nkp.cz/F/?func=find-b&request=01789063&find_code=SYS&local_base=nkc
2008 @ 02 @ 07 @ Data a výzkum : SDA Info @ http://aleph.nkp.cz/F/?func=find-b&request=01788898&find_code=SYS&local_base=nkc
2008 @ 02 @ 08 @ Diva : divadlo jako životní styl : magazín Národního divadla Brno @ http://aleph.nkp.cz/F/?func=find-b&request=01789824&find_code=SYS&local_base=nkc
2008 @ 02 @ 09 @ FHM : jediný časopis pro opravdové muže! @ http://aleph.nkp.cz/F/?func=find-b&request=01792889&find_code=SYS&local_base=nkc
2008 @ 02 @ 10 @ Get in balance : noviny vašeho životního stylu @ http://aleph.nkp.cz/F/?func=find-b&request=01792868&find_code=SYS&local_base=nkc
2008 @ 02 @ 11 @ Gurmán light : příloha časopisu Glanc @ http://aleph.nkp.cz/F/?func=find-b&request=01792587&find_code=SYS&local_base=nkc
2008 @ 02 @ 12 @ Hot Wheels magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01788900&find_code=SYS&local_base=nkc
2008 @ 02 @ 13 @ Chief Information Officer Magazine : časopis pro klíčové IT manažery v českých podnicích @ http://aleph.nkp.cz/F/?func=find-b&request=01792086&find_code=SYS&local_base=nkc
2008 @ 02 @ 14 @ InzertníTýdeník.cz : noviny pro bezplatnou soukromou inzerci @ http://aleph.nkp.cz/F/?func=find-b&request=01791122&find_code=SYS&local_base=nkc
2008 @ 02 @ 15 @ Journal Inter Cars @ http://aleph.nkp.cz/F/?func=find-b&request=01793127&find_code=SYS&local_base=nkc
2008 @ 02 @ 16 @ Journal of the National Museum (Prague). Natural history series @ http://aleph.nkp.cz/F/?func=find-b&request=01792743&find_code=SYS&local_base=nkc
2008 @ 02 @ 17 @ Kam po Česku @ http://aleph.nkp.cz/F/?func=find-b&request=01788892&find_code=SYS&local_base=nkc
2008 @ 02 @ 18 @ Kladenský valcíř : magazín Sochorové válcovny TŽ@ a.s.', 'http://aleph.nkp.cz/F/?func=find-b&request=01793341&find_code=SYS&local_base=nkc
2008 @ 02 @ 19 @ Krušnohorský Berggeist @ http://aleph.nkp.cz/F/?func=find-b&request=01792901&find_code=SYS&local_base=nkc
2008 @ 02 @ 20 @ Křížovky : Radka speciál @ http://aleph.nkp.cz/F/?func=find-b&request=01790940&find_code=SYS&local_base=nkc
2008 @ 02 @ 21 @ Labyrint křížovek : Katka @ http://aleph.nkp.cz/F/?func=find-b&request=01793146&find_code=SYS&local_base=nkc
2008 @ 02 @ 22 @ Lázeňská pohoda : měsíční zpravodaj městských slatinných lázní - Třeboň @ http://aleph.nkp.cz/F/?func=find-b&request=01793089&find_code=SYS&local_base=nkc
2008 @ 02 @ 23 @ Makozpravodaj : zpravodaj Obecního úřadu Makotřasy @ http://aleph.nkp.cz/F/?func=find-b&request=01792255&find_code=SYS&local_base=nkc
2008 @ 02 @ 24 @ Mickey Max! @ http://aleph.nkp.cz/F/?func=find-b&request=01793252&find_code=SYS&local_base=nkc
2008 @ 02 @ 25 @ Můj pes@ moje kočka : měsíčník o psech a kočkách', 'http://aleph.nkp.cz/F/?func=find-b&request=01789097&find_code=SYS&local_base=nkc
2008 @ 02 @ 26 @ Naše cihla : čtvrtletník společnosti Heluz @ http://aleph.nkp.cz/F/?func=find-b&request=01792244&find_code=SYS&local_base=nkc
2008 @ 02 @ 27 @ Náves : zpravodaj Obecního úřadu Vejprnice @ http://aleph.nkp.cz/F/?func=find-b&request=01790678&find_code=SYS&local_base=nkc
2008 @ 02 @ 28 @ Neziskovky.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01791292&find_code=SYS&local_base=nkc
2008 @ 02 @ 29 @ Obecnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01789337&find_code=SYS&local_base=nkc
2008 @ 02 @ 30 @ Pošli recept! : svět ženy @ http://aleph.nkp.cz/F/?func=find-b&request=01791445&find_code=SYS&local_base=nkc
2008 @ 02 @ 31 @ Power Rangers magazín : komiksy - hádanky - hry @ http://aleph.nkp.cz/F/?func=find-b&request=01792535&find_code=SYS&local_base=nkc
2008 @ 02 @ 32 @ Pupen : studentský časopis Fakulty agrobiologie@ potravinových a přírodních zdrojů České zemědělské univerzity v Praze', 'http://aleph.nkp.cz/F/?func=find-b&request=01793291&find_code=SYS&local_base=nkc
2008 @ 02 @ 33 @ Severočeský metropol @ http://aleph.nkp.cz/F/?func=find-b&request=01789273&find_code=SYS&local_base=nkc
2008 @ 02 @ 34 @ Stroboinfo : firemní zpravodaj společnosti Strojírny Bohdalice @ http://aleph.nkp.cz/F/?func=find-b&request=01791791&find_code=SYS&local_base=nkc
2008 @ 02 @ 35 @ Středočeský demokrat : zpravodaj středočeské krajské organizace ČSSD @ http://aleph.nkp.cz/F/?func=find-b&request=01792611&find_code=SYS&local_base=nkc
2008 @ 02 @ 36 @ Šotolák @ http://aleph.nkp.cz/F/?func=find-b&request=01791870&find_code=SYS&local_base=nkc
2008 @ 02 @ 37 @ Think again : Prague’s (almost) bilingual city magazine @ http://aleph.nkp.cz/F/?func=find-b&request=01791518&find_code=SYS&local_base=nkc
2008 @ 02 @ 38 @ Time for students : bilingual monthly newsmagazine for students : Czech Republic edition @ http://aleph.nkp.cz/F/?func=find-b&request=01791861&find_code=SYS&local_base=nkc
2008 @ 02 @ 39 @ Totally Spies! = Špionky! @ http://aleph.nkp.cz/F/?func=find-b&request=01793072&find_code=SYS&local_base=nkc
2008 @ 02 @ 40 @ Třebovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01789081&find_code=SYS&local_base=nkc
2008 @ 02 @ 41 @ Turnovsko v akci : zpravodajské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01793280&find_code=SYS&local_base=nkc
2008 @ 02 @ 42 @ Upgrade IT! : ICT technology for corporate solution @ http://aleph.nkp.cz/F/?func=find-b&request=01791504&find_code=SYS&local_base=nkc
2008 @ 02 @ 43 @ Věstník Společenstva uměleckých kovářů a zámečníků a kovářů-podkovářů Čech@ Moravy a Slezska', 'http://aleph.nkp.cz/F/?func=find-b&request=01792283&find_code=SYS&local_base=nkc
2008 @ 02 @ 44 @ Zpravodaj města Březová a přidružených obcí @ http://aleph.nkp.cz/F/?func=find-b&request=01792033&find_code=SYS&local_base=nkc
2008 @ 02 @ 45 @ Zpravodaj města Volyně @ http://aleph.nkp.cz/F/?func=find-b&request=01791300&find_code=SYS&local_base=nkc
2008 @ 02 @ 46 @ Zpravodaj obce Dukovany @ http://aleph.nkp.cz/F/?func=find-b&request=01791112&find_code=SYS&local_base=nkc
2008 @ 02 @ 47 @ Zpravodaj obce Nemotice @ http://aleph.nkp.cz/F/?func=find-b&request=01791860&find_code=SYS&local_base=nkc
2008 @ 02 @ 48 @ Zpravodaj obce Vlkaneč @ http://aleph.nkp.cz/F/?func=find-b&request=01791500&find_code=SYS&local_base=nkc
2008 @ 02 @ 49 @ Zpravodaj občanů Rokytnice a Kochavce @ http://aleph.nkp.cz/F/?func=find-b&request=01792853&find_code=SYS&local_base=nkc
2008 @ 03 @ 01 @ BIOTecho : české biotechnologické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=01796930&find_code=SYS&local_base=nkc
2008 @ 03 @ 02 @ Borecký občasník : zpravodaj zastupitelstvo obce @ http://aleph.nkp.cz/F/?func=find-b&request=01794789&find_code=SYS&local_base=nkc
2008 @ 03 @ 03 @ Carlsbad revue : hotelový magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01797601&find_code=SYS&local_base=nkc
2008 @ 03 @ 04 @ Deštnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01794493&find_code=SYS&local_base=nkc
2008 @ 03 @ 05 @ Domy komplet : nejlepší nabídka projektů za skvělé ceny @ http://aleph.nkp.cz/F/?func=find-b&request=01797115&find_code=SYS&local_base=nkc
2008 @ 03 @ 06 @ Energie 21 : časopis o alternativních zdrojích energie @ http://aleph.nkp.cz/F/?func=find-b&request=01794801&find_code=SYS&local_base=nkc
2008 @ 03 @ 07 @ Energy news : elixír pro celou rodinu @ http://aleph.nkp.cz/F/?func=find-b&request=01796729&find_code=SYS&local_base=nkc
2008 @ 03 @ 08 @ Euroweekend : výjimečný časopis pro volný čas výjimečných lidí @ http://aleph.nkp.cz/F/?func=find-b&request=01794832&find_code=SYS&local_base=nkc
2008 @ 03 @ 09 @ Flying revue @ http://aleph.nkp.cz/F/?func=find-b&request=01794856&find_code=SYS&local_base=nkc
2008 @ 03 @ 10 @ Gansewinkel news : informační zpravodaj společnosti van Gansewinkel a.s. @ http://aleph.nkp.cz/F/?func=find-b&request=01795862&find_code=SYS&local_base=nkc
2008 @ 03 @ 11 @ Gastromagazín : magazín moderní gastronomie @ http://aleph.nkp.cz/F/?func=find-b&request=01795619&find_code=SYS&local_base=nkc
2008 @ 03 @ 12 @ Homeopatická revue : časopis Homeopatické lékařské asociace @ http://aleph.nkp.cz/F/?func=find-b&request=01797111&find_code=SYS&local_base=nkc
2008 @ 03 @ 13 @ Horoměřický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01797268&find_code=SYS&local_base=nkc
2008 @ 03 @ 14 @ Informační zpravodaj společnosti BT Residential Dnes @ http://aleph.nkp.cz/F/?func=find-b&request=01796953&find_code=SYS&local_base=nkc
2008 @ 03 @ 15 @ Jezevčík @ http://aleph.nkp.cz/F/?func=find-b&request=01798043&find_code=SYS&local_base=nkc
2008 @ 03 @ 16 @ Kontakt : váš společník ve světě peněz @ http://aleph.nkp.cz/F/?func=find-b&request=01794488&find_code=SYS&local_base=nkc
2008 @ 03 @ 17 @ Krušnohorské novinky @ http://aleph.nkp.cz/F/?func=find-b&request=01796907&find_code=SYS&local_base=nkc
2008 @ 03 @ 18 @ Krušnohorský zpravodaj : Teplice - Bílina - Krupka - Most - Chomutov @ http://aleph.nkp.cz/F/?func=find-b&request=01796745&find_code=SYS&local_base=nkc
2008 @ 03 @ 19 @ Křížovky s tužkou @ http://aleph.nkp.cz/F/?func=find-b&request=01796917&find_code=SYS&local_base=nkc
2008 @ 03 @ 20 @ Mámy radí : Betynka : mezi námi maminkami @ http://aleph.nkp.cz/F/?func=find-b&request=01796012&find_code=SYS&local_base=nkc
2008 @ 03 @ 21 @ MaPA : Magazine Palác Akropolis @ http://aleph.nkp.cz/F/?func=find-b&request=01797598&find_code=SYS&local_base=nkc
2008 @ 03 @ 22 @ Mašinka Tomáš @ http://aleph.nkp.cz/F/?func=find-b&request=01797292&find_code=SYS&local_base=nkc
2008 @ 03 @ 23 @ MICE Central & Eastern Europe @ http://aleph.nkp.cz/F/?func=find-b&request=01795892&find_code=SYS&local_base=nkc
2008 @ 03 @ 24 @ MVV news : zpravodaj koncernu MVV Energie CZ @ http://aleph.nkp.cz/F/?func=find-b&request=01797609&find_code=SYS&local_base=nkc
2008 @ 03 @ 25 @ Natoaktual Quarterly Review : Informační centrum o NATO @ http://aleph.nkp.cz/F/?func=find-b&request=01794514&find_code=SYS&local_base=nkc
2008 @ 03 @ 26 @ Nezávislé zábřežské noviny : barevný měsíčník pro město Zábřeh @ http://aleph.nkp.cz/F/?func=find-b&request=01797583&find_code=SYS&local_base=nkc
2008 @ 03 @ 27 @ Nomádva @ http://aleph.nkp.cz/F/?func=find-b&request=01796498&find_code=SYS&local_base=nkc
2008 @ 03 @ 28 @ Nord-Real : inzertní časopis o bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=01796718&find_code=SYS&local_base=nkc
2008 @ 03 @ 29 @ Nové byty a domy : katalog tuzemských a zahraničních nemovitostí @ http://aleph.nkp.cz/F/?func=find-b&request=01795991&find_code=SYS&local_base=nkc
2008 @ 03 @ 30 @ Novinky z éteru : Regie Radio Music @ http://aleph.nkp.cz/F/?func=find-b&request=01795375&find_code=SYS&local_base=nkc
2008 @ 03 @ 31 @ Ohlasy od Dřeva : neperiodický zpravodaj zastupitelstva obcí Horní Pěna a Malíkov nad Nežárkou @ http://aleph.nkp.cz/F/?func=find-b&request=01797117&find_code=SYS&local_base=nkc
2008 @ 03 @ 32 @ Olomouc City magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01797119&find_code=SYS&local_base=nkc
2008 @ 03 @ 33 @ Paddock revue : časopis o dostihovém sportu @ http://aleph.nkp.cz/F/?func=find-b&request=01794708&find_code=SYS&local_base=nkc
2008 @ 03 @ 34 @ Panenské rozhledy @ http://aleph.nkp.cz/F/?func=find-b&request=01796511&find_code=SYS&local_base=nkc
2008 @ 03 @ 35 @ "Pes můj kamarád : kynologický časopis nejen pro členy klubu ""Hafan""" @ http://aleph.nkp.cz/F/?func=find-b&request=01796040&find_code=SYS&local_base=nkc
2008 @ 03 @ 36 @ Pratecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01797548&find_code=SYS&local_base=nkc
2008 @ 03 @ 37 @ Profily @ http://aleph.nkp.cz/F/?func=find-b&request=01796529&find_code=SYS&local_base=nkc
2008 @ 03 @ 38 @ Sales Power : magazín pro všechny@ kteří jsou pod velením obchodu', 'http://aleph.nkp.cz/F/?func=find-b&request=01794504&find_code=SYS&local_base=nkc
2008 @ 03 @ 39 @ Sešit pro umění@ teorii a příbuzné zóny = Notebook for art, theory and related zones', 'http://aleph.nkp.cz/F/?func=find-b&request=01796712&find_code=SYS&local_base=nkc
2008 @ 03 @ 40 @ Slavia pojišťovna: magazín o pojišťovnictví a financích @ http://aleph.nkp.cz/F/?func=find-b&request=01797566&find_code=SYS&local_base=nkc
2008 @ 03 @ 41 @ Svárovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01794784&find_code=SYS&local_base=nkc
2008 @ 03 @ 42 @ Štěchovické proudy @ http://aleph.nkp.cz/F/?func=find-b&request=01796731&find_code=SYS&local_base=nkc
2008 @ 03 @ 43 @ The European Entomologist @ http://aleph.nkp.cz/F/?func=find-b&request=01797264&find_code=SYS&local_base=nkc
2008 @ 03 @ 44 @ Ve hvězdách @ http://aleph.nkp.cz/F/?func=find-b&request=01797828&find_code=SYS&local_base=nkc
2008 @ 03 @ 45 @ Vysoké Studnice : informační zpravodaj obce @ http://aleph.nkp.cz/F/?func=find-b&request=01795396&find_code=SYS&local_base=nkc
2008 @ 03 @ 46 @ Zpravodaj obce Chocerady : Komorní Hrádek@ Samechov, Vlkovec a Vestec', 'http://aleph.nkp.cz/F/?func=find-b&request=01795347&find_code=SYS&local_base=nkc
2008 @ 03 @ 47 @ Zpravodaj obce Ovčáry @ http://aleph.nkp.cz/F/?func=find-b&request=01795622&find_code=SYS&local_base=nkc
2008 @ 03 @ 48 @ Zrcadlo doby : břeclavský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=01797828&find_code=SYS&local_base=nkc
2008 @ 04 @ 55 @ Zpravodaj Občanské demokratické strany v Rudné @ http://aleph.nkp.cz/F/?func=find-b&request=1801945&find_code=SYS&local_base=nkc
2008 @ 04 @ 54 @ Zpravodaj obce Prštice @ http://aleph.nkp.cz/F/?func=find-b&request=1799517&find_code=SYS&local_base=nkc
2008 @ 04 @ 53 @ Zpravodaj Českomoravského klubu veteránů @ http://aleph.nkp.cz/F/?func=find-b&request=001798736&find_code=SYS&local_base=nkc
2008 @ 04 @ 52 @ Zpravodaj : město Černošín @ http://aleph.nkp.cz/F/?func=find-b&request=01798404&find_code=SYS&local_base=nkc
2008 @ 04 @ 51 @ Zpravodaj : informační čtvrtletník obce Felbabka @ http://aleph.nkp.cz/F/?func=find-b&request=01799759&find_code=SYS&local_base=nkc
2008 @ 04 @ 50 @ Zpravodaj : Festival sportu pro všechny... @ http://aleph.nkp.cz/F/?func=find-b&request=001798390&find_code=SYS&local_base=nkc
2008 @ 04 @ 49 @ Znojemský magazín @ http://aleph.nkp.cz/F/?func=find-b&request=01799756&find_code=SYS&local_base=nkc
2008 @ 04 @ 48 @ Zdraví : svět ženy @ http://aleph.nkp.cz/F/?func=find-b&request=1801386&find_code=SYS&local_base=nkc
2008 @ 04 @ 47 @ Veselské listy @ http://aleph.nkp.cz/F/?func=find-b&request=1800676&find_code=SYS&local_base=nkc
2008 @ 04 @ 46 @ Vaříme : ...protože láska prochází žaludkem @ http://aleph.nkp.cz/F/?func=find-b&request=01800012&find_code=SYS&local_base=nkc
2008 @ 04 @ 45 @ Třebovický kapr : zpravodaj městského obvodu Třebovice @ http://aleph.nkp.cz/F/?func=find-b&request=001798556&find_code=SYS&local_base=nkc
2010 @ 10 @ 23 @ Pražské listy @ http://aleph.nkp.cz/F/?func=direct&doc_number=002132148&local_base=nkc
2008 @ 04 @ 43 @ Sex na DVD @ http://aleph.nkp.cz/F/?func=find-b&request=1801557&find_code=SYS&local_base=nkc
2008 @ 04 @ 44 @ Speciál ČD Cargo @ http://aleph.nkp.cz/F/?func=find-b&request=01798226&find_code=SYS&local_base=nkc
2008 @ 04 @ 42 @ Severka : občasník pro obyvatele Severní Terasy @ http://aleph.nkp.cz/F/?func=find-b&request=01799524&find_code=SYS&local_base=nkc
2008 @ 04 @ 41 @ Scania zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01799532&find_code=SYS&local_base=nkc
2008 @ 04 @ 40 @ Rudoltický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01799311&find_code=SYS&local_base=nkc
2008 @ 04 @ 39 @ Rohozenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=1801370&find_code=SYS&local_base=nkc
2008 @ 04 @ 38 @ Retro křížovky : vzpomínky na staré dobré časy @ http://aleph.nkp.cz/F/?func=find-b&request=001798545&find_code=SYS&local_base=nkc
2008 @ 04 @ 37 @ Recepty naší vesnice s křížovkami @ http://aleph.nkp.cz/F/?func=find-b&request=001798989&find_code=SYS&local_base=nkc
2008 @ 04 @ 36 @ Realitní rádce @ http://aleph.nkp.cz/F/?func=find-b&request=1800334&find_code=SYS&local_base=nkc
2008 @ 04 @ 35 @ Ptenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=1800735&find_code=SYS&local_base=nkc
2008 @ 04 @ 34 @ Práce a zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=01799557&find_code=SYS&local_base=nkc
2008 @ 04 @ 33 @ Pohledské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001798568&find_code=SYS&local_base=nkc
2008 @ 04 @ 32 @ Plánské ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=01799792&find_code=SYS&local_base=nkc
2008 @ 04 @ 31 @ Panorama traveller @ http://aleph.nkp.cz/F/?func=find-b&request=01799692&find_code=SYS&local_base=nkc
2008 @ 04 @ 30 @ Otevřený zpravodaj MŠMT @ http://aleph.nkp.cz/F/?func=find-b&request=1801367&find_code=SYS&local_base=nkc
2008 @ 04 @ 29 @ Ořík : farní zpravodaj Ostrovačice@ Říčany, Veverské Knínice', 'http://aleph.nkp.cz/F/?func=find-b&request=01799303&find_code=SYS&local_base=nkc
2008 @ 04 @ 28 @ Obecní občasník @ http://aleph.nkp.cz/F/?func=find-b&request=1800303&find_code=SYS&local_base=nkc
2008 @ 04 @ 27 @ National geographic traveler : Česko @ http://aleph.nkp.cz/F/?func=find-b&request=1801338&find_code=SYS&local_base=nkc
2008 @ 04 @ 26 @ Naše příroda @ http://aleph.nkp.cz/F/?func=find-b&request=01799721&find_code=SYS&local_base=nkc
2008 @ 04 @ 25 @ Moravské hospodářství @ http://aleph.nkp.cz/F/?func=find-b&request=01799995&find_code=SYS&local_base=nkc
2008 @ 04 @ 24 @ Modré listy ODS @ http://aleph.nkp.cz/F/?func=find-b&request=1801956&find_code=SYS&local_base=nkc
2008 @ 04 @ 23 @ Misiologické info @ http://aleph.nkp.cz/F/?func=find-b&request=1801363&find_code=SYS&local_base=nkc
2008 @ 04 @ 22 @ Magické křížovky : ...trochu jiná kratochvíle @ http://aleph.nkp.cz/F/?func=find-b&request=001798541&find_code=SYS&local_base=nkc
2008 @ 04 @ 20 @ Life Ostrava @ http://aleph.nkp.cz/F/?func=find-b&request=01799298&find_code=SYS&local_base=nkc
2008 @ 04 @ 21 @ Magazine CCA @ http://aleph.nkp.cz/F/?func=find-b&request=01798400&find_code=SYS&local_base=nkc
2008 @ 04 @ 19 @ Kulturní a sportovní kalendář Karlovarského kraje @ http://aleph.nkp.cz/F/?func=find-b&request=1800693&find_code=SYS&local_base=nkc
2008 @ 04 @ 18 @ Křížovky o památkách @ http://aleph.nkp.cz/F/?func=find-b&request=01799332&find_code=SYS&local_base=nkc
2008 @ 04 @ 17 @ Krnovský info @ http://aleph.nkp.cz/F/?func=find-b&request=1801137&find_code=SYS&local_base=nkc
2008 @ 04 @ 16 @ Kobylnické listy @ http://aleph.nkp.cz/F/?func=find-b&request=01799486&find_code=SYS&local_base=nkc
2008 @ 04 @ 15 @ Karvinský info @ http://aleph.nkp.cz/F/?func=find-b&request=01801134&find_code=SYS&local_base=nkc
2008 @ 04 @ 14 @ Jalovec @ http://aleph.nkp.cz/F/?func=find-b&request=1801936&find_code=SYS&local_base=nkc
2008 @ 04 @ 13 @ Info Těšínska @ http://aleph.nkp.cz/F/?func=find-b&request=1801136&find_code=SYS&local_base=nkc
2008 @ 04 @ 12 @ Hovorčovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001798723&find_code=SYS&local_base=nkc
2008 @ 04 @ 11 @ Hostis @ http://aleph.nkp.cz/F/?func=find-b&request=1801738&find_code=SYS&local_base=nkc
2008 @ 04 @ 10 @ Francovolhotský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=1801374&find_code=SYS&local_base=nkc
2008 @ 04 @ 09 @ Finmag @ http://aleph.nkp.cz/F/?func=find-b&request=001799057&find_code=SYS&local_base=nkc
2008 @ 04 @ 08 @ Eurozpravodaj : informační a ekonomický časopis @ http://aleph.nkp.cz/F/?func=find-b&request=001799192&find_code=SYS&local_base=nkc
2008 @ 04 @ 07 @ Clique : graffiti magazine from Praha @ http://aleph.nkp.cz/F/?func=find-b&request=1799199&find_code=SYS&local_base=nkc
2008 @ 04 @ 06 @ Církevní dějiny @ http://aleph.nkp.cz/F/?func=find-b&request=1801729&find_code=SYS&local_base=nkc
2008 @ 04 @ 05 @ Bruntálský info @ http://aleph.nkp.cz/F/?func=find-b&request=1801135&find_code=SYS&local_base=nkc
2008 @ 04 @ 04 @ Bedecker @ http://aleph.nkp.cz/F/?func=find-b&request=1800296&find_code=SYS&local_base=nkc
2008 @ 04 @ 03 @ APM automagazín @ http://aleph.nkp.cz/F/?func=find-b&request=01799757&find_code=SYS&local_base=nkc
2008 @ 04 @ 02 @ Andělák @ http://aleph.nkp.cz/F/?func=find-b&request=01799480&find_code=SYS&local_base=nkc
2008 @ 04 @ 01 @ Acta VŠFS : ekonomické studie a analýzy @ http://aleph.nkp.cz/F/?func=find-b&request=1801161&find_code=SYS&local_base=nkc
2008 @ 04 @ 56 @ Zpravodaj Radia Proglas @ http://aleph.nkp.cz/F/?func=find-b&request=001798362&find_code=SYS&local_base=nkc
2008 @ 04 @ 57 @ Zpravodaj Římskokatolické farnosti Modřany @ http://aleph.nkp.cz/F/?func=find-b&request=001798807&find_code=SYS&local_base=nkc
2008 @ 05 @ 01 @ 14 dní : Domažlice a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=1803501&find_code=SYS&local_base=nkc
2008 @ 05 @ 02 @ 14 dní : Cheb a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=1803508&find_code=SYS&local_base=nkc
2008 @ 05 @ 03 @ 14 dní : Jablonec nad Nisou a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=1803005&find_code=SYS&local_base=nkc
2008 @ 05 @ 04 @ 14 dní : Karlovy Vary a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=1803509&find_code=SYS&local_base=nkc
2008 @ 05 @ 05 @ 14 dní : Klatovy a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=1803504&find_code=SYS&local_base=nkc
2008 @ 05 @ 06 @ 14 dní : Liberec a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=1803004&find_code=SYS&local_base=nkc
2008 @ 05 @ 07 @ 14 dní : Plzeň a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=1803497&find_code=SYS&local_base=nkc
2008 @ 05 @ 08 @ 14 dní : Teplice a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=1803006&find_code=SYS&local_base=nkc
2008 @ 05 @ 09 @ 14 dní : Ústí nad Labem a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=1803007&find_code=SYS&local_base=nkc
2008 @ 05 @ 10 @ AZ list @ http://aleph.nkp.cz/F/?func=find-b&request=1805273&find_code=SYS&local_base=nkc
2008 @ 05 @ 11 @ BGE realitní magazín @ http://aleph.nkp.cz/F/?func=find-b&request=1803255&find_code=SYS&local_base=nkc
2008 @ 05 @ 12 @ CB inzert @ http://aleph.nkp.cz/F/?func=find-b&request=1805344&find_code=SYS&local_base=nkc
2008 @ 05 @ 13 @ Časopis Ostrožska a Horňácka @ http://aleph.nkp.cz/F/?func=find-b&request=1804050&find_code=SYS&local_base=nkc
2008 @ 05 @ 14 @ D.A.S. magazín @ http://aleph.nkp.cz/F/?func=find-b&request=1803023&find_code=SYS&local_base=nkc
2008 @ 05 @ 15 @ Diana : doplňky @ http://aleph.nkp.cz/F/?func=find-b&request=1803847&find_code=SYS&local_base=nkc
2008 @ 05 @ 16 @ Diana : kreativní móda @ http://aleph.nkp.cz/F/?func=find-b&request=1803844&find_code=SYS&local_base=nkc
2008 @ 05 @ 17 @ Diana : pletená móda pro ženy @ http://aleph.nkp.cz/F/?func=find-b&request=1803833&find_code=SYS&local_base=nkc
2008 @ 05 @ 18 @ Diana : škola háčkování @ http://aleph.nkp.cz/F/?func=find-b&request=1803846&find_code=SYS&local_base=nkc
2008 @ 05 @ 19 @ Duhové listy @ http://aleph.nkp.cz/F/?func=find-b&request=1803262&find_code=SYS&local_base=nkc
2008 @ 05 @ 20 @ DuklaSport @ http://aleph.nkp.cz/F/?func=find-b&request=1803494&find_code=SYS&local_base=nkc
2008 @ 05 @ 21 @ EGE montáže @ http://aleph.nkp.cz/F/?func=find-b&request=1805850&find_code=SYS&local_base=nkc
2008 @ 05 @ 22 @ Expres @ http://aleph.nkp.cz/F/?func=find-b&request=1805855&find_code=SYS&local_base=nkc
2008 @ 05 @ 23 @ Fajn : časopis pro fajn život @ http://aleph.nkp.cz/F/?func=find-b&request=1802569&find_code=SYS&local_base=nkc
2008 @ 05 @ 24 @ Filip : kulturní měsíční magazín @ http://aleph.nkp.cz/F/?func=find-b&request=1805325&find_code=SYS&local_base=nkc
2008 @ 05 @ 25 @ Finance.cz newspaper @ http://aleph.nkp.cz/F/?func=find-b&request=1805298&find_code=SYS&local_base=nkc
2008 @ 05 @ 26 @ Fórum UTB @ http://aleph.nkp.cz/F/?func=find-b&request=1805842&find_code=SYS&local_base=nkc
2008 @ 05 @ 27 @ Geofin @ http://aleph.nkp.cz/F/?func=find-b&request=1803478&find_code=SYS&local_base=nkc
2008 @ 05 @ 28 @ Go! : lifestyle magazine @ http://aleph.nkp.cz/F/?func=find-b&request=1805515&find_code=SYS&local_base=nkc
2008 @ 05 @ 29 @ Havířovský telegraf @ http://aleph.nkp.cz/F/?func=find-b&request=180409&find_code=SYS&local_base=nkc
2008 @ 05 @ 30 @ Hodinky šperky = Watch & jewellery magazine @ http://aleph.nkp.cz/F/?func=find-b&request=1806495&find_code=SYS&local_base=nkc
2008 @ 05 @ 31 @ Chvíľka pre teba @ http://aleph.nkp.cz/F/?func=find-b&request=1806535&find_code=SYS&local_base=nkc
2008 @ 05 @ 32 @ IKEA family live @ http://aleph.nkp.cz/F/?func=find-b&request=1804042&find_code=SYS&local_base=nkc
2008 @ 05 @ 33 @ Imos news @ http://aleph.nkp.cz/F/?func=find-b&request=1805283&find_code=SYS&local_base=nkc
2008 @ 05 @ 34 @ Inzerce středního Povltaví @ http://aleph.nkp.cz/F/?func=find-b&request=1805307&find_code=SYS&local_base=nkc
2008 @ 05 @ 35 @ Kam : kultura a město České Budějovice @ http://aleph.nkp.cz/F/?func=find-b&request=1805023&find_code=SYS&local_base=nkc
2008 @ 05 @ 36 @ Kleťák : věstník Klubu přátel hory Kleť @ http://aleph.nkp.cz/F/?func=find-b&request=1803251&find_code=SYS&local_base=nkc
2008 @ 05 @ 37 @ Krajský ex-press @ http://aleph.nkp.cz/F/?func=find-b&request=1803268&find_code=SYS&local_base=nkc
2008 @ 05 @ 38 @ Královédvorský posel @ http://aleph.nkp.cz/F/?func=find-b&request=1804273&find_code=SYS&local_base=nkc
2008 @ 05 @ 39 @ Krásy Česka : turistika.. @ http://aleph.nkp.cz/F/?func=find-b&request=1803280&find_code=SYS&local_base=nkc
2008 @ 05 @ 40 @ Křížovky mini @ http://aleph.nkp.cz/F/?func=find-b&request=1803678&find_code=SYS&local_base=nkc
2008 @ 05 @ 41 @ Le Coeur de l´Europe @ http://aleph.nkp.cz/F/?func=find-b&request=1804882&find_code=SYS&local_base=nkc
2008 @ 05 @ 42 @ Les nouvelles esthétiques spa : české vydání @ http://aleph.nkp.cz/F/?func=find-b&request=1804556&find_code=SYS&local_base=nkc
2008 @ 05 @ 43 @ Listy Uhlířskojanovicka a středního Posázaví @ http://aleph.nkp.cz/F/?func=find-b&request=1806496&find_code=SYS&local_base=nkc
2008 @ 05 @ 44 @ Magazín ROP @ http://aleph.nkp.cz/F/?func=find-b&request=1806304&find_code=SYS&local_base=nkc
2008 @ 05 @ 45 @ Magazín zajímavostí a humoru ze světa i z domova @ http://aleph.nkp.cz/F/?func=find-b&request=1806534&find_code=SYS&local_base=nkc
2008 @ 05 @ 46 @ Marie Claire @ http://aleph.nkp.cz/F/?func=find-b&request=1802217&find_code=SYS&local_base=nkc
2008 @ 05 @ 47 @ Metroprojekt informuje @ http://aleph.nkp.cz/F/?func=find-b&request=1806267&find_code=SYS&local_base=nkc
2008 @ 05 @ 48 @ Motion @ http://aleph.nkp.cz/F/?func=find-b&request=1802579&find_code=SYS&local_base=nkc
2008 @ 05 @ 49 @ MyNews @ http://aleph.nkp.cz/F/?func=find-b&request=1805265&find_code=SYS&local_base=nkc
2008 @ 05 @ 50 @ Nová Vysočina @ http://aleph.nkp.cz/F/?func=find-b&request=1803533&find_code=SYS&local_base=nkc
2008 @ 05 @ 51 @ Novosedelské listy @ http://aleph.nkp.cz/F/?func=find-b&request=1803217&find_code=SYS&local_base=nkc
2008 @ 05 @ 52 @ Original noviny @ http://aleph.nkp.cz/F/?func=find-b&request=1805349&find_code=SYS&local_base=nkc
2008 @ 05 @ 53 @ Pirát : magazín pro profesionály v gastronomii @ http://aleph.nkp.cz/F/?func=find-b&request=1805054&find_code=SYS&local_base=nkc
2008 @ 05 @ 54 @ Pro Pardubicko @ http://aleph.nkp.cz/F/?func=find-b&request=1803485&find_code=SYS&local_base=nkc
2008 @ 05 @ 55 @ Profi florista @ http://aleph.nkp.cz/F/?func=find-b&request=1803981&find_code=SYS&local_base=nkc
2008 @ 05 @ 56 @ Real-City @ http://aleph.nkp.cz/F/?func=find-b&request=1804058&find_code=SYS&local_base=nkc
2008 @ 05 @ 57 @ Regionální studia @ http://aleph.nkp.cz/F/?func=find-b&request=1806095&find_code=SYS&local_base=nkc
2008 @ 05 @ 58 @ Rexel Elvo @ http://aleph.nkp.cz/F/?func=find-b&request=1803651&find_code=SYS&local_base=nkc
2008 @ 05 @ 59 @ Rybolov @ http://aleph.nkp.cz/F/?func=find-b&request=1805045&find_code=SYS&local_base=nkc
2008 @ 05 @ 60 @ Spektrum @ http://aleph.nkp.cz/F/?func=find-b&request=1806062&find_code=SYS&local_base=nkc
2008 @ 05 @ 61 @ Sudoku : Radka speciál @ http://aleph.nkp.cz/F/?func=find-b&request=1806044&find_code=SYS&local_base=nkc
2008 @ 05 @ 62 @ Telegraf F-M @ http://aleph.nkp.cz/F/?func=find-b&request=1806529&find_code=SYS&local_base=nkc
2008 @ 05 @ 63 @ Tipy+triky : svět ženy @ http://aleph.nkp.cz/F/?func=find-b&request=1803461&find_code=SYS&local_base=nkc
2008 @ 05 @ 64 @ Týdeník Prostějovska @ http://aleph.nkp.cz/F/?func=find-b&request=1805860&find_code=SYS&local_base=nkc
2008 @ 05 @ 65 @ V serdce Evropy : revju Češskoj respubliki @ http://aleph.nkp.cz/F/?func=find-b&request=1804881&find_code=SYS&local_base=nkc
2008 @ 05 @ 66 @ Volejbal @ http://aleph.nkp.cz/F/?func=find-b&request=1804714&find_code=SYS&local_base=nkc
2008 @ 05 @ 67 @ Zpravodaj : Česká Bělá @ http://aleph.nkp.cz/F/?func=find-b&request=1805062&find_code=SYS&local_base=nkc
2008 @ 05 @ 68 @ Zpravodaj : Fokus České Budějovice @ http://aleph.nkp.cz/F/?func=find-b&request=1805551&find_code=SYS&local_base=nkc
2008 @ 05 @ 69 @ Zpravodaj Mostecka @ http://aleph.nkp.cz/F/?func=find-b&request=1802740&find_code=SYS&local_base=nkc
2008 @ 05 @ 70 @ Zpravodaj obce Újezd @ http://aleph.nkp.cz/F/?func=find-b&request=1803679&find_code=SYS&local_base=nkc
2008 @ 06 @ 01 @ Aktivně @ http://aleph.nkp.cz/F/?func=find-b&request=01809917&find_code=SYS&local_base=nkc
2008 @ 06 @ 02 @ Autocar @ http://aleph.nkp.cz/F/?func=find-b&request=01809415&find_code=SYS&local_base=nkc
2008 @ 06 @ 03 @ Brněnský týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=01809441&find_code=SYS&local_base=nkc
2008 @ 06 @ 04 @ Bumerang @ http://aleph.nkp.cz/F/?func=find-b&request=01809930&find_code=SYS&local_base=nkc
2008 @ 06 @ 05 @ Cebivský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001806814&find_code=SYS&local_base=nkc
2008 @ 06 @ 06 @ Daně a účetnictví @ http://aleph.nkp.cz/F/?func=find-b&request=01808713&find_code=SYS&local_base=nkc
2008 @ 06 @ 07 @ Exclusive Top Cars @ http://aleph.nkp.cz/F/?func=find-b&request=01808725&find_code=SYS&local_base=nkc
2008 @ 06 @ 08 @ For Golf Woman @ http://aleph.nkp.cz/F/?func=find-b&request=01809023&find_code=SYS&local_base=nkc
2008 @ 06 @ 09 @ Generace @ http://aleph.nkp.cz/F/?func=find-b&request=01809927&find_code=SYS&local_base=nkc
2008 @ 06 @ 10 @ History revue @ http://aleph.nkp.cz/F/?func=find-b&request=01808773&find_code=SYS&local_base=nkc
2008 @ 06 @ 11 @ Hlas z Loštic @ http://aleph.nkp.cz/F/?func=find-b&request=01807230&find_code=SYS&local_base=nkc
2008 @ 06 @ 12 @ Hlavnovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01808791&find_code=SYS&local_base=nkc
2008 @ 06 @ 13 @ Inzertní obchodník @ http://aleph.nkp.cz/F/?func=find-b&request=1806785&find_code=SYS&local_base=nkc
2008 @ 06 @ 14 @ Jetřichovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01807192&find_code=SYS&local_base=nkc
2008 @ 06 @ 15 @ Lenorské střepiny @ http://aleph.nkp.cz/F/?func=find-b&request=01807215&find_code=SYS&local_base=nkc
2008 @ 06 @ 16 @ Loketský smajlík @ http://aleph.nkp.cz/F/?func=find-b&request=01807217&find_code=SYS&local_base=nkc
2008 @ 06 @ 17 @ Medvídek Pú ... a jeho báječný svět @ http://aleph.nkp.cz/F/?func=find-b&request=001807004&find_code=SYS&local_base=nkc
2008 @ 06 @ 18 @ Motivy tetování @ http://aleph.nkp.cz/F/?func=find-b&request=01809017&find_code=SYS&local_base=nkc
2008 @ 06 @ 19 @ Mratínoviny @ http://aleph.nkp.cz/F/?func=find-b&request=01807213&find_code=SYS&local_base=nkc
2008 @ 06 @ 20 @ Mzdy a personalistika @ http://aleph.nkp.cz/F/?func=find-b&request=01806992&find_code=SYS&local_base=nkc
2008 @ 06 @ 21 @ Naše Poličsko @ http://aleph.nkp.cz/F/?func=find-b&request=01810313&find_code=SYS&local_base=nkc
2008 @ 06 @ 22 @ Naše Praha 9.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01810654&find_code=SYS&local_base=nkc
2008 @ 06 @ 23 @ NewsDrive @ http://aleph.nkp.cz/F/?func=find-b&request=01810155&find_code=SYS&local_base=nkc
2008 @ 06 @ 24 @ Novoveský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01807226&find_code=SYS&local_base=nkc
2008 @ 06 @ 25 @ Obec Loukov @ http://aleph.nkp.cz/F/?func=find-b&request=01808949&find_code=SYS&local_base=nkc
2008 @ 06 @ 26 @ Obec Páleč : informační zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001807187&find_code=SYS&local_base=nkc
2008 @ 06 @ 27 @ Polenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=01806977&find_code=SYS&local_base=nkc
2008 @ 06 @ 28 @ Pražský metropol @ http://aleph.nkp.cz/F/?func=find-b&request=01808956&find_code=SYS&local_base=nkc
2008 @ 06 @ 29 @ Příroda @ http://aleph.nkp.cz/F/?func=find-b&request=01810554&find_code=SYS&local_base=nkc
2008 @ 06 @ 30 @ Real spektrum : spektrum nemovitostí @ http://aleph.nkp.cz/F/?func=find-b&request=001806821&find_code=SYS&local_base=nkc
2008 @ 06 @ 31 @ Real-immo.cz @ http://aleph.nkp.cz/F/?func=find-b&request=01809053&find_code=SYS&local_base=nkc
2008 @ 06 @ 32 @ Region Karlovarský venkov @ http://aleph.nkp.cz/F/?func=find-b&request=001806842&find_code=SYS&local_base=nkc
2008 @ 06 @ 33 @ Ren?e horoskopy @ http://aleph.nkp.cz/F/?func=find-b&request=01810670&find_code=SYS&local_base=nkc
2008 @ 06 @ 34 @ Rybolov noviny @ http://aleph.nkp.cz/F/?func=find-b&request=  001807057&find_code=SYS&local_base=nkc
2008 @ 06 @ 35 @ Stříbrské pivní listy @ http://aleph.nkp.cz/F/?func=find-b&request=01809178&find_code=SYS&local_base=nkc
2008 @ 06 @ 36 @ Transaction on Transport Sciences @ http://aleph.nkp.cz/F/?func=find-b&request=01809432&find_code=SYS&local_base=nkc
2008 @ 06 @ 37 @ Třeština: občasník obce @ http://aleph.nkp.cz/F/?func=find-b&request=01808774&find_code=SYS&local_base=nkc
2008 @ 06 @ 38 @ Týdeník Pernštejn @ http://aleph.nkp.cz/F/?func=find-b&request=01806793&find_code=SYS&local_base=nkc
2008 @ 06 @ 39 @ Veleňáček @ http://aleph.nkp.cz/F/?func=find-b&request=01810125&find_code=SYS&local_base=nkc
2008 @ 06 @ 40 @ Video A-Z @ http://aleph.nkp.cz/F/?func=find-b&request=01810308&find_code=SYS&local_base=nkc
2008 @ 06 @ 41 @ Vinařské listy @ http://aleph.nkp.cz/F/?func=find-b&request=01810099&find_code=SYS&local_base=nkc
2008 @ 06 @ 42 @ Visage : vášeň pro krásu @ http://aleph.nkp.cz/F/?func=find-b&request=01810117&find_code=SYS&local_base=nkc
2008 @ 06 @ 43 @ Vlčické kořeny @ http://aleph.nkp.cz/F/?func=find-b&request=01807181&find_code=SYS&local_base=nkc
2008 @ 06 @ 44 @ Zpravodaj : obec Petrovice @ http://aleph.nkp.cz/F/?func=find-b&request=01807550&find_code=SYS&local_base=nkc
2008 @ 06 @ 45 @ Zpravodaj Jílovicko @ http://aleph.nkp.cz/F/?func=find-b&request=01807236&find_code=SYS&local_base=nkc
2008 @ 06 @ 46 @ Zpravodaj klubu UNESCO Kroměříž @ http://aleph.nkp.cz/F/?func=find-b&request=01809906&find_code=SYS&local_base=nkc
2008 @ 06 @ 47 @ Zpravodaj městyse Mrákotína @ http://aleph.nkp.cz/F/?func=find-b&request=01809208&find_code=SYS&local_base=nkc
2008 @ 06 @ 48 @ Zpravodaj obce Hněvotín @ http://aleph.nkp.cz/F/?func=find-b&request=01810648&find_code=SYS&local_base=nkc
2008 @ 06 @ 49 @ Zpravodaj obce Olbramice @ http://aleph.nkp.cz/F/?func=find-b&request=01808781&find_code=SYS&local_base=nkc
2008 @ 06 @ 50 @ Život umělce @ http://aleph.nkp.cz/F/?func=find-b&request=01809922&find_code=SYS&local_base=nkc
2008 @ 07 @ 36 @ Zlaté listy (informační servis pro školy) @ http://aleph.nkp.cz/F/?func=find-b&request=001813472&find_code=SYS&local_base=nkc
2008 @ 07 @ 37 @ Zpráva Ekologického právního servisu @ http://aleph.nkp.cz/F/?func=find-b&request=001813298&find_code=SYS&local_base=nkc
2008 @ 07 @ 38 @ Živá historie : historický magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001813268&find_code=SYS&local_base=nkc
2008 @ 07 @ 35 @ Woodyland : dětský magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001812586&find_code=SYS&local_base=nkc
2008 @ 07 @ 34 @ Vraclavsko-sedlecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001812578&find_code=SYS&local_base=nkc
2008 @ 07 @ 31 @ Švédské křížovky : Katka @ http://aleph.nkp.cz/F/?func=find-b&request=001813119&find_code=SYS&local_base=nkc
2008 @ 07 @ 32 @ T.B.C. : zpravodaj 51. ročníku Wolkerova Prostějova @ http://aleph.nkp.cz/F/?func=find-b&request=001812307&find_code=SYS&local_base=nkc
2008 @ 07 @ 33 @ Telnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001812657&find_code=SYS&local_base=nkc
2008 @ 07 @ 30 @ Šumavák @ http://aleph.nkp.cz/F/?func=find-b&request=001813281&find_code=SYS&local_base=nkc
2008 @ 07 @ 28 @ Steel style : firemní magazín společnosti Tenzo @ http://aleph.nkp.cz/F/?func=find-b&request=001812555&find_code=SYS&local_base=nkc
2008 @ 07 @ 29 @ Štěrboholské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001812606&find_code=SYS&local_base=nkc
2008 @ 07 @ 27 @ SOUdek SOŠ : školní noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001812692&find_code=SYS&local_base=nkc
2008 @ 07 @ 26 @ Real-immo.cz : Liberecký kraj @ http://aleph.nkp.cz/F/?func=find-b&request=001813018&find_code=SYS&local_base=nkc
2008 @ 07 @ 25 @ PSG report @ http://aleph.nkp.cz/F/?func=find-b&request=001812533&find_code=SYS&local_base=nkc
2008 @ 07 @ 24 @ Praha centrum.cz @ http://aleph.nkp.cz/F/?func=find-b&request=001813285&find_code=SYS&local_base=nkc
2008 @ 07 @ 21 @ Magazín od Křížovek s tužkou @ http://aleph.nkp.cz/F/?func=find-b&request=001812572&find_code=SYS&local_base=nkc
2008 @ 07 @ 22 @ Magazín východní Morava @ http://aleph.nkp.cz/F/?func=find-b&request=001812929&find_code=SYS&local_base=nkc
2008 @ 07 @ 23 @ Napísané životom @ http://aleph.nkp.cz/F/?func=find-b&request=001813308&find_code=SYS&local_base=nkc
2008 @ 07 @ 20 @ Lady in @ http://aleph.nkp.cz/F/?func=find-b&request=001812273&find_code=SYS&local_base=nkc
2008 @ 07 @ 18 @ Jihočeské avízo speciál @ http://aleph.nkp.cz/F/?func=find-b&request=001813437&find_code=SYS&local_base=nkc
2008 @ 07 @ 19 @ Kojetický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001812385&find_code=SYS&local_base=nkc
2008 @ 07 @ 15 @ Jak to dělají jinde@ aneb nechte se inspirovat', 'http://aleph.nkp.cz/F/?func=find-b&request=001812418&find_code=SYS&local_base=nkc
2008 @ 07 @ 16 @ Jídla pro zdravý život : osmisměrky a správná výživa @ http://aleph.nkp.cz/F/?func=find-b&request=001812699&find_code=SYS&local_base=nkc
2008 @ 07 @ 17 @ Jihočeské avízo @ http://aleph.nkp.cz/F/?func=find-b&request=001813438&find_code=SYS&local_base=nkc
2008 @ 07 @ 14 @ HMMC News @ http://aleph.nkp.cz/F/?func=find-b&request=001812517&find_code=SYS&local_base=nkc
2008 @ 07 @ 13 @ Guard @ http://aleph.nkp.cz/F/?func=find-b&request=001812527&find_code=SYS&local_base=nkc
2008 @ 07 @ 11 @ F.O.O.D. : jídlo & styl & zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=001812611&find_code=SYS&local_base=nkc
2008 @ 07 @ 12 @ Fastlane : lifestyle magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001812689&find_code=SYS&local_base=nkc
2008 @ 07 @ 10 @ Dobroty na talíři @ http://aleph.nkp.cz/F/?func=find-b&request=001813478&find_code=SYS&local_base=nkc
2008 @ 07 @ 09 @ ČKD magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001812538&find_code=SYS&local_base=nkc
2008 @ 07 @ 06 @ CZ novosti : Češskaja respublika @ http://aleph.nkp.cz/F/?func=find-b&request=001810887&find_code=SYS&local_base=nkc
2008 @ 07 @ 08 @ Čížovský kurýr : čtvrtletník obce Čížová @ http://aleph.nkp.cz/F/?func=find-b&request=001812382&find_code=SYS&local_base=nkc
2008 @ 07 @ 07 @ Čas na lásku : skutočné osudy @ http://aleph.nkp.cz/F/?func=find-b&request=001813300&find_code=SYS&local_base=nkc
2008 @ 07 @ 04 @ Construct revue @ http://aleph.nkp.cz/F/?func=find-b&request=001813008&find_code=SYS&local_base=nkc
2008 @ 07 @ 05 @ Cvrkot (měsíčník pro Prahu 6 a okolí) @ http://aleph.nkp.cz/F/?func=find-b&request=001812399&find_code=SYS&local_base=nkc
2008 @ 07 @ 03 @ Arkáda : obchodní galerie @ http://aleph.nkp.cz/F/?func=find-b&request=001813030&find_code=SYS&local_base=nkc
2008 @ 07 @ 00 @  @ 
2008 @ 07 @ 01 @ Alfík : Alcoa firemní informační kabel @ http://aleph.nkp.cz/F/?func=find-b&request=001812329&find_code=SYS&local_base=nkc
2008 @ 07 @ 02 @ All for Power @ http://aleph.nkp.cz/F/?func=find-b&request=001813128&find_code=SYS&local_base=nkc
2008 @ 09 @ 27 @ Thermae Europae @ http://aleph.nkp.cz/F/?func=find-b&request=001819287find_code=SYS&local_base=nkc
2008 @ 08 @ 36 @ Zpravodaj z Klamoše a Štíta @ http://aleph.nkp.cz/F/?func=find-b&request=001813789&find_code=SYS&local_base=nkc
2008 @ 08 @ 35 @ Zpravodaj obecního úřadu Pačejov @ http://aleph.nkp.cz/F/?func=find-b&request=001816682&find_code=SYS&local_base=nkc
2008 @ 08 @ 34 @ ViaTerea : realitní katalog pro Pardubicko @ http://aleph.nkp.cz/F/?func=find-b&request=001816691&find_code=SYS&local_base=nkc
2008 @ 08 @ 33 @ ViaTerea : realitní katalog pro České Budějovice @ http://aleph.nkp.cz/F/?func=find-b&request=001816692&find_code=SYS&local_base=nkc
2008 @ 08 @ 31 @ Svět barev @ http://aleph.nkp.cz/F/?func=find-b&request=001816694&find_code=SYS&local_base=nkc
2008 @ 08 @ 32 @ Velichovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001816034&find_code=SYS&local_base=nkc
2008 @ 08 @ 29 @ Rekin bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=001816048&find_code=SYS&local_base=nkc
2008 @ 08 @ 30 @ Schneider magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001816685&find_code=SYS&local_base=nkc
2008 @ 08 @ 27 @ Radiměřský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001814384&find_code=SYS&local_base=nkc
2008 @ 08 @ 28 @ RCMAG : čtení o rallyecrossu@ které jinde nenajdete', 'http://aleph.nkp.cz/F/?func=find-b&request=001816210&find_code=SYS&local_base=nkc
2008 @ 08 @ 26 @ Přehledné reality.cz @ http://aleph.nkp.cz/F/?func=find-b&request=001817126&find_code=SYS&local_base=nkc
2008 @ 08 @ 25 @ Pardubický patriot : regionální noviny pro Pardubický kraj @ http://aleph.nkp.cz/F/?func=find-b&request=001814397&find_code=SYS&local_base=nkc
2008 @ 08 @ 23 @ Novart : originální inzert @ http://aleph.nkp.cz/F/?func=find-b&request=001816970&find_code=SYS&local_base=nkc
2008 @ 08 @ 24 @ Ozvěna @ http://aleph.nkp.cz/F/?func=find-b&request=001813788&find_code=SYS&local_base=nkc
2008 @ 08 @ 22 @ Naše Čakovičky @ http://aleph.nkp.cz/F/?func=find-b&request=001817322&find_code=SYS&local_base=nkc
2008 @ 08 @ 21 @ Moravský region : Brno-venkov@ Blansko', 'http://aleph.nkp.cz/F/?func=find-b&request=001816925&find_code=SYS&local_base=nkc
2008 @ 08 @ 20 @ Milotický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001817939&find_code=SYS&local_base=nkc
2008 @ 08 @ 19 @ Mezi regály : občasník pro návštěvníky KK KV @ http://aleph.nkp.cz/F/?func=find-b&request=001816040&find_code=SYS&local_base=nkc
2008 @ 08 @ 17 @ Medicína & umění @ http://aleph.nkp.cz/F/?func=find-b&request=001816046&find_code=SYS&local_base=nkc
2008 @ 08 @ 18 @ Městem v pohybu @ http://aleph.nkp.cz/F/?func=find-b&request=001816197&find_code=SYS&local_base=nkc
2008 @ 08 @ 16 @ Loučenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001817140&find_code=SYS&local_base=nkc
2008 @ 08 @ 15 @ Kostelecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001816441&find_code=SYS&local_base=nkc
2008 @ 08 @ 14 @ Každý luští! @ http://aleph.nkp.cz/F/?func=find-b&request=001816779&find_code=SYS&local_base=nkc
2008 @ 08 @ 12 @ GolfProfi magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001817289&find_code=SYS&local_base=nkc
2008 @ 08 @ 13 @ Holedečská drbna @ http://aleph.nkp.cz/F/?func=find-b&request=001816450&find_code=SYS&local_base=nkc
2008 @ 08 @ 11 @ Družstevní bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=001816964&find_code=SYS&local_base=nkc
2008 @ 08 @ 10 @ Drahanské listy : objevujte s námi Drahanskou vrchovinu @ http://aleph.nkp.cz/F/?func=find-b&request=001813800&find_code=SYS&local_base=nkc
2008 @ 08 @ 08 @ Dicra : bulletin Společnosti Dicre o.s. @ http://aleph.nkp.cz/F/?func=find-b&request=001818264&find_code=SYS&local_base=nkc
2008 @ 08 @ 09 @ Discourse and interaction @ http://aleph.nkp.cz/F/?func=find-b&request=001816759&find_code=SYS&local_base=nkc
2008 @ 08 @ 07 @ Den’gi pljus @ http://aleph.nkp.cz/F/?func=find-b&request=001816946&find_code=SYS&local_base=nkc
2008 @ 08 @ 06 @ Číselné křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001816980&find_code=SYS&local_base=nkc
2008 @ 08 @ 05 @ Blatensko sobě : živě a nově @ http://aleph.nkp.cz/F/?func=find-b&request=001816213&find_code=SYS&local_base=nkc
2008 @ 08 @ 04 @ Autotip sportscars @ http://aleph.nkp.cz/F/?func=find-b&request=001814400&find_code=SYS&local_base=nkc
2008 @ 08 @ 02 @ ACMAG : čtení o autocrossu@ které jinde nenajdete', 'http://aleph.nkp.cz/F/?func=find-b&request=001816211&find_code=SYS&local_base=nkc
2008 @ 08 @ 03 @ Armed Forces review @ http://aleph.nkp.cz/F/?func=find-b&request=001817005&find_code=SYS&local_base=nkc
2008 @ 08 @ 00 @  @ 
2008 @ 08 @ 01 @ 9sil : sociálně zdravotní bulletin Zlínska @ http://aleph.nkp.cz/F/?func=find-b&request=001817530&find_code=SYS&local_base=nkc
2008 @ 09 @ 26 @ Srubecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001821274find_code=SYS&local_base=nkc
2008 @ 09 @ 25 @ Řízení & údržba průmyslového podniku @ http://aleph.nkp.cz/F/?func=find-b&request=001819919find_code=SYS&local_base=nkc
2008 @ 09 @ 24 @ Q inzert @ http://aleph.nkp.cz/F/?func=find-b&request=001819452find_code=SYS&local_base=nkc
2008 @ 09 @ 23 @ Porozumění @ http://aleph.nkp.cz/F/?func=find-b&request=001818802find_code=SYS&local_base=nkc
2008 @ 09 @ 22 @ Pardubická čtyřka @ http://aleph.nkp.cz/F/?func=find-b&request=001818651find_code=SYS&local_base=nkc
2008 @ 09 @ 21 @ Osmisměrky speciál : Radka @ http://aleph.nkp.cz/F/?func=find-b&request=001818816find_code=SYS&local_base=nkc
2008 @ 09 @ 20 @ Oceňování @ http://aleph.nkp.cz/F/?func=find-b&request=001819939find_code=SYS&local_base=nkc
2008 @ 09 @ 19 @ Nové Tachovsko @ http://aleph.nkp.cz/F/?func=find-b&request=001819907find_code=SYS&local_base=nkc
2008 @ 09 @ 18 @ Nové Klatovsko @ http://aleph.nkp.cz/F/?func=find-b&request=001819911find_code=SYS&local_base=nkc
2008 @ 09 @ 17 @ Náš region : [Bašť@ ...Zlonín]', 'http://aleph.nkp.cz/F/?func=find-b&request=001820655find_code=SYS&local_base=nkc
2008 @ 09 @ 16 @ Náš kraj @ http://aleph.nkp.cz/F/?func=find-b&request=001819013find_code=SYS&local_base=nkc
2008 @ 09 @ 15 @ My little pony @ http://aleph.nkp.cz/F/?func=find-b&request=001821269find_code=SYS&local_base=nkc
2008 @ 09 @ 14 @ Motion : revue Českých drah @ http://aleph.nkp.cz/F/?func=find-b&request=001821265find_code=SYS&local_base=nkc
2008 @ 09 @ 13 @ Listy jižní Moravy @ http://aleph.nkp.cz/F/?func=find-b&request=001819038find_code=SYS&local_base=nkc
2008 @ 09 @ 12 @ Krimi story : luštitelský měsíčník @ http://aleph.nkp.cz/F/?func=find-b&request=001819027find_code=SYS&local_base=nkc
2008 @ 09 @ 11 @ IQ rébusy @ http://aleph.nkp.cz/F/?func=find-b&request=001818653find_code=SYS&local_base=nkc
2008 @ 09 @ 10 @ Info expres @ http://aleph.nkp.cz/F/?func=find-b&request=001819924ind_code=SYS&local_base=nkc
2008 @ 09 @ 09 @ In bar & restaurant @ http://aleph.nkp.cz/F/?func=find-b&request=001821252find_code=SYS&local_base=nkc
2008 @ 09 @ 08 @ Chodovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001820866find_code=SYS&local_base=nkc
2008 @ 09 @ 07 @ Hodonínské zelené listy @ http://aleph.nkp.cz/F/?func=find-b&request=001818806find_code=SYS&local_base=nkc
2008 @ 09 @ 06 @ Gastro @ http://aleph.nkp.cz/F/?func=find-b&request=001819932find_code=SYS&local_base=nkc
2010 @ 10 @ 22 @ Pražan : mimořádné vydání @ http://aleph.nkp.cz/F/?func=direct&doc_number=002130245&local_base=nkc
2008 @ 09 @ 05 @ Časopis Společnosti přátel starožitností @ http://aleph.nkp.cz/F/?func=find-b&request=001818448find_code=SYS&local_base=nkc
2008 @ 09 @ 04 @ CE kontakt @ http://aleph.nkp.cz/F/?func=find-b&request=001819166find_code=SYS&local_base=nkc
2008 @ 09 @ 03 @ Benešovské ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=001818823find_code=SYS&local_base=nkc
2008 @ 09 @ 02 @ Benešov : informační zpravodaj města @ http://aleph.nkp.cz/F/?func=find-b&request=001819923find_code=SYS&local_base=nkc
2008 @ 09 @ 00 @  @ 
2008 @ 09 @ 01 @ Aha! - Morava @ http://aleph.nkp.cz/F/?func=find-b&request=001819502find_code=SYS&local_base=nkc
2008 @ 09 @ 28 @ Týdeník Jindřichohradecka @ http://aleph.nkp.cz/F/?func=find-b&request=001818826find_code=SYS&local_base=nkc
2008 @ 09 @ 29 @ Ukrgazeta : reklamno-informačjnyj tyžnevyk @ http://aleph.nkp.cz/F/?func=find-b&request=001819120find_code=SYS&local_base=nkc
2008 @ 09 @ 30 @ Velbloud @ http://aleph.nkp.cz/F/?func=find-b&request=001819281find_code=SYS&local_base=nkc
2008 @ 09 @ 31 @ Vlaštovka @ http://aleph.nkp.cz/F/?func=find-b&request=001819295find_code=SYS&local_base=nkc
2008 @ 09 @ 32 @ Výstavba měst a obcí @ http://aleph.nkp.cz/F/?func=find-b&request=001819138find_code=SYS&local_base=nkc
2008 @ 09 @ 33 @ Winx club @ http://aleph.nkp.cz/F/?func=find-b&request=001818813find_code=SYS&local_base=nkc
2008 @ 10 @ 00 @  @ 
2008 @ 10 @ 01 @ 1 : ArcelorMittal @ http://aleph.nkp.cz/F/?func=find-b&request=001828378&find_code=SYS&local_base=nkc
2008 @ 10 @ 02 @ Aréna : HC Slavia Praha @ http://aleph.nkp.cz/F/?func=find-b&request=0018224338&find_code=SYS&local_base=nkc
2008 @ 10 @ 03 @ Auta : svět na kolech @ http://aleph.nkp.cz/F/?func=find-b&request=001824457&find_code=SYS&local_base=nkc
2008 @ 10 @ 04 @ Boutique : jak chytře utrácet @ http://aleph.nkp.cz/F/?func=find-b&request=001824002&find_code=SYS&local_base=nkc
2008 @ 10 @ 05 @ Brandýsko-Staroboleslavský prostor @ http://aleph.nkp.cz/F/?func=find-b&request=0018223738&find_code=SYS&local_base=nkc
2008 @ 10 @ 06 @ Český les : zpravodaj MAS Český les @ http://aleph.nkp.cz/F/?func=find-b&request=0018226308&find_code=SYS&local_base=nkc
2008 @ 10 @ 07 @ Decanter : the world´s best wine magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001828361&find_code=SYS&local_base=nkc
2008 @ 10 @ 08 @ Domanínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001825462&find_code=SYS&local_base=nkc
2008 @ 10 @ 09 @ Europlan @ http://aleph.nkp.cz/F/?func=find-b&request=001822624&find_code=SYS&local_base=nkc
2008 @ 10 @ 10 @ Heřmánek @ http://aleph.nkp.cz/F/?func=find-b&request=0018223878&find_code=SYS&local_base=nkc
2008 @ 10 @ 11 @ Ježkovy voči : občasný týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=0018214838&find_code=SYS&local_base=nkc
2008 @ 10 @ 12 @ Jihlavský kmotr @ http://aleph.nkp.cz/F/?func=find-b&request=001823708&find_code=SYS&local_base=nkc
2008 @ 10 @ 13 @ Křišťanoviny @ http://aleph.nkp.cz/F/?func=find-b&request=001828218&find_code=SYS&local_base=nkc
2008 @ 10 @ 14 @ Lípa : zpravodaj Výboru národní kultury @ http://aleph.nkp.cz/F/?func=find-b&request=001822849&find_code=SYS&local_base=nkc
2008 @ 10 @ 15 @ Littera scripta @ http://aleph.nkp.cz/F/?func=find-b&request=001825358&find_code=SYS&local_base=nkc
2008 @ 10 @ 16 @ Moje země : Česká republika @ http://aleph.nkp.cz/F/?func=find-b&request=001824635&find_code=SYS&local_base=nkc
2008 @ 10 @ 17 @ Moravský metropol @ http://aleph.nkp.cz/F/?func=find-b&request=0018230618&find_code=SYS&local_base=nkc
2008 @ 10 @ 18 @ Nižborský list @ http://aleph.nkp.cz/F/?func=find-b&request=001825404&find_code=SYS&local_base=nkc
2008 @ 10 @ 19 @ O nás : o.s. Náš domov Otročiněves @ http://aleph.nkp.cz/F/?func=find-b&request=0018236268&find_code=SYS&local_base=nkc
2008 @ 10 @ 20 @ O2 arena : magazín O2 areny @ http://aleph.nkp.cz/F/?func=find-b&request=001827942&find_code=SYS&local_base=nkc
2008 @ 10 @ 21 @ Odborářský palovák @ http://aleph.nkp.cz/F/?func=find-b&request=001823714&find_code=SYS&local_base=nkc
2008 @ 10 @ 22 @ Padesát pět plus @ http://aleph.nkp.cz/F/?func=find-b&request=001823728&find_code=SYS&local_base=nkc
2008 @ 10 @ 23 @ Palác Flóra : nákupní galerie @ http://aleph.nkp.cz/F/?func=find-b&request=001825626&find_code=SYS&local_base=nkc
2008 @ 10 @ 24 @ Prickelnde Welt @ http://aleph.nkp.cz/F/?func=find-b&request=001825801&find_code=SYS&local_base=nkc
2008 @ 10 @ 25 @ Prima recepty speciál v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=001825643&find_code=SYS&local_base=nkc
2008 @ 10 @ 26 @ Programa cultural : Instituto Cervantes de Praga @ http://aleph.nkp.cz/F/?func=find-b&request=001824774&find_code=SYS&local_base=nkc
2008 @ 10 @ 27 @ Radonické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001828381&find_code=SYS&local_base=nkc
2008 @ 10 @ 28 @ Ross magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001823145&find_code=SYS&local_base=nkc
2008 @ 10 @ 29 @ Rybář @ http://aleph.nkp.cz/F/?func=find-b&request=001823547&find_code=SYS&local_base=nkc
2008 @ 10 @ 30 @ Severočeský metropol @ http://aleph.nkp.cz/F/?func=find-b&request=0018230698&find_code=SYS&local_base=nkc
2008 @ 10 @ 31 @ Slovo pro každý den @ http://aleph.nkp.cz/F/?func=find-b&request=0018236232&find_code=SYS&local_base=nkc
2008 @ 10 @ 32 @ Sparkling world @ http://aleph.nkp.cz/F/?func=find-b&request=001825802&find_code=SYS&local_base=nkc
2008 @ 10 @ 33 @ Sportstar @ http://aleph.nkp.cz/F/?func=find-b&request=001825116&find_code=SYS&local_base=nkc
2008 @ 10 @ 34 @ Standard : časopis pro mírnou inzerci @ http://aleph.nkp.cz/F/?func=find-b&request=001822400&find_code=SYS&local_base=nkc
2008 @ 10 @ 35 @ Stříbrský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=0018236278&find_code=SYS&local_base=nkc
2008 @ 10 @ 36 @ Studenský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001823618&find_code=SYS&local_base=nkc
2008 @ 10 @ 37 @ Svět potravin @ http://aleph.nkp.cz/F/?func=find-b&request=0018257668&find_code=SYS&local_base=nkc
2008 @ 10 @ 38 @ Symetrála @ http://aleph.nkp.cz/F/?func=find-b&request=001825779&find_code=SYS&local_base=nkc
2008 @ 10 @ 39 @ Šikulka : časopis pro malé šikulky @ http://aleph.nkp.cz/F/?func=find-b&request=001824784&find_code=SYS&local_base=nkc
2008 @ 10 @ 40 @ Tech Magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001824132&find_code=SYS&local_base=nkc
2008 @ 10 @ 41 @ Tennis arena @ http://aleph.nkp.cz/F/?func=find-b&request=001823950&find_code=SYS&local_base=nkc
2008 @ 10 @ 42 @ Tv - program : Jihlava - Třešť @ http://aleph.nkp.cz/F/?func=find-b&request=001828208&find_code=SYS&local_base=nkc
2008 @ 10 @ 43 @ ViaTerea : realitní katalog pro Zlínský kraj @ http://aleph.nkp.cz/F/?func=find-b&request=001828202&find_code=SYS&local_base=nkc
2008 @ 10 @ 44 @ Visionnews.eu : průvodce světem optiky @ http://aleph.nkp.cz/F/?func=find-b&request=001823935&find_code=SYS&local_base=nkc
2008 @ 10 @ 45 @ Vrážský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=0018224148&find_code=SYS&local_base=nkc
2008 @ 10 @ 46 @ Vyhrajte s luštěním @ http://aleph.nkp.cz/F/?func=find-b&request=001823599&find_code=SYS&local_base=nkc
2008 @ 10 @ 47 @ Západočeský metropol @ http://aleph.nkp.cz/F/?func=find-b&request=0018230558&find_code=SYS&local_base=nkc
2008 @ 10 @ 48 @ Zelený život @ http://aleph.nkp.cz/F/?func=find-b&request=0018236018&find_code=SYS&local_base=nkc
2008 @ 10 @ 49 @ Zpravodaj městyse Lomnice @ http://aleph.nkp.cz/F/?func=find-b&request=001827818&find_code=SYS&local_base=nkc
2008 @ 10 @ 50 @ Zvířata & zdraví @ http://aleph.nkp.cz/F/?func=find-b&request=0018217058&find_code=SYS&local_base=nkc
2008 @ 11 @ 26 @ The Spiritor @ http://aleph.nkp.cz/F/?func=find-b&request=001831219&find_code=SYS&local_base=nkc
2008 @ 11 @ 25 @ Tajemství islámu @ http://aleph.nkp.cz/F/?func=find-b&request=001830165&find_code=SYS&local_base=nkc
2008 @ 11 @ 24 @ Silesia style @ http://aleph.nkp.cz/F/?func=find-b&request=001831223&find_code=SYS&local_base=nkc
2008 @ 11 @ 23 @ Security World @ http://aleph.nkp.cz/F/?func=find-b&request=001829404&find_code=SYS&local_base=nkc
2008 @ 11 @ 22 @ Rohožník : dubečský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001829399&find_code=SYS&local_base=nkc
2008 @ 11 @ 21 @ RevueHotel @ http://aleph.nkp.cz/F/?func=find-b&request=001829002&find_code=SYS&local_base=nkc
2008 @ 11 @ 20 @ Reliant Logistic News @ http://aleph.nkp.cz/F/?func=find-b&request=001829446&find_code=SYS&local_base=nkc
2008 @ 11 @ 19 @ Recepty : houby v kuchyni @ http://aleph.nkp.cz/F/?func=find-b&request=001829931&find_code=SYS&local_base=nkc
2008 @ 11 @ 18 @ Periodica Academica @ http://aleph.nkp.cz/F/?func=find-b&request=001831567&find_code=SYS&local_base=nkc
2008 @ 11 @ 17 @ Pardubický puk @ http://aleph.nkp.cz/F/?func=find-b&request=001831717&find_code=SYS&local_base=nkc
2008 @ 11 @ 16 @ Koncept : časopis o české architektuře @ http://aleph.nkp.cz/F/?func=find-b&request=001831724&find_code=SYS&local_base=nkc
2008 @ 11 @ 14 @ Kamarád @ http://aleph.nkp.cz/F/?func=find-b&request=001831673&find_code=SYS&local_base=nkc
2008 @ 11 @ 13 @ Jihomoravský lobbing @ http://aleph.nkp.cz/F/?func=find-b&request=001830527&find_code=SYS&local_base=nkc
2008 @ 11 @ 12 @ Im Herzen Europas @ http://aleph.nkp.cz/F/?func=find-b&request=001828387&find_code=SYS&local_base=nkc
2008 @ 11 @ 11 @ I´multiexpo @ http://aleph.nkp.cz/F/?func=find-b&request=001829280&find_code=SYS&local_base=nkc
2008 @ 11 @ 10 @ High School Musical @ http://aleph.nkp.cz/F/?func=find-b&request=001831691&find_code=SYS&local_base=nkc
2008 @ 11 @ 09 @ Gastro & hotel @ http://aleph.nkp.cz/F/?func=find-b&request=001829281&find_code=SYS&local_base=nkc
2008 @ 11 @ 08 @ Galerie style @ http://aleph.nkp.cz/F/?func=find-b&request=001831719&find_code=SYS&local_base=nkc
2008 @ 11 @ 07 @ Fokus @ http://aleph.nkp.cz/F/?func=find-b&request=001830963&find_code=SYS&local_base=nkc
2008 @ 11 @ 06 @ Flosman Flop @ http://aleph.nkp.cz/F/?func=find-b&request=001831731&find_code=SYS&local_base=nkc
2008 @ 11 @ 05 @ Eso : esoterický informační občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001830973&find_code=SYS&local_base=nkc
2008 @ 11 @ 04 @ Epravo.cz magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001830568&find_code=SYS&local_base=nkc
2008 @ 11 @ 03 @ DIA.info @ http://aleph.nkp.cz/F/?func=find-b&request=001831568&find_code=SYS&local_base=nkc
2008 @ 11 @ 02 @ Control Engineering Česko @ http://aleph.nkp.cz/F/?func=find-b&request=001831736&find_code=SYS&local_base=nkc
2010 @ 10 @ 21 @ Pražan @ http://aleph.nkp.cz/F/?func=direct&doc_number=002130301&local_base=nkc
2008 @ 11 @ 00 @  @ 
2008 @ 11 @ 01 @ Alfa : bulletin Fakulty architektury ČVUT @ http://aleph.nkp.cz/F/?func=find-b&request=001830919&find_code=SYS&local_base=nkc
2008 @ 11 @ 27 @ Trifid @ http://aleph.nkp.cz/F/?func=find-b&request=001830155&find_code=SYS&local_base=nkc
2008 @ 11 @ 28 @ Truck magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001828581&find_code=SYS&local_base=nkc
2008 @ 11 @ 29 @ Trucker-King magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001828580&find_code=SYS&local_base=nkc
2008 @ 11 @ 30 @ TZB Haustechnik : technická zařízení budov @ http://aleph.nkp.cz/F/?func=find-b&request=001830576&find_code=SYS&local_base=nkc
2008 @ 11 @ 31 @ Villa journal @ http://aleph.nkp.cz/F/?func=find-b&request=001830554&find_code=SYS&local_base=nkc
2008 @ 11 @ 32 @ Volný čas @ http://aleph.nkp.cz/F/?func=find-b&request=001828609&find_code=SYS&local_base=nkc
2008 @ 12 @ 28 @ Třemošnické novinky @ http://aleph.nkp.cz/F/?func=find-b&request=001833750&find_code=SYS&local_base=nkc
2008 @ 12 @ 29 @ Zpravodaj Sdružení Český ráj @ http://aleph.nkp.cz/F/?func=find-b&request=001836526&find_code=SYS&local_base=nkc
2008 @ 12 @ 27 @ Tep : regionální týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=001835593&find_code=SYS&local_base=nkc
2008 @ 12 @ 26 @ Škorcová s.r.o @ http://aleph.nkp.cz/F/?func=find-b&request=001835234&find_code=SYS&local_base=nkc
2008 @ 12 @ 24 @ Svět ženy : číselné křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001835759&find_code=SYS&local_base=nkc
2008 @ 12 @ 25 @ Škoda news : časopis pro studenty univerzit @ http://aleph.nkp.cz/F/?func=find-b&request=001831835&find_code=SYS&local_base=nkc
2008 @ 12 @ 22 @ Start pro podnikání a franchising @ http://aleph.nkp.cz/F/?func=find-b&request=001835199&find_code=SYS&local_base=nkc
2008 @ 12 @ 23 @ Svět kabin @ http://aleph.nkp.cz/F/?func=find-b&request=001830919&find_code=SYS&local_base=nkc
2008 @ 12 @ 21 @ Rendezvous @ http://aleph.nkp.cz/F/?func=find-b&request=01836620&find_code=SYS&local_base=nkc
2008 @ 12 @ 20 @ Presidentské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001835771&find_code=SYS&local_base=nkc
2008 @ 12 @ 19 @ Poradce - auditor @ http://aleph.nkp.cz/F/?func=find-b&request=001833754&find_code=SYS&local_base=nkc
2008 @ 12 @ 18 @ Point @ http://aleph.nkp.cz/F/?func=find-b&request=001833232&find_code=SYS&local_base=nkc
2008 @ 12 @ 17 @ Ona ví @ http://aleph.nkp.cz/F/?func=find-b&request=001830919&find_code=SYS&local_base=nkc
2008 @ 12 @ 16 @ Nové Rokycansko @ http://aleph.nkp.cz/F/?func=find-b&request=001835795&find_code=SYS&local_base=nkc
2008 @ 12 @ 14 @ Naše Praha2.cz @ http://aleph.nkp.cz/F/?func=find-b&request=001835813&find_code=SYS&local_base=nkc
2008 @ 12 @ 15 @ Naše Praha3.cz @ http://aleph.nkp.cz/F/?func=find-b&request=001835812&find_code=SYS&local_base=nkc
2008 @ 12 @ 13 @ Naše Jihlava.cz @ http://aleph.nkp.cz/F/?func=find-b&request=001836523&find_code=SYS&local_base=nkc
2008 @ 12 @ 12 @ Mercury´s exclusive magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001830919&find_code=SYS&local_base=nkc
2008 @ 12 @ 11 @ Lokomotiva Tomáš @ http://aleph.nkp.cz/F/?func=find-b&request=001830919&find_code=SYS&local_base=nkc
2008 @ 12 @ 10 @ Liška @ http://aleph.nkp.cz/F/?func=find-b&request=001830919&find_code=SYS&local_base=nkc
2008 @ 12 @ 08 @ Kroužkovatel @ http://aleph.nkp.cz/F/?func=find-b&request=001835523&find_code=SYS&local_base=nkc
2008 @ 12 @ 09 @ Lifestyle pro mou rodinu @ http://aleph.nkp.cz/F/?func=find-b&request=001830919&find_code=SYS&local_base=nkc
2008 @ 12 @ 07 @ Informace mikroregionu Kahan @ http://aleph.nkp.cz/F/?func=find-b&request=001831864&find_code=SYS&local_base=nkc
2008 @ 12 @ 06 @ Horsch : značkový magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001831830&find_code=SYS&local_base=nkc
2008 @ 12 @ 05 @ Hardware speciál @ http://aleph.nkp.cz/F/?func=find-b&request=001833469&find_code=SYS&local_base=nkc
2008 @ 12 @ 02 @  H_aluze @ http://aleph.nkp.cz/F/?func=find-b&request=001833248&find_code=SYS&local_base=nkc
2008 @ 12 @ 03 @ Číčenický hlasatel @ http://aleph.nkp.cz/F/?func=find-b&request=001830919&find_code=SYS&local_base=nkc
2008 @ 12 @ 04 @ Gift & Promotion @ http://aleph.nkp.cz/F/?func=find-b&request=01831849&find_code=SYS&local_base=nkc
2008 @ 12 @ 00 @  @ 
2008 @ 12 @ 01 @ Autogram @ http://aleph.nkp.cz/F/?func=find-b&request=001835524&find_code=SYS&local_base=nkc
2009 @ 01 @ 21 @ Zpravodaj : Nízkojesenický region @ http://aleph.nkp.cz/F/?func=find-b&request=001850156&find_code=SYS&local_base=nkc
2009 @ 01 @ 20 @ Via Iveco @ http://aleph.nkp.cz/F/?func=find-b&request=001850300&find_code=SYS&local_base=nkc
2010 @ 10 @ 20 @ Petropavlovskij vestnik @ http://aleph.nkp.cz/F/?func=direct&doc_number=002133428&local_base=nkc
2009 @ 01 @ 19 @ The science for population protection @ http://aleph.nkp.cz/F/?func=find-b&request=001850844&find_code=SYS&local_base=nkc
2009 @ 01 @ 18 @ Soběhrdský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001850989&find_code=SYS&local_base=nkc
2009 @ 01 @ 17 @ Priorita @ http://aleph.nkp.cz/F/?func=find-b&request=001850296&find_code=SYS&local_base=nkc
2009 @ 01 @ 16 @ Poodří plné příležitostí @ http://aleph.nkp.cz/F/?func=find-b&request=001850521&find_code=SYS&local_base=nkc
2009 @ 01 @ 15 @ Pohodový region @ http://aleph.nkp.cz/F/?func=find-b&request=001830919&find_code=SYS&local_base=nkc
2009 @ 01 @ 14 @ Podbřežický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001850642&find_code=SYS&local_base=nkc
2009 @ 01 @ 12 @ Moravský metropol @ http://aleph.nkp.cz/F/?func=find-b&request=001851230&find_code=SYS&local_base=nkc
2009 @ 01 @ 13 @ Osek dnes @ http://aleph.nkp.cz/F/?func=find-b&request=001851247&find_code=SYS&local_base=nkc
2009 @ 01 @ 11 @ Mlejn @ http://aleph.nkp.cz/F/?func=find-b&request=001850160&find_code=SYS&local_base=nkc
2009 @ 01 @ 10 @ Mini výherní su-do-ku @ http://aleph.nkp.cz/F/?func=find-b&request=001850522&find_code=SYS&local_base=nkc
2009 @ 01 @ 08 @ Leštinský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001850297&find_code=SYS&local_base=nkc
2009 @ 01 @ 09 @ Longevity @ http://aleph.nkp.cz/F/?func=find-b&request=001851254&find_code=SYS&local_base=nkc
2009 @ 01 @ 07 @ Jizerský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001850859&find_code=SYS&local_base=nkc
2009 @ 01 @ 06 @ Health only @ http://aleph.nkp.cz/F/?func=find-b&request=001850825&find_code=SYS&local_base=nkc
2009 @ 01 @ 05 @ Golf punk @ http://aleph.nkp.cz/F/?func=find-b&request=001850832&find_code=SYS&local_base=nkc
2009 @ 01 @ 04 @ Fakta & svědectví @ http://aleph.nkp.cz/F/?func=find-b&request=001851493&find_code=SYS&local_base=nkc
2009 @ 01 @ 02 @ Biologická léčba @ http://aleph.nkp.cz/F/?func=find-b&request=001851508&find_code=SYS&local_base=nkc
2009 @ 01 @ 03 @ Česko : země české - domov Tvůj @ http://aleph.nkp.cz/F/?func=find-b&request=001850649&find_code=SYS&local_base=nkc
2009 @ 01 @ 00 @  @ 
2009 @ 01 @ 01 @ Aspectus philosophici @ http://aleph.nkp.cz/F/?func=find-b&request=001851520&find_code=SYS&local_base=nkc
2009 @ 03 @ 47 @ Úklid @ http://aleph.nkp.cz/F/?func=find-b&request=001857605&find_code=SYS&local_base=nkc
2009 @ 03 @ 48 @ Úklid plus @ http://aleph.nkp.cz/F/?func=find-b&request=001860888&find_code=SYS&local_base=nkc
2009 @ 02 @ 27 @ Zpravodaj pro mateřské školy @ http://aleph.nkp.cz/F/?func=find-b&request=001854527&find_code=SYS&local_base=nkc
2009 @ 02 @ 23 @ Top life @ http://aleph.nkp.cz/F/?func=find-b&request=001854732&find_code=SYS&local_base=nkc
2009 @ 02 @ 24 @ Volfartický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001854314&find_code=SYS&local_base=nkc
2009 @ 02 @ 25 @ www.muas.cz informuje @ http://aleph.nkp.cz/F/?func=find-b&request=001855052&find_code=SYS&local_base=nkc
2009 @ 02 @ 26 @ Zpravodaj města Jevišovice @ http://aleph.nkp.cz/F/?func=find-b&request=001854529&find_code=SYS&local_base=nkc
2009 @ 02 @ 16 @ Naše policie @ http://aleph.nkp.cz/F/?func=find-b&request=001857191&find_code=SYS&local_base=nkc
2009 @ 02 @ 17 @ Novaja rusistika @ http://aleph.nkp.cz/F/?func=find-b&request=001854345&find_code=SYS&local_base=nkc
2009 @ 02 @ 18 @ Obchodněprávní revue @ http://aleph.nkp.cz/F/?func=find-b&request=001854027&find_code=SYS&local_base=nkc
2009 @ 02 @ 19 @ Ohrazenický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001854038&find_code=SYS&local_base=nkc
2009 @ 02 @ 20 @ Pekaři Moravy a Slezska @ http://aleph.nkp.cz/F/?func=find-b&request=001854295&find_code=SYS&local_base=nkc
2009 @ 02 @ 21 @ Proměny @ http://aleph.nkp.cz/F/?func=find-b&request=001854016&find_code=SYS&local_base=nkc
2009 @ 02 @ 22 @ Suchohrdelský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001854036&find_code=SYS&local_base=nkc
2009 @ 02 @ 14 @ Naše Frýdecko-Místecko.cz @ http://aleph.nkp.cz/F/?func=find-b&request=001857205&find_code=SYS&local_base=nkc
2009 @ 02 @ 15 @ Naše obec : zpravodaj obce Poteč @ http://aleph.nkp.cz/F/?func=find-b&request=001854338&find_code=SYS&local_base=nkc
2009 @ 02 @ 13 @ Ledax news @ http://aleph.nkp.cz/F/?func=find-b&request=001857180&find_code=SYS&local_base=nkc
2009 @ 02 @ 09 @ Inside local government report @ http://aleph.nkp.cz/F/?func=find-b&request=001851869&find_code=SYS&local_base=nkc
2009 @ 02 @ 10 @ Journal of landscape ecology @ http://aleph.nkp.cz/F/?func=find-b&request=001854707&find_code=SYS&local_base=nkc
2009 @ 02 @ 11 @ Kolovratský @ http://aleph.nkp.cz/F/?func=find-b&request=001856995&find_code=SYS&local_base=nkc
2009 @ 02 @ 12 @ Kolovratský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001856993&find_code=SYS&local_base=nkc
2009 @ 02 @ 08 @ In touch @ http://aleph.nkp.cz/F/?func=find-b&request=001854739&find_code=SYS&local_base=nkc
2009 @ 02 @ 07 @ Frag @ http://aleph.nkp.cz/F/?func=find-b&request=001855236&find_code=SYS&local_base=nkc
2009 @ 02 @ 06 @ Droužkovický obecní zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001855050&find_code=SYS&local_base=nkc
2009 @ 02 @ 05 @ Dalovické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001855053&find_code=SYS&local_base=nkc
2009 @ 02 @ 04 @ Brána @ http://aleph.nkp.cz/F/?func=find-b&request=001857023&find_code=SYS&local_base=nkc
2009 @ 02 @ 00 @  @ 
2009 @ 02 @ 01 @ ABAS report @ http://aleph.nkp.cz/F/?func=find-b&request=001850688&find_code=SYS&local_base=nkc
2009 @ 02 @ 03 @ Běhej @ http://aleph.nkp.cz/F/?func=find-b&request=001854329&find_code=SYS&local_base=nkc
2009 @ 02 @ 02 @ Batelovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001851864&find_code=SYS&local_base=nkc
2009 @ 03 @ 46 @ Tvoje svatba @ http://aleph.nkp.cz/F/?func=find-b&request=001857622&find_code=SYS&local_base=nkc
2009 @ 03 @ 45 @ Tuning life @ http://aleph.nkp.cz/F/?func=find-b&request=001857593&find_code=SYS&local_base=nkc
2009 @ 03 @ 44 @ Th? gi?i tr? @ http://aleph.nkp.cz/F/?func=find-b&request=001860871&find_code=SYS&local_base=nkc
2009 @ 03 @ 43 @ Syninfo @ http://aleph.nkp.cz/F/?func=find-b&request=001859255&find_code=SYS&local_base=nkc
2009 @ 03 @ 42 @ Sudoku pro pokročilé @ http://aleph.nkp.cz/F/?func=find-b&request=001859781&find_code=SYS&local_base=nkc
2009 @ 03 @ 41 @ Stařečský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001859775&find_code=SYS&local_base=nkc
2009 @ 03 @ 40 @ Soudní tlumočník @ http://aleph.nkp.cz/F/?func=find-b&request=001863929&find_code=SYS&local_base=nkc
2009 @ 03 @ 39 @ Sociální služby @ http://aleph.nkp.cz/F/?func=find-b&request=001858703&find_code=SYS&local_base=nkc
2009 @ 03 @ 38 @ Rozvojovka @ http://aleph.nkp.cz/F/?func=find-b&request=001859400&find_code=SYS&local_base=nkc
2009 @ 03 @ 37 @ Rozhled @ http://aleph.nkp.cz/F/?func=find-b&request=001861629&find_code=SYS&local_base=nkc
2009 @ 03 @ 36 @ Recepty z kupé @ http://aleph.nkp.cz/F/?func=find-b&request=001864064&find_code=SYS&local_base=nkc
2009 @ 03 @ 35 @ Průhledy @ http://aleph.nkp.cz/F/?func=find-b&request=001861644&find_code=SYS&local_base=nkc
2009 @ 03 @ 34 @ Plzeňský rozhled @ http://aleph.nkp.cz/F/?func=find-b&request=001861630&find_code=SYS&local_base=nkc
2009 @ 03 @ 33 @ Písecký kalich @ http://aleph.nkp.cz/F/?func=find-b&request=001860475&find_code=SYS&local_base=nkc
2009 @ 03 @ 32 @ Parlamentní servis @ http://aleph.nkp.cz/F/?func=find-b&request=001857665&find_code=SYS&local_base=nkc
2009 @ 03 @ 31 @ On stage @ http://aleph.nkp.cz/F/?func=find-b&request=001861798&find_code=SYS&local_base=nkc
2009 @ 03 @ 30 @ Oční listy kliniky Horní Počernice @ http://aleph.nkp.cz/F/?func=find-b&request=001859377&find_code=SYS&local_base=nkc
2009 @ 03 @ 29 @ Nové Plzeňsko @ http://aleph.nkp.cz/F/?func=find-b&request=001857575&find_code=SYS&local_base=nkc
2009 @ 03 @ 28 @ Náš Zlín.cz @ http://aleph.nkp.cz/F/?func=find-b&request=001857610&find_code=SYS&local_base=nkc
2009 @ 03 @ 27 @ MVP mag @ http://aleph.nkp.cz/F/?func=find-b&request=001863827&find_code=SYS&local_base=nkc
2009 @ 03 @ 26 @ Muzeum : muzejní a vlastivědná práce @ http://aleph.nkp.cz/F/?func=find-b&request=001859415&find_code=SYS&local_base=nkc
2009 @ 03 @ 25 @ Karel Hynek Mácha @ http://aleph.nkp.cz/F/?func=find-b&request=001860639&find_code=SYS&local_base=nkc
2009 @ 03 @ 24 @ Kaleidoskop Středočeského kraje @ http://aleph.nkp.cz/F/?func=find-b&request=001859427&find_code=SYS&local_base=nkc
2009 @ 03 @ 23 @ Journal of technology and information education @ http://aleph.nkp.cz/F/?func=find-b&request=001858690&find_code=SYS&local_base=nkc
2009 @ 03 @ 22 @ Informace odborné knihovny MF @ http://aleph.nkp.cz/F/?func=find-b&request=001860415&find_code=SYS&local_base=nkc
2009 @ 03 @ 21 @ Homeopatické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001857583&find_code=SYS&local_base=nkc
2009 @ 03 @ 20 @ Handball plus @ http://aleph.nkp.cz/F/?func=find-b&request=001861633&find_code=SYS&local_base=nkc
2009 @ 03 @ 19 @ Freeski @ http://aleph.nkp.cz/F/?func=find-b&request=001857633&find_code=SYS&local_base=nkc
2009 @ 03 @ 18 @ Fotballady @ http://aleph.nkp.cz/F/?func=find-b&request=001858471&find_code=SYS&local_base=nkc
2009 @ 03 @ 17 @ Femina @ http://aleph.nkp.cz/F/?func=find-b&request=001861640&find_code=SYS&local_base=nkc
2009 @ 03 @ 16 @ Ekomonitor @ http://aleph.nkp.cz/F/?func=find-b&request=001861779&find_code=SYS&local_base=nkc
2009 @ 03 @ 15 @ Džbánovský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=001861046&find_code=SYS&local_base=nkc
2009 @ 03 @ 14 @ Dupito @ http://aleph.nkp.cz/F/?func=find-b&request=001864078&find_code=SYS&local_base=nkc
2009 @ 03 @ 13 @ Dobnet zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001859431&find_code=SYS&local_base=nkc
2010 @ 10 @ 19 @ Osmisměrky letem světem @ http://aleph.nkp.cz/F/?func=direct&doc_number=002130273&local_base=nkc
2009 @ 03 @ 12 @ Diana můj kreativní svět @ http://aleph.nkp.cz/F/?func=find-b&request=001858456&find_code=SYS&local_base=nkc
2009 @ 03 @ 11 @ Devítka @ http://aleph.nkp.cz/F/?func=find-b&request=001858712&find_code=SYS&local_base=nkc
2009 @ 03 @ 10 @ Česká judikatura @ http://aleph.nkp.cz/F/?func=find-b&request=001858745&find_code=SYS&local_base=nkc
2009 @ 03 @ 09 @ Červenoújezdský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001858461&find_code=SYS&local_base=nkc
2009 @ 03 @ 08 @ Církvické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001857635&find_code=SYS&local_base=nkc
2009 @ 03 @ 07 @ CIO business world @ http://aleph.nkp.cz/F/?func=find-b&request=001859120&find_code=SYS&local_base=nkc
2009 @ 03 @ 06 @ Cesty katecheze @ http://aleph.nkp.cz/F/?func=find-b&request=001860612&find_code=SYS&local_base=nkc
2009 @ 03 @ 05 @ Bulletin Technologického centra AV ČR @ http://aleph.nkp.cz/F/?func=find-b&request=001860263&find_code=SYS&local_base=nkc
2009 @ 03 @ 04 @ Berounský region @ http://aleph.nkp.cz/F/?func=find-b&request=001860313&find_code=SYS&local_base=nkc
2009 @ 03 @ 03 @ Aquaristik @ http://aleph.nkp.cz/F/?func=find-b&request=001859731&find_code=SYS&local_base=nkc
2009 @ 03 @ 02 @ Akustické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001861033&find_code=SYS&local_base=nkc
2009 @ 03 @ 00 @  @ 
2009 @ 03 @ 01 @ Acta Universitatis carolinae @ http://aleph.nkp.cz/F/?func=find-b&request=001863900&find_code=SYS&local_base=nkc
2009 @ 03 @ 49 @ Visions @ http://aleph.nkp.cz/F/?func=find-b&request=001861636&find_code=SYS&local_base=nkc
2009 @ 03 @ 50 @ Víte@ že : osmisměrky a spousta vtipů', 'http://aleph.nkp.cz/F/?func=find-b&request=001857638&find_code=SYS&local_base=nkc
2009 @ 03 @ 51 @ Zpravodaj městyse Malšice @ http://aleph.nkp.cz/F/?func=find-b&request=001859930&find_code=SYS&local_base=nkc
2009 @ 03 @ 52 @ Zpravodaj Obecního úřadu Čeledná @ http://aleph.nkp.cz/F/?func=find-b&request=001859224&find_code=SYS&local_base=nkc
2009 @ 03 @ 53 @ Zprávy České parazitologické společnosti @ http://aleph.nkp.cz/F/?func=find-b&request=001859747&find_code=SYS&local_base=nkc
2009 @ 03 @ 54 @ Zprávy epidemiologie a mikrobiologie @ http://aleph.nkp.cz/F/?func=find-b&request=001859934&find_code=SYS&local_base=nkc
2009 @ 03 @ 55 @ Zvonilka @ http://aleph.nkp.cz/F/?func=find-b&request=001858435&find_code=SYS&local_base=nkc
2009 @ 03 @ 56 @ Žurnál + @ http://aleph.nkp.cz/F/?func=find-b&request=001859113&find_code=SYS&local_base=nkc
2009 @ 04 @ 69 @ Zpravodaj místní akční skupiny Sdružení Růže @ http://aleph.nkp.cz/F/?func=find-b&request=001867701&find_code=SYS&local_base=nkc
2009 @ 04 @ 68 @ X press @ http://aleph.nkp.cz/F/?func=find-b&request=001865155&find_code=SYS&local_base=nkc
2009 @ 04 @ 67 @ Věci veřejné @ http://aleph.nkp.cz/F/?func=find-b&request=001926920&find_code=SYS&local_base=nkc
2009 @ 04 @ 66 @ Valašskobystřický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001864638&find_code=SYS&local_base=nkc
2009 @ 04 @ 65 @ The best woman @ http://aleph.nkp.cz/F/?func=find-b&request=001865141&find_code=SYS&local_base=nkc
2009 @ 04 @ 64 @ Svět pojištěnce @ http://aleph.nkp.cz/F/?func=find-b&request=001867691&find_code=SYS&local_base=nkc
2009 @ 04 @ 63 @ Sudoku ke kávě @ http://aleph.nkp.cz/F/?func=find-b&request=001867195&find_code=SYS&local_base=nkc
2009 @ 04 @ 62 @ Sudoku 60 @ http://aleph.nkp.cz/F/?func=find-b&request=001864700&find_code=SYS&local_base=nkc
2009 @ 04 @ 60 @ Selling @ http://aleph.nkp.cz/F/?func=find-b&request=001866138&find_code=SYS&local_base=nkc
2009 @ 04 @ 61 @ Studia kinanthropologica @ http://aleph.nkp.cz/F/?func=find-b&request=001926691&find_code=SYS&local_base=nkc
2009 @ 04 @ 59 @ Sedmička @ http://aleph.nkp.cz/F/?func=find-b&request=001927103&find_code=SYS&local_base=nkc
2009 @ 04 @ 58 @ Sabrina : háčkovaná móda pro ženy @ http://aleph.nkp.cz/F/?func=find-b&request=001926494&find_code=SYS&local_base=nkc
2009 @ 04 @ 57 @ Řemeslo žije! @ http://aleph.nkp.cz/F/?func=find-b&request=001868332&find_code=SYS&local_base=nkc
2009 @ 04 @ 56 @ Report Liberec 2009 @ http://aleph.nkp.cz/F/?func=find-b&request=001865177&find_code=SYS&local_base=nkc
2009 @ 04 @ 54 @ Púova školka @ http://aleph.nkp.cz/F/?func=find-b&request=001927096&find_code=SYS&local_base=nkc
2009 @ 04 @ 55 @ RE/MAX magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001926470&find_code=SYS&local_base=nkc
2009 @ 04 @ 53 @ Psychosom @ http://aleph.nkp.cz/F/?func=find-b&request=001864682&find_code=SYS&local_base=nkc
2009 @ 04 @ 52 @ Přísloví v křížovkách @ http://aleph.nkp.cz/F/?func=find-b&request=001866140&find_code=SYS&local_base=nkc
2009 @ 04 @ 51 @ Průmyslové inženýrství @ http://aleph.nkp.cz/F/?func=find-b&request=001864928&find_code=SYS&local_base=nkc
2009 @ 04 @ 50 @ Plumlovské ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=001866310&find_code=SYS&local_base=nkc
2009 @ 04 @ 49 @ P-fórum @ http://aleph.nkp.cz/F/?func=find-b&request=001865949&find_code=SYS&local_base=nkc
2009 @ 04 @ 47 @ Obecní čtyřlístek @ http://aleph.nkp.cz/F/?func=find-b&request=001867307&find_code=SYS&local_base=nkc
2009 @ 04 @ 48 @ One @ http://aleph.nkp.cz/F/?func=find-b&request=001864699&find_code=SYS&local_base=nkc
2009 @ 04 @ 46 @ Nevecomtip @ http://aleph.nkp.cz/F/?func=find-b&request=001866762&find_code=SYS&local_base=nkc
2009 @ 04 @ 45 @ Musicalia @ http://aleph.nkp.cz/F/?func=find-b&request=001866354&find_code=SYS&local_base=nkc
2009 @ 04 @ 43 @ Moje rodina @ http://aleph.nkp.cz/F/?func=find-b&request=001926479&find_code=SYS&local_base=nkc
2009 @ 04 @ 42 @ Místní informační zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001866744&find_code=SYS&local_base=nkc
2009 @ 04 @ 41 @ Mirošovské střípky @ http://aleph.nkp.cz/F/?func=find-b&request=001866722&find_code=SYS&local_base=nkc
2009 @ 04 @ 40 @ McSport @ http://aleph.nkp.cz/F/?func=find-b&request=001865944&find_code=SYS&local_base=nkc
2009 @ 04 @ 39 @ Marvel heroes @ http://aleph.nkp.cz/F/?func=find-b&request=001867840&find_code=SYS&local_base=nkc
2009 @ 04 @ 38 @ Magazín obchodního centra Central Most @ http://aleph.nkp.cz/F/?func=find-b&request=001866905&find_code=SYS&local_base=nkc
2009 @ 04 @ 37 @ Magazín OD Kotva @ http://aleph.nkp.cz/F/?func=find-b&request=001867855&find_code=SYS&local_base=nkc
2009 @ 04 @ 36 @ M.B.L. @ http://aleph.nkp.cz/F/?func=find-b&request=001865675&find_code=SYS&local_base=nkc
2009 @ 04 @ 35 @ Lovčický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001867327&find_code=SYS&local_base=nkc
2009 @ 04 @ 34 @ Linka bezpečí @ http://aleph.nkp.cz/F/?func=find-b&request=001927107&find_code=SYS&local_base=nkc
2009 @ 04 @ 33 @ Kuriozity a zajímavosti ze světa @ http://aleph.nkp.cz/F/?func=find-b&request=001864624&find_code=SYS&local_base=nkc
2009 @ 04 @ 32 @ Křížovky mix @ http://aleph.nkp.cz/F/?func=find-b&request=001927112&find_code=SYS&local_base=nkc
2009 @ 04 @ 31 @ Kouzelná školka @ http://aleph.nkp.cz/F/?func=find-b&request=001866627&find_code=SYS&local_base=nkc
2009 @ 04 @ 30 @ Kontexty @ http://aleph.nkp.cz/F/?func=find-b&request=001865921&find_code=SYS&local_base=nkc
2009 @ 04 @ 29 @ Kolkovna friends @ http://aleph.nkp.cz/F/?func=find-b&request=001927156&find_code=SYS&local_base=nkc
2009 @ 04 @ 28 @ Knaufstyl @ http://aleph.nkp.cz/F/?func=find-b&request=001867702&find_code=SYS&local_base=nkc
2009 @ 04 @ 27 @ Klínecké noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001926936&find_code=SYS&local_base=nkc
2009 @ 04 @ 26 @ Kapitoly z kardiologie pro praktické lékaře @ http://aleph.nkp.cz/F/?func=find-b&request=001867965&find_code=SYS&local_base=nkc
2009 @ 04 @ 25 @ Jtekt zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001867354&find_code=SYS&local_base=nkc
2009 @ 04 @ 24 @ Jičínský čtvrtletník @ http://aleph.nkp.cz/F/?func=find-b&request=001866628&find_code=SYS&local_base=nkc
2009 @ 04 @ 23 @ Jetix @ http://aleph.nkp.cz/F/?func=find-b&request=001864618&find_code=SYS&local_base=nkc
2009 @ 04 @ 22 @ Inzert servis @ http://aleph.nkp.cz/F/?func=find-b&request=001926921&find_code=SYS&local_base=nkc
2009 @ 04 @ 21 @ Image @ http://aleph.nkp.cz/F/?func=find-b&request=001926925&find_code=SYS&local_base=nkc
2009 @ 04 @ 20 @ Hornický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001926956&find_code=SYS&local_base=nkc
2009 @ 04 @ 19 @ H.O.M.I.E. @ http://aleph.nkp.cz/F/?func=find-b&request=001867194&find_code=SYS&local_base=nkc
2009 @ 04 @ 18 @ Gastrotrend @ http://aleph.nkp.cz/F/?func=find-b&request=001867317&find_code=SYS&local_base=nkc
2009 @ 04 @ 17 @ Facility manager @ http://aleph.nkp.cz/F/?func=find-b&request=001867187&find_code=SYS&local_base=nkc
2009 @ 04 @ 16 @ Ekonomika a management @ http://aleph.nkp.cz/F/?func=find-b&request=001864911&find_code=SYS&local_base=nkc
2009 @ 04 @ 15 @ Duchovní střípky @ http://aleph.nkp.cz/F/?func=find-b&request=001866912&find_code=SYS&local_base=nkc
2009 @ 04 @ 14 @ Dřevo & stavby pro bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=001926490&find_code=SYS&local_base=nkc
2009 @ 04 @ 13 @ Dílčák @ http://aleph.nkp.cz/F/?func=find-b&request=001926926&find_code=SYS&local_base=nkc
2009 @ 04 @ 12 @ Diana : nové trendy @ http://aleph.nkp.cz/F/?func=find-b&request=001865165&find_code=SYS&local_base=nkc
2009 @ 04 @ 11 @ Dialog @ http://aleph.nkp.cz/F/?func=find-b&request=001868307&find_code=SYS&local_base=nkc
2009 @ 04 @ 10 @ Dětská výživa dnes @ http://aleph.nkp.cz/F/?func=find-b&request=001865146&find_code=SYS&local_base=nkc
2009 @ 04 @ 09 @ Ďáblické fórum @ http://aleph.nkp.cz/F/?func=find-b&request=001866734&find_code=SYS&local_base=nkc
2009 @ 04 @ 08 @ Current opinion in hematology @ http://aleph.nkp.cz/F/?func=find-b&request=001867967&find_code=SYS&local_base=nkc
2009 @ 04 @ 07 @ CSS listy @ http://aleph.nkp.cz/F/?func=find-b&request=001867582&find_code=SYS&local_base=nkc
2009 @ 04 @ 06 @ Bydlete s RCB @ http://aleph.nkp.cz/F/?func=find-b&request=001867931&find_code=SYS&local_base=nkc
2009 @ 04 @ 05 @ Business panorama @ http://aleph.nkp.cz/F/?func=find-b&request=001926909&find_code=SYS&local_base=nkc
2009 @ 04 @ 04 @ Bohemica Olomucensia @ http://aleph.nkp.cz/F/?func=find-b&request=001867669&find_code=SYS&local_base=nkc
2009 @ 04 @ 03 @ Biblické křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001864129&find_code=SYS&local_base=nkc
2009 @ 04 @ 02 @ AMB @ http://aleph.nkp.cz/F/?func=find-b&request=001926740&find_code=SYS&local_base=nkc
2009 @ 04 @ 00 @  @ 
2009 @ 04 @ 01 @ Allegro @ http://aleph.nkp.cz/F/?func=find-b&request=001926919&find_code=SYS&local_base=nkc
2009 @ 04 @ 70 @ Zpravodaj městyse Brozany nad Ohří @ http://aleph.nkp.cz/F/?func=find-b&request=001867698&find_code=SYS&local_base=nkc
2009 @ 04 @ 71 @ Zpravodaj obce Francova Lhota @ http://aleph.nkp.cz/F/?func=find-b&request=001867810&find_code=SYS&local_base=nkc
2009 @ 04 @ 72 @ Zpravodaj obce Podolí @ http://aleph.nkp.cz/F/?func=find-b&request=001867981&find_code=SYS&local_base=nkc
2009 @ 04 @ 73 @ Živé pomezí @ http://aleph.nkp.cz/F/?func=find-b&request=001867979&find_code=SYS&local_base=nkc
2009 @ 04 @ 74 @ Životní moudra : osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001865934&find_code=SYS&local_base=nkc
2009 @ 04 @ 75 @ Životní moudra slavných @ http://aleph.nkp.cz/F/?func=find-b&request=001865935&find_code=SYS&local_base=nkc
2009 @ 05 @ 00 @  @ 
2009 @ 05 @ 01 @ 53x11 : časopis silniční cyklistiky @ http://aleph.nkp.cz/F/?func=find-b&request=001930968&find_code=SYS&local_base=nkc
2009 @ 05 @ 02 @ Amond magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001930987&find_code=SYS&local_base=nkc
2009 @ 05 @ 03 @ Auto Heller @ http://aleph.nkp.cz/F/?func=find-b&request=001930593&find_code=SYS&local_base=nkc
2009 @ 05 @ 04 @ Auto-Exner magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001927478&find_code=SYS&local_base=nkc
2009 @ 05 @ 05 @ Camic magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001930591&find_code=SYS&local_base=nkc
2009 @ 05 @ 06 @ Československá mladá pravda @ http://aleph.nkp.cz/F/?func=find-b&request=001929648&find_code=SYS&local_base=nkc
2009 @ 05 @ 07 @ Dovolená v Čechách @ http://aleph.nkp.cz/F/?func=find-b&request=001928397&find_code=SYS&local_base=nkc
2009 @ 05 @ 08 @ Dysport Bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=001928390&find_code=SYS&local_base=nkc
2009 @ 05 @ 09 @ Ekologické listy @ http://aleph.nkp.cz/F/?func=find-b&request=001929664&find_code=SYS&local_base=nkc
2009 @ 05 @ 10 @ Flash @ http://aleph.nkp.cz/F/?func=find-b&request=001929876&find_code=SYS&local_base=nkc
2009 @ 05 @ 11 @ Globe revue @ http://aleph.nkp.cz/F/?func=find-b&request=001930579&find_code=SYS&local_base=nkc
2009 @ 05 @ 12 @ Grand life @ http://aleph.nkp.cz/F/?func=find-b&request=001930944&find_code=SYS&local_base=nkc
2009 @ 05 @ 13 @ Hasičské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001930370&find_code=SYS&local_base=nkc
2009 @ 05 @ 14 @ Hradčanské rozhledy @ http://aleph.nkp.cz/F/?func=find-b&request=001930375&find_code=SYS&local_base=nkc
2009 @ 05 @ 15 @ InStyle @ http://aleph.nkp.cz/F/?func=find-b&request=001927799&find_code=SYS&local_base=nkc
2009 @ 05 @ 16 @ Kouzelná orchidea @ http://aleph.nkp.cz/F/?func=find-b&request=001929657&find_code=SYS&local_base=nkc
2009 @ 05 @ 17 @ Královédvorský magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001929461&find_code=SYS&local_base=nkc
2009 @ 05 @ 18 @ Lednicko-valtický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001930956&find_code=SYS&local_base=nkc
2009 @ 05 @ 19 @ Moravskou cestou @ http://aleph.nkp.cz/F/?func=find-b&request=001929873&find_code=SYS&local_base=nkc
2009 @ 05 @ 20 @ My life @ http://aleph.nkp.cz/F/?func=find-b&request=001929875&find_code=SYS&local_base=nkc
2009 @ 05 @ 21 @ Na Vyškovsku @ http://aleph.nkp.cz/F/?func=find-b&request=001929465&find_code=SYS&local_base=nkc
2009 @ 05 @ 22 @ Nadační bulletin Fóra dárců @ http://aleph.nkp.cz/F/?func=find-b&request=001928841&find_code=SYS&local_base=nkc
2009 @ 05 @ 23 @ Napínavé osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=001927811&find_code=SYS&local_base=nkc
2009 @ 05 @ 24 @ Nemocniční zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001929473&find_code=SYS&local_base=nkc
2009 @ 05 @ 25 @ Pražskij telegraf @ http://aleph.nkp.cz/F/?func=find-b&request=001928669&find_code=SYS&local_base=nkc
2009 @ 05 @ 26 @ Rajhradský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001927493&find_code=SYS&local_base=nkc
2009 @ 05 @ 27 @ Rodina & finance @ http://aleph.nkp.cz/F/?func=find-b&request=001928651&find_code=SYS&local_base=nkc
2009 @ 05 @ 28 @ Říčanské klepeto @ http://aleph.nkp.cz/F/?func=find-b&request=001930951&find_code=SYS&local_base=nkc
2009 @ 05 @ 29 @ Strakonicko : týdeník @ http://aleph.nkp.cz/F/?func=find-b&request=001930380&find_code=SYS&local_base=nkc
2009 @ 05 @ 30 @ Struhařovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001928400&find_code=SYS&local_base=nkc
2009 @ 05 @ 31 @ Styxus @ http://aleph.nkp.cz/F/?func=find-b&request=001928853&find_code=SYS&local_base=nkc
2009 @ 05 @ 32 @ Škorcová@ s.r.o : kraj Jihomoravský', 'http://aleph.nkp.cz/F/?func=find-b&request=001928598&find_code=SYS&local_base=nkc
2009 @ 05 @ 33 @ Zpravodaj města Radnic @ http://aleph.nkp.cz/F/?func=find-b&request=001930971&find_code=SYS&local_base=nkc
2009 @ 06 @ 37 @ Štamgast & gurmán @ http://aleph.nkp.cz/F/?func=find-b&request=001931091&find_code=SYS&local_base=nkc
2009 @ 06 @ 36 @ Šepoty greenů @ http://aleph.nkp.cz/F/?func=find-b&request=001962242&find_code=SYS&local_base=nkc
2009 @ 06 @ 35 @ Svět průmyslu @ http://aleph.nkp.cz/F/?func=find-b&request=001962873&find_code=SYS&local_base=nkc
2009 @ 06 @ 34 @ Svet pravoslavija @ http://aleph.nkp.cz/F/?func=find-b&request=001963110&find_code=SYS&local_base=nkc
2009 @ 06 @ 33 @ Sudoku 88x @ http://aleph.nkp.cz/F/?func=find-b&request=001931845&find_code=SYS&local_base=nkc
2009 @ 06 @ 32 @ Středoevropské sešity @ http://aleph.nkp.cz/F/?func=find-b&request=001964052&find_code=SYS&local_base=nkc
2009 @ 06 @ 31 @ Stonařovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001931735&find_code=SYS&local_base=nkc
2010 @ 10 @ 18 @ Obchodní centrum Zlín aktuálně @ http://aleph.nkp.cz/F/?func=direct&doc_number=002130289&local_base=nkc
2009 @ 06 @ 30 @ Spolu @ http://aleph.nkp.cz/F/?func=find-b&request=001931291&find_code=SYS&local_base=nkc
2009 @ 06 @ 29 @ Senator Travel report @ http://aleph.nkp.cz/F/?func=find-b&request=001931096&find_code=SYS&local_base=nkc
2009 @ 06 @ 28 @ Rockwoolák @ http://aleph.nkp.cz/F/?func=find-b&request=001962250&find_code=SYS&local_base=nkc
2009 @ 06 @ 27 @ Rádce @ http://aleph.nkp.cz/F/?func=find-b&request=001963482&find_code=SYS&local_base=nkc
2009 @ 06 @ 26 @ Poustevník @ http://aleph.nkp.cz/F/?func=find-b&request=001931439&find_code=SYS&local_base=nkc
2009 @ 06 @ 25 @ Plzeň Comeback @ http://aleph.nkp.cz/F/?func=find-b&request=001964333&find_code=SYS&local_base=nkc
2009 @ 06 @ 24 @ Pieta @ http://aleph.nkp.cz/F/?func=find-b&request=001931282&find_code=SYS&local_base=nkc
2009 @ 06 @ 23 @ Osmisměrky na zimu a Vánoce @ http://aleph.nkp.cz/F/?func=find-b&request=001931426&find_code=SYS&local_base=nkc
2009 @ 06 @ 22 @ Ondřejnická oáza @ http://aleph.nkp.cz/F/?func=find-b&request=001963087&find_code=SYS&local_base=nkc
2009 @ 06 @ 21 @ Magazín receptů @ http://aleph.nkp.cz/F/?func=find-b&request=001963511&find_code=SYS&local_base=nkc
2009 @ 06 @ 19 @ Lékařské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001964495&find_code=SYS&local_base=nkc
2009 @ 06 @ 18 @ Leaders @ http://aleph.nkp.cz/F/?func=find-b&request=001964511&find_code=SYS&local_base=nkc
2009 @ 06 @ 17 @ Kvalita pro život @ http://aleph.nkp.cz/F/?func=find-b&request=001931929&find_code=SYS&local_base=nkc
2009 @ 06 @ 16 @ Křížovky s mazlíčky @ http://aleph.nkp.cz/F/?func=find-b&request=001931295&find_code=SYS&local_base=nkc
2009 @ 06 @ 15 @ Krajem svatého Antonínka @ http://aleph.nkp.cz/F/?func=find-b&request=001931451&find_code=SYS&local_base=nkc
2009 @ 06 @ 14 @ Klatovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001963771&find_code=SYS&local_base=nkc
2009 @ 06 @ 13 @ Journal of clinical oncology @ http://aleph.nkp.cz/F/?func=find-b&request=001962026&find_code=SYS&local_base=nkc
2009 @ 06 @ 12 @ Inside IT @ http://aleph.nkp.cz/F/?func=find-b&request=001961251&find_code=SYS&local_base=nkc
2009 @ 06 @ 11 @ Home tip @ http://aleph.nkp.cz/F/?func=find-b&request=001963737&find_code=SYS&local_base=nkc
2009 @ 06 @ 10 @ HardRocker @ http://aleph.nkp.cz/F/?func=find-b&request=001963533&find_code=SYS&local_base=nkc
2009 @ 06 @ 09 @ Hannah Montana @ http://aleph.nkp.cz/F/?func=find-b&request=001962405&find_code=SYS&local_base=nkc
2009 @ 06 @ 20 @ Esprit @ http://aleph.nkp.cz/F/?func=find-b&request=001962850&find_code=SYS&local_base=nkc
2009 @ 06 @ 08 @ Dobrý nákup @ http://aleph.nkp.cz/F/?func=find-b&request=001963767&find_code=SYS&local_base=nkc
2009 @ 06 @ 07 @ Čiperka @ http://aleph.nkp.cz/F/?func=find-b&request=001963464&find_code=SYS&local_base=nkc
2009 @ 06 @ 06 @ Czech focus @ http://aleph.nkp.cz/F/?func=find-b&request=001962238&find_code=SYS&local_base=nkc
2009 @ 06 @ 05 @ Cooper standard Automotive @ http://aleph.nkp.cz/F/?func=find-b&request=001963980&find_code=SYS&local_base=nkc
2009 @ 06 @ 04 @ Bulletin : Společnost česko-arabská @ http://aleph.nkp.cz/F/?func=find-b&request=001931087&find_code=SYS&local_base=nkc
2009 @ 06 @ 03 @ Brepta @ http://aleph.nkp.cz/F/?func=find-b&request=001963516&find_code=SYS&local_base=nkc
2009 @ 06 @ 02 @ Beskydy tourist info @ http://aleph.nkp.cz/F/?func=find-b&request=001964334&find_code=SYS&local_base=nkc
2009 @ 06 @ 00 @  @ 
2009 @ 06 @ 01 @ Baptistic theologies @ http://aleph.nkp.cz/F/?func=find-b&request=001931946&find_code=SYS&local_base=nkc
2009 @ 06 @ 38 @ Techmaniak @ http://aleph.nkp.cz/F/?func=find-b&request=001962350&find_code=SYS&local_base=nkc
2009 @ 06 @ 39 @ T-way @ http://aleph.nkp.cz/F/?func=find-b&request=001963123&find_code=SYS&local_base=nkc
2009 @ 06 @ 40 @ Větrník @ http://aleph.nkp.cz/F/?func=find-b&request=001963065&find_code=SYS&local_base=nkc
2009 @ 06 @ 41 @ Vítonický čáp @ http://aleph.nkp.cz/F/?func=find-b&request=001962874&find_code=SYS&local_base=nkc
2009 @ 06 @ 42 @ Wild cat @ http://aleph.nkp.cz/F/?func=find-b&request=001962857&find_code=SYS&local_base=nkc
2009 @ 06 @ 43 @ Zdravotnické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001964485&find_code=SYS&local_base=nkc
2009 @ 06 @ 44 @ Zpravodaj obce Rudná pod Pradědem @ http://aleph.nkp.cz/F/?func=find-b&request=001962660&find_code=SYS&local_base=nkc
2009 @ 07 @ 00 @  @ 
2009 @ 07 @ 01 @ Andragogické noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001967036&find_code=SYS&local_base=nkc
2009 @ 07 @ 02 @ Apropo @ http://aleph.nkp.cz/F/?func=find-b&request=001968230&find_code=SYS&local_base=nkc
2009 @ 07 @ 03 @ Brünner Hefte zu Deutsch als Fremsprache @ http://aleph.nkp.cz/F/?func=find-b&request=001966124&find_code=SYS&local_base=nkc
2009 @ 07 @ 04 @ Budoucnost církve @ http://aleph.nkp.cz/F/?func=find-b&request=001964729&find_code=SYS&local_base=nkc
2009 @ 07 @ 05 @ C plus @ http://aleph.nkp.cz/F/?func=find-b&request=001967407&find_code=SYS&local_base=nkc
2009 @ 07 @ 06 @ Čuřina @ http://aleph.nkp.cz/F/?func=find-b&request=001966945&find_code=SYS&local_base=nkc
2009 @ 07 @ 07 @ Dobrušský list @ http://aleph.nkp.cz/F/?func=find-b&request=001967439&find_code=SYS&local_base=nkc
2009 @ 07 @ 08 @ Energetická bezpečnost Kaspického regionu @ http://aleph.nkp.cz/F/?func=find-b&request=001968541&find_code=SYS&local_base=nkc
2009 @ 07 @ 09 @ Enter @ http://aleph.nkp.cz/F/?func=find-b&request=001966333&find_code=SYS&local_base=nkc
2009 @ 07 @ 10 @ Fénix express @ http://aleph.nkp.cz/F/?func=find-b&request=001967019&find_code=SYS&local_base=nkc
2009 @ 07 @ 11 @ Fontána style @ http://aleph.nkp.cz/F/?func=find-b&request=001965201&find_code=SYS&local_base=nkc
2009 @ 07 @ 12 @ Girenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001968101&find_code=SYS&local_base=nkc
2009 @ 07 @ 13 @ Grygovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001966931&find_code=SYS&local_base=nkc
2009 @ 07 @ 14 @ Hudební návraty : křížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001968077&find_code=SYS&local_base=nkc
2009 @ 07 @ 15 @ Industry Fórum @ http://aleph.nkp.cz/F/?func=find-b&request=001967230&find_code=SYS&local_base=nkc
2009 @ 07 @ 16 @ Interface @ http://aleph.nkp.cz/F/?func=find-b&request=001965169&find_code=SYS&local_base=nkc
2009 @ 07 @ 17 @ Inzerce Trutnovsko @ http://aleph.nkp.cz/F/?func=find-b&request=001964687&find_code=SYS&local_base=nkc
2009 @ 07 @ 18 @ Jablonecký zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001964997&find_code=SYS&local_base=nkc
2009 @ 07 @ 19 @ Krásnoočko @ http://aleph.nkp.cz/F/?func=find-b&request=001966953&find_code=SYS&local_base=nkc
2009 @ 07 @ 20 @ Kredit @ http://aleph.nkp.cz/F/?func=find-b&request=001964723&find_code=SYS&local_base=nkc
2009 @ 07 @ 21 @ Lestkovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001968316&find_code=SYS&local_base=nkc
2009 @ 07 @ 22 @ Machining and tooling @ http://aleph.nkp.cz/F/?func=find-b&request=001964969&find_code=SYS&local_base=nkc
2009 @ 07 @ 23 @ McNoviny @ http://aleph.nkp.cz/F/?func=find-b&request=001965862&find_code=SYS&local_base=nkc
2009 @ 07 @ 24 @ Naše adresa : Bílina @ http://aleph.nkp.cz/F/?func=find-b&request=001966585&find_code=SYS&local_base=nkc
2009 @ 07 @ 25 @ Naše adresa : Bystřicko @ http://aleph.nkp.cz/F/?func=find-b&request=001966570&find_code=SYS&local_base=nkc
2009 @ 07 @ 26 @ Naše adresa : Holešovsko @ http://aleph.nkp.cz/F/?func=find-b&request=001966571&find_code=SYS&local_base=nkc
2009 @ 07 @ 27 @ Naše adresa : Kroměřížsko @ http://aleph.nkp.cz/F/?func=find-b&request=001966572&find_code=SYS&local_base=nkc
2009 @ 07 @ 28 @ Naše adresa : Olomouc @ http://aleph.nkp.cz/F/?func=find-b&request=001966573&find_code=SYS&local_base=nkc
2009 @ 07 @ 29 @ Naše adresa : Teplicko @ http://aleph.nkp.cz/F/?func=find-b&request=001966584&find_code=SYS&local_base=nkc
2009 @ 07 @ 30 @ Naše adresa : Ústí @ http://aleph.nkp.cz/F/?func=find-b&request=001966569&find_code=SYS&local_base=nkc
2009 @ 07 @ 31 @ Naše noviny @ http://aleph.nkp.cz/F/?func=find-b&request=001964768&find_code=SYS&local_base=nkc
2009 @ 07 @ 32 @ Naše tv @ http://aleph.nkp.cz/F/?func=find-b&request=001966567&find_code=SYS&local_base=nkc
2009 @ 07 @ 33 @ Olešenský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001965219&find_code=SYS&local_base=nkc
2009 @ 07 @ 34 @ Osmisměrky Xénie @ http://aleph.nkp.cz/F/?func=find-b&request=001966170&find_code=SYS&local_base=nkc
2009 @ 07 @ 35 @ Prague monitor @ http://aleph.nkp.cz/F/?func=find-b&request=001965900&find_code=SYS&local_base=nkc
2009 @ 07 @ 36 @ Progress @ http://aleph.nkp.cz/F/?func=find-b&request=001965000&find_code=SYS&local_base=nkc
2009 @ 07 @ 37 @ Příbramské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001966911&find_code=SYS&local_base=nkc
2009 @ 07 @ 38 @ Rady našich babiček s křížovkami @ http://aleph.nkp.cz/F/?func=find-b&request=001966153&find_code=SYS&local_base=nkc
2009 @ 07 @ 39 @ Realitkacs.cz @ http://aleph.nkp.cz/F/?func=find-b&request=001965628&find_code=SYS&local_base=nkc
2009 @ 07 @ 40 @ Region revue @ http://aleph.nkp.cz/F/?func=find-b&request=001965199&find_code=SYS&local_base=nkc
2009 @ 07 @ 41 @ Rezonance @ http://aleph.nkp.cz/F/?func=find-b&request=001965841&find_code=SYS&local_base=nkc
2009 @ 07 @ 42 @ Rodinka @ http://aleph.nkp.cz/F/?func=find-b&request=001967244&find_code=SYS&local_base=nkc
2009 @ 07 @ 43 @ Sibyla @ http://aleph.nkp.cz/F/?func=find-b&request=001965903&find_code=SYS&local_base=nkc
2009 @ 07 @ 44 @ Smiřický infoservis @ http://aleph.nkp.cz/F/?func=find-b&request=001966721&find_code=SYS&local_base=nkc
2009 @ 07 @ 45 @ Sportzóna @ http://aleph.nkp.cz/F/?func=find-b&request=001965217&find_code=SYS&local_base=nkc
2009 @ 07 @ 46 @ Súčasná klinická prax @ http://aleph.nkp.cz/F/?func=find-b&request=001967238&find_code=SYS&local_base=nkc
2009 @ 07 @ 47 @ Synergie @ http://aleph.nkp.cz/F/?func=find-b&request=001966747&find_code=SYS&local_base=nkc
2009 @ 07 @ 48 @ Tourist newspaper for the region of Eastern Bohemia @ http://aleph.nkp.cz/F/?func=find-b&request=001965045&find_code=SYS&local_base=nkc
2009 @ 07 @ 49 @ Touristenzeitung für die Region Ostböhmen @ http://aleph.nkp.cz/F/?func=find-b&request=001965043&find_code=SYS&local_base=nkc
2009 @ 07 @ 50 @ Turistické noviny pro region východní Čechy @ http://aleph.nkp.cz/F/?func=find-b&request=001965042&find_code=SYS&local_base=nkc
2009 @ 07 @ 51 @ Válka revue @ http://aleph.nkp.cz/F/?func=find-b&request=001965879&find_code=SYS&local_base=nkc
2009 @ 07 @ 52 @ ViaReality : katalog nemovitostí : Jižní Čechy @ http://aleph.nkp.cz/F/?func=find-b&request=001965422&find_code=SYS&local_base=nkc
2009 @ 07 @ 53 @ ViaReality : katalog nemovitostí : Střední Morava @ http://aleph.nkp.cz/F/?func=find-b&request=001965419&find_code=SYS&local_base=nkc
2009 @ 07 @ 54 @ ViaReality : katalog nemovitostí : Východní Čechy @ http://aleph.nkp.cz/F/?func=find-b&request=001965421&find_code=SYS&local_base=nkc
2009 @ 07 @ 55 @ ViaReality : katalog nemovitostí : Západní Čechy @ http://aleph.nkp.cz/F/?func=find-b&request=001965420&find_code=SYS&local_base=nkc
2009 @ 07 @ 56 @ ViaReality : katalog nemovitostí : Zlínský kraj @ http://aleph.nkp.cz/F/?func=find-b&request=001965423&find_code=SYS&local_base=nkc
2009 @ 07 @ 57 @ Vysočina city @ http://aleph.nkp.cz/F/?func=find-b&request=001967211&find_code=SYS&local_base=nkc
2009 @ 07 @ 58 @ Wiadomości turystyczne dla regionu Wschodnich Czech @ http://aleph.nkp.cz/F/?func=find-b&request=001965046&find_code=SYS&local_base=nkc
2009 @ 07 @ 59 @ Zdibské info @ http://aleph.nkp.cz/F/?func=find-b&request=001965655&find_code=SYS&local_base=nkc
2009 @ 07 @ 60 @ Zpravodaj Anthroposofické společnosti v ČR @ http://aleph.nkp.cz/F/?func=find-b&request=001967055&find_code=SYS&local_base=nkc
2009 @ 07 @ 61 @ Zpravodaj Historického klubu @ http://aleph.nkp.cz/F/?func=find-b&request=001965615&find_code=SYS&local_base=nkc
2009 @ 08 @ 08 @ Nedvižimost’ v Čechii @ http://aleph.nkp.cz/F/?func=find-b&request=001970338&find_code=SYS&local_base=nkc
2009 @ 08 @ 07 @ Mendel green @ http://aleph.nkp.cz/F/?func=find-b&request=001970305&find_code=SYS&local_base=nkc
2009 @ 08 @ 06 @ Maxim fashion @ http://aleph.nkp.cz/F/?func=find-b&request=001970649&find_code=SYS&local_base=nkc
2009 @ 08 @ 05 @ L’Oréal Paris magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001970485&find_code=SYS&local_base=nkc
2009 @ 08 @ 04 @ Krašovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001970319&find_code=SYS&local_base=nkc
2009 @ 08 @ 03 @ Futurum magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001970514&find_code=SYS&local_base=nkc
2009 @ 08 @ 02 @ Dráha revue @ http://aleph.nkp.cz/F/?func=find-b&request=001970756&find_code=SYS&local_base=nkc
2009 @ 08 @ 00 @ Adrenaline!!! Magazine @ http://aleph.nkp.cz/F/?func=find-b&request=001970317&find_code=SYS&local_base=nkc
2009 @ 08 @ 09 @ NemMagazín @ http://aleph.nkp.cz/F/?func=find-b&request=001970504&find_code=SYS&local_base=nkc
2009 @ 08 @ 10 @ Nové břehy @ http://aleph.nkp.cz/F/?func=find-b&request=001970300&find_code=SYS&local_base=nkc
2010 @ 10 @ 17 @ Natnamada @ http://aleph.nkp.cz/F/?func=direct&doc_number=002133226&local_base=nkc
2009 @ 09 @ 13 @ Vlaštovička @ http://aleph.nkp.cz/F/?func=find-b&request=001990414&find_code=SYS&local_base=nkc
2009 @ 09 @ 12 @ Veselé barvičky @ http://aleph.nkp.cz/F/?func=find-b&request=001991991&find_code=SYS&local_base=nkc
2009 @ 09 @ 11 @ Trendy ekonomiky a managementu @ http://aleph.nkp.cz/F/?func=find-b&request=001990909&find_code=SYS&local_base=nkc
2009 @ 09 @ 09 @ Revue Borská pole @ http://aleph.nkp.cz/F/?func=find-b&request=001992047&find_code=SYS&local_base=nkc
2009 @ 09 @ 10 @ Sborník muzea dělnického hnutí @ http://aleph.nkp.cz/F/?func=find-b&request=001996464&find_code=SYS&local_base=nkc
2009 @ 09 @ 08 @ Oko magazín @ http://aleph.nkp.cz/F/?func=find-b&request=001992836&find_code=SYS&local_base=nkc
2009 @ 09 @ 07 @ Novinky @ http://aleph.nkp.cz/F/?func=find-b&request=001990252&find_code=SYS&local_base=nkc
2009 @ 09 @ 06 @ Naše hospoda @ http://aleph.nkp.cz/F/?func=find-b&request=001990420&find_code=SYS&local_base=nkc
2009 @ 09 @ 04 @ Mariánská zahrada @ http://aleph.nkp.cz/F/?func=find-b&request=001997436&find_code=SYS&local_base=nkc
2009 @ 09 @ 05 @ My a svět @ http://aleph.nkp.cz/F/?func=find-b&request=001992043&find_code=SYS&local_base=nkc
2009 @ 09 @ 03 @ Elle decor @ http://aleph.nkp.cz/F/?func=find-b&request=001996596&find_code=SYS&local_base=nkc
2009 @ 09 @ 02 @ Bio & Natur @ http://aleph.nkp.cz/F/?func=find-b&request=001996599&find_code=SYS&local_base=nkc
2009 @ 09 @ 00 @  @ 
2009 @ 09 @ 01 @ Barvičky plus @ http://aleph.nkp.cz/F/?func=find-b&request=001991989&find_code=SYS&local_base=nkc
2009 @ 10 @ 22 @ Ústecký kraj @ http://aleph.nkp.cz/F/?func=find-b&request=002006308&find_code=SYS&local_base=nkc
2009 @ 10 @ 21 @ Sudoku @ http://aleph.nkp.cz/F/?func=find-b&request=002008672&find_code=SYS&local_base=nkc
2009 @ 10 @ 20 @ Sport speciál : fotbal @ http://aleph.nkp.cz/F/?func=find-b&request=002006002&find_code=SYS&local_base=nkc
2009 @ 10 @ 19 @ Royal flush @ http://aleph.nkp.cz/F/?func=find-b&request=002007310&find_code=SYS&local_base=nkc
2009 @ 10 @ 18 @ Robot revue @ http://aleph.nkp.cz/F/?func=find-b&request=002006845&find_code=SYS&local_base=nkc
2009 @ 10 @ 17 @ Popularis @ http://aleph.nkp.cz/F/?func=find-b&request=002007979&find_code=SYS&local_base=nkc
2009 @ 10 @ 16 @ Pohodové osmisměrky @ http://aleph.nkp.cz/F/?func=find-b&request=002005717&find_code=SYS&local_base=nkc
2009 @ 10 @ 15 @ Obecní zpravodaj Přezletice @ http://aleph.nkp.cz/F/?func=find-b&request=002005768&find_code=SYS&local_base=nkc
2009 @ 10 @ 14 @ Naran : vestnik tibetskoj mediciny @ http://aleph.nkp.cz/F/?func=find-b&request=002006087&find_code=SYS&local_base=nkc
2009 @ 10 @ 13 @ Naran : věstník tibetské medicíny @ http://aleph.nkp.cz/F/?func=find-b&request=002006086&find_code=SYS&local_base=nkc
2009 @ 10 @ 12 @ Military revue @ http://aleph.nkp.cz/F/?func=find-b&request=002005943&find_code=SYS&local_base=nkc
2009 @ 10 @ 11 @ Kurortnaja gazeta @ http://aleph.nkp.cz/F/?func=find-b&request=002005835&find_code=SYS&local_base=nkc
2009 @ 10 @ 10 @ Kulturní revue @ http://aleph.nkp.cz/F/?func=find-b&request=002007054&find_code=SYS&local_base=nkc
2009 @ 10 @ 09 @ Křížovky plné humoru @ http://aleph.nkp.cz/F/?func=find-b&request=002006368&find_code=SYS&local_base=nkc
2009 @ 10 @ 08 @ Kamarádka osmisměrka @ http://aleph.nkp.cz/F/?func=find-b&request=002007019&find_code=SYS&local_base=nkc
2009 @ 10 @ 07 @ Jinčínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=002005780&find_code=SYS&local_base=nkc
2009 @ 10 @ 06 @ Info Kenny @ http://aleph.nkp.cz/F/?func=find-b&request=002007305&find_code=SYS&local_base=nkc
2009 @ 10 @ 05 @ Flair @ http://aleph.nkp.cz/F/?func=find-b&request=002008708&find_code=SYS&local_base=nkc
2009 @ 10 @ 04 @ Faster magazine @ http://aleph.nkp.cz/F/?func=find-b&request=002008684&find_code=SYS&local_base=nkc
2009 @ 10 @ 03 @ Domácnost a zdraví v osmisměrkách @ http://aleph.nkp.cz/F/?func=find-b&request=002006855&find_code=SYS&local_base=nkc
2009 @ 10 @ 02 @ Diana : škola pletení @ http://aleph.nkp.cz/F/?func=find-b&request=002008339&find_code=SYS&local_base=nkc
2009 @ 10 @ 00 @  @ 
2009 @ 10 @ 01 @ 24 časa v Čechii @ http://aleph.nkp.cz/F/?func=find-b&request=002005754&find_code=SYS&local_base=nkc
2009 @ 10 @ 23 @ Veřejné zakázky a PPP projekty @ http://aleph.nkp.cz/F/?func=find-b&request=002005790&find_code=SYS&local_base=nkc
2009 @ 10 @ 24 @ Viza @ http://aleph.nkp.cz/F/?func=find-b&request=002006018&find_code=SYS&local_base=nkc
2009 @ 10 @ 25 @ Vltavská @ http://aleph.nkp.cz/F/?func=find-b&request=002006322&find_code=SYS&local_base=nkc
2009 @ 10 @ 26 @ Želechovický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=002008710&find_code=SYS&local_base=nkc
2009 @ 11 @ 00 @  @ 
2009 @ 11 @ 01 @ 3pMag @ http://aleph.nkp.cz/F/?func=find-b&request=001995315&find_code=SYS&local_base=nkc
2009 @ 11 @ 02 @ Areality Vysočina @ http://aleph.nkp.cz/F/?func=find-b&request=001998293&find_code=SYS&local_base=nkc
2009 @ 11 @ 03 @ Auto tip 4x4 @ http://aleph.nkp.cz/F/?func=find-b&request=002010087&find_code=SYS&local_base=nkc
2009 @ 11 @ 04 @ Báječná školka @ http://aleph.nkp.cz/F/?func=find-b&request=001997811&find_code=SYS&local_base=nkc
2009 @ 11 @ 05 @ Bělocké noviny @ http://aleph.nkp.cz/F/?func=find-b&request=002009209&find_code=SYS&local_base=nkc
2009 @ 11 @ 06 @ Biuletyn euroregionu Glacensis @ http://aleph.nkp.cz/F/?func=find-b&request=001998121&find_code=SYS&local_base=nkc
2009 @ 11 @ 07 @ Brands & stories @ http://aleph.nkp.cz/F/?func=find-b&request=001996383&find_code=SYS&local_base=nkc
2009 @ 11 @ 08 @ Buildinfo @ http://aleph.nkp.cz/F/?func=find-b&request=001997682&find_code=SYS&local_base=nkc
2009 @ 11 @ 09 @ Card player @ http://aleph.nkp.cz/F/?func=find-b&request=001998167&find_code=SYS&local_base=nkc
2009 @ 11 @ 10 @ Current Orthopaedic Practice @ http://aleph.nkp.cz/F/?func=find-b&request=001995681&find_code=SYS&local_base=nkc
2009 @ 11 @ 11 @ Grand Moravia @ http://aleph.nkp.cz/F/?func=find-b&request=002009363&find_code=SYS&local_base=nkc
2009 @ 11 @ 12 @ Guide @ http://aleph.nkp.cz/F/?func=find-b&request=002012895&find_code=SYS&local_base=nkc
2009 @ 11 @ 13 @ Info TB @ http://aleph.nkp.cz/F/?func=find-b&request=001993303&find_code=SYS&local_base=nkc
2009 @ 11 @ 14 @ Inzertní listy @ http://aleph.nkp.cz/F/?func=find-b&request=001997889&find_code=SYS&local_base=nkc
2009 @ 11 @ 15 @ Kolešovické listy @ http://aleph.nkp.cz/F/?func=find-b&request=002012188&find_code=SYS&local_base=nkc
2009 @ 11 @ 16 @ Kolo pro život @ http://aleph.nkp.cz/F/?func=find-b&request=001998352&find_code=SYS&local_base=nkc
2009 @ 11 @ 17 @ Kompas obchodníka @ http://aleph.nkp.cz/F/?func=find-b&request=001998282&find_code=SYS&local_base=nkc
2009 @ 11 @ 18 @ Koník Filly @ http://aleph.nkp.cz/F/?func=find-b&request=002009843&find_code=SYS&local_base=nkc
2009 @ 11 @ 19 @ Konzervativní listy @ http://aleph.nkp.cz/F/?func=find-b&request=001995696&find_code=SYS&local_base=nkc
2009 @ 11 @ 20 @ Kralický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001993918&find_code=SYS&local_base=nkc
2009 @ 11 @ 21 @ Královédvorský inzert @ http://aleph.nkp.cz/F/?func=find-b&request=002009734&find_code=SYS&local_base=nkc
2009 @ 11 @ 22 @ Kris-krosy @ http://aleph.nkp.cz/F/?func=find-b&request=001998112&find_code=SYS&local_base=nkc
2009 @ 11 @ 23 @ Lanškrounsko.cz @ http://aleph.nkp.cz/F/?func=find-b&request=001996802&find_code=SYS&local_base=nkc
2009 @ 11 @ 24 @ Lovčické ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=001995685&find_code=SYS&local_base=nkc
2009 @ 11 @ 25 @ Luštění @ http://aleph.nkp.cz/F/?func=find-b&request=002012480&find_code=SYS&local_base=nkc
2009 @ 11 @ 26 @ Měsíčník : zábavný jihlavský časopis @ http://aleph.nkp.cz/F/?func=find-b&request=001995923&find_code=SYS&local_base=nkc
2009 @ 11 @ 27 @ Moje město @ http://aleph.nkp.cz/F/?func=find-b&request=001993913&find_code=SYS&local_base=nkc
2009 @ 11 @ 28 @ Motion @ http://aleph.nkp.cz/F/?func=find-b&request=001997641&find_code=SYS&local_base=nkc
2009 @ 11 @ 29 @ Mymagazine @ http://aleph.nkp.cz/F/?func=find-b&request=001995722&find_code=SYS&local_base=nkc
2009 @ 11 @ 30 @ Nakupování 21. století @ http://aleph.nkp.cz/F/?func=find-b&request=002011356&find_code=SYS&local_base=nkc
2009 @ 11 @ 31 @ Nenuď se! @ http://aleph.nkp.cz/F/?func=find-b&request=001995962&find_code=SYS&local_base=nkc
2009 @ 11 @ 32 @ Newsletter ROP Jihovýchod @ http://aleph.nkp.cz/F/?func=find-b&request=001995732&find_code=SYS&local_base=nkc
2009 @ 11 @ 33 @ Notoviny @ http://aleph.nkp.cz/F/?func=find-b&request=001997438&find_code=SYS&local_base=nkc
2009 @ 11 @ 34 @ Noviny VÚP @ http://aleph.nkp.cz/F/?func=find-b&request=001996848&find_code=SYS&local_base=nkc
2009 @ 11 @ 35 @ Okrouhlecký list @ http://aleph.nkp.cz/F/?func=find-b&request=002009878&find_code=SYS&local_base=nkc
2009 @ 11 @ 36 @ Pacientské listy @ http://aleph.nkp.cz/F/?func=find-b&request=001998527&find_code=SYS&local_base=nkc
2009 @ 11 @ 37 @ Panorama 21. století @ http://aleph.nkp.cz/F/?func=find-b&request=002009702&find_code=SYS&local_base=nkc
2009 @ 11 @ 38 @ Pečuj doma @ http://aleph.nkp.cz/F/?func=find-b&request=001993255&find_code=SYS&local_base=nkc
2009 @ 11 @ 39 @ Perspectives of innovations@ economics and business', 'http://aleph.nkp.cz/F/?func=find-b&request=001993297&find_code=SYS&local_base=nkc
2009 @ 11 @ 40 @ Plzeňák @ http://aleph.nkp.cz/F/?func=find-b&request=001995883&find_code=SYS&local_base=nkc
2009 @ 11 @ 41 @ Pražský dopravák @ http://aleph.nkp.cz/F/?func=find-b&request=002011894&find_code=SYS&local_base=nkc
2009 @ 11 @ 42 @ Pražský senior @ http://aleph.nkp.cz/F/?func=find-b&request=002010173&find_code=SYS&local_base=nkc
2009 @ 11 @ 43 @ Psychologie pro praxi @ http://aleph.nkp.cz/F/?func=find-b&request=001997316&find_code=SYS&local_base=nkc
2009 @ 11 @ 44 @ Reality & bydlení @ http://aleph.nkp.cz/F/?func=find-b&request=002009206&find_code=SYS&local_base=nkc
2009 @ 11 @ 45 @ Sabrina - recepty : cukroví @ http://aleph.nkp.cz/F/?func=find-b&request=002009328&find_code=SYS&local_base=nkc
2009 @ 11 @ 46 @ Scool @ http://aleph.nkp.cz/F/?func=find-b&request=001995737&find_code=SYS&local_base=nkc
2009 @ 11 @ 47 @ Strašínský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=001995750&find_code=SYS&local_base=nkc
2009 @ 11 @ 48 @ Střed @ http://aleph.nkp.cz/F/?func=find-b&request=001993306&find_code=SYS&local_base=nkc
2009 @ 11 @ 49 @ Think! @ http://aleph.nkp.cz/F/?func=find-b&request= 002011895&find_code=SYS&local_base=nkc
2009 @ 11 @ 50 @ Top seriál : speciál do vaší knihovny @ http://aleph.nkp.cz/F/?func=find-b&request=002012037&find_code=SYS&local_base=nkc
2009 @ 11 @ 51 @ Týdeník Přerovska @ http://aleph.nkp.cz/F/?func=find-b&request=001996346&find_code=SYS&local_base=nkc
2009 @ 11 @ 52 @ Úsměv @ http://aleph.nkp.cz/F/?func=find-b&request=001998494&find_code=SYS&local_base=nkc
2009 @ 11 @ 53 @ Užitkový Ford @ http://aleph.nkp.cz/F/?func=find-b&request=002012201&find_code=SYS&local_base=nkc
2009 @ 11 @ 54 @ Váš rozhled @ http://aleph.nkp.cz/F/?func=find-b&request=002010881&find_code=SYS&local_base=nkc
2009 @ 11 @ 55 @ Ventil @ http://aleph.nkp.cz/F/?func=find-b&request=002009732&find_code=SYS&local_base=nkc
2009 @ 11 @ 56 @ Vita Universitatis @ http://aleph.nkp.cz/F/?func=find-b&request=002010425&find_code=SYS&local_base=nkc
2009 @ 11 @ 57 @ Vizáž & styl @ http://aleph.nkp.cz/F/?func=find-b&request=002009414&find_code=SYS&local_base=nkc
2009 @ 11 @ 58 @ Zpravodaj : vydává obec Telnice @ http://aleph.nkp.cz/F/?func=find-b&request=002010993&find_code=SYS&local_base=nkc
2009 @ 12 @ 27 @ Viet magazín @ http://aleph.nkp.cz/F/?func=find-b&request=002025458&find_code=SYS&local_base=nkc
2009 @ 12 @ 26 @ Toyota report @ http://aleph.nkp.cz/F/?func=find-b&request=002025525&find_code=SYS&local_base=nkc
2009 @ 12 @ 25 @ Texty @ http://aleph.nkp.cz/F/?func=find-b&request=002025819&find_code=SYS&local_base=nkc
2009 @ 12 @ 24 @ Tescoma magazín @ http://aleph.nkp.cz/F/?func=find-b&request=002024853&find_code=SYS&local_base=nkc
2009 @ 12 @ 23 @ Šiml @ http://aleph.nkp.cz/F/?func=find-b&request=002026547&find_code=SYS&local_base=nkc
2009 @ 12 @ 22 @ Stavo-aktuality @ http://aleph.nkp.cz/F/?func=find-b&request=002026494&find_code=SYS&local_base=nkc
2009 @ 12 @ 21 @ Region Vyškovsko @ http://aleph.nkp.cz/F/?func=find-b&request=002025045&find_code=SYS&local_base=nkc
2009 @ 12 @ 20 @ Region inzert @ http://aleph.nkp.cz/F/?func=find-b&request=002026616&find_code=SYS&local_base=nkc
2009 @ 12 @ 19 @ Real-city @ http://aleph.nkp.cz/F/?func=find-b&request=002026496&find_code=SYS&local_base=nkc
2009 @ 12 @ 18 @ Příbramsko live @ http://aleph.nkp.cz/F/?func=find-b&request=002025801&find_code=SYS&local_base=nkc
2009 @ 12 @ 17 @ Pošli vtip @ http://aleph.nkp.cz/F/?func=find-b&request=002025978&find_code=SYS&local_base=nkc
2009 @ 12 @ 16 @ Podřipské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=002027303&find_code=SYS&local_base=nkc
2009 @ 12 @ 15 @ Mojo @ http://aleph.nkp.cz/F/?func=find-b&request=002012947&find_code=SYS&local_base=nkc
2009 @ 12 @ 14 @ Mnohosti @ http://aleph.nkp.cz/F/?func=find-b&request=002025995&find_code=SYS&local_base=nkc
2009 @ 12 @ 13 @ Lui @ http://aleph.nkp.cz/F/?func=find-b&request=002023221&find_code=SYS&local_base=nkc
2009 @ 12 @ 12 @ KVI : Karlovarský inzert @ http://aleph.nkp.cz/F/?func=find-b&request=002024507&find_code=SYS&local_base=nkc
2009 @ 12 @ 11 @ Komorní listy @ http://aleph.nkp.cz/F/?func=find-b&request=002027297&find_code=SYS&local_base=nkc
2009 @ 12 @ 10 @ Chodovské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=002026042&find_code=SYS&local_base=nkc
2009 @ 12 @ 09 @ Charme @ http://aleph.nkp.cz/F/?func=find-b&request=002024382&find_code=SYS&local_base=nkc
2009 @ 12 @ 08 @ Help @ http://aleph.nkp.cz/F/?func=find-b&request=002026865&find_code=SYS&local_base=nkc
2009 @ 12 @ 07 @ Ekonomika-management-inovace @ http://aleph.nkp.cz/F/?func=find-b&request=002027329&find_code=SYS&local_base=nkc
2009 @ 12 @ 06 @ Bulletin : klubový časopis @ http://aleph.nkp.cz/F/?func=find-b&request=001968796&find_code=SYS&local_base=nkc
2009 @ 12 @ 05 @ Buddy UP @ http://aleph.nkp.cz/F/?func=find-b&request=002023476&find_code=SYS&local_base=nkc
2009 @ 12 @ 04 @ Blanenské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=002023215&find_code=SYS&local_base=nkc
2009 @ 12 @ 03 @ Baby Book @ http://aleph.nkp.cz/F/?func=find-b&request=002024367&find_code=SYS&local_base=nkc
2009 @ 12 @ 02 @ Aquaviva @ http://aleph.nkp.cz/F/?func=find-b&request=002024283&find_code=SYS&local_base=nkc
2009 @ 12 @ 00 @  @ 
2009 @ 12 @ 01 @ Antitrust @ http://aleph.nkp.cz/F/?func=find-b&request=002027316&find_code=SYS&local_base=nkc
2009 @ 12 @ 28 @ Vlachovické listy @ http://aleph.nkp.cz/F/?func=find-b&request=002026862&find_code=SYS&local_base=nkc
2009 @ 12 @ 29 @ Zaostřeno na průmysl @ http://aleph.nkp.cz/F/?func=find-b&request=002023682&find_code=SYS&local_base=nkc
2009 @ 12 @ 30 @ Zpravodaj : Újezd u Brna @ http://aleph.nkp.cz/F/?func=find-b&request=002023750&find_code=SYS&local_base=nkc
2009 @ 12 @ 31 @ Zpravodaj Místní akční skupiny Pošumaví @ http://aleph.nkp.cz/F/?func=find-b&request=002027326&find_code=SYS&local_base=nkc
2009 @ 12 @ 32 @ Život v Praze 5 @ http://aleph.nkp.cz/F/?func=find-b&request=002026495&find_code=SYS&local_base=nkc
2010 @ 01 @ 23 @ Vlasta horoskopy @ http://aleph.nkp.cz/F/?func=find-b&request=002030678&find_code=SYS&local_base=nkc
2010 @ 01 @ 22 @ Top listy @ http://aleph.nkp.cz/F/?func=find-b&request=002028237&find_code=SYS&local_base=nkc
2010 @ 01 @ 21 @ Tachovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=002027612&find_code=SYS&local_base=nkc
2010 @ 01 @ 20 @ Středohoří @ http://aleph.nkp.cz/F/?func=find-b&request=002031240&find_code=SYS&local_base=nkc
2010 @ 01 @ 19 @ Současná Evropa @ http://aleph.nkp.cz/F/?func=find-b&request=002030371&find_code=SYS&local_base=nkc
2010 @ 01 @ 18 @ Somatuline bulletin @ http://aleph.nkp.cz/F/?func=find-b&request=002030872&find_code=SYS&local_base=nkc
2010 @ 01 @ 17 @ Smečenské ozvěny @ http://aleph.nkp.cz/F/?func=find-b&request=002030624&find_code=SYS&local_base=nkc
2010 @ 01 @ 16 @ Smajlík @ http://aleph.nkp.cz/F/?func=find-b&request=002029486&find_code=SYS&local_base=nkc
2010 @ 01 @ 15 @ Sedmička Kladno @ http://aleph.nkp.cz/F/?func=find-b&request=002030475&find_code=SYS&local_base=nkc
2010 @ 01 @ 14 @ Sanační noviny @ http://aleph.nkp.cz/F/?func=find-b&request=002029482&find_code=SYS&local_base=nkc
2010 @ 01 @ 13 @ Reality Plzeňského kraje @ http://aleph.nkp.cz/F/?func=find-b&request=002030932&find_code=SYS&local_base=nkc
2010 @ 01 @ 12 @ Prime Russian Magazine @ http://aleph.nkp.cz/F/?func=find-b&request=002029748&find_code=SYS&local_base=nkc
2010 @ 01 @ 11 @ Pardubický krajánek @ http://aleph.nkp.cz/F/?func=find-b&request=002030492&find_code=SYS&local_base=nkc
2010 @ 01 @ 10 @ Motolin @ http://aleph.nkp.cz/F/?func=find-b&request=002030160&find_code=SYS&local_base=nkc
2010 @ 01 @ 09 @ mBnoviny @ http://aleph.nkp.cz/F/?func=find-b&request=002030878&find_code=SYS&local_base=nkc
2010 @ 01 @ 08 @ Luštění @ http://aleph.nkp.cz/F/?func=find-b&request=002031290&find_code=SYS&local_base=nkc
2010 @ 01 @ 07 @ Lexum @ http://aleph.nkp.cz/F/?func=find-b&request=002029216&find_code=SYS&local_base=nkc
2010 @ 01 @ 06 @ Lánský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=002030161&find_code=SYS&local_base=nkc
2010 @ 01 @ 05 @ Křížovky švédské a jiné @ http://aleph.nkp.cz/F/?func=find-b&request=002030173&find_code=SYS&local_base=nkc
2010 @ 01 @ 04 @ Kapesní su-do-ku @ http://aleph.nkp.cz/F/?func=find-b&request=002030170&find_code=SYS&local_base=nkc
2010 @ 01 @ 03 @ Forprint @ http://aleph.nkp.cz/F/?func=find-b&request=002028215&find_code=SYS&local_base=nkc
2010 @ 01 @ 02 @ Dortománie @ http://aleph.nkp.cz/F/?func=find-b&request=002028885&find_code=SYS&local_base=nkc
2010 @ 01 @ 00 @  @ 
2010 @ 01 @ 01 @ Diabetology news @ http://aleph.nkp.cz/F/?func=find-b&request=002027561&find_code=SYS&local_base=nkc
2010 @ 01 @ 24 @ Wine & degustation @ http://aleph.nkp.cz/F/?func=find-b&request=002027584&find_code=SYS&local_base=nkc
2010 @ 01 @ 25 @ Zemědělec v regionu @ http://aleph.nkp.cz/F/?func=find-b&request=002030650&find_code=SYS&local_base=nkc
2010 @ 01 @ 26 @ Zpravodaj : Zahradnické centrum @ http://aleph.nkp.cz/F/?func=find-b&request=002030892&find_code=SYS&local_base=nkc
2010 @ 01 @ 27 @ Zpravodaj obce Ločenice a osady Nesměň @ http://aleph.nkp.cz/F/?func=find-b&request=002027774&find_code=SYS&local_base=nkc
2010 @ 02 @ 00 @  @ 
2010 @ 02 @ 01 @ Andragogická revue @ http://aleph.nkp.cz/F/?func=find-b&request=002033815&find_code=SYS&local_base=nkc
2010 @ 02 @ 02 @ Auto Průhonice news @ http://aleph.nkp.cz/F/?func=find-b&request=002039471&find_code=SYS&local_base=nkc
2010 @ 02 @ 03 @ A-Z elektro @ http://aleph.nkp.cz/F/?func=find-b&request=002031346&find_code=SYS&local_base=nkc
2010 @ 02 @ 04 @ Be the best @ http://aleph.nkp.cz/F/?func=find-b&request=002031714&find_code=SYS&local_base=nkc
2010 @ 02 @ 05 @ Bondy centrum @ http://aleph.nkp.cz/F/?func=find-b&request=002032333&find_code=SYS&local_base=nkc
2010 @ 02 @ 06 @ Czech Top 100 forum @ http://aleph.nkp.cz/F/?func=find-b&request=002032134&find_code=SYS&local_base=nkc
2010 @ 02 @ 07 @ Diplomat @ http://aleph.nkp.cz/F/?func=find-b&request=002009378&find_code=SYS&local_base=nkc
2010 @ 02 @ 08 @ Dřevo-Central @ http://aleph.nkp.cz/F/?func=find-b&request=002033844&find_code=SYS&local_base=nkc
2010 @ 02 @ 09 @ Exit 62 @ http://aleph.nkp.cz/F/?func=find-b&request=002039414&find_code=SYS&local_base=nkc
2010 @ 02 @ 10 @ Historica @ http://aleph.nkp.cz/F/?func=find-b&request=002039943&find_code=SYS&local_base=nkc
2010 @ 02 @ 11 @ Infopress @ http://aleph.nkp.cz/F/?func=find-b&request=002031383&find_code=SYS&local_base=nkc
2010 @ 02 @ 12 @ Journal of Competitiveness @ http://aleph.nkp.cz/F/?func=find-b&request=002031357&find_code=SYS&local_base=nkc
2010 @ 02 @ 13 @ Kluci v akci @ http://aleph.nkp.cz/F/?func=find-b&request=002029185&find_code=SYS&local_base=nkc
2010 @ 02 @ 14 @ Kolekce Hannah Montana @ http://aleph.nkp.cz/F/?func=find-b&request=002033235&find_code=SYS&local_base=nkc
2010 @ 02 @ 15 @ Krok za krokem @ http://aleph.nkp.cz/F/?func=find-b&request=002031891&find_code=SYS&local_base=nkc
2010 @ 02 @ 16 @ Kulturní pecka @ http://aleph.nkp.cz/F/?func=find-b&request=002033826&find_code=SYS&local_base=nkc
2010 @ 02 @ 17 @ Magazín : Nisa obchodní centrum @ http://aleph.nkp.cz/F/?func=find-b&request=002031716&find_code=SYS&local_base=nkc
2010 @ 02 @ 18 @ PragMoon @ http://aleph.nkp.cz/F/?func=find-b&request=002039491&find_code=SYS&local_base=nkc
2010 @ 02 @ 19 @ Prague onco journal @ http://aleph.nkp.cz/F/?func=find-b&request=002032812&find_code=SYS&local_base=nkc
2010 @ 02 @ 20 @ Pražan @ http://aleph.nkp.cz/F/?func=find-b&request=002031707&find_code=SYS&local_base=nkc
2010 @ 02 @ 21 @ Real-city @ http://aleph.nkp.cz/F/?func=find-b&request=002087126&find_code=SYS&local_base=nkc
2010 @ 02 @ 22 @ Suchdolské listy @ http://aleph.nkp.cz/F/?func=find-b&request=002039463&find_code=SYS&local_base=nkc
2010 @ 02 @ 23 @ Tajemství české minulosti @ http://aleph.nkp.cz/F/?func=find-b&request=002086838&find_code=SYS&local_base=nkc
2010 @ 02 @ 24 @ Valečské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=002033546&find_code=SYS&local_base=nkc
2010 @ 02 @ 25 @ Zdravotnictví a sociální práce @ http://aleph.nkp.cz/F/?func=find-b&request=002033436&find_code=SYS&local_base=nkc
2010 @ 02 @ 26 @ Zpravodaj Královského Poříčí @ http://aleph.nkp.cz/F/?func=find-b&request=002033245&find_code=SYS&local_base=nkc
2010 @ 02 @ 27 @ Zpravodaj obce Bohuslavice @ http://aleph.nkp.cz/F/?func=find-b&request=002031918&find_code=SYS&local_base=nkc
2010 @ 02 @ 28 @ Zpravodaj obce Výčapy @ http://aleph.nkp.cz/F/?func=find-b&request=002032141&find_code=SYS&local_base=nkc
2010 @ 02 @ 29 @ Zpravodaj Spectrum @ http://aleph.nkp.cz/F/?func=find-b&request=002040271&find_code=SYS&local_base=nkc
2010 @ 02 @ 30 @ Zpravodaj úřadu městyse Prosiměřice @ http://aleph.nkp.cz/F/?func=find-b&request=002031889&find_code=SYS&local_base=nkc
2010 @ 02 @ 31 @ Žižkovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=002033511&find_code=SYS&local_base=nkc
2010 @ 03 @ 24 @ Slovenské korene @ http://aleph.nkp.cz/F/?func=find-b&request=002088337&find_code=SYS&local_base=nkc
2010 @ 03 @ 23 @ Romano vodori @ http://aleph.nkp.cz/F/?func=find-b&request=002089823&find_code=SYS&local_base=nkc
2010 @ 03 @ 22 @ Práce z dějiny Akademie věd @ http://aleph.nkp.cz/F/?func=find-b&request=002024845&find_code=SYS&local_base=nkc
2010 @ 03 @ 21 @ Pižmo @ http://aleph.nkp.cz/F/?func=find-b&request=002090988&find_code=SYS&local_base=nkc
2010 @ 10 @ 16 @ Náš region : nezávislý místní zpravodaj. Kolínsko @ http://aleph.nkp.cz/F/?func=direct&doc_number=002132192&local_base=nkc
2010 @ 03 @ 20 @ Pařát @ http://aleph.nkp.cz/F/?func=find-b&request=002088070&find_code=SYS&local_base=nkc
2010 @ 03 @ 19 @ Ostravak @ http://aleph.nkp.cz/F/?func=find-b&request=002089834&find_code=SYS&local_base=nkc
2010 @ 03 @ 18 @ News : Faiveley Transport @ http://aleph.nkp.cz/F/?func=find-b&request=002089076&find_code=SYS&local_base=nkc
2010 @ 03 @ 17 @ Můj příběh @ http://aleph.nkp.cz/F/?func=find-b&request=002088850&find_code=SYS&local_base=nkc
2010 @ 03 @ 16 @ Moje zahrádka @ http://aleph.nkp.cz/F/?func=find-b&request=002088091&find_code=SYS&local_base=nkc
2010 @ 03 @ 15 @ Lékař přítelem @ http://aleph.nkp.cz/F/?func=find-b&request=002087967&find_code=SYS&local_base=nkc
2010 @ 03 @ 14 @ Křížovky s květinami @ http://aleph.nkp.cz/F/?func=find-b&request=002089296&find_code=SYS&local_base=nkc
2010 @ 03 @ 13 @ Křížovky s celebritami @ http://aleph.nkp.cz/F/?func=find-b&request=002089139&find_code=SYS&local_base=nkc
2010 @ 03 @ 12 @ Klubový zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=002087987&find_code=SYS&local_base=nkc
2010 @ 03 @ 11 @ Item @ http://aleph.nkp.cz/F/?func=find-b&request=002090588&find_code=SYS&local_base=nkc
2010 @ 03 @ 10 @ Ikona @ http://aleph.nkp.cz/F/?func=find-b&request=002088821&find_code=SYS&local_base=nkc
2010 @ 03 @ 09 @ Hobby historie @ http://aleph.nkp.cz/F/?func=find-b&request=002087953&find_code=SYS&local_base=nkc
2010 @ 03 @ 08 @ Eurokřížovky @ http://aleph.nkp.cz/F/?func=find-b&request=002088701&find_code=SYS&local_base=nkc
2010 @ 03 @ 07 @ Echo @ http://aleph.nkp.cz/F/?func=find-b&request=002088799&find_code=SYS&local_base=nkc
2010 @ 03 @ 06 @ Dvacáté století @ http://aleph.nkp.cz/F/?func=find-b&request=002039451&find_code=SYS&local_base=nkc
2010 @ 03 @ 05 @ Český exportér @ http://aleph.nkp.cz/F/?func=find-b&request=002088699&find_code=SYS&local_base=nkc
2010 @ 03 @ 04 @ Czech-polish historical and pedagogical journal @ http://aleph.nkp.cz/F/?func=find-b&request=002086647&find_code=SYS&local_base=nkc
2010 @ 03 @ 03 @ Combat zone @ http://aleph.nkp.cz/F/?func=find-b&request=002088700&find_code=SYS&local_base=nkc
2010 @ 03 @ 02 @ Beskydská oáza @ http://aleph.nkp.cz/F/?func=find-b&request=002089141&find_code=SYS&local_base=nkc
2010 @ 03 @ 00 @  @ 
2010 @ 03 @ 01 @ Acta Moraviae @ http://aleph.nkp.cz/F/?func=find-b&request=002088855&find_code=SYS&local_base=nkc
2010 @ 03 @ 25 @ Studia mediaevalia bohemica @ http://aleph.nkp.cz/F/?func=find-b&request=002086663&find_code=SYS&local_base=nkc
2010 @ 03 @ 26 @ Temnokomornický občasník @ http://aleph.nkp.cz/F/?func=find-b&request=002091166&find_code=SYS&local_base=nkc
2010 @ 03 @ 27 @ Terešovský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=002088702&find_code=SYS&local_base=nkc
2010 @ 03 @ 28 @ Trendy baby @ http://aleph.nkp.cz/F/?func=find-b&request=002091231&find_code=SYS&local_base=nkc
2010 @ 03 @ 29 @ Vremena @ http://aleph.nkp.cz/F/?func=find-b&request=002091471&find_code=SYS&local_base=nkc
2010 @ 03 @ 30 @ Zpravodaj : město Lovosice @ http://aleph.nkp.cz/F/?func=find-b&request=002088082&find_code=SYS&local_base=nkc
2010 @ 04 @ 61 @ Vyšehořovicko @ http://aleph.nkp.cz/F/?func=find-b&request=002096881&find_code=SYS&local_base=nkc
2010 @ 04 @ 60 @ Větrník @ http://aleph.nkp.cz/F/?func=find-b&request=002094706&find_code=SYS&local_base=nkc
2010 @ 04 @ 59 @ Valašské panorama @ http://aleph.nkp.cz/F/?func=find-b&request=002099273&find_code=SYS&local_base=nkc
2010 @ 04 @ 58 @ Theatralia @ http://aleph.nkp.cz/F/?func=find-b&request=002086635&find_code=SYS&local_base=nkc
2010 @ 04 @ 57 @ Švejkovic listy @ http://aleph.nkp.cz/F/?func=find-b&request=002097482&find_code=SYS&local_base=nkc
2010 @ 04 @ 56 @ Svět hub @ http://aleph.nkp.cz/F/?func=find-b&request=002095032&find_code=SYS&local_base=nkc
2010 @ 04 @ 55 @ Studentský list @ http://aleph.nkp.cz/F/?func=find-b&request=002099225&find_code=SYS&local_base=nkc
2010 @ 04 @ 54 @ Spotplus @ http://aleph.nkp.cz/F/?func=find-b&request=002095643&find_code=SYS&local_base=nkc
2010 @ 04 @ 53 @ Sociálka @ http://aleph.nkp.cz/F/?func=find-b&request=002092691&find_code=SYS&local_base=nkc
2010 @ 04 @ 52 @ Smečenský uličník @ http://aleph.nkp.cz/F/?func=find-b&request=002091912&find_code=SYS&local_base=nkc
2010 @ 04 @ 50 @ Sedmička : Žďár nad Sázavou @ http://aleph.nkp.cz/F/?func=find-b&request=002095704&find_code=SYS&local_base=nkc
2010 @ 04 @ 51 @ Skutečné zločiny @ http://aleph.nkp.cz/F/?func=find-b&request=002095063&find_code=SYS&local_base=nkc
2010 @ 04 @ 49 @ Sedmička : Uherské Hradiště@ Staré město a Kunovice', 'http://aleph.nkp.cz/F/?func=find-b&request=002095718&find_code=SYS&local_base=nkc
2010 @ 04 @ 48 @ Rychnovský poutník @ http://aleph.nkp.cz/F/?func=find-b&request=002099753&find_code=SYS&local_base=nkc
2010 @ 04 @ 47 @ Rooftop @ http://aleph.nkp.cz/F/?func=find-b&request=001968803&find_code=SYS&local_base=nkc
2010 @ 04 @ 46 @ Revue českého obranného a bezpečnostního průmyslu @ http://aleph.nkp.cz/F/?func=find-b&request=002095246&find_code=SYS&local_base=nkc
2010 @ 04 @ 45 @ Pražský metropolitan @ http://aleph.nkp.cz/F/?func=find-b&request=002104271&find_code=SYS&local_base=nkc
2010 @ 04 @ 44 @ Porta Balkanica @ http://aleph.nkp.cz/F/?func=find-b&request=002093066&find_code=SYS&local_base=nkc
2010 @ 04 @ 42 @ Planeta Země @ http://aleph.nkp.cz/F/?func=find-b&request=002097328&find_code=SYS&local_base=nkc
2010 @ 04 @ 43 @ Plzeň Plaza @ http://aleph.nkp.cz/F/?func=find-b&request=002094830&find_code=SYS&local_base=nkc
2010 @ 04 @ 41 @ Osmisměrky z Turpressu @ http://aleph.nkp.cz/F/?func=find-b&request=002033775&find_code=SYS&local_base=nkc
2010 @ 04 @ 39 @ Oponent @ http://aleph.nkp.cz/F/?func=find-b&request=002096558&find_code=SYS&local_base=nkc
2010 @ 04 @ 40 @ Osmisměrky kapesní @ http://aleph.nkp.cz/F/?func=find-b&request=002093289&find_code=SYS&local_base=nkc
2010 @ 04 @ 38 @ Olomouc life @ http://aleph.nkp.cz/F/?func=find-b&request=002095638&find_code=SYS&local_base=nkc
2010 @ 04 @ 37 @ Oblíbené dobroty pro každého @ http://aleph.nkp.cz/F/?func=find-b&request=002095190&find_code=SYS&local_base=nkc
2010 @ 04 @ 36 @ Novinky Zeměměřičské knihovny @ http://aleph.nkp.cz/F/?func=find-b&request=002104367&find_code=SYS&local_base=nkc
2010 @ 04 @ 35 @ Nodig @ http://aleph.nkp.cz/F/?func=find-b&request=002096306&find_code=SYS&local_base=nkc
2010 @ 04 @ 34 @ Naše Čelákovice - zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=002093782&find_code=SYS&local_base=nkc
2010 @ 04 @ 33 @ Naše 4 @ http://aleph.nkp.cz/F/?func=find-b&request=002092587&find_code=SYS&local_base=nkc
2010 @ 04 @ 32 @ Megakřížovky @ http://aleph.nkp.cz/F/?func=find-b&request=001993243&find_code=SYS&local_base=nkc
2010 @ 04 @ 31 @ Magazín obchodního centra DBK Budějovická @ http://aleph.nkp.cz/F/?func=find-b&request=002094529&find_code=SYS&local_base=nkc
2010 @ 04 @ 30 @ Kultovní auta ČSSR @ http://aleph.nkp.cz/F/?func=find-b&request=002095262&find_code=SYS&local_base=nkc
2010 @ 04 @ 29 @ Křížovky supervýběr @ http://aleph.nkp.cz/F/?func=find-b&request=002099267&find_code=SYS&local_base=nkc
2010 @ 04 @ 28 @ Křížovky na víkend @ http://aleph.nkp.cz/F/?func=find-b&request=002104267&find_code=SYS&local_base=nkc
2010 @ 04 @ 27 @ Krásná @ http://aleph.nkp.cz/F/?func=find-b&request=002096289&find_code=SYS&local_base=nkc
2010 @ 04 @ 26 @ Kopaninské listy @ http://aleph.nkp.cz/F/?func=find-b&request=002095319&find_code=SYS&local_base=nkc
2010 @ 10 @ 15 @ Metronom @ http://aleph.nkp.cz/F/?func=direct&doc_number=002130725&local_base=nkc
2010 @ 04 @ 24 @ KM Beta magazín @ http://aleph.nkp.cz/F/?func=find-b&request=002097763&find_code=SYS&local_base=nkc
2010 @ 04 @ 25 @ Kolečské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=002095266&find_code=SYS&local_base=nkc
2010 @ 04 @ 23 @ Journal of hypertension @ http://aleph.nkp.cz/F/?func=find-b&request=002096780&find_code=SYS&local_base=nkc
2010 @ 04 @ 22 @ Jihoměstské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=002097067&find_code=SYS&local_base=nkc
2010 @ 04 @ 21 @ Inzerce Vrchlabsko @ http://aleph.nkp.cz/F/?func=find-b&request=002094796&find_code=SYS&local_base=nkc
2010 @ 04 @ 19 @ Hybris @ http://aleph.nkp.cz/F/?func=find-b&request=002092630&find_code=SYS&local_base=nkc
2010 @ 04 @ 20 @ Informační bulletin Sellier & Bellot @ http://aleph.nkp.cz/F/?func=find-b&request=002104354&find_code=SYS&local_base=nkc
2010 @ 04 @ 18 @ Hradčovské listy @ http://aleph.nkp.cz/F/?func=find-b&request=002096786&find_code=SYS&local_base=nkc
2010 @ 04 @ 16 @ Fresh marketing @ http://aleph.nkp.cz/F/?func=find-b&request=002094155&find_code=SYS&local_base=nkc
2010 @ 04 @ 17 @ Hello Kitty @ http://aleph.nkp.cz/F/?func=find-b&request=002033838&find_code=SYS&local_base=nkc
2010 @ 04 @ 15 @ Feedback @ http://aleph.nkp.cz/F/?func=find-b&request=002092011&find_code=SYS&local_base=nkc
2010 @ 04 @ 13 @ European journal of Haematology @ http://aleph.nkp.cz/F/?func=find-b&request=002096781&find_code=SYS&local_base=nkc
2010 @ 04 @ 14 @ Evo @ http://aleph.nkp.cz/F/?func=find-b&request=002095254&find_code=SYS&local_base=nkc
2010 @ 04 @ 12 @ Education and science without borders @ http://aleph.nkp.cz/F/?func=find-b&request=002097626&find_code=SYS&local_base=nkc
2010 @ 04 @ 11 @ Didaktické studie @ http://aleph.nkp.cz/F/?func=find-b&request=002093373&find_code=SYS&local_base=nkc
2010 @ 04 @ 10 @ Desítka @ http://aleph.nkp.cz/F/?func=find-b&request=002096899&find_code=SYS&local_base=nkc
2010 @ 04 @ 09 @ Dáša @ http://aleph.nkp.cz/F/?func=find-b&request=002092641&find_code=SYS&local_base=nkc
2010 @ 04 @ 08 @ Černovický kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=002104270&find_code=SYS&local_base=nkc
2010 @ 04 @ 07 @ Častnaja žizn’ : gazeta dlja Evrosojuza @ http://aleph.nkp.cz/F/?func=find-b&request=002104273&find_code=SYS&local_base=nkc
2010 @ 04 @ 06 @ Current opinion in Anesthesiology @ http://aleph.nkp.cz/F/?func=find-b&request=002096784&find_code=SYS&local_base=nkc
2010 @ 04 @ 05 @ Credium news @ http://aleph.nkp.cz/F/?func=find-b&request=002092610&find_code=SYS&local_base=nkc
2010 @ 04 @ 04 @ Bydlet v panelu @ http://aleph.nkp.cz/F/?func=find-b&request=002096785&find_code=SYS&local_base=nkc
2010 @ 04 @ 03 @ Bulletin SUF @ http://aleph.nkp.cz/F/?func=find-b&request=002092342&find_code=SYS&local_base=nkc
2010 @ 04 @ 02 @ Bulletin Institutu certifikace účetních @ http://aleph.nkp.cz/F/?func=find-b&request=002094672&find_code=SYS&local_base=nkc
2010 @ 04 @ 00 @  @ 
2010 @ 04 @ 01 @ Bechlínské listy @ http://aleph.nkp.cz/F/?func=find-b&request=002091997&find_code=SYS&local_base=nkc
2010 @ 04 @ 62 @ Zelené Slovácko @ http://aleph.nkp.cz/F/?func=find-b&request=002097766&find_code=SYS&local_base=nkc
2010 @ 04 @ 63 @ Zenia @ http://aleph.nkp.cz/F/?func=find-b&request=002093760&find_code=SYS&local_base=nkc
2010 @ 05 @ 34 @ Telnický zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=002104802&find_code=SYS&local_base=nkc
2010 @ 05 @ 33 @ Swissmag @ http://aleph.nkp.cz/F/?func=find-b&request=002107360&find_code=SYS&local_base=nkc
2010 @ 05 @ 32 @ Svět zdravotnictví @ http://aleph.nkp.cz/F/?func=find-b&request=002105465&find_code=SYS&local_base=nkc
2010 @ 05 @ 31 @ Svět plastů @ http://aleph.nkp.cz/F/?func=find-b&request=002107104&find_code=SYS&local_base=nkc
2010 @ 05 @ 30 @ Staroměstské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=002107963&find_code=SYS&local_base=nkc
2010 @ 10 @ 14 @ Klatovský pohled @ http://aleph.nkp.cz/F/?func=direct&doc_number=002133224&local_base=nkc
2010 @ 05 @ 29 @ Rozhlasové noviny @ http://aleph.nkp.cz/F/?func=find-b&request=002105477&find_code=SYS&local_base=nkc
2010 @ 05 @ 28 @ PRIO : Porubská radnice informuje občany @ http://aleph.nkp.cz/F/?func=find-b&request=002106210&find_code=SYS&local_base=nkc
2010 @ 05 @ 27 @ Pražský kurýr @ http://aleph.nkp.cz/F/?func=find-b&request=002105143&find_code=SYS&local_base=nkc
2010 @ 05 @ 26 @ Právo@ ekonomika, management', 'http://aleph.nkp.cz/F/?func=find-b&request=002107798&find_code=SYS&local_base=nkc
2010 @ 05 @ 25 @ Pozemkové úpravy @ http://aleph.nkp.cz/F/?func=find-b&request=002104643&find_code=SYS&local_base=nkc
2010 @ 05 @ 24 @ Opatky a Opati @ http://aleph.nkp.cz/F/?func=find-b&request=002107321&find_code=SYS&local_base=nkc
2010 @ 05 @ 23 @ Můj pes @ http://aleph.nkp.cz/F/?func=find-b&request=002107909&find_code=SYS&local_base=nkc
2010 @ 05 @ 22 @ Medical and health science journal @ http://aleph.nkp.cz/F/?func=find-b&request=002107142&find_code=SYS&local_base=nkc
2010 @ 05 @ 21 @ Lužanský občasník @ http://aleph.nkp.cz/F/?func=find-b&request=002105726&find_code=SYS&local_base=nkc
2010 @ 05 @ 20 @ Leader mas Sokolovsko @ http://aleph.nkp.cz/F/?func=find-b&request=002107928&find_code=SYS&local_base=nkc
2010 @ 05 @ 19 @ Krupské střípky @ http://aleph.nkp.cz/F/?func=find-b&request=002105908&find_code=SYS&local_base=nkc
2010 @ 05 @ 18 @ Kovárna pro radost @ http://aleph.nkp.cz/F/?func=find-b&request=002107802&find_code=SYS&local_base=nkc
2010 @ 05 @ 17 @ KomoraZT.cz @ http://aleph.nkp.cz/F/?func=find-b&request=002106819&find_code=SYS&local_base=nkc
2010 @ 05 @ 16 @ Karlova Studánka a okolí @ http://aleph.nkp.cz/F/?func=find-b&request=002107917&find_code=SYS&local_base=nkc
2010 @ 10 @ 13 @ Chrudimské noviny @ http://aleph.nkp.cz/F/?func=direct&doc_number=002132954&local_base=nkc
2010 @ 05 @ 15 @ InfoKompas @ http://aleph.nkp.cz/F/?func=find-b&request=002106171&find_code=SYS&local_base=nkc
2010 @ 05 @ 14 @ Chvilka v kuchyni @ http://aleph.nkp.cz/F/?func=find-b&request=002107124&find_code=SYS&local_base=nkc
2010 @ 05 @ 13 @ HOP : historie - otázky - problémy @ http://aleph.nkp.cz/F/?func=find-b&request=002106146&find_code=SYS&local_base=nkc
2010 @ 05 @ 12 @ Family @ http://aleph.nkp.cz/F/?func=find-b&request=002106846&find_code=SYS&local_base=nkc
2010 @ 05 @ 11 @ Études romanes de Brno @ http://aleph.nkp.cz/F/?func=find-b&request=002088408&find_code=SYS&local_base=nkc
2010 @ 05 @ 10 @ Domy a bydlení exclusive @ http://aleph.nkp.cz/F/?func=find-b&request=002105756&find_code=SYS&local_base=nkc
2010 @ 05 @ 09 @ Dlouhomilovský zpravodaj @ http://aleph.nkp.cz/F/?func=find-b&request=002105769&find_code=SYS&local_base=nkc
2010 @ 05 @ 08 @ Český export @ http://aleph.nkp.cz/F/?func=find-b&request=002104841&find_code=SYS&local_base=nkc
2010 @ 05 @ 07 @ Bydlení dnes @ http://aleph.nkp.cz/F/?func=find-b&request=002105481&find_code=SYS&local_base=nkc
2010 @ 05 @ 06 @ Business and economic horizons @ http://aleph.nkp.cz/F/?func=find-b&request=002106803&find_code=SYS&local_base=nkc
2010 @ 05 @ 05 @ Budečské rozhledy @ http://aleph.nkp.cz/F/?func=find-b&request=002105762&find_code=SYS&local_base=nkc
2010 @ 05 @ 04 @ Billa news @ http://aleph.nkp.cz/F/?func=find-b&request=002107958&find_code=SYS&local_base=nkc
2010 @ 05 @ 03 @ Bella Sara @ http://aleph.nkp.cz/F/?func=find-b&request=002107807&find_code=SYS&local_base=nkc
2010 @ 05 @ 02 @ Auto4Drive @ http://aleph.nkp.cz/F/?func=find-b&request=002107811&find_code=SYS&local_base=nkc
2010 @ 05 @ 00 @  @ 
2010 @ 05 @ 01 @ 365 dnů v OC Letňany @ http://aleph.nkp.cz/F/?func=find-b&request=002108609&find_code=SYS&local_base=nkc
2010 @ 05 @ 35 @ Top novinky v Hradišti @ http://aleph.nkp.cz/F/?func=find-b&request=002104578&find_code=SYS&local_base=nkc
2010 @ 05 @ 36 @ Tuty magazín @ http://aleph.nkp.cz/F/?func=find-b&request=002107329&find_code=SYS&local_base=nkc
2010 @ 05 @ 37 @ Události druhé světové války @ http://aleph.nkp.cz/F/?func=find-b&request=002108128&find_code=SYS&local_base=nkc
2010 @ 05 @ 38 @ Varyáda @ http://aleph.nkp.cz/F/?func=find-b&request=002107639&find_code=SYS&local_base=nkc
2010 @ 05 @ 39 @ Zeiss magazín @ http://aleph.nkp.cz/F/?func=find-b&request=002107311&find_code=SYS&local_base=nkc
2010 @ 05 @ 40 @ Zpravodaj obce Mrsklesy @ http://aleph.nkp.cz/F/?func=find-b&request=002107368&find_code=SYS&local_base=nkc
2010 @ 05 @ 41 @ Zpravodaj UVP ČR @ http://aleph.nkp.cz/F/?func=find-b&request=002105139&find_code=SYS&local_base=nkc
2010 @ 06 @ 00 @  @ 
2010 @ 06 @ 01 @ Amanah @ http://aleph.nkp.cz/F/?func=find-b&request=002113672&find_code=SYS&local_base=nkc
2010 @ 06 @ 02 @ Dalmateens magazine @ http://aleph.nkp.cz/F/?func=find-b&request=002113646&find_code=SYS&local_base=nkc
2010 @ 06 @ 03 @ Fullmoon @ http://aleph.nkp.cz/F/?func=find-b&request=002114056&find_code=SYS&local_base=nkc
2010 @ 06 @ 04 @ Funeral @ http://aleph.nkp.cz/F/?func=find-b&request=002113640&find_code=SYS&local_base=nkc
2010 @ 06 @ 05 @ Choice @ http://aleph.nkp.cz/F/?func=find-b&request=002111851&find_code=SYS&local_base=nkc
2010 @ 06 @ 06 @ Já a rodina @ http://aleph.nkp.cz/F/?func=find-b&request=002114056&find_code=SYS&local_base=nkc
2010 @ 06 @ 07 @ Jóga dnes @ http://aleph.nkp.cz/F/?func=find-b&request=002111853&find_code=SYS&local_base=nkc
2010 @ 06 @ 08 @ Křížovky na cestách @ http://aleph.nkp.cz/F/?func=find-b&request=002111854&find_code=SYS&local_base=nkc
2010 @ 06 @ 09 @ Lazy town magazín @ http://aleph.nkp.cz/F/?func=find-b&request=002110143&find_code=SYS&local_base=nkc
2010 @ 06 @ 10 @ Maentiva Galopp @ http://aleph.nkp.cz/F/?func=find-b&request=002111855&find_code=SYS&local_base=nkc
2010 @ 06 @ 11 @ Malostranské noviny @ http://aleph.nkp.cz/F/?func=find-b&request=002110527&find_code=SYS&local_base=nkc
2010 @ 06 @ 12 @ Mini-max @ http://aleph.nkp.cz/F/?func=find-b&request=002110382&find_code=SYS&local_base=nkc
2010 @ 06 @ 13 @ Obecní listy pro Lipovou@ Hrochov a Seč', 'http://aleph.nkp.cz/F/?func=find-b&request=002109260&find_code=SYS&local_base=nkc
2010 @ 06 @ 14 @ Okinfo @ http://aleph.nkp.cz/F/?func=find-b&request=002111609&find_code=SYS&local_base=nkc
2010 @ 06 @ 15 @ Parlamentní magazín @ http://aleph.nkp.cz/F/?func=find-b&request=002111591&find_code=SYS&local_base=nkc
2010 @ 06 @ 16 @ Pause @ http://aleph.nkp.cz/F/?func=find-b&request=002113512&find_code=SYS&local_base=nkc
2010 @ 06 @ 17 @ Pentagram @ http://aleph.nkp.cz/F/?func=find-b&request=002010668&find_code=SYS&local_base=nkc
2010 @ 06 @ 18 @ Pravé Zdiby @ http://aleph.nkp.cz/F/?func=find-b&request=002109997&find_code=SYS&local_base=nkc
2010 @ 06 @ 19 @ Redway @ http://aleph.nkp.cz/F/?func=find-b&request=002113522&find_code=SYS&local_base=nkc
2010 @ 06 @ 20 @ Score girl @ http://aleph.nkp.cz/F/?func=find-b&request=002111566&find_code=SYS&local_base=nkc
2010 @ 06 @ 21 @ Solidarita @ http://aleph.nkp.cz/F/?func=find-b&request=002113961&find_code=SYS&local_base=nkc
2010 @ 06 @ 22 @ Studia Ethnologica Pragensia @ http://aleph.nkp.cz/F/?func=find-b&request=002111967&find_code=SYS&local_base=nkc
2010 @ 06 @ 23 @ S?c s?ng @ http://aleph.nkp.cz/F/?func=find-b&request=002109379&find_code=SYS&local_base=nkc
2010 @ 06 @ 24 @ Su-do-ku víte@ že...?', 'http://aleph.nkp.cz/F/?func=find-b&request=002112114&find_code=SYS&local_base=nkc
2010 @ 06 @ 25 @ Trefa @ http://aleph.nkp.cz/F/?func=find-b&request=002110919&find_code=SYS&local_base=nkc
2010 @ 06 @ 26 @ UHNinfo @ http://aleph.nkp.cz/F/?func=find-b&request=002113962&find_code=SYS&local_base=nkc
2010 @ 06 @ 27 @ Watch it! @ http://aleph.nkp.cz/F/?func=find-b&request=002029181&find_code=SYS&local_base=nkc
2010 @ 06 @ 28 @ Zpravodaj : vychází v celém Ústeckém kraji @ http://aleph.nkp.cz/F/?func=find-b&request=002110920&find_code=SYS&local_base=nkc
2010 @ 07 @ 43 @ Video a dvd @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115903&local_base=nkc
2010 @ 07 @ 42 @ Video - domácí kino @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115904&local_base=nkc
2010 @ 07 @ 41 @ T??i m?i & thu?n ti?n @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116937&local_base=nkc
2010 @ 07 @ 40 @ Top Express @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115670&local_base=nkc
2010 @ 07 @ 38 @ Studenta @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116942&local_base=nkc
2010 @ 07 @ 39 @ Svijanoviny @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115235&local_base=nkc
2010 @ 07 @ 37 @ Strom @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115471&local_base=nkc
2010 @ 07 @ 36 @ Stavba a rekonstrukce @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116051&local_base=nkc
2010 @ 07 @ 35 @ Staletá Praha @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116140&local_base=nkc
2010 @ 07 @ 34 @ Sokolovsko @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116258&local_base=nkc
2010 @ 07 @ 33 @ Pantheon @ http://aleph.nkp.cz/F/?func=direct&doc_number=002086668&local_base=nkc
2010 @ 07 @ 32 @ Nezdický občasník @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114350&local_base=nkc
2010 @ 07 @ 31 @ NaScéně.cz @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115243&local_base=nkc
2010 @ 07 @ 30 @ Mosty @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114266&local_base=nkc
2010 @ 07 @ 29 @ Magie image @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114415&local_base=nkc
2010 @ 07 @ 28 @ Magazín : Fakultní nemocnice Na Bulovce @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115659&local_base=nkc
2010 @ 07 @ 27 @ Logos polytechnikos @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114563&local_base=nkc
2010 @ 07 @ 26 @ LOGI @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116907&local_base=nkc
2010 @ 07 @ 24 @ Kultura Evropa @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114115&local_base=nkc
2010 @ 07 @ 25 @ Kurýr @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114123&local_base=nkc
2010 @ 07 @ 23 @ Křížovky autohit @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115890&local_base=nkc
2010 @ 07 @ 22 @ Komfortmag @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115871&local_base=nkc
2010 @ 07 @ 21 @ Koktejl křížovek a kreslených vtipů @ http://aleph.nkp.cz/F/?func=direct&doc_number=002039377&local_base=nkc
2010 @ 07 @ 20 @ Kapr a kapří svět @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115781&local_base=nkc
2010 @ 07 @ 19 @ Journal of noursing@ social studies and public health', 'http://aleph.nkp.cz/F/?func=direct&doc_number=002115694&local_base=nkc
2010 @ 07 @ 18 @ Journal of agrobiology @ http://aleph.nkp.cz/F/?func=direct&doc_number=002009468&local_base=nkc
2010 @ 07 @ 17 @ IK+EM @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115530&local_base=nkc
2010 @ 07 @ 16 @ Chvilka pro luštění @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116574&local_base=nkc
2010 @ 07 @ 15 @ Hroznětínský zpravodaj @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114535&local_base=nkc
2010 @ 07 @ 14 @ Horecký zpravodaj @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116397&local_base=nkc
2010 @ 07 @ 13 @ Hlásnický zpravodaj @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116424&local_base=nkc
2010 @ 07 @ 12 @ Hlas Klánovic @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116912&local_base=nkc
2010 @ 07 @ 11 @ Grasp @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114105&local_base=nkc
2010 @ 07 @ 10 @ Folk @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115790&local_base=nkc
2010 @ 07 @ 09 @ Filmag @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115646&local_base=nkc
2010 @ 07 @ 08 @ Dogs magazín @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116573&local_base=nkc
2010 @ 07 @ 07 @ Devítka @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116559&local_base=nkc
2010 @ 07 @ 06 @ Dáša : číselné křížovky @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116946&local_base=nkc
2010 @ 07 @ 05 @ Bydlení : čtvrtletník pro nájemníky @ http://aleph.nkp.cz/F/?func=direct&doc_number=002116430&local_base=nkc
2010 @ 07 @ 04 @ Assistance news @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114238&local_base=nkc
2010 @ 07 @ 03 @ Antiinfective news @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115517&local_base=nkc
2010 @ 07 @ 02 @ Aconto @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114229&local_base=nkc
2010 @ 07 @ 00 @  @ 
2010 @ 07 @ 01 @ Abala.eu @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114263&local_base=nkc
2010 @ 07 @ 44 @ Zuhause in der Šumava @ http://aleph.nkp.cz/F/?func=direct&doc_number=002114409&local_base=nkc
2010 @ 08 @ 10 @ Zpravodaj místní akční skupiny Valašsko - Horní Vsacko @ http://aleph.nkp.cz/F/?func=direct&doc_number=002121841&local_base=nkc
2010 @ 08 @ 09 @ Zpravodaj místní akční skupiny Podralsko @ http://aleph.nkp.cz/F/?func=direct&doc_number=002121470&local_base=nkc
2010 @ 08 @ 08 @ Středočeský magazín @ http://aleph.nkp.cz/F/?func=direct&doc_number=002121989&local_base=nkc
2010 @ 08 @ 07 @ Ranní a večerní chvály @ http://aleph.nkp.cz/F/?func=direct&doc_number=002121986&local_base=nkc
2010 @ 08 @ 06 @ Psychologie a její kontexty @ http://aleph.nkp.cz/F/?func=direct&doc_number=002121884&local_base=nkc
2010 @ 08 @ 05 @ Osvětimanský zpravodaj @ http://aleph.nkp.cz/F/?func=direct&doc_number=002121462&local_base=nkc
2010 @ 08 @ 04 @ Obec Svojšín : zpravodaj @ http://aleph.nkp.cz/F/?func=direct&doc_number=002121476&local_base=nkc
2010 @ 08 @ 03 @ Naše Česká Třebová @ http://aleph.nkp.cz/F/?func=direct&doc_number=002121805&local_base=nkc
2010 @ 08 @ 02 @ Jasně @ http://aleph.nkp.cz/F/?func=direct&doc_number=002121854&local_base=nkc
2010 @ 08 @ 00 @  @ 
2010 @ 08 @ 01 @ Brněnský metropolitan @ http://aleph.nkp.cz/F/?func=direct&doc_number=002122015&local_base=nkc
2010 @ 08 @ 11 @ Zpravodaj Musica sacra @ http://aleph.nkp.cz/F/?func=direct&doc_number=002121472&local_base=nkc
2010 @ 08 @ 12 @ Zrcadlo @ http://aleph.nkp.cz/F/?func=direct&doc_number=002119022&local_base=nkc
2010 @ 09 @ 36 @ Rossica Olomucensia @ http://aleph.nkp.cz/F/?func=direct&doc_number=001861622&local_base=nkc
2010 @ 09 @ 35 @ Qido @ http://aleph.nkp.cz/F/?func=direct&doc_number=002123967&local_base=nkc
2010 @ 09 @ 34 @ Promedcs news @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126615&local_base=nkc
2010 @ 09 @ 33 @ Podkrkonošský hojič @ http://aleph.nkp.cz/F/?func=direct&doc_number=002124413&local_base=nkc
2010 @ 09 @ 32 @ Plzeňský pohled @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127311&local_base=nkc
2010 @ 09 @ 31 @ Písecký kulturní přehled @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127301&local_base=nkc
2010 @ 09 @ 30 @ Osmisměrky @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126621&local_base=nkc
2010 @ 09 @ 29 @ Obelisk @ http://aleph.nkp.cz/F/?func=direct&doc_number=001176588&local_base=nkc
2010 @ 09 @ 28 @ Nýrské noviny @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126337&local_base=nkc
2010 @ 09 @ 27 @ Nový impuls pro Otrokovice @ http://aleph.nkp.cz/F/?func=direct&doc_number=002128114&local_base=nkc
2010 @ 09 @ 26 @ Moje šestka @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127785&local_base=nkc
2010 @ 09 @ 25 @ Mělnický reklamní občasník @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126420&local_base=nkc
2010 @ 09 @ 24 @ Madeta dnes @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126579&local_base=nkc
2010 @ 09 @ 23 @ Litoměřicko24.cz : Štětí @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127381&local_base=nkc
2010 @ 09 @ 22 @ Litoměřicko24.cz : Roudnice n.L. @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127331&local_base=nkc
2010 @ 09 @ 21 @ Litoměřicko24.cz : Lovosice @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127328&local_base=nkc
2010 @ 09 @ 20 @ Litoměřicko24.cz : Litoměřice. @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127325&local_base=nkc
2010 @ 09 @ 19 @ Korpus - gramatika - axiologie @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126992&local_base=nkc
2010 @ 09 @ 18 @ Kde chci bydlet @ http://aleph.nkp.cz/F/?func=direct&doc_number=001961405&local_base=nkc
2010 @ 09 @ 17 @ Kapka @ http://aleph.nkp.cz/F/?func=direct&doc_number=002124415&local_base=nkc
2010 @ 09 @ 16 @ Jihočeský pohled @ http://aleph.nkp.cz/F/?func=direct&doc_number=002128113&local_base=nkc
2010 @ 09 @ 15 @ ISO news @ http://aleph.nkp.cz/F/?func=direct&doc_number=002125548&local_base=nkc
2010 @ 09 @ 14 @ Chuťovka @ http://aleph.nkp.cz/F/?func=direct&doc_number=002128109&local_base=nkc
2010 @ 09 @ 13 @ Gastroenterology @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126986&local_base=nkc
2010 @ 09 @ 12 @ Fórum sociální práce @ http://aleph.nkp.cz/F/?func=direct&doc_number=002123919&local_base=nkc
2010 @ 09 @ 11 @ Flotila @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127502&local_base=nkc
2010 @ 09 @ 10 @ Fikce a napětí @ http://aleph.nkp.cz/F/?func=direct&doc_number=002125172&local_base=nkc
2010 @ 09 @ 09 @ Export journal @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126993&local_base=nkc
2010 @ 09 @ 08 @ Energonoviny @ http://aleph.nkp.cz/F/?func=direct&doc_number=002115611&local_base=nkc
2010 @ 09 @ 07 @ DPS : plošné zdroje od A do Z @ http://aleph.nkp.cz/F/?func=direct&doc_number=002124856&local_base=nkc
2010 @ 09 @ 06 @ Dobré zprávy ze Znojma @ http://aleph.nkp.cz/F/?func=direct&doc_number=002121518&local_base=nkc
2010 @ 09 @ 05 @ Diabetologia @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126990&local_base=nkc
2010 @ 09 @ 04 @ Dětské osmisměrky @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127080&local_base=nkc
2010 @ 09 @ 03 @ Corpus et Psyché @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127146&local_base=nkc
2010 @ 09 @ 02 @ Byl jednou jeden život @ http://aleph.nkp.cz/F/?func=direct&doc_number=002124412&local_base=nkc
2010 @ 09 @ 00 @  @ 
2010 @ 09 @ 01 @ A-report speciál @ http://aleph.nkp.cz/F/?func=direct&doc_number=002097535&local_base=nkc
2010 @ 09 @ 37 @ Světové křížovky @ http://aleph.nkp.cz/F/?func=direct&doc_number=002123835&local_base=nkc
2010 @ 09 @ 38 @ Textil journal @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127114&local_base=nkc
2010 @ 09 @ 39 @ Turistické noviny @ http://aleph.nkp.cz/F/?func=direct&doc_number=002009387&local_base=nkc
2010 @ 09 @ 40 @ Váš pohled @ http://aleph.nkp.cz/F/?func=direct&doc_number=002127315&local_base=nkc
2010 @ 09 @ 41 @ Zašovské noviny @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126120&local_base=nkc
2010 @ 09 @ 42 @ Zpravodaj ochrany přírody Moravskoslezského kraje @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126402&local_base=nkc
2010 @ 09 @ 43 @ Zvonky @ http://aleph.nkp.cz/F/?func=direct&doc_number=002126391&local_base=nkc
2010 @ 10 @ 12 @ Charitní listy @ http://aleph.nkp.cz/F/?func=direct&doc_number=002133306&local_base=nkc
2010 @ 10 @ 11 @ Hornojiřetínský dialog @ http://aleph.nkp.cz/F/?func=direct&doc_number=002131888&local_base=nkc
2010 @ 10 @ 10 @ Gormiti @ http://aleph.nkp.cz/F/?func=direct&doc_number=002131872&local_base=nkc
2010 @ 10 @ 09 @ Financial assets and investing @ http://aleph.nkp.cz/F/?func=direct&doc_number=002131748&local_base=nkc
2010 @ 10 @ 08 @ Domažlický občasník @ http://aleph.nkp.cz/F/?func=direct&doc_number=002131835&local_base=nkc
2010 @ 10 @ 07 @ Dental news @ http://aleph.nkp.cz/F/?func=direct&doc_number=002131682&local_base=nkc
2010 @ 10 @ 06 @ Československá fotografie @ http://aleph.nkp.cz/F/?func=direct&doc_number=002131744&local_base=nkc
2010 @ 10 @ 05 @ Caxmix @ http://aleph.nkp.cz/F/?func=direct&doc_number=002131818&local_base=nkc
2010 @ 10 @ 04 @ Business car @ http://aleph.nkp.cz/F/?func=direct&doc_number=002131678&local_base=nkc
2010 @ 10 @ 03 @ Bášť se baví : bulletin @ http://aleph.nkp.cz/F/?func=direct&doc_number=002131914&local_base=nkc
2010 @ 10 @ 02 @ Bakugan @ http://aleph.nkp.cz/F/?func=direct&doc_number=002131696&local_base=nkc
2010 @ 10 @ 00 @  @ 
2010 @ 10 @ 01 @ American journal of hematology @ http://aleph.nkp.cz/F/?func=direct&doc_number=002132936&local_base=nkc
2010 @ 10 @ 24 @ Sesterna @ http://aleph.nkp.cz/F/?func=direct&doc_number=002133525&local_base=nkc
2010 @ 10 @ 25 @ Syslojed @ http://aleph.nkp.cz/F/?func=direct&doc_number=002130664&local_base=nkc
2010 @ 10 @ 26 @ Youth time @ http://aleph.nkp.cz/F/?func=direct&doc_number=002132190&local_base=nkc
