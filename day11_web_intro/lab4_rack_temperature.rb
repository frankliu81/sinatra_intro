# Build a simple ap that converts temperatures from fahrenheit to celsius using Rack
# URL  should be http://localhost:8080/?temp=100

require "rack"

class RackTemperature

  def intiaialize
    @fahrenheit = 0;
    @celsius = 0;
  end

  def self.call(env)
    req = Rack::Request.new(env)
    @fahrenheit = req.params["temp"]
    @celsius = f_to_c(@fahrenheit)
    response = "<h1>#{@fahrenheit} F is #{'%.2f' % @celsius}. C</h1>"
    [200, {"Content-Type" => "text/html"}, [response]]
  end

  def self.f_to_c(fahrenheit)
    (fahrenheit.to_i - 32) * 5/9.0
  end

end

Rack::Handler::WEBrick.run RackTemperature
