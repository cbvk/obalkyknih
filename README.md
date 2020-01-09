Implementační manuál

[[https://docs.google.com/document/d/1b2iw31p5Izs0cHyDmErETQSp4KppBVm05BBCkiw67kI/]]


Obálky knih.cz 3.4
==================

Implementátorům doporučuje shlédnout tyto nové funkce:
* [Doporučování literatury](https://github.com/cbvk/obalkyknih/wiki/Doporu%C4%8Dov%C3%A1n%C3%AD-literatury)
* [Další vydání titulu](https://github.com/cbvk/obalkyknih/wiki/Dal%C5%A1%C3%AD-vyd%C3%A1n%C3%AD-titulu)
* [Seznam použité literatury](https://github.com/cbvk/obalkyknih/wiki/Seznam-pou%C5%BEit%C3%A9-literatury)


Obálky knih.cz 3.3
==================

Metadatový kontejner obohacen o odkazy na digitalizované dokumenty z digitální knihovny Kramerius včetně informace, jestli se jedná o veřejný dokument, např.:

<pre>
  "dig_obj": {
   "BOA001": {
    "public": "1",
    "url": "https://kramerius.mzk.cz/search/i.jsp?pid=uuid:3a75b860-8bae-11e2-a920-005056827e51",
    "uuid": "uuid:3a75b860-8bae-11e2-a920-005056827e51"
   }
  }
</pre>

Metadatový kontejner obohacen o odkazy na veřejně přístupné e-knihy z produkce Městské knihovny Praha, např.:

<pre>
  "ebook": [
   {
    "url": "https://web2.mlp.cz/koweb/00/04/13/10/41/zongleruv-slabikar.epub",
    "type": "epub"
   },
   {
    "url": "https://web2.mlp.cz/koweb/00/04/13/10/41/zongleruv-slabikar.pdf",
    "type": "pdf"
   },
   {
    "url": "https://web2.mlp.cz/koweb/00/04/13/10/41/zongleruv-slabikar.prc",
    "type": "prc"
   }
  ]
</pre>


Obálky knih.cz 3.2
==================

Došlo k obohacení API projektu Obálky knih.cz o "obálky" autorů.

Ukázka na stránkách projektu: <a href="http://www.obalkyknih.cz/view_auth?auth_id=jk01083016">http://www.obalkyknih.cz/view_auth?auth_id=jk01083016</a>


Obálky knih.cz 3.1
==================

Podstatou této části projektu Obálky knih.cz (OKCZ) je podpora vícesvazkových monografií a periodik.

Je řešena otázka skenování částí monografií a čísel periodik a poskytování knihovním informačním systémům v podobě API v3.1. 


Obálky knih.cz 3.0
==================

Podstatou projektu je prozdělit řešení obalkyknih.cz na backend (perl/catalyst a MySQL) a nový frontend (node.js a MongoDB), ktery tvoří kešovací vrstvu pro backend. 

Backend je zodpovědný za import dat a portál obalkyhnih.cz, frontend je převážně read-only, poskytuje metadata a náhledy obálek.

Licence:
--------
GNU General Public License version 2.0 (GPLv2)
