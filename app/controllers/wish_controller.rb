class WishController <ApplicationController
  use Rack::Flash

  namespace '/wish' do
    get '/:wish_list_id/new' do
      @wishlist = WishList.find(params[:wish_list_id])
      erb :'add_wish_to_wishlist'
    end

    post '/:wish_list_id/new' do
      @user = Helper.current_user(session)
      @wishlist = WishList.find(params[:wish_list_id])

      if @user.id == @wishlist.user_id
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
      @wishlist = WishList.find(params[:wish_list_id])
      @wish = Wish.find(params[:id])

       if @user.id == @wishlist.user_id
         @wish.name = params[:name]
         @wish.description = params[:description]
         @wish.url = params[:url]
         @wish.save
         redirect "/wish_list/show/#{@wish.wish_list_id}"
       else
         "oops, you don't seem to be the owner of this list. Only the owner of the list edit it."
         redirect '/list'
       end
    end
  end
end
