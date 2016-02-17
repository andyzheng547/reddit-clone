class UsersController < ApplicationController

  get '/u/:username' do
    erb :"users/profile"
  end

end