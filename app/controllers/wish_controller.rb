class WishController <ApplicationController
  use Rack::Flash

  namespace '/wish' do
    get '/:wish_list_id/new' do
      @wish_list = WishList.find(params[:wish_list_id])
      erb :'add_wish_to_wishlist'
    end

    post '/:wish_list_id/new' do
      @user = Helper.current_user(session)
      @wish_list = WishList.find(params[:wish_list_id])

      if @user.id == @wish_list.user_id
        @wish = Wish.create(
          name: params[:name],
          description: params[:description],
          url: params[:url],
          wish_list_id: params[:wish_list_id]
        )

        redirect "/wish_list/show/#{@wish.wish_list_id}"
      else
        flash[:message] = "oops, you don't seem to be the owner of this list. Only the owner of the list add wishes to it."
        redirect "/list"
      end
    end

    get '/:id/edit' do
      @user = Helper.current_user(session)
      @wish = Wish.find(params[:id])
      erb :'edit_wish'
    end

    patch '/:id/edit' do

      @user = Helper.current_user(session)
      @wish = Wish.find(params[:id])
      @wish_list = WishList.find(@wish.wish_list_id)

       if @user.id == @wish_list.user_id
         @wish.name = params[:name]
         @wish.description = params[:description]
         @wish.url = params[:url]
         @wish.save
         redirect "/wish_list/show/#{@wish.wish_list_id}"
       else
         flash[:message] = "oops, you don't seem to be the owner of this list. Only the owner of the list edit it."
         redirect '/list'
       end
    end

    delete '/:id' do
      @user = Helper.current_user(session)
      @wish = Wish.find(params[:id])
      @wish_list = WishList.find(@wish.wish_list_id)

      if Helper.is_logged_in?(session) && @wish_list.user.id == session[:user_id]
        @wish.delete
        redirect "/wish_list/show/#{@wish_list.id}"
      else
        flash[:message] = "oops, you don't seem to be the owner of this list. Only the owner of the list edit it."
        redirect '/list'
      end
    end

  end
end
