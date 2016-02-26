
# Post types: 1 = Link Post, 2 = Text Post

class PostsController < ApplicationController

  get '/posts/new' do
    if Helpers.is_logged_in?(session)
      erb :"posts/new"
    else
      erb :index, locals: {message: "You need to be logged in to create a new post."}
    end
  end

  # When user fills out form for new post
  post '/posts/new' do
    # If the title is empty show the new post form again
    if params[:title].gsub(" ", "").empty?
      erb :"posts/new", locals: {message: "You left this post without a title."}

    # If the user did not click a checkbox indicating the subreddit to post to
    elsif params[:subreddit_name].empty?
      erb :"posts/new", locals: {message: "You need to post to a subreddit."}

    # Create a link post or text post based on post type id
    else
      case params[:post_type_id]

      # Link Post
      when "1"
        # If they forgot a link
        if params[:link].gsub(" ", "").empty?
          erb :"posts/new", locals: {message: "You need a link."}
        # else create link post
        else
          subreddit = Subreddit.find_by(name: params[:subreddit_name])
          @post = Post.create(
            title: params[:title],
            link: params[:link], 
            post_type_id: params[:post_type_id], 
            user_id: Helpers.current_user(session).id, 
            subreddit_id: subreddit.id)
          redirect "/r/#{@post.subreddit.slug}/#{@post.slug}/comments"
        end

      # Text Post
      when "2"
        subreddit = Subreddit.find_by(name: params[:subreddit_name])
          @post = Post.create(
            title: params[:title],
            content: params[:content], 
            post_type_id: params[:post_type_id], 
            user_id: Helpers.current_user(session).id, 
            subreddit_id: subreddit.id)
          redirect "/r/#{@post.subreddit.slug}/#{@post.slug}/comments"
      end
    end
  end # post '/posts/new'

  # Show a particular post in subreddit
  get '/r/:subreddit_slug/:post_slug/comments' do
    @user = Helpers.current_user(session) if session[:user_id] != nil
    @subreddit = Subreddit.find_by_slug(params[:subreddit_slug])
    @post = Post.find_by_slug(params[:post_slug])
    @comments = Comment.where(post_id: @post.id)
    erb :"posts/show"
  end

  post '/r/:subreddit_slug/:post_slug/new_comment' do
    if !params[:content].gsub(" ", "").empty?
      @comment = Comment.create(
        content: params[:content],
        user_id: Helpers.current_user(session).id,
        post_id: params[:post_id]
      )
    end
    # Redirect back to comments page when comment created
    redirect "/r/#{Subreddit.find_by_slug(params[:subreddit_slug]).slug}/#{Post.find_by_slug(params[:post_slug]).slug}/comments"
  end

  post '/r/:subreddit_slug/:post_slug/new_reply' do
    if !params[:content].gsub(" ", "").empty?
      @comment = Comment.create(
        content: params[:content],
        user_id: Helpers.current_user(session).id,
        post_id: params[:post_id],
        parent_id: params[:parent_id]
      )
    end
    # Redirect back to comments page when reply created
    redirect "/r/#{Subreddit.find_by_slug(params[:subreddit_slug]).slug}/#{Post.find_by_slug(params[:post_slug]).slug}/comments"
  end

end



