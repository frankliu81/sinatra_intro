// node.js createserver documentation
const net = require("net");

const PORT = 8080;
const HOST = "127.0.0.1";

// This initializes the server object
// https://nodejs.org/api/net.html#net_net_createserver_options_connectionlistener
const server = net.createServer(function(socket) {
  // Setup a listener on the "data" event
  // The event will trigger when data is sent
  // to the socket
  socket.on("data", function(data) {
    console.log("Data received: " + data.toString());
    socket.write(data.toString().toUpperCase());
  });
});

// at some point of getting the server up and running
// the net library will call the callback function that takes a socket
server.listen(PORT, HOST);

console.log("Server listening on " + HOST + ":" + PORT + "...");
