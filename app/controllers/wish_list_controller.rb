class WishListController <ApplicationController
  use Rack::Flash

  get '/list' do
    if !Helper.is_logged_in?(session)
      redirect '/login'
    else
      @wish_list = WishList.all
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
      @wish_list = WishList.create(name: params[:name], user: @user)
      redirect "/wish_list/show/#{@wish_list.id}"
    end

    get '/show/:id' do
      if !Helper.is_logged_in?(session)
        redirect '/login'
      else
        @user = Helper.current_user(session)
        @wish_list = WishList.find(params[:id])
        erb :'show_wish_list'
      end
    end

    get '/:id/edit' do
      @user = Helper.current_user(session)
      @wish_list = WishList.find(params[:id])
      erb :'edit_wish_list'
    end

    patch '/:id/edit' do

      @wish_list = WishList.find(params[:id])

       if Helper.is_logged_in?(session)
         @wish_list.name = params[:name]
         @wish_list.save
         redirect "/wish_list/show/#{@wish_list.id}"
       else
         redirect '/login'
       end
    end


    delete '/:id' do
      @wish_list = WishList.find(params[:id])

      if Helper.is_logged_in?(session) && @wish_list.user.id == session[:user_id]
        @wish_list.delete
        redirect '/list'
      else
        flash[:message] = "Oops, you don't seem to be the owner of this list. Only the owner of the list can delete it <3"
        redirect '/list'
      end
    end



  end
end
