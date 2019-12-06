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

  namespace '/wish_list' do
    get '/new' do
      erb :'new_wish_list'
    end

    post '/new' do
      @user = Helper.current_user(session)
      @newlist = WishList.create(name: params[:name], user: @user)
      redirect "/wish_list/show/#{@newlist.id}"
    end

    get '/show/:id' do
      if !Helper.is_logged_in?(session)
        redirect '/login'
      else
        @user = Helper.current_user(session)
        @newlist = WishList.find(params[:id])
        erb :'show_wish_list'
      end
    end

    get '/:id/edit' do
      @user = Helper.current_user(session)
      @wish_list = WishList.find(params[:id])
      erb :'edit_wish_list'
    end

    patch '/wish_list/:id/edit' do
      "Hello World"
    end

  end
end
