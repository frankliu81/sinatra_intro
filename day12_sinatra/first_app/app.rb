require "sinatra"
require "sinatra/reloader"
require "faker"
require "byebug"

#byebug

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
  @name  = "Frank"
  @title  = "Greeting"
  erb(:greeting, {layout: :app_layout})
end

get '/company' do
  erb(:company, {layout: :app_layout})
end

post '/company' do
  @phrase = "<h2>#{Faker::Company.bs}</h2>"
  # when you are posting, you need to re-render the view
  erb(:company, {layout: :app_layout})
end


get '/convert' do
  erb :convert, layout: :app_layout
end

post '/convert' do
  # fahrenheit to celsius
  #@fahrenheit = params[:fahrenheit]
  #@celsius = (@fahrenheit.to_i - 32) * 5 / 9.0

  # celsius to fahrenheit
  # sinatra returns params from { "celius" => "45"}
  puts params
  @celsius = params[:celsius]
  @fahrenheit = @celsius.to_f  * (9 / 5) + 32

  erb :convert, layout: :app_layout
end

get '/calculator' do
  erb :calculator, layout: :app_layout
end

post '/calculator' do
  puts params
  @val1 = params[:val1]
  @val2 = params[:val2]
  @history=params[:history]
  @operator = params[:operator]
  if @operator == "+"
    @result = @val1.to_f + @val2.to_f
  elsif @operator == "-"
    @result = @val1.to_f - @val2.to_f
  elsif @operator == "*"
    @result = @val1.to_f * @val2.to_f
  elsif @operator == "/"
    @result = @val1.to_f / @val2.to_f
  end
  puts @result
  # greg's solution
  #@result = eval "#{@val1}#{@operator}#{@val2}"
  @history = @history + "#{@val1}#{@operator}#{@val2}=#{@result}\n"
  erb :calculator, layout: :app_layout
end


get '/car_status' do
  erb :car_status, layout: :app_layout
end

post '/car_status' do
  puts params
  @year = params[:year].to_i

  case
  when @year > Date.today.year
    @time_period = "future"
  when @year > (Date.today.year - 5)
    @time_period = "new"
  when @year > (Date.today.year - 15)
    @time_period = "old"
  else
    @time_period = "very old"
  end

  # Yi Van's solution
  # case params[:year].to_i
  #   when 1900...1950 then @result = "very old"
  #   when 1950...2010 then @result = "old"
  #   when 2010..2016 then @result = "new"
  #   when 2017 then @result = "future"
  #   else @result = "uncategorized"
  # end

  # if @year > 2016
  #   @time_period = "future"
  # elsif @year > 2011
  #   @time_period = "new"
  # elsif @year > 2000
  #   @time_period = "old"
  # else
  #   @time_period = "very old"
  # end

  erb :car_status, layout: :app_layout
end
