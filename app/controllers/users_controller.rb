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
      @user = User.new(username: params["username"], email: params["email"], password: params["password"])
      @user.save

      if @user.valid?
        session[:user_id] = @user.id
      else
        if @user.errors[:username].present?
          flash[:message] = @user.errors[:username][0]
        elsif @user.errors[:email].present?
          flash[:message] = @user.errors[:email][0]
        elsif @user.errors[:password_digest].present?
          flash[:message] = @user.errors[:password_digest][0]
        end
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
  end
end
