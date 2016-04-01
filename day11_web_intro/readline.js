// require in Node.js will look in a local directory called node_modules
// if it's not found it will look in the system for the libraries with that name
// Node actually comes with readline
var readline = require("readline");

var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


// in Ruby you pass in block, do ... end
// or lambda

var responseFunction = function(name) {
  console.log("Hello " + name);
  // r1.close();
  // process.exit(0);

};


rl.question("What is your name? ", responseFunction);
