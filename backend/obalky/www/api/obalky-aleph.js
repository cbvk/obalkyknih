<script language="JavaScript">

var obalky_url = (("https:" == document.location.protocol)
        ? "https://" : "http://")+"www.obalkyknih.cz";
document.write(unescape("%3Cscript src='" + obalky_url + "/api/functions.js' type='text/javascript'%3E%3C/script%3E"));
document.write(unescape("%3Cscript src='" + obalky_url + "/api/custom.js' type='text/javascript'%3E%3C/script%3E"));


function obalky_display_mine(place, bibinfo) {
//      debug.innerHTML = "obalky_display_mine(bibinfo="+
//                              JSON.stringify(bibinfo)+")";
        if(bibinfo["cover_medium_url"]) {
                var ahref = document.createElement("A");
                ahref.href = bibinfo["backlink_url"];
                ahref.border = 0;
                var img = document.createElement("IMG");
                img.src = bibinfo["cover_medium_url"];
                ahref.appendChild(img);
                img.style.borderStyle = "none";
                place.appendChild(ahref);
                place.appendChild(document.createElement("P"));
        }
        if(bibinfo["toc_pdf_url"]) {
                var ahref = document.createElement("A");
                ahref.href = bibinfo["toc_pdf_url"];
                ahref.border = 0;
                var img = document.createElement("IMG");
                img.src = bibinfo["toc_thumbnail_url"];
                img.style.borderStyle = "none";
                ahref.appendChild(img);
                place.appendChild(ahref);
        }

}
function obalky_custom_onload() {
        var table = document.getElementById("fullbody");
        var bibinfo = { "authors": [] };
        var permalink;
        var debug = document.getElementById("obalky_test");
        var rows = table.getElementsByTagName("tr");
        for(i = 0; i < rows.length; i++) {
                var tds = rows[i].getElementsByTagName("td");
                var key = tds[0].innerText ? tds[0].innerText : tds[0].textContent;
                var val = tds[1].innerText ? tds[1].innerText : tds[1].textContent;
                var value = val ? val.replace(new
                        RegExp("[\n\t ]+"+String.fromCharCode(36)),"").
                        replace(/^[\n\t ]+/,"") : ''; // 36 - Aleph dolary zere..
                if(key.match(/ISBN/)) bibinfo["isbn"] = value;
                if(key.match(/ISSN/)) bibinfo["isbn"] = value;
                if(key.match(/EAN/)) bibinfo["ean"] = value;
                if(key.match(/.NB/) && value.match(/cnb/)) 
									  bibinfo["nbn"] = value;
                if(key.match(/N.zev/) && !key.match(/origin/)) bibinfo["title"] =
                                        value.replace(/\s+[\/\:].*/,'');
                if(key.match(/Rok vyd/)) {
                        bibinfo["year"] = value;
                }
                if(key.match(/SYSNO/i)) {
                        permalink = "http://aleph.muni.cz/"+
                                "F?func=find-c&ccl_term=sys="+value;
                }
                if(key.match(/Auto/)) bibinfo["authors"].push( value );
        }
        obalky.process("obalky_display_mine","cover_place",permalink,bibinfo);
        obalky.onload();
}

</script>
