
# Post types: 1 = Link Post, 2 = Text Post

class PostsController < ApplicationController

  get '/posts/new' do
    erb :"posts/new"
  end

  # When user fills out form for new post
  post '/posts/new' do
    # If the title is empty show the new post form again
    if params[:title].gsub(" ", "").empty?
      erb :"posts/new", locals: {message: "You left this post without a title."}

    # If the user did not click a checkbox indicating the subreddit to post to
    elsif params[:subreddit_id].empty?
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
          @post = Post.create(
            title: params[:title],
            link: params[:link], 
            post_type_id: params[:post_type_id], 
            user_id: Helpers.current_user(session).id, 
            subreddit_id: params[:subreddit_id])
          redirect "/r/#{@post.subreddit.slug}/#{@post.slug}/comments"
        end

      # Text Post
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
  end # post '/posts/new'

  # Show a particular post in subreddit
  get '/r/:subreddit_slug/:post_slug/comments' do
    @user = Helpers.current_user(session)
    @subreddit = Subreddit.find_by_slug(params[:subreddit_slug])
    @post = Post.find_by_slug(params[:post_slug])
    @comments = Comment.where(post_id: @post.id)
    erb :"posts/show"
  end

  post '/r/:subreddit_slug/:post_slug/new_comment' do
    if !params[:content].gsub(" ", "").empty?
      @comment = Comment.create(content: params[:content], user_id: Helpers.current_user(session).id, post_id: params[:post_id])
    end
    redirect "/r/#{Subreddit.find_by_slug(params[:subreddit_slug]).slug}/#{Post.find_by_slug(params[:post_slug]).slug}/comments"
  end

  post '/r/:subreddit_slug/:post_slug/new_reply' do
    if !params[:content].gsub(" ", "").empty?
      @reply = Reply.create(content: params[:content], user_id: Helpers.current_user(session).id, comment_id: params[:comment_id])
    end
    redirect "/r/#{Subreddit.find_by_slug(params[:subreddit_slug]).slug}/#{Post.find_by_slug(params[:post_slug]).slug}/comments"
  end

end



