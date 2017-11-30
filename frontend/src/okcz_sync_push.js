// version 1

// mongodb://url:port/database  - spojeni na mongodb
var urlmongo = "mongodb://localhost:27017/okcz_db"
// timeout dotazu na backend (ms)
var timeout = 5 * 1000;
// =========================================

var mongo = require('mongodb');
var client = mongo.MongoClient;
var http = require('http');
var request = require('request');
var url = require('url');
var qs = require('querystring');
var date = new Date();
var timestamp = date.toISOString();
var emailSentForSigla = {};
var smtp =  {
  from: {
    name: 'Obalkyknih.cz',
    address: 'obalkyknih@gmail.com'
  },
  credentials: {
    user: 'obalkyknih@gmail.com',
    password: 'visk2016',
    host: 'smtp.gmail.com'
  }
};

console.log('TIMESTAMP: '+timestamp);

var arg1 = process.argv.slice(2);
var test = false;
if (arg1=='-t' || arg1=='--test') test = true; // priznak testovaciho prostredi


if (test) {
  var email = require('emailjs/email');
  
  var server = email.server.connect({
     user: smtp.credentials.user,
     password: smtp.credentials.password,
     host: smtp.credentials.host,
     ssl: true
  });
  
  server.send({
     text: "Dobrý den.\nPokus o zaslání synchronizačního požadavku (PUSH API obalkyknih.cz) na Váš systém selhal.\n\nProsíme o kontrolu funkčnosti ve Vašem systému.\n\nEmail Vám byl automaticky zaslán systémem obalkyknih.cz",
     from: smtp.from.address,
     to: "obalkyknih@gmail.com",
     subject: "obalkyknih.cz - Synchronizace pomoci PUSH API selhala"
  }, function(err, message) {
    console.log(err || message);
    process.exit();
    exit;
  });
  
  console.log('[ TEST DONE ]');
}


function stopIfNothingToProcess(sigla, db, req) {
  db.collection('settings_push').update({ sigla:sigla }, {$set:{'flag_processing':0}}, {w:1}, function(err) {
    db.collection('settings_push').find({ flag_processing:1 }).toArray(function(err, items) {
      if (err || !items || !items.length) {
        console.log('[ HALT: ' + sigla + ']');
        db.close();
        if (req) req.abort();
        process.exit();
      }
    });
  });
}


function finishSigla(sigla, db) {
  let now = new Date();
  db.collection('settings_push').update({ sigla:sigla }, {$set:{synced_last_time:now}}, {w:1}, function(err) {
    console.log('[ END: ' + sigla + ' ]');
  });
}


function sendMail(sigla, db, req) {
  if (!sigla || sigla === "") {
    return;
  }
  console.log('    [ EMAIL ' + sigla + ' ]');

  db.collection('settings_push').find({ sigla:sigla }).toArray( function(err, settings) {
    if (err) {
      stopIfNothingToProcess(sigla, db, req);
      return;
    }
    
    if (!settings[0]) {
      stopIfNothingToProcess(sigla, db, req);
      return;
    } else {
      settings = settings[0];
    }
    
    let flag_email_send = false,
        now = new Date();
    
    // nikdy jeste nebyl zaslan email
    if (!settings.last_warning_email_sent) {
      flag_email_send = true;
    }
    // dnes jeste nebylo zaslan email
    else {
      var next_sync_date = new Date(new Date(settings.last_warning_email_sent).getTime() + 24*60*60*1000);
      if (now > next_sync_date) {
        flag_email_send = true;
      }
    }
    console.log('    [ EMAIL ' + sigla + ' flag_email_send ' + flag_email_send + ' ]');
  
    // zaslat email
    if (flag_email_send) {
      console.log('    [ EMAIL ' + sigla + ' sending... ]');
      var email = require('emailjs/email');
      
      var server = email.server.connect({
        user: smtp.credentials.user,
        password: smtp.credentials.password,
        host: smtp.credentials.host,
        ssl: true
      });
      
      server.send({
        text: "Dobrý den.\nPokus o zaslání synchronizačního požadavku (PUSH API obalkyknih.cz) na Váš systém selhal.\n\nProsíme o kontrolu funkčnosti ve Vašem systému.\nURL pro zasílání požadavků pro knihovnu se siglou " + sigla + ":\n" + settings.url + "\n\nEmail Vám byl automaticky zaslán systémem obalkyknih.cz",
        from: smtp.from.address,
        to: settings.email,
        subject: "obalkyknih.cz - Synchronizace pomoci PUSH API selhala"
      }, function(err, message) {
        if (err) console.log(err);
        console.log('    [ EMAIL ' + sigla + ' sent ]');
        // poznacit casove razitko zaslani emailu, aby sa najblizsich 24hod opakovane nezaslalo
        db.collection('settings_push').update({ sigla:sigla }, {$set:{ last_warning_email_sent: now }}, {w:1}, function(err) {
          // pokud byl email zaslan a uz neni co procesovat, ukonci script
          stopIfNothingToProcess(sigla, db, req);
        });
        
      });
    } else {
      // pokud email nebylo potreba zaslat a uz neni co procesovat, ukonci script
      stopIfNothingToProcess(sigla, db, req);
    }
  });
}


function increaseRetryCount(ids, db, req, retryCounts, sigla) {
  let stopable = true;
  
  for (j = 0; j < ids.length; j++) {
    var retryDate = new Date();
    retryDate.setMinutes(retryDate.getMinutes() + (parseInt(retryCounts[j])<=5 ? 5 : 60) );

    db.collection('okcz_push').update({_id:ids[j]},{$set:{retry_date:retryDate.toISOString(), retry_count:retryCounts[j] + 1}}, {w:1}, function(err, result) {
      if (err) { console.dir(err); }
    });
    // ked bol presiahnuty limit poctu opakovani posle email adminovi(v pripade ze bol vyplneny v registracii)
    if (parseInt(retryCounts[j])==15) {
      if (!emailSentForSigla[sigla]) {
        stopable = false;
        sendMail(sigla, db, req);
      }
      emailSentForSigla[sigla] = true;
    }
  }
  // pokud uz neni co procesovat, ukonci script
  if (stopable) stopIfNothingToProcess(sigla, db, req);
}



client.connect(urlmongo, function (err, db) {
  if (err) { return console.dir(err); }

  db.collection('settings_push').update({}, {$set:{ 'flag_processing': 1 }}, {multi: true}, function(err) {
    if (err) {
      console.dir(err);
      db.collection('settings_push').update({}, {$set:{ 'flag_processing': 0 }}, {multi: true});
      db.close();
      return;
    }
    
    db.collection('settings_push').find().toArray(function(err, items) {
      if (err) {
        console.dir(err);
        db.collection('settings_push').update({}, {$set:{ 'flag_processing': 0 }}, {multi: true});
        db.close();
        return;
      }
  
      //nenasiel nastavenia!!
      if (items.length == 0) {
        console.log('Nenaslo se zadne nastaveni!');
        db.collection('settings_push').update({}, {$set:{ 'flag_processing': 0 }}, {multi: true});
        db.close();
        return;
      }
  
      items.forEach(function(settings, i) {
        var sigla = settings.sigla,
            now = new Date();

        if (settings.synced_last_time != null) {
          var next_sync_date = new Date(new Date(settings.synced_last_time).getTime() + parseInt(settings.frequency));
  
          /*console.log("___"+sigla+"___\n");
          console.log(now);
          console.log(settings.synced_last_time);
          console.log(settings.frequency);
          console.log(next_sync_date);
          console.log("^^^\n");*/
          if (now < next_sync_date) {
            stopIfNothingToProcess(sigla, db, null);
            return;
          }
        }

        console.log('[ START: ' + sigla + ']');
        db.collection('okcz_push').find({sigla:sigla, retry_count:{$lt:16}, retry_date:{$lt:timestamp}}).limit(parseInt(settings.item_count)).toArray(function(err, items) {
          if (err) {
            console.log("  Ziskani zaznamu z okcz_push selhalo");
            console.log('  ' + err);
            stopIfNothingToProcess(sigla, db, null);
            return;
          }
  
          // knihovna nema zadne zaznamy k synchronizaci
          if (!items || items.length == 0) {
            stopIfNothingToProcess(sigla, db, null);
            return;
          }
  
          let url_params = url.parse(settings.url);
          var options = {
            host: url_params.hostname,
            port: url_params.port,
            path: url_params.path,
            method: 'POST',
          };
  
          var post_data = [];
          var ids = [];
          var retryCounts = [];
  
          //prejde vsetky nevybavene synchronizacne poziadavky (max stanoveny limit/davku)
          for (var j=0; j<items.length; j++) {
            var item = items[j];
            //console.log(JSON.stringify(JSON.parse(item.rec)[0]));
            var metadata = JSON.parse(item.rec);
            post_data.push(metadata.metadata);
            ids.push(item['_id']);
            retryCounts.push(item['retry_count']);
          }
  
          // *** START - SYNC REQUEST ***
          (function(ids, retryCounts, post_data_req, sigla) {
            console.log('  [ PROCESSING: ' + sigla + ']');
            
            //zasli pozadavek na synchronizaci
            var req = http.request(options, function(res) {
              res.on('error', function (e) {
                console.log('  **** ERR (' + e.code + ') **** ');
                console.log('  ' + ids);
                increaseRetryCount(ids, db, req, retryCounts, sigla);
                console.log('[ END: ' + sigla + ']');
                return;
              });
  
              res.on('data', function(){});
  
              res.on('end', function () {
                if (res.statusCode===200) {
                  // *** OK ***
                  console.log('  ....OK.... ');
                  console.log(ids);
  
                  // synchronizace se povedla, vymaz
                  db.collection('okcz_push').remove({_id:{'$in':ids}},function(err, result) {
                    if (err) { console.log(err); }
                  });
  
                  var now = new Date();
  
                  db.collection('settings_push').update({sigla:sigla}, {$set:{synced_last_time:now.toISOString()}}, function(err, result) {
                    if (err) {
                      console.log(err);
                    }
                  });
  
                  // pokud uz neni co procesovat, ukonci script
                  stopIfNothingToProcess(sigla, db, req);
                  finishSigla(sigla, db);
                  return;
                }
  
                // *** ERR http code != 200 ***
                // synchronizace selhala, nastav cas dalsiho opakovani (pokud je max. 5.opakovani nastav za 5min, jinak nastav za 24hod)
                else {
                  console.log('  **** ERR (' + res.statusCode + ') **** ');
                  console.log('  ' + ids);
                  increaseRetryCount(ids, db, req, retryCounts, sigla);
                  finishSigla(sigla, db);
                  return;
                }
                
              });
            });
              
            req.on('socket', function (socket) {
              socket.setTimeout(timeout);
              socket.on('timeout', function() {
                console.log('  **** TIMEOUT **** ');
                console.log('  ' + ids);
                increaseRetryCount(ids, db, req, retryCounts, sigla);
                finishSigla(sigla, db);
                return;
              });
            });
  
            req.on('error', function (e) {
              console.log('  **** ERR (' + e.code + ') **** ');
              console.log('  ' + ids);
              increaseRetryCount(ids, db, req, retryCounts, sigla);
              finishSigla(sigla, db);
              return;
            });
  
            // ****** TADY ZASILAM DATA ******
            req.write(JSON.stringify(post_data_req));
            req.end();
          })(ids, retryCounts, post_data, sigla);
          // *** END - SYNC REQUEST *** 
        });
        
        finishSigla(sigla, db); // normalni ukonceni; ty predchozi jsou v pripade chyb
      });
    });
  });
});
