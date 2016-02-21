class SubredditsController < ApplicationController

  get '/r/:subreddit_slug' do
    @subreddit = Subreddit.find_by_slug(params[:subreddit_slug])
    @user = Helpers.current_user(session)
    erb :"subreddits/show"
  end

  get '/r/subreddit/new' do
    erb :"subreddits/new"
  end

  post '/r/subreddit/new' do
    if existing_subreddit = Subreddit.find_by(name: params[:name]) || params[:name] == "all"
      erb :"subreddits/new", locals: {message: "That subreddit already exists</a>."}
    elsif !params[:name].empty?
      @subreddit = Subreddit.create(name: params[:name], description: params[:description], is_private: params[:is_private])
      subscription = Subscription.create(user_id: Helpers.current_user(session).id, subreddit_id: @subreddit.id, access: true)
      moderator = Moderator.create(user_id: Helpers.current_user(session).id, subreddit_id: @subreddit.id)
      redirect "/r/#{@subreddit.slug}"
    else
      erb :"subreddits/new", locals: {message: "You forgot to enter a subreddit name."}
    end
  end

end