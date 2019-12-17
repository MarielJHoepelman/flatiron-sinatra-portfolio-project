class UsersController < ApplicationController
  use Rack::Flash

  namespace '/users' do
    get '/signup' do
     if Helper.is_logged_in?(session)
       redirect "/list"
     else
       erb :'signup'
      end
    end

    post '/signup' do
      if params["username"] != "" && params["email"] != "" &&  params["password"] != "" && Helper.is_valid_email?(params["email"])
        @user = User.new(username: params["username"], email: params["email"], password: params["password"])
        @user.save
        session[:user_id] = @user.id
      elsif !Helper.is_valid_email?(params["email"])
        flash[:message] = "Please enter a valid email. Please try again <3"
        redirect "/users/signup"
      else
        flash[:message] = "Unable to complete your request. Please try again <3"
        redirect "/users/signup"
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
        flash[:message] = "Unable to complete your request. Please try again <3"
        erb :'/login'
      end
    end

    get '/logout' do
      session.clear
      redirect to '/'
    end

    get '/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'/users/index'
    end
  end
end
