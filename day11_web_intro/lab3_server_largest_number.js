const net = require("net");

const PORT = 8080;
const HOST = "127.0.0.1"


var largestNumber = function(data){
  // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/max
  console.log(data.toString());

  // from Alex:
  // var arrayNumbers = data..split(",").map(Number);
  // var number = Math.max.apply(null, arrayNumbers);

  var number = Math.max.apply(null, data.toString().split(","));
  console.log("largestNumber: " + number);
  return number;
};

const server = net.createServer( function(socket) {
  socket.on("data", function(data){
    console.log("Data Received: " + data);
    socket.write(largestNumber(data).toString())
    // socket.write(largestNumber(data));
  });
});

server.listen(PORT, HOST);
console.log("Server listening on " + HOST + ":" + PORT + "...")
