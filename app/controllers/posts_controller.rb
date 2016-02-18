
# Post types: 1 = Link, 2 = Text

class PostsController < ApplicationController

  get '/posts/new/:subreddit_name/' do
    @subreddit = Subreddit.find_by(name: params[:subreddit_name])
    erb :"posts/new"
  end

  post '/posts/new/:subreddit_name/' do
    "#{params}"
  end

  get '/r/:subreddit_name/:post_title/comments' do
    erb :"posts/show"
  end



end