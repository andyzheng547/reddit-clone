class UsersController < ApplicationController

  get '/u/:username' do
    @user = Helpers.current_user(session)
    erb :"users/profile"
  end

end