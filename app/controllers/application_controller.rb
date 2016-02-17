# Homepage and signups/logins

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/signup' do
    if found_existing_user = User.find_by(name: params[:name])
      erb :index, locals: {message: "That username is already taken."}
    elsif User.valid_username?(params[:name]) && !params[:name].empty? && !params[:password].empty?
      @user = User.create(name: params[:name], password: params[:password])
      session[:user_id] = @user.id
      redirect "/u/#{@user.name}"
    else
      erb :index, locals: {message: "Please enter valid username(letters, numbers, dashes and underscores) and password."}
    end
  end

  post '/login' do
    if @user = User.find_by(name: params[:name])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        erb :index, locals: {message: "Successful login. Welcome back."}
      else
        erb :index, locals: {message: "You entered the wrong password."}
      end
    else
      erb :index, locals: {message: "Could not find the account. Try logging in again."}
    end
  end

  post '/logout' do
    session.clear
    erb :index, locals: {message: "You have been logged out."}
  end

end