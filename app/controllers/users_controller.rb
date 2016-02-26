class UsersController < ApplicationController

  get '/u/:username' do
    @user = User.find_by(name: params[:username])
    erb :"users/profile"
  end

  get '/u/:username/edit' do
    @user = User.find_by(name: params[:username])
    redirect "/" if Helpers.current_user(session) != @user
    erb :"users/edit"
  end

  post '/u/:username/edit' do
    @user = User.find(params[:user_id])
    if !params[:name].gsub(" ", "").empty? && User.valid_username?(params[:name])
      # Username is taken and message shown or username is updated
      if found_user = User.find_by(name: params[:name])
        erb :"users/edit", locals: {message: "There is already a user with that name."}
      else
        @user.update(name: params[:name])
      end
    end

    if !params[:old_password].empty? && !params[:new_password].empty? && @user.authenticate(params[:old_password])
      @user.update(password: params[:new_password])
    end

    redirect "/u/#{@user.name}"
  end

  get '/u/:username/delete' do
    @user = User.find_by(name: params[:username])
    redirect "/" if Helpers.current_user(session) != @user
    erb :"users/delete"
  end

  post '/u/:username/delete' do
    @user = User.find(params[:user_id])
    mod_statuses = Moderator.where(user_id: @user.id)

    # Find each subreddit the user a moderator of. 
    # If the subreddit does not have another moderator find another subscriber to make a mod or delete the subreddit.
    mod_statuses.each do |mod|
      subreddit = Subreddit.find(mod.subreddit_id)

      if subreddit.moderators.count == 1
        if subreddit.subscriptions.where(access: true).count > 1
          new_mod_user_id = subreddit.subscriptions.where(access: true).second.user_id
          mod.update(user_id: new_mod_user_id)
        else
          subreddit.delete_all
        end
      end

    end # end of loop

    @user.delete_all
    redirect "/"
  end

end