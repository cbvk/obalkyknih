var request = require('request');
var http = require('http');
var fs = require('fs');

  http.createServer(function (req, response) {
    var body = '';
        req.on('data', function (data) {
            body += data;
        });
        req.on('end', function () {
            console.dir(req.headers);
            console.log("\n\n");
            console.log("Body: " + body);
        });
        response.writeHead(500, {'Content-Type': 'text/html'});
        response.end('post received');
  }).listen(22222);

  console.log("listening at port: 22222");
  
