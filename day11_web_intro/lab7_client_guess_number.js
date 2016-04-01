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
  if (data.toString() == "too small")
  {
    console.log("This is too small");
    r1.question("Please give me a number: ", function(numberString){
      socket.write(numberString);
    });
  }
  else if (data.toString() == "too large") {
    console.log("This is too large");
    r1.question("Please give me a number: ", function(numberString){
      socket.write(numberString);
    });
  }
  else if (data.toString() == "correct")
  {
    console.log("This is correct");
    process.exit(0);
  }

});

r1.question("Please give me a number: ", function(numberString){
  socket.write(numberString);
});
