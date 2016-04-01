# Write a Ruby Rack application that takes in a score from the user and then
# displays a grade on the screen (A, B, C, D or F).
# For example the user can enter a URL like:
# http://localhost:8080/?score=95
# The user should then see an <h1> element on the screen with the letter A in it.


require "rack"

class RackGrade

  def intiaialize
  end

  def self.call(env)
    req = Rack::Request.new(env)
    scoreString = req.params["score"]
    letterGrade = grade(scoreString)
    response = "<h1>#{scoreString} is a #{letterGrade}.</h1>"
    [200, {"Content-Type" => "text/html"}, [response]]
  end

  def self.grade(scoreString)
    score = scoreString.to_i
    if score > 80
      "A"
    elsif score > 70
      "B"
    elsif score > 60
      "C"
    elsif score > 50
      "D"
    elsif
      "F"
    end
  end

  ""
end

Rack::Handler::WEBrick.run RackGrade
