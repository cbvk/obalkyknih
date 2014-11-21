// version 1

// mongodb://url:port/database  - spojeni na mongodb
var urlmongo = "mongodb://localhost:27017/test"
// adresa backendu
var urlMain = "www.obalkyknih.cz"
//var urlMain = "10.90.90.14"
// timeout dotazu na backend (ms)
var timeout = 5 * 1000;
// pole obsahuje _id vsech synch. udalosti
var ids = [];

// =========================================

var mongo = require('mongodb');
var client = mongo.MongoClient;
var http = require('http');
var request = require('request');
var qs = require('querystring');
var date = new Date();
var timestamp = date.toISOString();
console.log('TIMESTAMP: '+timestamp);

client.connect(urlmongo, function (err, db) {
  if (err) {  return console.dir(err); }
  
  db.collection('be_sync').find({flag_synced:0, retry_count:{$lt:16}, retry_date:{$lt:timestamp}}).toArray(function(err, items) {
    if (!items) {
      console.log('nothing to sync');
      db.close();
      return;
    }
    
    // projdi vsechny nevybavene synchronizacni pozadavky
    for (var i=0; i<items.length; i++) {
      if (!items[i]['get_data']) continue;
      var flag_post = items[i]['post_data'] ? true : false;
      
      // sestav hlavicku request
      var options = {
        host: urlMain,
        port: 80,
        path: '/'+items[i]['uri']+'?'+qs.stringify(items[i]['get_data'])
      };
      // rozsir hlavicku pokud posilame POST data
      var post_data = '';
      if (flag_post) {
        post_data = qs.stringify(items[i]['post_data']);
        options.method = 'POST';
        options.headers = {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Content-Length': post_data.length
        }
      }
      //console.log(JSON.stringify(post_data,null,' ')); console.log(JSON.stringify(options,null,' ')); db.close(); return; //debug
      
      // anonymni funkce pro predani _ID zaznamu (vyuziti function scope)
      // *** START - SYNC REQUEST ***
      (function(rowPk, retryCount, post_data_req) {
        // zasli pozadavek na synchronizaci
        var flag_post = post_data_req=='' ? false : true;
        var req = http.request(options, function(res) {
          var data=[];
          
          res.on('error', function (e) {
            console.log(e);
            // *** ERR ***
            // pokud uz neni co procesovat, ukonci script
            var itemIndex = ids.indexOf(rowPk);
            if (itemIndex>-1) ids.splice(itemIndex, 1); if (ids.length==0){ req.abort; db.close(); return; }
          });
          
          res.on('data', function (chunk) {
            data.push(chunk);
          });
          
          res.on('end', function () {
            var resOk=false;
            if (res.statusCode===200) {
              if (data.length>0) {
                if (data[0][0]===111 && data[0][1]===98) {
                  resOk=true;
                  
                  // *** OK ***
                  console.log('....OK.... '+rowPk);
                  // synchronizace se povedla, poznac, aby se uz dale nevykonavala (flag_synced=1)
                  db.collection('be_sync').update({_id:rowPk},{$set:{flag_synced:1}}, {w:1}, function(err, result) {
                    if (err) { console.dir(err); }
                  });
                  // pokud uz neni co procesovat, ukonci script
                  var itemIndex = ids.indexOf(rowPk);
                  if (itemIndex>-1) ids.splice(itemIndex, 1); if (ids.length==0){ req.abort; db.close(); return; }
                }
              }
            }
            
            // *** ERR ***
            // synchronizace selhala, nastav cas dalsiho opakovani (pokud je max. 5.opakovani nastav za 5min, jinak nastav za 24hod)
            if (!resOk) {
              console.log('****ERR**** '+rowPk);
              var retryDate = new Date();
              retryDate.setMinutes(retryDate.getMinutes() + (parseInt(retryCount)<=5 ? 5 : 1440) );
              db.collection('be_sync').update({_id:rowPk},{$set:{retry_date:retryDate.toISOString(), retry_count:retryCount+1}}, {w:1}, function(err, result) {
                if (err) { console.dir(err); }
              });
              // pokud uz neni co procesovat, ukonci script
              var itemIndex = ids.indexOf(rowPk);
              if (itemIndex>-1) ids.splice(itemIndex, 1); if (ids.length==0){ req.abort; db.close(); return; }
            }
          
          });
        });
      
        req.on('socket', function (socket) {
          socket.setTimeout(timeout);  
          socket.on('timeout', function() {
            // *** ERR ***
            // pokud uz neni co procesovat, ukonci script
            var itemIndex = ids.indexOf(rowPk);
            if (itemIndex>-1) ids.splice(itemIndex, 1); if (ids.length==0){ db.close(); return; }
            req.abort;
          });
        });

        req.on('error', function (e) {
          if (e.code === "ECONNRESET") {
            console.log('timeout');
            // *** ERR ***
            // pokud uz neni co procesovat, ukonci script
            var itemIndex = ids.indexOf(rowPk);
            if (itemIndex>-1) ids.splice(itemIndex, 1); if (ids.length==0){ req.abort; db.close(); return; }
          }
        });
        
        // posli POST data pokud, jsou pozadovany
        if (flag_post) {
          req.write(post_data_req);
        }
        req.end();
      
      })(items[i]['_id'], items[i]['retry_count'], post_data);
      // *** END - SYNC REQUEST ***
    
      ids.push(items[i]['_id']);
    }
    
    if (ids.length==0){ db.close(); }
    
  });  
});
