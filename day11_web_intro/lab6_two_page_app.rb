# Build a two-page application with Rack that supports the following urls:
# 1. http://localhost:8080/ > home page display: "Welcome to my application"
# 2. http://localhost:8080/greeting?name=tam > A second page that display in <h1>: Hello Tam (tam is fetched from the `name` parameter`)
#
# Stretch: Figure out how to serve static assets (such as images and CSS files) with your application.



require "rack"

class RackRouter

  def intiaialize
  end

  def call(env)
    req = Rack::Request.new(env)

    # puts env
    response = ""
    params = req.params
    #puts req.path
    #puts env["PATH_INFO"]
    #puts env["REQUEST_PATH"]
    # puts params

    if  params == {}
      response = "<h1>Welcome to my application</h1>"
    #elsif env["PATH_INFO"] == "/greeting"
    elsif req.path == "/greeting"
      response = "<h1>Hello #{params["name"]}</h1>"
    end

    [200, {"Content-Type" => "text/html"}, [response]]
  end

end

Rack::Handler::WEBrick.run RackRouter.new
