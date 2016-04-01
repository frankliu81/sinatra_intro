const net = require("net");
const readline = require("readline");

const PORT = 8080;
const HOST = "127.0.0.1";

const r1 = readline.createInterface({
      input: process.stdin,
      output: process.stdout
});

const socket = net.createConnection({port: PORT, host: HOST});

socket.on("data", function(data){
  console.log("LargestNumber: " + data)
});

r1.question("Please give me list of number (ie. 1,2,3,5,4): ", function(number){
  socket.write(number);
});
