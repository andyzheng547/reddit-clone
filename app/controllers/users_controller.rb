class UsersController < ApplicationController

  get '/u/:username' do
    @user = User.find_by(name: params[:username])
    erb :"users/profile"
  end

  get '/u/:username/edit' do
    @user = User.find_by(name: params[:username])
    redirect "/" if current_user != @user
    erb :"users/edit"
  end

  post '/u/:username/edit' do
    @user = User.find(params[:user_id])

    # Update username if new username was given
    if !params[:name].gsub(" ", "").empty? && User.valid_username?(params[:name])
      # Username is taken and message shown or username is updated
      if found_user = User.find_by(name: params[:name])
        erb :"users/edit", locals: {message: "There is already a user with that name."}
      else
        @user.update(name: params[:name])
      end
    end

    # Update password if user confirms old password and gives a new one
    if !params[:old_password].empty? && !params[:new_password].empty? && @user.authenticate(params[:old_password])
      @user.update(password: params[:new_password])
    end

    redirect "/u/#{@user.name}"
  end

  # Form for deleting user
  get '/u/:username/delete' do
    @user = User.find_by(name: params[:username])
    redirect "/" if current_user != @user
    erb :"users/delete"
  end

  # If user is a moderator, reassign the mod statuses or delete subreddits
  post '/u/:username/delete' do
    @user = current_user

    if params[:confirmation] == "yes"
      # Reassign moderator status or delete moderated subreddits
      current_user.moderators.each do |mod_status|
        mod_subscription = current_user.subscriptions.find_by(mod_status.subreddit.id)
        mod_status.subreddit.reassign_mod_or_delete_subreddit(mod_subscription)
      end

      @user.delete
      session.clear
      @current_user = nil

      redirect "/"

    # Redirect back to profile if user selected no or nothing 
    else
      redirect "/u/#{@user.name}"
    end
  end
end