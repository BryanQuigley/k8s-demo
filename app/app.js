var https = require('https');
const os = require('os');
const fs = require('fs');
const process = require('process');

var port = 8000
hostname = os.hostname();

const options = {
    key: fs.readFileSync('key.pem'),
    cert: fs.readFileSync('cert.pem')
  };
 
var server = https.createServer(options, (request, response) => {
    let now = new Date();
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end("Hello World! Version " + process.env.npm_package_version + " running " + now + " on " + hostname)
});
 
server.listen(port)
 
console.log("Server running at https://127.0.0.1:" + port)