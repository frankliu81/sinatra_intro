require "sinatra"
require "sinatra/reloader"
# if you want to send e-mail
# require "pony"

enable :sessions
use Rack::MethodOverride

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'supersecret']
  end
end

# DSL: Domain Specific Language
# do ... end is a block, every Ruby function can take in a block
# Sinatra DSL has the format HTTP verb follow by URL
get "/" do
  # "Hello World"
  # erb :index, layout: :app_layout

  #puts "before session[:visit_count]: #{session[:visit_count]}"
  # if session[:visit_count] == nil
  # if session[:visit_count].nil?
   # nil or zero
  if session[:visit_count]
    session[:visit_count] += 1
  else
    session[:visit_count] = 1
  end
  #puts "after session[:visit_count]: #{session[:visit_count]}"

  erb(:index, {layout: :app_layout})
end

get "/converter" do
  erb(:converter, {layout: :app_layout})
end

post "/convert" do
  @temp_f = params[:temp_f].to_f
  @temp_c = ((@temp_f - 32) * 5/9).round(2)
  session[:last_temp] = @temp_c
  erb(:converter, {layout: :app_layout})
end

get "/secret" do
    protected!
    "Super Secret"
end

get "/about" do
  # if you want to redirect to about us
  redirect to("/about-us")
end

get "/about-us" do
  erb(:about_us, {layout: :app_layout})
end

delete "/reset_visit_count" do
  session[:visit_count] = 0
  # redirect to ("/")
  # back to the page you were on
  redirect back
end

# sending e-mail
# Pony.mail({
#   to: "tam@codecore.ca",
#   from: "tam@codecore.ca",
#   subject: "You got a message",
#   body: params[:message],
#   via: :smtp,
#   via_options:     {
#         address:        'smtp.gmail.com',
#         port:           '587',
#         user_name:      'answerawesome',
#         password:       'Sup3r$ecret$$',
#         authentication: :plain,
#         domain:         "localhost.localdomain" # the HELO domain provided by the client to the server
#       }
# });
