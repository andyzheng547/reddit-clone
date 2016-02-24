# Handles subreddit routing for subreddit, subreddit creation, and subscriptions

class SubredditsController < ApplicationController

  get '/r/:subreddit_slug' do
    redirect "/r/#{params[:subreddit_slug]}/pg/1"
  end

  get '/r/:subreddit_slug/pg/:page_num' do
    @subreddit = Subreddit.find_by_slug(params[:subreddit_slug])
    @user = Helpers.current_user(session)
    @posts, max_pages = Helpers.get_subreddit_posts(params[:subreddit_slug], params[:page_num].to_i)
    redirect "/r/#{@subreddit.slug}/pg/1" if params[:page_num].to_i <= 0 || params[:page_num].to_i > max_pages

    erb :"subreddits/show"
  end

  get '/r/subreddit/new' do
    if Helpers.is_logged_in?(session)
      erb :"subreddits/new"
    else
      erb :index, locals: {message: "You need to be logged in to create a new subreddit."}
    end
  end

  post '/r/subreddit/new' do
    if existing_subreddit = Subreddit.find_by(name: params[:name]) || params[:name] == "all"
      erb :"subreddits/new", locals: {message: "That subreddit already exists</a>."}
    elsif !params[:name].gsub(" ", "").empty?
      @subreddit = Subreddit.create(name: params[:name], description: params[:description], is_private: params[:is_private])
      subscription = Subscription.create(user_id: Helpers.current_user(session).id, subreddit_id: @subreddit.id, access: true)
      moderator = Moderator.create(user_id: Helpers.current_user(session).id, subreddit_id: @subreddit.id)
      redirect "/r/#{@subreddit.slug}"
    else
      erb :"subreddits/new", locals: {message: "You forgot to enter a subreddit name."}
    end
  end

  # Posted from form in subreddit page via the "Subscribe" button inside the subreddit side info
  post '/r/:subreddit_slug/subscribe' do
    @subreddit = Subreddit.find_by_slug(params[:subreddit_slug])
    if @subreddit.is_private == true
      @subscription = Subscription.find_or_create_by(user_id: Helpers.current_user(session).id, subreddit_id: @subreddit.id, access: false)
      @subscription_request = SubscriptionRequest.find_or_create_by(user_id: Helpers.current_user(session).id, subscription_id: @subscription.id)
      @subscription_request.status = "pending"
      @subscription_request.save
      redirect "/r/#{@subreddit.slug}"
    else
      @subscription = Subscription.create(user_id: Helpers.current_user(session).id, subreddit_id: @subreddit.id, access: true)
      redirect "/r/#{@subreddit.slug}"
    end
  end

  # Change subscription request status and subsciption access for the requester
  post '/r/approve_request/:request_id' do
    request = SubscriptionRequest.find(params[:request_id])
    request.update(status: "approved")

    subscription = Subscription.find(request.subscription_id)
    subscription.update(access: true)

    redirect to "/u/#{Helpers.current_user(session).name}"
  end

  # Changes subscription request status
  post '/r/deny_request/:request_id' do
    request = SubscriptionRequest.find(params[:request_id])
    request.update(status: "denied")

    redirect to "/u/#{Helpers.current_user(session).name}"
  end


end