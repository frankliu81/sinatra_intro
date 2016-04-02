# yield takes a block, and insert it in the middle of the method

def my_method
    puts "<html>"
    puts "<head>"
    puts "</head>"
    puts "</body>"
    yield
    puts "</body>"
    puts "</html>"
end

my_method do
    puts "<h1>Hello World</h1>"
end

puts

my_method do
    puts "<h1>About Us</h1>"
end
