class WishListController <ApplicationController
  # use Rack::Flash

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
end
