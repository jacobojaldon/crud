require 'sinatra'
require 'sequel'

DB = Sequel.connect("postgresql://localhost/users")

def initialize
  @users = DB[:users]
end

get '/users' do 
  erb :"users/index"
end

get '/' do
  redirect '/users'
end

get '/users/new' do
  erb :"users/new"
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

post '/users' do
  @users.insert(fname: params[:fname], lname: params[:lname], email: params[:email])
  redirect '/users'
  # @users.insert(params[:users])    alternative version look at new_user.erb
end

patch '/users/:id' do
  @users = @users.where(id: params[:id])
  # @users.insert(fname: params[:fname], lname: params[:lname], email: params[:email]) dont use insert
  @users.update(fname: params[:fname], lname: params[:lname], email: params[:email])
  redirect '/users'
end

delete '/users/:id' do
  # you find in the @users table where the :id key is equivalent to params [:id] and the assign to a variable
  # x = @users.where(id: params[:id])             alternative way
  # x.delete
  @users = @users.where(id: params[:id]).delete 
  redirect '/users'
end

