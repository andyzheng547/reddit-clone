class UsersController < ApplicationController

  get '/u/:username' do
    @user = Helpers.current_user(session)
    erb :"users/profile"
  end

  get '/u/:username/edit' do

  end

  get '/u/:username/delete' do

  end

  post '/u/:username/edit' do

  end

  post '/u/:username/delete' do

  end

end