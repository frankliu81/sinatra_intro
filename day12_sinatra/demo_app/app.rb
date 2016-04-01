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
