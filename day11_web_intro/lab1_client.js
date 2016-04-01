// node.js createserver documentation
const readline = require("readline");
const net = require("net");

const PORT = 8080;
const HOST = "127.0.0.1";


const r1 = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// https://nodejs.org/api/net.html#net_net_createconnection_options_connectlistener
// Set up connection between server in lab1_server.js
const socket = net.createConnection({port: PORT, host: HOST});

// socket.write("Hello, Server.  How's it hanging");

// on the client, add a listener so it can react to the response
// back from the server
socket.on("data", function (data) {
  console.log("hello, " + data.toString());
})

// The folowingwill ask the user for his name,
// then it will call the function with the name
// argument when the user presses enter
r1.question("What is your name?\n", function(name){
  socket.write(name);
})

// should process exit after you listen for a response
// or else the write won't even happen
// process.exit();
