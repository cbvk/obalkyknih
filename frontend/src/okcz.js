/// version 19

/// mongodb://url:port/database  - spojeni na mongodb
var urlmongo = "mongodb://localhost:27017/okcz_db"
//var urlPerms = "http://www.obalkyknih.cz/api/get_perms"
var urlPerms = "http://www.obalkyknih.cz/api/get_perms"
var urlPushSettings = "http://www.obalkyknih.cz/api/get_settings_push";
/// timeout dotazu na backend (ms)
var timeout = 15 * 1000;

/// port frontendu HTTP / HTTPS
var frontPortHttp = 1337;
var frontPortHttps = 1338;

// =========================================

/// knihovna API OKCZ v3.2
var okcz = require('okcz19_server');

/// node.js moduly
var mongo = require('mongodb');
var client = mongo.MongoClient;
var request = require('request');
var http = require('http');
var https = require('https');
var fs = require('fs');

/// soukromy klic, certifikat a intermediate certifikat; vse pro HTTPS
/*var httpsOptions = {
  key: fs.readFileSync('cert/serverkey.pem'),
  cert: fs.readFileSync('cert/cache.obalkyknih.cz-1404285806.pem'),
  ca: [ fs.readFileSync('cert/tcs-ca-bundle.pem') ]
};*/
var httpsOptions = {
  key: fs.readFileSync('certs/cache.obalkyknih.cz.key'),
  cert: fs.readFileSync('certs/cache.obalkyknih.cz.crt'),
  ca: [ fs.readFileSync('certs/chain.crt') ]
};

// **********************************************
//   Serverova cast Front-End API obalkyknih.cz
// **********************************************
// * Navazani komunikace s MongoDB
// * Nactenu prav pristupu
// * Vytvoreni HTTP a HTTPS serveru
// **********************************************

client.connect(urlmongo, function (err, db) {
  if (err) {  return console.dir(err); }

  var arg1 = process.argv.slice(2);
  var test = false;
  if (arg1=='-t' || arg1=='--test') test = true; // priznak testovaciho prostredi

  okcz.getPushSettings(false, null, db);

  if (!test) {
    request({url:urlPerms,timeout:timeout}, function(error, res, body) {
      if (!error) {
        var perms = JSON.parse(body);
        var perms_count = parseInt(perms.count);
        if (perms_count>0 && perms.perms.length==perms_count) {
          db.collection('perms').remove({},function(err,numberRemoved) {
            db.collection('perms').insert(perms.perms, {continueOnError: true}, function(err, result) {
              console.log('PERMS LOADED AT FRONTEND STARTUP (count:'+perms_count+')');
              okcz.getPerms(db, true);
            });
          });
        } else {
          console.log('ERROR: FAILED TO LOAD PERMS AT FRONTEND STARTUP - PERMS COUNT MICHMACH');
          db.close();
          return;
        }
      } else {
        console.log('ERROR: FAILED TO LOAD PERMS AT FRONTEND STARTUP - TIMEOUT');
      }
    });

    //getPushSettings
/*    request({url:urlPushSettings,timeout:timeout}, function(error, res, body) {
      if (!error) {
        var settings = JSON.parse(body);
        var settings_count = parseInt(settings.count);
        if (settings_count>0 && settings.settings.length==settings_count) {
          db.collection('settings_push').remove({},function(err,numberRemoved) {
            settings.settings.forEach(function(s) { s['full_container'] = (s['full_container'] == 1) });
            db.collection('settings_push').insert(settings.settings, {continueOnError: true}, function(err, result) {
              console.log('PUSH_SETTINGS LOADED AT FRONTEND STARTUP (count:'+settings_count+')');
              okcz.getPushSettings(true, settings.settings, null);
            });
          });
        } else {
          console.log('ERROR: FAILED TO LOAD PUSH_SETTINGS AT FRONTEND STARTUP - SETTINGS COUNT MICHMACH');
          db.close();
          return;
        }
      } else {
        console.log('ERROR: FAILED TO LOAD PUSH_SETTINGS AT FRONTEND STARTUP - TIMEOUT');
      }
    });*/
  }

  okcz.getPerms(db);

  // HTTP
  http.createServer(function (req, response) {
    okcz.server(req, response, db);
  }).listen(frontPortHttp);

  // HTTPS
  https.createServer(httpsOptions, function (req, response) {
    okcz.server(req, response, db);
  }).listen(frontPortHttps);

});
