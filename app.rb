require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models"

configure :development do
  set :database, "sqlite3:main.db"
  require 'pry'
end

configure :production do
  set :database, ENV["DATABASE_URL"]
end

enable :sessions

set :database, "sqlite3:app.db"

get "/" do
  if session[:user_id]
    erb :index_signedin
  else
    erb :index_signedout
  end
end

# displays sign in form
get "/sign-in" do
  erb :sign_in
end

# responds to sign in form
post "/sign-in" do
  @user = User.find_by(username: params[:username])

  # checks to see if the user exists
  #   and also if the user password matches the password in the db
  if @user && @user.password == params[:password]
    # this line signs a user in
    session[:user_id] = @user.id

    # lets the user know login status
    flash[:info] = "You have signed in successfully!"
    # redirects to the home page
    redirect "/"
  else
    flash[:warning] = "Your username, password and/or whole way of life is incorrect."

    #   redirect user to the sign-in page
    redirect "/sign-in"
  end
end

# displays sign-up form
#   with fields for relevant user information like:
#   username, password
get "/sign-up" do
  erb :sign-up
end

post "/sign-up" do
  @user = User.create(
    username: params[:username],
    password: params[:password],
    first_name: params[:first_name],
    last_name: params[:last_name],
    birthday: params[:birthday],
    email: params[:email]
  )

  # signing in
  session[:user_id] = @user.id

  # lets the user know sign-up status
  flash[:info] = "You signed up! AWESOME!"

  # assuming this page exists
  redirect "/"
end

# if from hit via link, resets session and redirects to home
get "/sign-out" do
  # this is the line that signs a user out
  session[:user_id] = nil

  # lets the user know sign-out
  flash[:info] = "You have been signed out"

  redirect "/sign-in"
end

get "/main" do
  @posts = Post.all.order("created_at DESC")
  @users = User.all
  erb :main
end

get "/post" do
  @posts = Post.all
  @user = User.find(session[:user_id])
  erb :post
end

post "/post" do
  @post = Post.create(
    title: params[:title],
    subject: params[:subject],
    content: params[:content],
    user_id: session[:user_id]
  )
  redirect "/main"
end

get "/users" do
  @users = User.all
  @post = Post.last
  User.all.map { |user| "USERNAME: #{user.username} PASSWORD:#{user.password}" }.join(", ")
end

get "/profile" do
  @user = User.find(session[:user_id])
  erb :profile
end


get "/profile/:id" do
  @user = User.find(session[:user_id])
  @posts = @user.posts
end

get '/settings' do
  erb :settings
end

post '/settings' do
  title = params[:title]
  id = session[:user_id]
  user = User.find(id)
  if title != user.username
    redirect '/settings'
  else
    user.posts.destroy
    user.destroy
    session[:user_id] = nil
    redirect '/'
  end
end
