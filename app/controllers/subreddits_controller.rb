# Handles subreddit routing for subreddit, subreddit creation, and subscriptions

class SubredditsController < ApplicationController

  get '/r/:subreddit_slug' do
    redirect "/r/#{params[:subreddit_slug]}/pg/1"
  end

  get '/r/:subreddit_slug/pg/:page_num' do
    @subreddit = Subreddit.find_by_slug(params[:subreddit_slug])
    @user = current_user if session[:user_id] != nil
    @posts, max_pages = get_subreddit_posts(params[:subreddit_slug], params[:page_num].to_i)

    # For safety
    redirect "/r/#{@subreddit.slug}/pg/1" if params[:page_num].to_i <= 0 || params[:page_num].to_i > max_pages

    erb :"subreddits/index"
  end

  get '/r/subreddits/new' do
    if logged_in?(session)
      erb :"subreddits/new"
    else
      erb :index, locals: {message: "You need to be logged in to create a new subreddit."}
    end
  end

  post '/r/subreddits/new' do
    if existing_subreddit = Subreddit.find_by(name: params[:name]) || params[:name] == "all"
      erb :"subreddits/new", locals: {message: "That subreddit already exists</a>."}
    elsif !params[:name].gsub(" ", "").empty?
      @subreddit = Subreddit.create(name: params[:name], description: params[:description], is_private: params[:is_private])
      subscription = Subscription.create(user_id: current_user.id, subreddit_id: @subreddit.id, access: true)
      moderator = Moderator.create(user_id: current_user.id, subreddit_id: @subreddit.id)
      redirect "/r/#{@subreddit.slug}"
    else
      erb :"subreddits/new", locals: {message: "You forgot to enter a subreddit name."}
    end
  end

  get '/r/:subreddit_slug/edit' do
    @subreddit = Subreddit.find_by_slug(params[:subreddit_slug])
    erb :"subreddits/edit"
  end

  post '/r/:subreddit_slug/edit' do
    @subreddit = Subreddit.find(params[:subreddit_id])
    @subreddit.update(description: params[:description]) if !params[:description].empty?
    @subreddit.update(is_private: params[:is_private])

    redirect "/r/#{@subreddit.slug}"
  end

  get '/r/:subreddit_slug/add_mod' do
    @subreddit = Subreddit.find_by_slug(params[:subreddit_slug])
    erb :"subreddits/add_mod"
  end

  post '/r/:subreddit_slug/add_mod' do
    subreddit = Subreddit.find(params[:subreddit_id])
    subscribers_user_ids = Subscription.where(subreddit_id: subreddit.id, access: true).pluck(:user_id)
    if params[:new_mod_username].empty?
      # If username is empty do nothing
    elsif found_user = User.find_by(name: params[:new_mod_username])
      # if username entered belongs to an actual user 
      # check that user is subscribed to the subreddit before making them a mod
      if subscribers_user_ids.include?(found_user.id)
        new_mod = Moderator.create(subreddit_id: subreddit.id, user_id: found_user.id )
      end
    end
    redirect "/u/#{current_user.name}"
  end

  # Posted from form in subreddit page via the "Subscribe" button inside the subreddit side info
  post '/r/:subreddit_slug/subscribe' do
    @subreddit = Subreddit.find_by_slug(params[:subreddit_slug])
    if @subreddit.is_private == true
      @subscription = Subscription.find_or_create_by(user_id: current_user.id, subreddit_id: @subreddit.id, access: false)
      redirect "/r/#{@subreddit.slug}"
    else
      @subscription = Subscription.create(user_id: current_user.id, subreddit_id: @subreddit.id, access: true)
      redirect "/r/#{@subreddit.slug}"
    end
  end

  post '/r/:subreddit_slug/unsubscribe' do
    subreddit = Subreddit.find(params[:subreddit_id])

    # If the user was the moderator and there are no other mods, find another subscriber to make a mod or delete the subreddit.
    if subreddit.moderators.count == 1 && mod_status = Moderator.find_by(user_id: current_user.id, subreddit_id: subreddit.id)
      if subreddit.subscriptions.where(access: true).count > 1
        new_mod_user_id = subreddit.subscriptions.where(access: true).second.user_id
        mod_status.update(user_id: new_mod_user_id)
      else
        # delete_all may not exist if there are no other associations
        if subreddit.methods.include?(:delete_all)
          subreddit.delete_all
        else
          subreddit.delete
        end
        if mod_status.methods.include?(:delete_all)
          mod_status.delete_all
        else
          mod_status.delete
        end
      end
    end

    subscription = Subscription.find_by(subreddit_id: subreddit.id, user_id: current_user.id)
    if subscription.methods.include?(:delete_all)
      subscription.delete_all
    else
      subscription.delete
    end

    redirect to "/u/#{current_user.name}"
  end

  # Change subscription request status and subsciption access for the requester
  post '/r/approve_sub/:subscription_id' do
    subscription = Subscription.find(params[:subscription_id])
    subscription.update(access: true)

    redirect to "/u/#{current_user.name}"
  end

end