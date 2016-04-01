var net = require("net");

var server = net.createServer(function(socket) {
  // the function will run when any data is received by the server
  socket.on("data", function(data) {
    console.log("Data received: " + data);
    socket.write("Roger: " + data);
  });
});

console.log("running server on port 4545");
server.listen(4545, "127.0.0.1")
