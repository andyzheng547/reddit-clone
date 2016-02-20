
# Post types: 1 = Link Post, 2 = Text Post

class PostsController < ApplicationController

  get '/posts/new' do
    erb :"posts/new"
  end

  post '/posts/new' do
    if params[:title].empty?
      erb :"posts/new", locals: {message: "You left this post without a title."}
    elsif params[:subreddit_id].empty?
      erb :"posts/new", locals: {message: "You need to post to a subreddit."}
    else
      case params[:post_type_id]
      when "1"
        if params[:link].empty?
          erb :"posts/new", locals: {message: "You need a link."}
        else
          @post = Post.create(
            title: params[:title],
            link: params[:link], 
            post_type_id: params[:post_type_id], 
            user_id: Helpers.current_user(session).id, 
            subreddit_id: params[:subreddit_id])
          redirect "/r/#{@post.subreddit.slug}/#{@post.slug}/comments"
        end
      when "2"
          @post = Post.create(
            title: params[:title],
            content: params[:content], 
            post_type_id: params[:post_type_id], 
            user_id: Helpers.current_user(session).id, 
            subreddit_id: params[:subreddit_id])
          redirect "/r/#{@post.subreddit.slug}/#{@post.slug}/comments"
      end
    end
  end

  # Show a particular post in subreddit
  get '/r/:subreddit_slug/:post_title/comments' do
    erb :"posts/show"
  end



end