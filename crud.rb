require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

# require 'sinatra'
# require 'sequel'

DB = Sequel.connect("postgresql://localhost/users")

def initialize
  @users = DB[:users]
end

get '/homepage' do
  erb :"homepage/index"
end

get '/users/new' do
  erb :"users/new"
end

get '/users' do 
  erb :"users/index"
end

get '/' do
  redirect '/homepage'
  # erb :"homepage"
end

get '/users/signin' do
  erb :"homepage/signin"
end

# url
get '/users/:id' do
  # to specify a user
  @user = @users.where(id: params[:id]).first
  erb :"users/show"
  # specific user page
end

get '/users/:id/edit' do
  @user = @users.where(id: params[:id]).first
  erb :"users/edit"
end

# you post/create a new text that will show on the index page
post '/users' do
  @users.insert(fname: params[:fname], lname: params[:lname], email: params[:email], username: params[:username], password: params[:password])
  redirect '/users'
  # @user.insert(params[:users])    alternative version look at new_user.erb
end

# you create an edit button to be able to edit the name in show user page
patch '/users/:id' do
  @user = @users.where(id: params[:id])
  # @users.insert(fname: params[:fname], lname: params[:lname], email: params[:email]) dont use insert
  @users.update(fname: params[:fname], lname: params[:lname], email: params[:email])
  redirect '/users'
end

# you create a delete button to be able to delete the user in that specific show user page
delete '/users/:id' do
  # you find in the @users table where the :id key is equivalent to params [:id] and the assign to a variable
  # x = @users.where(id: params[:id])             alternative way
  # x.delete
  @user = @users.where(id: params[:id]).delete 
  redirect '/users'
end

# post '/signin' do
#   @user = @users.where(id: params[:id]).first 
#   erb :"/signin"
# end

# get '/users/signin' do
#   erb :"users/signin"
# end


  #  @user = @users.where(id: params[:id])
  #  @users.authenticate(username: params[:username], password: params[:password])
  # redirect '/users'


