class WishListController <ApplicationController
  use Rack::Flash

  namespace '/wish_lists' do
    get '' do
      if !Helper.is_logged_in?(session)
        redirect '/users/login'
      else
        @wish_list = WishList.all
        set_user
        erb :'/wish_lists/index'
      end
    end

    get '/user_lists' do
      if !Helper.is_logged_in?(session)
        redirect '/users/login'
      else
        @is_user_list = true
        set_user
        @wish_list = @user.wish_lists
        erb :'/wish_lists/index'
      end
    end

    get '/new' do
      if !Helper.is_logged_in?(session)
        redirect '/users/login'
      else
        erb :'wish_lists/new'
      end
    end

    post '/new' do
      set_user
      @wish_list = WishList.create(name: params[:name], user: @user)
      if @wish_list.valid?
        redirect "/wish_lists/show/#{@wish_list.id}"
      else
        flash[:message] = @wish_list.errors[:name][0]
        redirect '/wish_lists/new'
      end
    end

    get '/show/:id' do
      if !Helper.is_logged_in?(session)
        redirect '/users/login'
      else
        set_user
        @wish_list = WishList.find(params[:id])

        erb :'wish_lists/show'
      end
    end

    get '/:id/edit' do
      if !Helper.is_logged_in?(session)
        redirect '/users/login'
      else
        set_user
        @wish_list = WishList.find(params[:id])
        erb :'wish_lists/edit'
      end
    end

    patch '/:id/edit' do
      @wish_list = WishList.find(params[:id])

       if Helper.is_logged_in?(session)
         @wish_list.name = params[:name]
         @wish_list.save
         redirect "/wish_lists/show/#{@wish_list.id}"
       else
         redirect '/users/login'
       end
    end


    delete '/:id' do
      @wish_list = WishList.find(params[:id])

      if Helper.is_logged_in?(session) && @wish_list.user.id == session[:user_id]
        @wish_list.delete
      else
        flash[:message] = "Oops, you don't seem to be the owner of this list. Only the owner of the list can delete it <3"
      end
      redirect '/wish_lists'
    end
  end
end
