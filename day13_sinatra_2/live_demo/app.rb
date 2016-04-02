require "sinatra"
require "sinatra/reloader"
require "pry"
require "pry-byebug"
require "byebug"
# for fake task title and note
require "faker"
# for ajax
require "json"

LANG_ARR = ["English", "French", "Spanish"]

#byebug
enable :sessions
use Rack::MethodOverride

get "/" do
  erb :index, layout: :app_layout;
end

get "/max_number" do
  # "Hello"
  erb :max_number, layout: :app_layout;
end

post "/max_number" do
  binding.pry
  @number_list = params[:number_list]
  @max_number = get_max(@number_list)
  erb :max_number, layout: :app_layout;
end

def get_max(string)
  string.split(",").map(&:to_i).max
end

get "/bill_splitter" do
  erb :bill_splitter, layout: :app_layout;
end


post "/bill_splitter" do
  @amount = params[:amount].to_f
  @tax = params[:tax].to_f
  @tip = params[:tip].to_f
  @count = params[:count].to_f
  @split_amount = (@amount + @amount * @tax/100.0 + @amount * @tip/100.0) / @count

  erb :bill_splitter, layout: :app_layout;
end


get "/language_preference" do

  erb :language_preference, layout: :app_layout;
end

post "/language_preference" do

  if params[:name]
    session[:name] = params[:name]
  end

  if
    session[:language_preference] = params[:language_preference]
  end

  puts session[:name]
  puts session[:language_preference]
  erb :language_preference, layout: :app_layout;
end


get "/create_task" do
  @title_filler = Faker::Company.bs
  @note_filler = Faker::Lorem.paragraph

  erb :create_task, layout: :app_layout;
end

post "/create_task" do


  @title =  params[:title]
  @note = params[:note]
  @task_hash = {}
  @task_hash[@title] = @note


  if !session[:task_list]
    session[:task_list] = []
  else
    session[:task_list].push(@task_hash)
  end

  puts session[:task_list]

  redirect to("/list_task")
end

get "/list_task" do

  erb :list_task, layout: :app_layout;
end

delete "/delete_task" do
  session[:task_list].delete_at(params[:delete_task_index].to_i)
  # redirect to ("/")
  # back to the page you were on
  redirect back
end

get "/view_task_note" do
  #puts "inside view_task_note"
  content_type 'application/json'
  taskId = params[:taskId].to_i
  #puts session[:task_list][taskId].keys[0]
  #puts session[:task_list][taskId].values[0]
  # values[0] is the first value of the task_hash, which is the task note
  # ruby on rails has to_json
  #{ :note => session[:task_list][taskId].values[0] }.to_json
  content_type :json
  {:note => session[:task_list][taskId].values[0]}.to_json
end
