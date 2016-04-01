// Write a TCP client and a TCP server in Node.js that does the following:
//1. The client connects to the server
//2. The server generates a random number
//3. The client sends guesses to the server
//4. The server responds to the client after each guess with: "You guessed right in X attempt(s)", "Guess higher" or "Guess lower"


const net = require("net");

const PORT = 8080;
const HOST = "127.0.0.1"

var randomNumber = Math.floor(Math.random()*10+1);

const server = net.createServer( function(socket) {
  socket.on("data", function(data){
    console.log("Data Received: " + data);
    if (randomNumber == data)
    {
      socket.write("correct");
    }
    else if (data < randomNumber){
      socket.write("too small");
    }
    else
    {
      socket.write("too large");
    }

  });
});

server.listen(PORT, HOST);
console.log("Server listening on " + HOST + ":" + PORT + "...");
