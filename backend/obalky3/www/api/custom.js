/*
 * http://www.obalkyknih.cz
 *
 * Tento soubor je mozne stahnout a funkce volne modifikovat.
 *
 * (c)2009 Martin Sarfy <martin@sarfy.cz>
 */

function obalky_display_thumbnail(element, bibinfo) {
	if(bibinfo["cover_icon_url"]) {
		var ahref = document.createElement("A");
		ahref.href = bibinfo["backlink_url"];
		ahref.border = 0;
		var img = document.createElement("IMG");
		img.src = bibinfo["cover_icon_url"];
		ahref.appendChild(img);
		img.style.borderStyle = "none";
		element.appendChild(ahref);
	}
}
function obalky_display_cover(element, bibinfo) {
	if(bibinfo["cover_medium_url"]) {
		var ahref = document.createElement("A");
		ahref.href = bibinfo["backlink_url"];
		ahref.border = 0;
		var img = document.createElement("IMG");
		img.src = bibinfo["cover_medium_url"];
		ahref.appendChild(img);
		img.style.borderStyle = "none";
		element.appendChild(ahref);
	}
}
function obalky_display_reviews(element, book) {
}
function obalky_display_comments(element, book) {
}
function obalky_display_annotation(element, book) {
}
function obalky_display_rating(element, book) {
}
function obalky_display_toc(element, book) {
}
function obalky_display_tips(element, book) {
}

function obalky_display_all(element, book) {
	obalky_display_cover(element, book);
	obalky_display_reviews(element, book);
	obalky_display_rating(element, book);
	obalky_display_toc(element, book);
	obalky_display_tips(element, book);
	obalky_display_comments(element, book);
}
function obalky_display_none(element, book) {
}
function obalky_display_default(element, book) {
	obalky_display_cover(element, book);
	// obalky_display_rating(element, book);
}
function obalky_display_debug(element, bibinfo) { 
	alert("obalky_display_debug("+obalky.stringify(bibinfo)+")"); 
}

