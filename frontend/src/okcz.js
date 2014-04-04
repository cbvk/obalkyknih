/// version 10
/// mongodb://url:port/database  - spojeni na mongodb
var urlmongo = "mongodb://localhost:27017/test"
/// url na backend
//var urlMain = "192.168.1.25"
var urlMain = "www.obalkyknih.cz"
var urlPart = "/"
/// okcz - "api/books", oksk - "csp/OKSK/util.ws.cover.cls"
var urlMetadata = "api/books"
var urlCover = "file/cover/"
var urlCoverApi = "api/cover"
var urlParams = "?books="
/// okcz | oksk
var metaCollection = "okcz"
/// url frontendu / slolecne url vsech frontnendu
var urlReplace = "195.113.145.14:1337"
/// port frontendu
var frontPort = 1337;
/// timeout dotazu na backend (ms)
var timeout = 5 * 1000;
/// doba, po ktere se opet zkusime doptat backendu po timeoutu (ms)
var timeOutDuration = 1000 * 1000;
/// doba, po ktere se opet pokusime stahnout nahled, pokud ho backend nemel (ms)
var timeNotfound = 86400 * 1000;

// =========================================

var mongo = require('mongodb');
var client = mongo.MongoClient;
var http = require('http');
var request = require('request');
var ISBN = require('isbn').ISBN;
var URL = require('url');
var etags = {}; // obsahuje vsechny platne etag pro cache prohlizecu
var etagMatchCount = 0; // pocet dotazu na obalku kesovanych prohlizecem od spusteni
var metaRequests = 0; // pocet dotazu na metadata od spusteni
var metaFetches = 0; // pocet nacteni metadat z backendu od spusteni
var coverRequests = 0; // pocet dotazu obalky pres urlCover od spusteni
var coverApiRequests = 0; // pocet dotazu obalky pres urlCoverApi od spusteni
var coverFetches = 0; // pocet nacteni obalky z backendu od spusteni
var coverNotfound = 0; // pocet nenalezenych obalek z backendu od spusteni
var timeoutCount = 0; // pocet timeout nedostupnosti backendu od spusteni
var dateTimeout = 0; // cas do kdy je platny timeout
var dateStartup = new Date(); // doba startu
var referers = {}; // povolene referer hlavicky
var perms = {}; // povolene ip adresy


client.connect(urlmongo, function (err, db) {
  if (err) {  return console.dir(err); }
  getPerms(db);
  
  http.createServer(function (req, response) {    
    var requrl = req.url;
    // console.log('referers: ' + JSON.stringify(referers));
    // console.log('perms: ' + JSON.stringify(perms));
    // console.log(req.connection.remoteAddress);
    // console.log(requrl);
    var query = URL.parse(requrl,true).query;
    // console.log('query: ' + JSON.stringify(query));
    var date = new Date();
    var timestamp = date.toISOString();
    var now = date.getTime();
    // console.log(timestamp);
    // console.log('HEAD: ' + JSON.stringify(req.headers));
    var etag=req.headers['if-none-match'];
    var referer=req.headers['referer'];
    var remoteIP=req.connection.remoteAddress;
    // console.log(etags);    
    // console.log('index: ' + requrl.indexOf(urlMetadata));
  
    if (requrl === '/favicon.ico') {
      // console.log('favicon');
      response.statusCode = 404;
      response.end();
    }
    else if (etags[etag] !== undefined) {
      // console.log('etag match: ' + etag);
      etagMatchCount++;
      response.statusCode = 304;
      response.end();   
    }
    else if ((requrl.indexOf(urlCover))>0) {
      if (!refererValid(referer,remoteIP)) {
        response.writeHead(404);
        response.end('referer');
        return;
      }

      // console.log('xx');
      coverRequests++;
      cover(requrl.split('?')[0]);
    }
    else if ((requrl.indexOf(urlCoverApi))>0) {
      if (!refererValid(referer,remoteIP)) {
        response.writeHead(404);
        response.end('referer');
        return;
      }

      // console.log('yy');
      if (query.isbn) {
        isbn=query.isbn.split(' ')[0];
        ean=ISBN.asIsbn13(isbn);
        if (ean===null) {            
          if (isbn.length=13 && !isNaN(isbn)) {
            ean=isbn
            console.log('maybe ean: ' + isbn);
          } else {
            response.writeHead(404);
            response.end('identifier');
            return;
          }
        }
        db.collection(metaCollection).findOne({ean: ean}, function (err, item) {
          if (!item) {
            var fetch=JSON.stringify([{bibinfo:{ean:ean},permalink:'a'}]);
            metadata(fetch,[],true);
            return;
          }
          else if (!item.cover_medium_url) {
            response.writeHead(404);
            response.end();
            return;
          }
          // console.dir(item);
          var coverUrl = item.cover_medium_url.slice(item.cover_medium_url.indexOf('/',8));
          // console.log(coverUrl);
          coverApiRequests++;
          cover(coverUrl);
        });
      }
      else if (query.nbn) {
        db.collection(metaCollection).findOne({nbn: query.nbn}, function (err, item) {
          if (!item) {
            var fetch=JSON.stringify([{bibinfo:{nbn:query.nbn},permalink:'a'}]);
            metadata(fetch,[],true);
            return;
          }
          else if (!item.cover_medium_url) {
            response.writeHead(404);
            response.end();
            return;
          }
          // console.dir(item);k
          var coverUrl = item.cover_medium_url.slice(item.cover_medium_url.indexOf('/',8));
          // console.log(coverUrl);
          coverApiRequests++;
          cover(coverUrl);
        });
      } else {
        response.writeHead(404);
        response.end('identifier');
        return;
      }      
    }
    else if ((requrl.indexOf(urlMetadata))>0) {
      if (!perms[remoteIP]) {
        console.log('access denied')
        response.writeHead(404);
        response.end();
        return;
      }

      var ean = '';
      var isbns = [];
      var isbna = [];
      var isbno = {};
      metaRequests++;

      if (query.isbn) {
        var isbns = query.isbn.split(',');
        // console.log('isbns: ' + isbns);
        // console.log('length: ' + isbns.length);

        for (var i=0;i<isbns.length;i++) {              
          var isbn=isbns[i];
          if (isbn==='') continue;
          isbn=isbn.split(' ')[0];
          ean=ISBN.asIsbn13(isbn);
          if (ean===null) {            
            if (isbn.length=13 && !isNaN(isbn)) {
              ean=isbn
              console.log('maybe ean: ' + isbn);
            }
            else continue;
          }
        
          // console.log('isbn: ' + isbn);
          isbna.push(ean);
          isbno[ean]=isbn;
        }
        // console.log('isbna: ' + isbna);
      }
      
      var nbns = [];
      var nbna = [];
      var nbno = {};

      if (query.nbn) {
        var nbns = query.nbn.split(',');
        // console.log('nbns: ' + nbns);
        // console.log('length: ' + nbns.length);
        
        for (var i=0;i<nbns.length;i++) {              
          var nbn=nbns[i];
          if (nbn==='') continue;
          // console.log('nbn: ' + nbn);
          nbna.push(nbn);
          nbno[nbn]=nbn;
        }
        // console.log('nbna: ' + nbna);
      }

      response.writeHead(200, {'Content-Type': 'text/plain'});      
      var json=[];
        
      db.collection(metaCollection).find({$or:[{ean:{$in:isbna}},{nbn:{$in:nbna}}]}).toArray(function (err, items) {
        // console.log('items: ' + items.length); //JSON.stringify(items));        
        var fetch='';
        var fetcha=[];
        
        for (var i=0; i<items.length; i++) {        
          var item=items[i];          
          // console.log('item: ' + JSON.stringify(item));
          //isbn=item.bibinfo.isbn
          var ean=item.ean;
          // console.log('ean: ' + ean);
          var nbn=item.nbn;
          // console.log('nbn: ' + nbn);
          
        
          if (item !== null) {          
            //console.log(JSON.stringify(item));
            //delete item._id;
            if (ean && isbno[ean]) {
              item.bibinfo.isbn=isbno[ean];
              delete isbno[ean];
            }
            else if (nbn && nbno[nbn]) {
              item.bibinfo.nbn=nbn;
              delete nbno[nbn];
            }
            json.push(replaceUrl(item));
          } else {           
          }
          // console.log('i: '+i);
        }
        
        for (ean in isbno) {
          // console.log('to fetch: ' + ean);
          isbn=isbno[ean];
          if (metaCollection='okcz') {
            fetcha.push({bibinfo:{isbn:isbn},permalink:'a'});
          } else { 
            fetch=fetch + ',' + isbn;
          }
        }

        for (nbn in nbno) {
          // console.log('to fetch: ' + nbn);
          //isbn=isbno[ean];
          if (metaCollection='okcz') {
            fetcha.push({bibinfo:{nbn:nbn},permalink:'a'});
          } else { 
            //fetch=fetch + ',' + nbn;
          }
        }
        
        if (metaCollection='okcz') {
          fetch=JSON.stringify(fetcha)
        } else {
          fetch=fetch.substr(1);
        }
        
        metadata(fetch,json);
      });
    }
    else if (query.rating==='true') {
      // console.log('rating');
      var ictx=ipValid(remoteIP,query.ictx);
      if (!ictx || !query.id) {
        console.log('rating denied');
        response.writeHead(404);
        response.end('rating denied');
        return;
      }
      
      db.collection(metaCollection).findOne({_id:new mongo.ObjectID(query.id)}, function (err, item) {
        if (!item) {
          response.writeHead(200);
          response.end('rating notfound');
          return;
        }
        // console.log('rating found');
        if (query.value) {
          var value=query.value;
        } else {
          var value=1;
        }
        db.collection('rating').insert({value:value, ictx:ictx, ref:item._id, timestamp:timestamp}, {w:1}, function(err, result) {
          if (err) { 
            console.dir(err);
            response.writeHead(500);
            response.end('write failed');
            return;
          }         
          
          response.writeHead(200);
          response.end();
          db.collection('rating').aggregate([{$match: {ref:item._id}},{$group:{_id:null,total:{$sum:"$value"},count:{$sum:1}}}], function(err, result) {
            // console.dir(result);            
            
            if (!result) {
              console.dir(err)
              return;             
            }
            // console.log('agregation ok')

            db.collection(metaCollection).update({_id:item._id},{$set: {rating_count:result[0].count, rating_sum:result[0].total}}, {w:1}, function(err, result) {
              if (err) { console.dir(err); }
            });
          });
        });        
      });
    }
    else if (query.review==='true') {
      // console.log('review');
      var ictx=ipValid(remoteIP,query.ictx);
      if (!ictx || !query.id || !query.text) {
        console.log('review denied');
        response.writeHead(404);
        response.end('review denied');
        return;
      }

      db.collection(metaCollection).findOne({_id:new mongo.ObjectID(query.id)}, function (err, item) {
        if (!item) {
          response.writeHead(200);
          response.end('review notfound');
          return;
        }
        // console.log('review found');

        db.collection('review').insert({text:query.text, ictx:ictx, ref:item._id, timestamp:timestamp}, {w:1}, function(err, result) {
          if (err) { 
            console.dir(err);
            response.writeHead(500);
            response.end('write failed');
            return;
          }

          response.writeHead(200);
          response.end('ok');
        });
      });
    }
    else if (query.stats==='true') {
      if (perms[remoteIP]) {
        var stats = {};
        stats.uptime=uptime();
        stats.timeout_count=timeoutCount;
        stats.etag_match=etagMatchCount;
        stats.meta_requests=metaRequests;
        stats.meta_fetches=metaFetches;
        stats.cover_requests=coverRequests;
        stats.cover_api_requests=coverApiRequests;
        stats.cover_fetches=coverFetches;
        stats.cover_notfound=coverNotfound;
 

        db.collection(metaCollection).count(function(err, metaCount) {
          db.collection('cover').count(function(err, coverCount) {
            db.collection('logs').count(function(err, logsCount) {
              stats.meta_count=metaCount;
              stats.cover_count=coverCount;
              stats.logs_count=logsCount;              

              response.writeHead(200);
              response.end(JSON.stringify(stats,null,' '));

              if (query.save==='true') {
                stats.ip=remoteIP;
                stats.timestamp=timestamp;
                db.collection('stat').insert(stats, {w:0});
              }
            });
          });
        });        
      } else {        
        response.writeHead(404);
        response.end('access denied');        
      }
    }
    else if (query.permreload==='true') {
      getPerms(db);
      response.writeHead(200);
      if (perms[remoteIP]) {
        response.write(JSON.stringify(perms,null,' ')+'\n\n');
        response.write(JSON.stringify(referers,null,' ')+'\n\n');
      }
      response.end('ok');
    } 
    else {
      console.log("wrong query");
      response.writeHead(404);
      response.end();
    }

    /// nacteni metadat podle identifikatoru
    function metadata(fetch, json, coverApi) {            
      if ((fetch!=='') && (fetch!=='[]') && (now>dateTimeout)) {
        // console.log('fetch: ' + fetch);
        fetch=encodeURIComponent(fetch);
        var url='http://' + urlMain + urlPart + urlMetadata + urlParams + fetch
        // console.log('url: ' + url);
        metaFetches++;

        request({url:url,timeout:timeout}, function(error, res, body) {
          if (!error) {
            // console.log(body);
            if (metaCollection='okcz') {
              var jsonf = JSON.parse(body.substring(16,body.length-3));
            } else {
              var jsonf = JSON.parse(body);
            }
            // console.log(jsonf);
          
            for (var i=0;i<jsonf.length;i++) {
              item=jsonf[i];
              delete item.permalink;

              if (item.bibinfo.isbn) {
                // console.log(item.bibinfo.isbn);
                var isbn=item.bibinfo.isbn.split(' ')[0]
                item.ean=ISBN.asIsbn13(isbn);
                if (item.ean===null) {
                  if (isbn.length=13 && !isNaN(isbn)) item.ean=isbn
                  //delete item.ean;
                } else {
                  // console.log(ean);
                }
              }
              else if (item.bibinfo.nbn) {
                item.nbn=item.bibinfo.nbn;
                // console.log(nbn);
              }

        
              db.collection(metaCollection).insert(item, {w:1}, function(err, result) {
                if (err) { console.dir(err); }
                else {                     
                  // console.log(result)
                }                   
              });
              //delete item._id;                
              json.push(replaceUrl(item));
            } 
          } else {
            console.log(error);
            if (error.code==='ETIMEDOUT') { // error.code==='ENOTFOUND'
              dateTimeout=now+timeOutDuration;
              timeoutCount++;
              console.log('timeout : ' + dateTimeout);
            }
          }
          
          if (coverApi) {
            var item=json[0];
            if (!item || !item.cover_medium_url) {
              response.writeHead(404);
              response.end();
              return;
            }
            var coverUrl = item.cover_medium_url.slice(item.cover_medium_url.indexOf('/',8));
            // console.log(coverUrl);
            coverApiRequests++;
            cover(coverUrl);
          } else {
            var restmp=JSON.stringify(json,null,'');
            // console.log('json: ' + restmp);
            //restmp=restmp.replace(/www.obalkyknih.cz/g,urlReplace);
            response.end(restmp);
          }
        });        
      } else {
        if (coverApi) {
          response.writeHead(404);
          response.end();           
        } else {
          var restmp=JSON.stringify(json,null,'');
          // console.log('json: ' + restmp);
          //restmp=restmp.replace(/www.obalkyknih.cz/g,urlReplace);
          response.end(restmp);
        }
      }
    }

    /// ziskani / stazeni obalky podle url souborove cesty
    function cover(coverUrl) {       
      // var coverUrl=requrl.split('?')[0];
      if (query.keywords) {
        var keywords=query.keywords.trim().replace(/\s+|\t+/g,' ').split(' ');
      } else {
        var keywords=[];
      }
      db.collection('cover').findOne({url:coverUrl}, function (err, item) {
        // console.log('item: ' + item);
        //console.log('item: ' + JSON.stringify(item));
        // if (item) {console.log('notfound time: ' + (item.notfound<now))}

        if ((item !== null) && (!item.notfound)) {
          response.setHeader('Etag', item._id);
          etags[item._id]=null;
          // console.log('etag set: ' + item._id);
          response.writeHead(200, {'Content-Type': 'image/jpeg'});
          // console.log(item.x.length());
          response.end(item.x.buffer);
          db.collection('logs').insert({ip:remoteIP, referer:referer, op:coverUrl, state:'local', keywords:keywords, timestamp:timestamp}, {w:0});
        }
        else if (item && (item.notfound>now)) {
          response.writeHead(404);
          response.end()
        }
        else if (now>dateTimeout) {
          var options = {
            hostname: urlMain,
            //path: '/data/covers/cover/22556/107698/CO_22556_107698_1.jpg',
            //path: '/file/cover/716603/medium,
            path: coverUrl
          };
        
          var request = http.request(options, function(res) {
            coverFetches++;
            // console.log('STATUS: ' + res.statusCode);
            // console.log('HEADERS: ' + JSON.stringify(res.headers));
            
            //etag=res.headers['etag'];
            if (!item) {
              var id = new mongo.ObjectID();
            } else {
              var id = item._id;
            }
            etag=id.toHexString();
            etags[etag]=null;
            // console.log('etag set: ' + etag);            
            response.setHeader('Etag', etag);

            if (res.statusCode !== 200) {
              response.writeHead(404);
              coverNotfound++; 
              // console.log('not found');
              if (!item) {
                db.collection('cover').insert({notfound:now+timeNotfound, _id:id, url:coverUrl}, {w:1}, function(err, result) {
                  if (err) { console.dir(err); }
                });
              } else {
                db.collection('cover').update({_id:id},{notfound:now+timeNotfound, url:coverUrl}, {w:1}, function(err, result) {
                  if (err) { console.dir(err); }
                });
              }

              response.end()
              return;
            }            
            response.writeHead(200, {'Content-Type': 'image/jpeg'});
            
            //var cover='';
            var data=[];
            res.on('error', function (e) {
              console.log(e);
            });
            
            
            res.on('data', function (chunk) {          
              // console.log('chunk');
              // console.log(chunk);              
              //cover=cover + chunk
              data.push(chunk);
              response.write(chunk);
            }); //.pipe(response);
            
            res.on('end', function () {
              response.end();
              // console.log('end');
              var cover=new Buffer(data.reduce(function(prev, current) {
                return prev.concat(Array.prototype.slice.call(current));
              }, []));
              // console.log(cover);
              //response.end(cover);
              // console.log(cover.length);
              var binary = new mongo.Binary(cover);
              // console.log(binary.length());
                            
              db.collection('cover').insert({x:binary, _id:id, url:coverUrl}, {w:1}, function(err, result) {
                if (err) { console.dir(err); }
              });              
              db.collection('logs').insert({ip:remoteIP, referer:referer, op:coverUrl, state:'fetch', keywords:keywords, timestamp:timestamp}, {w:0});
            });
            
          });
          
          request.setTimeout(timeout, function() {
            dateTimeout=new Date().getTime()+timeOutDuration;
            timeoutCount++;
            console.log('timeout : ' + dateTimeout);
            request.abort();
            response.end()
          });
          
          /*
          request.on('socket', function (socket) {
            socket.setTimeout(timeout);  
            socket.on('timeout', function() {
              request.abort();
            });
          });
          */
          request.on('error', function(err) {
            if (err.code === "ECONNRESET") {
              console.log("Timeout occurs");              
            }
          });

          request.end()
        }
        else {
          // console.log('cover404');
          response.writeHead(404);
          response.end();
        }
      });    
    }    
  }).listen(frontPort)

});

function getPerms(db) {
  db.collection('perms').find().toArray(function (err, items) {
    // console.log('perms: ' + items.length);
    for (var i=0; i<items.length; i++) {
      var item=items[i];
      if (item.ref) {
        console.log('referer: ' + item.ref);
        referers[item.ref]=item.ictx;
      }
      if (item.ip) {
        console.log('ip: ' + item.ip);
        perms[item.ip]=item.ictx;
      }
    }    
  });
}


function replaceUrl(meta) {
/*  for (item in meta) {  	
  	console.log(item);
  	if (item==='backlink_url' || item==='toc_pdf_url' || !meta[item].replace) {
  	  continue;
  	}
  	meta[item]=meta[item].replace("www.obalkyknih.cz",urlReplace);
  }
 */
  
  if (meta.cover_thumbnail_url) {
    meta.cover_thumbnail_url=meta.cover_thumbnail_url.replace("www.obalkyknih.cz",urlReplace);
  }
  if (meta.cover_medium_url) {
    meta.cover_medium_url=meta.cover_medium_url.replace("www.obalkyknih.cz",urlReplace);
  }
  if (meta.cover_icon_url) {
    meta.cover_icon_url=meta.cover_icon_url.replace("www.obalkyknih.cz",urlReplace);
  }
  if (meta.toc_text_url) {
    meta.toc_text_url=meta.toc_text_url.replace("www.obalkyknih.cz",urlReplace);
  }
  if (meta.toc_thumbnail_url) {
    meta.toc_thumbnail_url=meta.toc_thumbnail_url.replace("www.obalkyknih.cz",urlReplace);
  }
  return meta;
}

function refererValid(referer, ip) {
  // console.log('revererValid:' + referer);

  if (perms[ip]) return perms[ip];
  if (!referer) return false;
  //referer=referer.split('?')[0];
  referer=referer.slice(0,referer.indexOf('/',8))

  if (referers[referer]) {
    return referers[referer];
  } 
  else {
  	console.log('referer is not valid')
  	return false;
  }
}

function ipValid(ip, ictx) {
  // console.log('ipValid:' + ip);
  var tmp=perms[ip];

  if (!tmp) return false;
  if (tmp==='ictx') {
    return ictx;
  } else {
    return tmp;
  }
}

function uptime() {
  var now = new Date();
  var uptime = Math.floor((now.getTime()-dateStartup.getTime())/1000);
  
  var sec = uptime % 60;
  uptime-=sec;
  uptime/=60;
  var min = uptime % 60;
  uptime-=min;
  uptime/=60;
  var hour = uptime % 24;
  uptime-=hour;
  uptime/=24;
  
  now.setHours(hour,min,sec);
  var time = now.toString().split(' ')[4];

  // 00:02:51 up 0 days, 2013-12-06T08:35:21.962Z
  return time+' up '+uptime+' days, '+dateStartup.toISOString()
}

