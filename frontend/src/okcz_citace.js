/// version 19

/// mongodb://url:port/database  - spojeni na mongodb
var urlmongo = "mongodb://localhost:27017/okcz_db"

//var urlPerms = "http://www.obalkyknih.cz/api/get_perms"
var urlPerms = "http://10.89.56.102/api/get_perms"

//var urlCitaceSettings = "http://www.obalkyknih.cz/api/get_settings_citace";
var urlCitaceSettings = "http://10.89.56.102/api/get_settings_citace";

/// timeout dotazu na backend (ms)
var timeout = 15 * 1000;

/// port frontendu HTTP / HTTPS
var frontPortHttp = 1339;
var frontPortHttps = 1340;

// =========================================

/// knihovna API OKCZ v3.2
var okcz = require('okcz_citace_v1_server');

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

// **********************************************
//   Serverova cast Front-End API obalkyknih.cz
// ************
// **********************************
// * Navazani komunikace s MongoDB
// * Nactenu prav pristupu
// * Vytvoreni HTTP a HTTPS serveru
// **********************************************

client.connect(urlmongo, function (err, db) {
  if (err) { return console.dir(err); }

  var arg1 = process.argv.slice(2);
  var test = false;
  if (arg1=='-t' || arg1=='--test') test = true; // priznak testovaciho prostredi

  okcz.getPerms(false, null, db);
  okcz.getCitaceSettings(false, null, db);

  if (!test) {
    //getPerms
    /*request({url:urlPerms,timeout:timeout}, function(error, res, body) {
      if (!error) {
        var perms = JSON.parse(body);
        var perms_count = parseInt(perms.count);
        if (perms_count>0 && perms.perms.length==perms_count) {
          db.collection('perms').remove({},function(err,numberRemoved) {
            db.collection('perms').insert(perms.perms, {continueOnError: true}, function(err, result) {
              console.log('PERMS LOADED AT FRONTEND STARTUP (count:'+perms_count+')');
              okcz.getPerms(true, perms, null);
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
    });*/

    //getCitaceSettings
    request({url:urlCitaceSettings,timeout:timeout}, function(error, res, body) {
      if (!error) {
        var settings = JSON.parse(body);
        var settings_count = parseInt(settings.count);
        if (settings_count>0 && settings.settings.length==settings_count) {
          db.collection('settings_citace').remove({},function(err,numberRemoved) {
            db.collection('settings_citace').insert(settings.settings, {continueOnError: true}, function(err, result) {
              console.log('CITACE_SETTINGS LOADED AT FRONTEND STARTUP (count:'+settings_count+')');
              okcz.getCitaceSettings(true, settings.settings, null);
            });
          });
        } else {
          console.log('ERROR: FAILED TO LOAD CITACE_SETTINGS AT FRONTEND STARTUP - SETTINGS COUNT MICHMACH');
          db.close();
          return;
        }
      } else {
        console.log('ERROR: FAILED TO LOAD CITACE_SETTINGS AT FRONTEND STARTUP - TIMEOUT');
      }
    });
  }

  // HTTP
  http.createServer(function (req, response) {
    okcz.server(req, response, db);
  }).listen(frontPortHttp);
  
  // HTTPS
  /*https.createServer(httpsOptions, function (req, response) {
    okcz.server(req, response, db);
  }).listen(frontPortHttps);*/
  
});
