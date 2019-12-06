class UsersController < ApplicationController
# use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/index'
  end

  get '/signup' do
   if Helper.is_logged_in?(session)
     redirect "/list"
   else
     erb :'signup'
    end
  end

  post '/signup' do
    if params["username"] != "" && params["email"] != "" &&  params["password"] != ""
      @user = User.new(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
    else
      redirect "/signup"
    end
    redirect :"/list"
  end

  get '/login' do
    if !Helper.is_logged_in?(session)
      erb :'/login'
    else
      redirect '/list'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/list'
    else
      erb :'/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end
end
