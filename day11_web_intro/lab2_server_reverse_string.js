const net = require("net");

const PORT = 8080;
const HOST = "127.0.0.1"

const server = net.createServer( function(socket) {
  debugger;
  socket.on("data", function(data){
    console.log("Data Received: " + data);
    reversed = data.toString().split("").reverse().join("");

    socket.write(reversed);
  });
});

server.listen(PORT, HOST);
console.log("Server listening on " + HOST + ":" + PORT + "...")
