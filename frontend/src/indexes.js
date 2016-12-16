var urlmongo = "mongodb://localhost:27017/okcz_db"
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

      db.collection('cover').ensureIndex({url:1}, {w:1}, function(err, result) {
        if (err) {  return console.dir(err); }

        db.collection('rating').ensureIndex({ref:1}, {w:1}, function(err, result) {
          if (err) {  return console.dir(err); }

          db.collection('review').ensureIndex({ref:1}, {w:1}, function(err, result) {
            if (err) {  return console.dir(err); }

            console.log('ok');
            db.close();
          });
        });
      });
    });
  });
});