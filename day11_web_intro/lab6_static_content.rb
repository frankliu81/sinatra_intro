# Build a two-page application with Rack that supports the following urls:
# 1. http://localhost:8080/ > home page display: "Welcome to my application"
# 2. http://localhost:8080/greeting?name=tam > A second page that display in <h1>: Hello Tam (tam is fetched from the `name` parameter`)
#
# Stretch: Figure out how to serve static assets (such as images and CSS files) with your application.
# 3. http://localhost:8080/images/cookie.png serve cookie image


require "rack"

# a test rack class
class Heartbeat
  def self.call(env)
   [200, { "Content-Type" => "text/html" }, ["<h1>Heartbeat</h1>"]]
 end
end

class RackRouter
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

# http://stackoverflow.com/questions/11512641/how-to-turn-a-config-ru-file-into-a-single-rack-application
class MyApp
  def initialize
      @app = Rack::Builder.new do


        # Serve requests to assets in /images, /js and /css with public/images, public/js and public/css.
        # this line has to be before the map statements
        use Rack::Static,
          :urls => ["/images", "/js", "/css"],
          :root => 'public'

        map '/' do
          # Heartbeat has a static call method, no need to new
          # run Heartbeat
          run RackRouter.new
        end

        # this specific route is not necessary, we let Rackrouter handles all the routes
        # map '/greeting' do
        #    #puts "run HeartBeat"
        #    # run lambda { |env| [200, { "Content-Type" => "text/html" }, ["<h1>OK</h1>"]] }
        #    #run Heartbeat
        #    run RackRouter.new
        # end


      end
      #puts "app1: "
      #puts @app
  end

  def call(env)
    puts "app2: "
    puts @app
    @app.call(env)
  end
end

Rack::Handler::WEBrick.run MyApp.new


# Rack from the beginning:
# http://hawkins.io/2012/07/rack_from_the_beginning/

# myApp = Rack::Builder.new do
#   map '/greeting' do
#    run Heartbeat
#  end
# end
# #
# # puts "myApp: "
# # puts myApp
# Rack::Server.start :app => myApp
