require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
   set :public_folder, 'public'
   set :views, 'app/views'
   enable :sessions
   set :session_secret, "secret"
 end

   get '/' do
     if Helper.is_logged_in?(session)
    redirect "/list"
    else
      erb :'/homepage'
    end
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

    get '/list' do
      if !Helper.is_logged_in?(session)
        redirect '/login'
      else
        @user = Helper.current_user(session)
        erb :'/list'
    end
  end

  get '/new_wish_list' do
   erb :'new_wish_list'
  end

  post '/new_wish_list' do
    @user = Helper.current_user(session)
    @newlist = WishList.create(name: params[:name], user: @user)
    @newlist.save
    redirect "/show_wish_list/#{@newlist.id}"
  end

  get '/show_wish_list/:id' do
    if !Helper.is_logged_in?(session)
      redirect '/login'
    else
      @user = Helper.current_user(session)
      @newlist = WishList.find(params[:id])
      erb :'show_wish_list'
    end
  end

  get '/add_wish_to_wishlist/:id' do
    @wishlist_id = params[:id]
    erb :'add_wish_to_wishlist'
  end

  post '/add_wish_to_wishlist/:wish_list_id' do
    @wish = Wish.create(name: params[:name], description: params[:description], url: params[:url], wish_list_id: params[:wish_list_id])
    redirect "/show_wish_list/#{@wish.wish_list_id}"
  end

end
