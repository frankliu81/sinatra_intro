require "sinatra"
require "sinatra/base"
require "sinatra/reloader"

$personality_hash = {
  ["with_deadline", "rational", "idea"] => "Rational",
  ["with_deadline", "rational", "fact"] => "Guardian",
  ["without_deadline", "rational", "idea"] => "Rational",
  ["without_deadline", "rational", "fact"] => "Artisan",
  ["with_deadline", "compassionate", "idea"] => "Idealist",
  ["with_deadline", "compassionate", "fact"] => "Guardian",
  ["without_deadline", "compassionate", "idea"] => "Idealist",
  ["without_deadline", "compassionate", "fact"] => "Artisan"

}

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


get '/personality' do
  erb :personality, layout: :app_layout
end

post '/personality_result' do
  puts params
  puts @personality_hash
  #{"a1"=>"without_deadline", "a2"=>"rational", "a3"=>"idea"}
  @options = [params[:a1], params[:a2], params[:a3]]
  @result = $personality_hash[@options]
  puts @result
  erb :personality_result, layout: :app_layout
end
