/*
 * http://www.obalkyknih.cz
 *
 * API Functions
 *
 * (c)2009 Martin Sarfy <martin@sarfy.cz>
 */

var obalky = obalky || {};

obalky.protocol = 
	(document.location.protocol == 'https:') ? 'https://':'http://';
obalky.url = obalky.protocol+"www.obalkyknih.cz";

obalky.books = obalky.books || [];
obalky.version = "0.2.0";
obalky.id = 0;
obalky.msie = navigator.userAgent.indexOf("MSIE") != -1 ? 1 : 0;

obalky.callback = obalky.callback || function (books) {
	for(var i=0;i<books.length;i++) {
		for(var j=0;j<books[i]["callbacks"].length;j++) {
			callback = books[i]["callbacks"][j];
			var element = document.getElementById(callback["id"]);
			var function_pointer = eval(callback["name"]);
			if(function_pointer) function_pointer(element,books[i]);
		}
	}
};

obalky.download = obalky.download || function (books) {
	var obalky_json = "obalky_json_"+obalky.id++;
	var jsonScript = document.getElementById(obalky_json);
	if (jsonScript) jsonScript.parentNode.removeChild(jsonScript);
	var scriptElement = document.createElement("script");
	scriptElement.setAttribute("id", obalky_json);
	scriptElement.setAttribute("type", "text/javascript");
	scriptElement.setAttribute("src", obalky.url+"/api/books?books="+
		encodeURIComponent(JSON.stringify(books)));
	document.documentElement.firstChild.appendChild(scriptElement);
};

obalky.findFirstNodeByClass = function (startNode, className) {
	if(!(startNode.nodeType === 1)) return null; // skip non-elements
	if(startNode.className == className) return startNode;
	var childs = startNode.childNodes;
	for(var i=0;i<childs.length;i++) {
		var found = obalky.findFirstNodeByClass(childs[i], className);
		if(found) return found;
	}
	return null;
};

obalky.findNodesByClass = function (startNode, className) {
	var nodes = (startNode.className == className) ? [ startNode ] : [];
	var childs = startNode.childNodes;
	for(var i=0;i<childs.length;i++)
		nodes = nodes.concat(obalky.findNodesByClass(childs[i], className));
	return nodes;
};
obalky.getValue = function (startNode, className) {
	var el = obalky.findFirstNodeByClass(startNode, className);
	return el ? (el.textContent ? el.textContent : el.innerHTML ) : undefined;
};
obalky.onload = function() {
	var id = 0;
	var book_els = obalky.findNodesByClass(document.body,"obalky_book");
	var books = [];
	for(var i=0;i<book_els.length;i++) {
		var book = book_els[i];
		// nacti permalink
		var permalink = obalky.getValue(book,"obalky_permalink");
	    var el = obalky.findFirstNodeByClass(book, "obalky_permalink");
		if(!permalink) continue;	

		var info = obalky.findFirstNodeByClass(book,"obalky_bibinfo");
		if(!info) continue;

		// nacti ostatni...
		var bibinfo = {};
		bibinfo["isbn"] = obalky.getValue(info,"obalky_isbn");
		bibinfo["issn"] = obalky.getValue(info,"obalky_issn");
		bibinfo["cnb"]  = obalky.getValue(info,"obalky_cnb"); // 924658
		bibinfo["ean"]  = obalky.getValue(info,"obalky_ean"); // 1121121

		// zkontroluj povinna metadata?

		var callback_els = obalky.findNodesByClass(book,"obalky_callback");
		var calls = [];
		for(var j=0;j<callback_els.length;j++) {
			var callback = callback_els[j];
			callback.id = callback.id ? callback.id : "obalky_callback_"+(++id);
			calls.push(	{ "name": callback.getAttribute("name"), 
						  "id": callback.id });
		}
		books.push( { "permalink": permalink, "bibinfo": bibinfo, 
		              "callbacks": calls } );
		if(obalky.msie || books.length > 10) {
			obalky.download(books);
			books = []; 
		}
	}
	if(!obalky.msie) obalky.download(books);
};
obalky.process = function(callback_name, element_id, permalink, bibinfo) {
	var books = [ { "permalink" : permalink, "bibinfo": bibinfo, 
			"callbacks": [ { "name": callback_name, "id": element_id } ] } ];
	obalky.download(books);
}
/*obalky.previous_onload = window.onload; // IE way...
window.onload = function() {
	if(obalky.previous_onload) obalky.previous_onload();
	obalky.onload();
	if(obalky_custom_onload) obalky_custom_onload();
};*/
/*document.addEventListener("load", function(event) { obalky.onload(); }, false);*/


/*
   if (document.addEventListener) {
       document.addEventListener("DOMContentLoaded", obalky.onload, false);
   } else if (window.attachEvent) {
		 window.attachEvent("onload", obalky.onload); 
	}
*/


/* ------------------------------------------------------------------------- */
/* http://www.JSON.org/json2.js (minified)                                   */
if(!this.JSON){this.JSON={};}
(function(){function f(n){return n<10?'0'+n:n;}
if(typeof Date.prototype.toJSON!=='function'){Date.prototype.toJSON=function(key){return isFinite(this.valueOf())?this.getUTCFullYear()+'-'+
f(this.getUTCMonth()+1)+'-'+
f(this.getUTCDate())+'T'+
f(this.getUTCHours())+':'+
f(this.getUTCMinutes())+':'+
f(this.getUTCSeconds())+'Z':null;};String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(key){return this.valueOf();};}
var cx=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,escapable=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,gap,indent,meta={'\b':'\\b','\t':'\\t','\n':'\\n','\f':'\\f','\r':'\\r','"':'\\"','\\':'\\\\'},rep;function quote(string){escapable.lastIndex=0;return escapable.test(string)?'"'+string.replace(escapable,function(a){var c=meta[a];return typeof c==='string'?c:'\\u'+('0000'+a.charCodeAt(0).toString(16)).slice(-4);})+'"':'"'+string+'"';}
function str(key,holder){var i,k,v,length,mind=gap,partial,value=holder[key];if(value&&typeof value==='object'&&typeof value.toJSON==='function'){value=value.toJSON(key);}
if(typeof rep==='function'){value=rep.call(holder,key,value);}
switch(typeof value){case'string':return quote(value);case'number':return isFinite(value)?String(value):'null';case'boolean':case'null':return String(value);case'object':if(!value){return'null';}
gap+=indent;partial=[];if(Object.prototype.toString.apply(value)==='[object Array]'){length=value.length;for(i=0;i<length;i+=1){partial[i]=str(i,value)||'null';}
v=partial.length===0?'[]':gap?'[\n'+gap+
partial.join(',\n'+gap)+'\n'+
mind+']':'['+partial.join(',')+']';gap=mind;return v;}
if(rep&&typeof rep==='object'){length=rep.length;for(i=0;i<length;i+=1){k=rep[i];if(typeof k==='string'){v=str(k,value);if(v){partial.push(quote(k)+(gap?': ':':')+v);}}}}else{for(k in value){if(Object.hasOwnProperty.call(value,k)){v=str(k,value);if(v){partial.push(quote(k)+(gap?': ':':')+v);}}}}
v=partial.length===0?'{}':gap?'{\n'+gap+partial.join(',\n'+gap)+'\n'+
mind+'}':'{'+partial.join(',')+'}';gap=mind;return v;}}
if(typeof JSON.stringify!=='function'){JSON.stringify=function(value,replacer,space){var i;gap='';indent='';if(typeof space==='number'){for(i=0;i<space;i+=1){indent+=' ';}}else if(typeof space==='string'){indent=space;}
rep=replacer;if(replacer&&typeof replacer!=='function'&&(typeof replacer!=='object'||typeof replacer.length!=='number')){throw new Error('JSON.stringify');}
return str('',{'':value});};}
if(typeof JSON.parse!=='function'){JSON.parse=function(text,reviver){var j;function walk(holder,key){var k,v,value=holder[key];if(value&&typeof value==='object'){for(k in value){if(Object.hasOwnProperty.call(value,k)){v=walk(value,k);if(v!==undefined){value[k]=v;}else{delete value[k];}}}}
return reviver.call(holder,key,value);}
cx.lastIndex=0;if(cx.test(text)){text=text.replace(cx,function(a){return'\\u'+
('0000'+a.charCodeAt(0).toString(16)).slice(-4);});}
if(/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,'@').replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,']').replace(/(?:^|:|,)(?:\s*\[)+/g,''))){j=eval('('+text+')');return typeof reviver==='function'?walk({'':j},''):j;}
throw new SyntaxError('JSON.parse');};}}());
/* ------------------------------------------------------------------------- */
/* http://www.devpro.it/JSL/  (encodeURIComponent)                           */
// (C) Andrea Giammarchi - JSL 1.4b
eval(function(A,G){return eval('["'+A.replace(/(\\|")/g,'\\$1').replace(/(\w+)/g,'",G[parseInt("$1",36)],"')+'"].join("")')}("0 1;2 $3(){4.5=2(){0 6=7,8=9[a].b;c(8&&!6)6=9[a][--8]===9[d];e 6;};4.f=2(g){e $3.5(g,$f)};4.h=2(i){0 6=$3.$h();c(j(i[6])!==\"1\")6=$3.$h();e 6;};4.$h=2(){e(k.h()*l).m()};4.n=2(g){e g.o(\"\").n().p(\"\")};4.q=2(g){0 6=g.o(\"\"),8=6.b;c(8>d)6[--8]=$3.$q(6[8]);e 6.p(\"\");};4.$q=2(6){0 8=6.b===a?6.r(d):d;s(8){t u:6=\"\\\\v\";w;t x:6=\"\\\\y\";w;t z:6=\"\\\\10\";w;t 11:6=\"\\\\12\";w;t 13:6=\"\\\\14\";w;t 15:6=\"\\\\\\\"\";w;t 16:6=\"\\\\\\\\\";w;17:6=6.q(/([\\18-\\19]|[\\1a-\\1b]|[\\1c-\\1d])/1e,2(1f,v){e \"\\\\1g\"+$3.r(v)}).q(/([\\1h-\\1i])/1e,2(1f,v){v=$3.r(v);e v.b<1j?\"\\\\1k\"+v:\"\\\\1l\"+v});w;};e 6;};4.r=2(g){e $3.$r(g.r(d))};4.$r=2(8){0 g=8.m(1m).1n();e g.b<1o?\"d\"+g:g;};4.$1p=2(i){e i.1p().q(/^(\\(1q \\1r+\\()([^\\d]+)(\\)\\))$/,\"$1o\")};4.$1s=2(i){0 6=1t;s(i.1u){t 1v:t 1w:6=i;w;t 1x:6=$3.$1p(i);w;17:6=i.1p();w;};e 6;};4.1y=2(1z,8,i,g){0 6=$3.$1y(1z),20=6.b,$6=[];c(8<20){21(6[8][g]===i||i===\"*\")$6.22($3.$23(6[8]));++8};21(!$6.24){21(!$3.f(\"24\"))$f.22(\"24\");$6.24=2(6){e 4[6]}};e $6;};4.$1y=2(1z){e 1z.25||1z.26};4.$23=2(i){21(!i.1y)i.1y=27.1y;e i;};4.28=2(g){e g.q(/\"/1e,\"%29\").q(/\\\\/1e,\"%2a\")};4.$28=2(g){e $3.$r(g)};4.$2b=2(1f,v){0 8=v.r(d),g=[];21(8<2c)g.22(8);2d 21(8<2e)g.22(2f+(8>>2g),2c+(8&2h));2d 21(8<2i)g.22(2j+(8>>11),2c+(8>>2g&2h),2c+(8&2h));2d g.22(2k+(8>>2l),2c+(8>>11&2h),2c+(8>>2g&2h),2c+(8&2h));e \"%\"+g.2m($3.$28).p(\"%\");};4.$2n=2(1f,v,2o,2p,2q){0 8=d;21(2q)8=2r(2q.2s(a,1o),1m);2d 21(2p)8=((2r(2p.2s(a,1o),1m)-2f)<<2g)+(2r(2p.2s(1j,1o),1m)-2c);2d 21(2o)8=((2r(2o.2s(a,1o),1m)-2j)<<11)+((2r(2o.2s(1j,1o),1m)-2c)<<2g)+(2r(2o.2s(2t,1o),1m)-2c);2d 8=((2r(v.2s(a,1o),1m)-2k)<<2l)+((2r(v.2s(1j,1o),1m)-2c)<<11)+((2r(v.2s(2t,1o),1m)-2c)<<2g)+(2r(v.2s(x,1o),1m)-2c);e 1x.2u(8);};0 $f=[];21(!2v.2w.1p){$f[$f.b]=\"1p\";2v.2w.1p=2(){0 g=[];s(4.1u){t 1v:g.22(\"(1q 1v(\",4,\"))\");w;t 1w:g.22(\"(1q 1w(\",4,\"))\");w;t 1x:g.22(\"(1q 1x(\\\"\",$3.q(4),\"\\\"))\");w;t 2x:g.22(\"(1q 2x(\",4.2y(),\"))\");w;t 2z().1u:g.22(\"(1q 2z(\",$3.$1p(4.30),\",\",$3.$1p(4.31),\",\",4.32,\"))\");w;t 33:g.22(\"(\",$3.$q(4.m()),\")\");w;t 34:0 8=d,20=4.b;c(8<20)g.22($3.$1s(4[8++]));g=[\"[\",g.p(\", \"),\"]\"];w;17:0 8=d,6;35(8 36 4){21(8!==\"1p\")g.22($3.$1p(8)+\":\"+$3.$1s(4[8]));};g=[\"{\",g.p(\", \"),\"}\"];w;};e g.p(\"\");}};21(!33.2w.37){$f[$f.b]=\"37\";33.2w.37=2(){0 8=9.b===1o?9[a].b:d,g,6=[],i=(\"\"+4).q(/[^\\(]+/,\"2\");21(!9[d])9[d]={};c(8)6.38(\"9[a][\"+(--8)+\"]\");39{g=\"3a\".3b($3.h(9[d]).q(/\\./,\"3c\"),\"3a\")}c(1q 3d(g).3e(i));3f(\"0 \".3b(g,\"=9[d];6=(\",i.q(/([^$])\\3g\\v([^$])/1e,\"$a\".3b(g,\"$1o\")),\")(\",6.p(\",\"),\")\"));e 6;}};21(!33.2w.3h){$f[$f.b]=\"3h\";33.2w.3h=2(){0 8=9.b,6=[];c(8>a)6.38(9[--8]);e 4.37((8?9[d]:{}),6);}};21(!34.2w.3i){$f[$f.b]=\"3i\";34.2w.3i=2(){0 1f=4.b,14=4[--1f];21(1f>=d)4.b=1f;e 14;}};21(!34.2w.22){$f[$f.b]=\"22\";34.2w.22=2(){0 1f=d,v=9.b,14=4.b;c(1f<v)4[14++]=9[1f++];e 14;}};21(!34.2w.3j){$f[$f.b]=\"3j\";34.2w.3j=2(){4.n();0 14=4.3i();4.n();e 14;}};21(!34.2w.3k){$f[$f.b]=\"3k\";34.2w.3k=2(){0 1f,v,2o,2p=9.b,6=[],14=[];21(2p>a){9[d]=2r(9[d]);9[a]=2r(9[a]);2o=9[d]+9[a];35(1f=d,v=4.b;1f<v;1f++){21(1f<9[d]||1f>=2o){21(1f===2o&&2p>1o){35(1f=1o;1f<2p;1f++)6.22(9[1f]);1f=2o;};6.22(4[1f]);}2d 14.22(4[1f]);};35(1f=d,v=6.b;1f<v;1f++)4[1f]=6[1f];4.b=1f;};e 14;}};21(!34.2w.38){$f[$f.b]=\"38\";34.2w.38=2(){0 8=9.b;4.n();c(8>d)4.22(9[--8]);4.n();e 4.b;}};21(!34.2w.3l){$f[$f.b]=\"3l\";34.2w.3l=2(i,8){0 20=4.b;21(!8)8=d;21(8>=d){c(8<20){21(4[8++]===i){8=8-a+20;20=8-20;}}}2d 20=4.3l(i,20+8);e 20!==4.b?20:-a;}};21(!34.2w.3m){$f[$f.b]=\"3m\";34.2w.3m=2(i,8){0 20=-a;21(!8)8=4.b;21(8>=d){39{21(4[8--]===i){20=8+a;8=d;}}c(8>d)}2d 21(8>-4.b)20=4.3m(i,4.b+8);e 20;}};21(!34.2w.3n){$f[$f.b]=\"3n\";34.2w.3n=2(3o,i){0 v=7,8=d,20=4.b;21(!i){c(8<20&&!v)v=!3o(4[8]||4.3p(8),8++,4)}2d{c(8<20&&!v)v=!3o.37(i,[4[8]||4.3p(8),8++,4]);}e!v;}};21(!34.2w.3q){$f[$f.b]=\"3q\";34.2w.3q=2(3o,i){0 14=[],8=d,20=4.b;21(!i){c(8<20){21(3o(4[8],8++,4))14.22(4[8-a]);}}2d{c(8<20){21(3o.37(i,[4[8],8++,4]))14.22(4[8-a]);}}e 14;}};21(!34.2w.3r){$f[$f.b]=\"3r\";34.2w.3r=2(3o,i){0 8=d,20=4.b;21(!i){c(8<20)3o(4[8],8++,4)}2d{c(8<20)3o.37(i,[4[8],8++,4]);}}};21(!34.2w.2m){$f[$f.b]=\"2m\";34.2w.2m=2(3o,i){0 14=[],8=d,20=4.b;21(!i){c(8<20)14.22(3o(4[8],8++,4))}2d{c(8<20)14.22(3o.37(i,[4[8],8++,4]));}e 14;}};21(!34.2w.3s){$f[$f.b]=\"3s\";34.2w.3s=2(3o,i){0 v=7,8=d,20=4.b;21(!i){c(8<20&&!v)v=3o(4[8],8++,4)}2d{c(8<20&&!v)v=3o.37(i,[4[8],8++,4]);}e v;}};21(!1x.2w.3m){21(!4.5(\"3m\",$f))$f[$f.b]=\"3m\";1x.2w.3m=2(i,8){0 g=$3.n(4),i=$3.n(i),14=g.3l(i,8);e 14<d?14:4.b-14;}};21(\"3t\".q(/\\1r/1e,2(){e 9[a]+\" \"})!==\"d a \"){$f[$f.b]=\"q\";1x.2w.q=2(q){e 2(3u,3v){0 14=\"\",6=$3.h(1x);1x.2w[6]=q;21(3v.1u!==33)14=4[6](3u,3v);2d{2 3w(3u,3x,1f){2 3y(){0 1f=3u.3l(\"(\",3x),v=1f;c(1f>d&&3u.3p(--1f)===\"\\\\\"){};3x=v!==-a?v+a:v;e(v-1f)%1o===a?a:d;};39{1f+=3y()}c(3x!==-a);e 1f;};2 $q(g){0 20=g.b-a;c(20>d)g[--20]=\'\"\'+g[20].2s(a,g[20--].b-1o)[6](/(\\\\|\")/1e,\'\\\\$a\')+\'\"\';				e g.p(\"\");			};			0 3z=-a,8=3w(\"\"+3u,d,d),40=[],$41=4.41(3u),i=$3.$h()[6](/\\./,\'42\');			c(4.3l(i)!==-a)i=$3.$h()[6](/\\./,\'42\');			c(8)40[--8]=[i,\'\"$\',(8+a),\'\"\',i].p(\"\");			21(!40.b)14=\"$41[8],(3z=4.3l($41[8++],3z+a)),4\";			2d		14=\"$41[8],\"+40.p(\",\")+\",(3z=4.3l($41[8++],3z+a)),4\";			14=3f(\'[\'+$q((i+(\'\"\'+4[6](3u,\'\"\'+i+\',3v(\'+14+\'),\'+i+\'\"\')+\'\"\')+i).o(i))[6](/\\y/1e,\'\\\\y\')[6](/\\14/1e,\'\\\\14\')+\'].p(\"\")\');		};		43 1x.2w[6];		e 14;	}}(1x.2w.q)};	21((1q 2x().44()).m().b===1j){$f[$f.b]=\"44\";2x.2w.44=2(){		e 4.45()-46;	}};};$3=1q $3();21(j(28)===\"1\"){2 28(g){	0 i=/([\\18-\\47]|[\\48|\\49|\\4a|\\4b|\\4c|\\4d|\\4e|\\1c]|[\\4f-\\4g]|[\\4h-\\1i])/1e;	e $3.28(g.m().q(i,$3.$2b));}};21(j(2b)===\"1\"){2 2b(g){	0 i=/([\\4i|\\4j|\\4k|\\4l|\\4m|\\4n|\\4o|\\4p|\\4q|\\4r|\\4s])/1e;	e $3.28(28(g).q(i,2(1f,v){e \"%\"+$3.r(v)}));}};21(j(2n)===\"1\"){2 2n(g){	0 i=/(%4t[d-4u-4t]%4v[d-4u-4t]%[4w-4x][d-4u-4t]%[u-4u-4x][d-4u-4t])|(%4v[d-4u-4t]%[4w-4x][d-4u-4t]%[u-4u-4x][d-4u-4t])|(%[4y-4z][d-4u-4t]%[u-4u-4x][d-4u-4t])|(%[d-4u-4t]{1o})/1e;	e g.m().q(i,$3.$2n);}};21(j(50)===\"1\"){2 50(g){	e 2n(g);}};21(!27.51){27.51=2(i){	e $3.$23($3.$1y(4)[i]);}};21(!27.1y){27.1y=2(i){	e $3.1y(4,d,i.1n(),\"52\");}};21(!27.23){27.23=2(i){	e $3.1y(4,d,i,\"53\");}};21(j(54)===\"1\"){54=2(){	0 6=1t,i=55.56;	21(i.1n().3l(\"57 1j\")<d&&58.59)		6=i.3l(\"57 5a\")<d?1q 59(\"5b.5c\"):1q 59(\"5d.5c\");	e 6;}};21(j(2z)===\"1\")2z=2(){};2z = 2(5e){e 2(30){	0 6=1q 5e();	6.30=30||\"\";	21(!6.31)		6.31=27.5f.5g;	21(!6.32)		6.32=d;	21(!6.5h)		6.5h=\"2z()@:d\\y(\\\"\"+4.30+\"\\\")@\"+6.31+\":\"+4.32+\"\\y@\"+6.31+\":\"+4.32;	21(!6.53)		6.53=\"2z\";	e 6;}}(2z);","var,undefined,function,JSL,this,inArray,tmp,false,i,arguments,1,length,while,0,return,has,str,random,elm,typeof,Math,1234567890,toString,reverse,split,join,replace,charCodeAt,switch,case,8,b,break,10,n,11,v,12,f,13,r,34,92,default,x00,x07,x0E,x1F,x7F,xFF,g,a,x,u0100,uFFFF,4,u0,u,16,toUpperCase,2,toSource,new,w,toInternalSource,null,constructor,Boolean,Number,String,getElementsByTagName,scope,j,if,push,getElementsByName,item,layers,all,document,encodeURI,22,5C,encodeURIComponent,128,else,2048,0xC0,6,0x3F,65536,0xE0,0xF0,18,map,decodeURIComponent,c,d,e,parseInt,substr,7,fromCharCode,Object,prototype,Date,getTime,Error,message,fileName,lineNumber,Function,Array,for,in,apply,unshift,do,__,concat,_,RegExp,test,eval,bthis,call,pop,shift,splice,indexOf,lastIndexOf,every,callback,charAt,filter,forEach,some,aa,reg,func,getMatches,pos,io,p,args,match,_AG_,delete,getYear,getFullYear,1900,x20,x25,x3C,x3E,x5B,x5D,x5E,x60,x7B,x7D,x80,x23,x24,x26,x2B,x2C,x2F,x3A,x3B,x3D,x3F,x40,F,9A,E,A,B,C,D,decodeURI,getElementById,tagName,name,XMLHttpRequest,navigator,userAgent,MSIE,window,ActiveXObject,5,Msxml2,XMLHTTP,Microsoft,base,location,href,stack".split(",")));
/* ------------------------------------------------------------------------- */

