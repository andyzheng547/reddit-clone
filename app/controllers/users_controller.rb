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

    # Find each subreddit the user a moderator of. If the subreddit does not have another moderator:
      # find the next subscriber with access and make them a mod, otherwise delete the subreddit since there are no subscribed users
    mod_statuses.each do |mod_of|
      subreddit = Subreddit.find(mod_of.subreddit_id)

      if next_mod = Subscription.where({subreddit_id: subreddit.id, access: true}).second && subreddit.moderators.count == 1
        Moderator.create(subreddit_id: subreddit.id, user_id: next_moderator.id)
      else
        subreddit.delete
      end
    end # end of loop

    @user.delete
    erb :index, locals: {message: "Deleted account and reassigned moderator statuses."}
  end

end