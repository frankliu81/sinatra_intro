require "sinatra"
require "sinatra/reloader"

get '/' do
  #puts "inside get /"
  # because of naming convention, :index will look into the views folder
  # for index.rb
  # in Sinatra you dont need html.erb, in Rails you do
  @title  = "Welcome"
  # layout: :app_layout helps reduce repetitions
  # "<h2>Welcome to my First Web App!</h2>"
  erb(:index, {layout: :app_layout})
  # alternative syntax
  #erb :index, {layout: :app_layout}
  #erb :index, layout: :app_layout
end

get '/about' do
  #puts "inside get /about"
  @title  = "About"
  erb(:about, {layout: :app_layout})
end

get '/greeting' do
  @title  = "Greeting"
  @name  = "Frank"
  erb(:greeting, {layout: :app_layout})
end

get '/fizzbuzz' do
  # http://localhost:4567/fizzbuzz?number1=3&number2=5
  @number1 = params[:number1].to_i
  @number2 = params[:number2].to_i
  puts @number1
  puts @number2
  erb :fizzbuzz, layout: :app_layout
end

post '/fizzbuzz' do
  @number1 = params[:number1].to_i
  @number2 = params[:number2].to_i
  erb :fizzbuzz, layout: :app_layout
end
