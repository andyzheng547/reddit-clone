class UsersController < ApplicationController

  get '/u/:username' do
    @user = User.find_by(name: params[:username])
    erb :"users/profile"
  end

  get '/u/:username/edit' do
    @user = User.find_by(name: params[:username])
    erb :"users/edit"
  end

  get '/u/:username/delete' do

  end

  post '/u/:username/edit' do

  end

  post '/u/:username/delete' do

  end

end