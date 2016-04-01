# Given this dictionary file: https://s3.amazonaws.com/codecore-website-data/certifiedin_images/Oxford+English+Dictionary.txt
#
# Use Ruby Rack to build a simple dictionary web a. The website should work as follows:
# 1. If you go to the hope page such as: http://localhost:8080 it will display "Welcome to Dictionary".
# 2. If you go to a url like http://localhost:8080/?word=Abandon where the word is defined in the dictionary it will display the definition of the word `Abandon`.
# 3. If you go to a url like http://localhost:8080/?word=fdsdfddf where the word is not defined in the dictionary it will display `Sorry your word was not found`.
# 4. If you go to a urt like http://localhost:8080/?word=Canada%20goose where there is space in the word
# 5. If you go to a urt like http://localhost:8080/?worsdfsdf where no word is provided "You did not provide a valid word"

require "rack"
# require "byebug"

class Dictionary

  def initialize
    @dict_hash = {}
  end

  def build_dictionary_hash
    line_num = 0
    # http://stackoverflow.com/questions/6012930/read-lines-of-a-file-in-ruby
    File.open('Oxford+English+Dictionary.txt').each do |line|
      #if line_num < 10
        #puts "#{line_num += 1} #{line}"
        # if we get empty line or
        # one character of the alphabet
        # follow by two spaces and a newline char, ie. "A "
        # we do nothing
        if line.length < 4
          # do nothing
        else
          # dictionary line format is word follow by two spaces
          #puts line
          #space_index = line.index(" ")
          #word = line[0...space_index]
          #puts word
          #definition = line[space_index+2..-1]

          # simpler implementation split the line by double space
          word_defnition = line.split("  ")
          #puts word_defnition[0]
          #puts word_defnition[1]
          #byebug
          @dict_hash[word_defnition[0]] = word_defnition[1]
        end
      #end

      line_num += 1;
    end
  end

  def look_up(word)
    @dict_hash[word]
  end

end

class RackDictionary

  @@dictionary = {}

  def self.initialize(dictionary)
      @@dictionary = dictionary
  end

  def self.call(env)
    req = Rack::Request.new(env)

    # puts env
    responseString = ""
    params = req.params
    #puts req.path
    #puts env["PATH_INFO"]
    #puts env["REQUEST_PATH"]
    #puts "hello"
    puts params

    if  params == {}
      responseString = "<h1>Welcome to Dictionary</h1>"
      #elsif env["PATH_INFO"] == "/greeting"
    # if the word param is not found
    elsif params["word"] == nil
      responseString = "<h1>You did not provide a valid word</h1>"
    else
      definition = @@dictionary.look_up(params["word"])
      if definition == nil
        responseString = "<h1>Sorry your word was not found</h1>"
      else
        # byebug
        #puts @@dictionary.look_up(params["word"])
        # needs to include the utf-8 encoding
        responseString =
        "<!DOCTYPE html><html><head><title>Dictionary</title><meta charset='utf-8'></head><body>" +
        "<h1> #{params["word"]}: #{@@dictionary.look_up(params["word"])} </h1>" +
        "</body></html>"
        #puts responseString;
      end
    end

    response = Rack::Response.new
    response.write responseString
    response.status = 200
    response['Content-Type'] = "text/html"
    #[200, {"Content-Type" => "text/html"}, [responseString]]
    #puts "response.finish"
    #puts response.finish
    response.finish
  end

end


dictionary = Dictionary.new
dictionary.build_dictionary_hash
RackDictionary.initialize(dictionary)
Rack::Handler::WEBrick.run RackDictionary
