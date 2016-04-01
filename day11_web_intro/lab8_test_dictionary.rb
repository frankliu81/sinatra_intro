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

dictionary = Dictionary.new
dictionary.build_dictionary_hash
puts dictionary.look_up("And")
