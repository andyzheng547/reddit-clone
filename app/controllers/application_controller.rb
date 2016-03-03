# Homepage and signups/logins

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :show_exceptions, :after_handler

    enable :sessions
    set :session_secret, "secret"
  end

  # 404 error
  not_found do
    erb :"404_error"
  end

  get '/test' do
    subreddit = Subreddit.find(26)
    "#{current_user.moderators.pluck(:subreddit_id).include?(26)}"
  end

  # Index has posts from all subreddits
  get '/' do
    redirect "/pg/1"
  end

  # Index shows up to 25 posts a page. The smaller the page number the more current the post entries are.
  get '/pg/:page_num' do
    @posts, max_pages = get_posts(params[:page_num].to_i)
    redirect "/r/#{@subreddit.slug}/pg/1" if params[:page_num].to_i <= 0 || params[:page_num].to_i > max_pages
    erb :index
  end

# Signup, Login and Logout buttons should be accessable on every page

  post '/signup' do
    # There was already a user with that name
    if found_existing_user = User.find_by(name: params[:name])
      erb :index, locals: {message: "That username is already taken."}

    # Create a new user if everything is valid and not empty. 
    elsif User.valid_username?(params[:name]) && !params[:name].gsub(" ", "").empty? && !params[:password].gsub(" ", "").empty?
      @user = User.create(name: params[:name], password: params[:password])
      session[:user_id] = @user.id
      redirect "/u/#{@user.name}"

    # Username was invalid or password and/or username was empty.
    else
      erb :index, locals: {message: "Please enter valid username(letters, numbers, dashes and underscores) and password."}
    end
  end

  post '/login' do
    # Username given
    if @user = User.find_by(name: params[:name])
      # Success
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/u/#{@user.name}"
      # Failure - wrong password for username
      else
        erb :index, locals: {message: "You entered the wrong password."}
      end

    # Could not find user
    else
      erb :index, locals: {message: "Could not find the account. Try logging in again."}
    end
  end

  post '/logout' do
    session.clear
    @current_user = nil
    redirect "/"
  end

# HELPERS
  def current_user
    @current_user || User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  # Get posts 25 posts for front page
  def get_posts(page_num)
    total_posts = Post.all
    max_pages = (total_posts.count.to_f / page_num).ceil

    # Max pages cannot be 0
    max_pages = 1 if max_pages == 0

    # Orders posts by id. Higher ids are the current entries
    select_posts = Post.all.order(id: :desc).limit(25 * page_num)
    posts = select_posts.limit(select_posts.count % 25)

    return posts, max_pages
  end

  # For getting posts from specific subreddits
  def get_subreddit_posts(subreddit_slug, page_num)
    subreddit = Subreddit.find_by_slug(subreddit_slug)
    subreddit_posts = Post.where(subreddit_id: subreddit.id)

    max_pages = (subreddit_posts.count.to_f / page_num).ceil

    # Max pages cannot be 0
    max_pages = 1 if max_pages == 0

    # Orders posts by id. Higher ids are the current entries
    select_posts = subreddit_posts.order(id: :desc).limit(25 * page_num)
    posts = select_posts.limit(select_posts.count % 25)

    return posts, max_pages
  end

end