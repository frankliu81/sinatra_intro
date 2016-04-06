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

set :public_folder, 'public'


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
    session[:task_list].push(@task_hash)
  else
    session[:task_list].push(@task_hash)
  end

  puts "===== session[:task_list]: ====="
  puts session[:task_list]

  redirect to("/list_task")
end

get "/list_task" do

  # if session[:task_list]
  #   puts session[:task_list][0].keys
  # end

  erb :list_task, layout: :app_layout;
end

get "/list_task" do

  # if session[:task_list]
  #   puts session[:task_list][0].keys
  # end

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
  taskIndex = params[:taskIndex].to_i

  #puts session[:task_list][taskId].keys[0]
  #puts session[:task_list][taskId].values[0]
  # values[0] is the first value of the task_hash, which is the task note
  # ruby on rails has to_json
  #{ :note => session[:task_list][taskId].values[0] }.to_json
  content_type :json
  # puts taskIndex;
  {:note => session[:task_list][taskIndex].values[0]}.to_json
end

get "/team_randomizer" do
  erb :team_randomizer, layout: :app_layout
end

post "/team_randomizer" do
  @array_of_teams = []
  @name_arr = params[:name_list].split(", ").shuffle!
  @name_arr_length = @name_arr.length
  session[:number] = params[:number]
  session[:name_list] = params[:name_list]

  if params[:randomizer_option] == "num_ppl"
    @num_per_team = params[:number].to_i
    session[:randomizer_option] = "num_ppl"
    puts "@num_per_team"
    puts @num_per_team
    puts "@name_arr_length"
    puts @name_arr_length
    @number_of_teams = (@name_arr_length / @num_per_team.to_f).ceil
  elsif params[:randomizer_option] == "num_team"
    @number_of_teams = params[:number].to_i
    puts "@number_of_teams"
    puts @number_of_teams
    puts " @name_arr_length"
    puts @name_arr_length
    session[:randomizer_option] = "num_team"
  end


  if @number_of_teams > @name_arr_length
    @number_of_teams_error = true;
    return erb :team_randomizer, layout: :app_layout
  end

  # Owen's implementation for num_per_team
  # if @num_per_team
  #
  #   @number_of_teams = (@name_arr_length / @num_per_team.to_f).ceil
  #   for x in 1..@name_arr_length
  #     @temp_array = []
  #     @num_per_team.times do
  #       @temp_array << @name_arr.pop
  #     end
  #
  #     @array_of_teams.push(@temp_array)
  #     # I might have to iterate through the arrays to delete the nils if they get printed
  #     # if !@temp_array.all? { |e| e == nil }
  #     #   @array_of_teams.push(@temp_array)
  #     # end
  #   end
  # end

  if @number_of_teams
    #@number_of_people = @name_arr_length
    # @people_per_team = (@number_of_people / @team_num.to_f).ceil

    # Initialize empty arrays for each team
    for i in 1..@number_of_teams
      @array_of_teams.push([])
    end


    for i in 0..@name_arr_length - 1
      index_to_team = i % @number_of_teams

      @array_of_teams[index_to_team].push(@name_arr.pop)
      puts "Array of teams:"
      print @array_of_teams
      puts
    end
      # for all the team except the last fill them with the max number of people per team
    # for x in 1..@team_num
    #   @temp_array = []
    #   @people_per_team.times do
    #     @temp_array.push(@name_arr.pop)
    #   end
    #   @array_of_teams.push(@temp_array)
    #   puts "Array of teams after push 1:"
    #   puts @array_of_teams
    # end​
    #   for the remaining team fill it with the left over people
    # @array_of_teams.push(@name_arr)
    # puts "Array of teams after push 2:"
    # puts @array_of_teams
  end

  erb :team_randomizer, layout: :app_layout
end
