var net = require("net");

var client = new net.Socket();

client.on("data", function(data){
  console.log("Data received from server: " + data);
  process.exit(0);

});

client.connect(4545, "127.0.0.1", function(){
  client.write("Hello World!");
});
