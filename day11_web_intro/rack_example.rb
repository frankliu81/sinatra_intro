require "rack"

class RackExample

  # The class must at least have one method named 'call' that reutrn an Array
  # it has to be a class method
  def self.call(env)
    req = Rack::Request.new(env)
    # if you send a request like: http://localhost:8080/?name=tam&city=Vancouver
    # then req.params will look like:
    # {"name"=>"tam", "city"=>"Vancouver"}
    puts ">>>>>"
    puts req.params
    puts ">>>>>"
    # first element in Array: HTTP response code
    # second element in Array: Header Options (type is Hash)
    # third element of the Array: Content (type is Array)
    [200, {"Content-Type" => "text/html"}, ["<h1>Hello World</h1>"]]
  end

end

# this runs the Rack application in the WEBrick server
Rack::Handler::WEBrick.run RackExample

# need to restart the server after a change, Cmd + C (Ctrl + C)
