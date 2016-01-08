var http = require("http");

var app = http.createServer(function(request, response) {
  response.writeHead(200, {
    "Content-Type": "text/plain"
  });
  response.end("Under construction!\n");
});

app.listen(3000, "localhost");
console.log("Server running at http://localhost:3000/");
