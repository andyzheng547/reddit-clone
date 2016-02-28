# Homepage and signups/logins

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :show_exceptions, :after_handler

    enable :sessions
    set :session_secret, "secret"
  end

  error do
    erb :error
  end

  # Index has posts from all subreddits
  get '/' do
    redirect "/pg/1"
  end

  # Index shows up to 25 posts a page. The smaller the page number the more current the post entries are.
  get '/pg/:page_num' do
    @posts, max_pages = Helpers.get_posts(params[:page_num].to_i)
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
    redirect "/"
  end

end