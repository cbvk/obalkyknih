var urlmongo = "mongodb://localhost:27017/test"
var metaCollection = "okcz"

// =========================================

var mongo = require('mongodb');
var client = mongo.MongoClient;

client.connect(urlmongo, function (err, db) {
  if (err) {  return console.dir(err); }

  db.collection(metaCollection).ensureIndex({ean:1}, {w:1}, function(err, result) {
    if (err) {  return console.dir(err); }

    db.collection(metaCollection).ensureIndex({nbn:1}, {w:1}, function(err, result) {
      if (err) {  return console.dir(err); }
      
      db.collection(metaCollection).ensureIndex({oclc:1}, {w:1}, function(err, result) {
        if (err) {  return console.dir(err); }
        
        db.collection(metaCollection).ensureIndex({ean:1,nbn:1,oclc:1}, {w:1}, function(err, result) {
          if (err) {  return console.dir(err); }
      
          db.collection(metaCollection).ensureIndex({book_id:1}, {w:1}, function(err, result) {
            if (err) {  return console.dir(err); }
            
            db.collection(metaCollection).ensureIndex({flag_synced:1,retry_count:1,retry_date:1}, {w:1}, function(err, result) {
            if (err) {  return console.dir(err); }

              db.collection('cover').ensureIndex({url:1}, {w:1}, function(err, result) {
                if (err) {  return console.dir(err); }

                db.collection('rating').ensureIndex({flag_synced:1,retry_count:1,retry_date:1}, {w:1}, function(err, result) {
                  if (err) {  return console.dir(err); }

                  db.collection('rating').ensureIndex({ref:1}, {w:1}, function(err, result) {
                    if (err) {  return console.dir(err); }

                    db.collection('review').ensureIndex({ref:1}, {w:1}, function(err, result) {
                      if (err) {  return console.dir(err); }
                      
                      db.collection('stat').ensureIndex({timestamp:1}, {w:1}, function(err, result) {
                      if (err) {  return console.dir(err); }

                        console.log('ok');
                        db.close();
                      });
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  });
});