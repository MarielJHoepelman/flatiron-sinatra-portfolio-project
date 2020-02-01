class UsersController < ApplicationController
  use Rack::Flash

  namespace '/users' do
    get '/signup' do
     if Helper.is_logged_in?(session)
       redirect "/wish_lists"
     else
       erb :'users/signup'
      end
    end

    post '/signup' do
      @user = User.new(params)
      @user.save

      if @user.valid?
        session[:user_id] = @user.id
      else
        if @user.errors[:name].present?
          flash[:message] = @user.errors[:name][0]
        elsif @user.errors[:email].present?
          flash[:message] = @user.errors[:email][0]
        elsif @user.errors[:password_digest].present?
          flash[:message] = @user.errors[:password_digest][0]
        end
        redirect "/users/signup"
      end
      redirect "/wish_lists"
    end

    get '/login' do
      if !Helper.is_logged_in?(session)
        erb :'users/login'
      else
        redirect '/wish_lists'
      end
    end

    post '/login' do
      @user = User.find_by(email: params["email"])

      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/wish_lists'
      else
        flash[:message] = "Unable to complete your request. Please try again <3"
        erb :'users/login'
      end
    end

    get '/logout' do
      session.clear
      redirect to '/'
    end
  end
end
