class WishController < ApplicationController
  use Rack::Flash

  namespace '/wishes' do
    get '/:wish_list_id/new' do
      find_wish_list_from_params
      erb :'wishes/new'
    end

    post '/:wish_list_id/new' do
      find_wish_list_from_params

      if @wish_list.is_own_list?(session[:user_id])
        @wish = Wish.create(
          name: params[:name],
          description: params[:description],
          url: params[:url],
          wish_list_id: params[:wish_list_id]
        )

        if @wish.valid?
          redirect "/wish_lists/show/#{@wish.wish_list_id}"
        else
          flash[:message] = @wish.errors[:name][0] || @wish.errors[:description][0] || @wish.errors[:url][0]
          redirect "/wishes/#{@wish.wish_list_id}/new"
        end
      else
        flash[:message] = "oops, you don't seem to be the owner of this list. Only the owner of the list add wishes to it."
        redirect "/wish_lists"
      end
    end

    get '/:id/edit' do
      if !Helper.is_logged_in?(session)
        redirect '/users/login'
      else
        set_user
        @wish = Wish.find(params[:id])
        erb :'wishes/edit'
      end
    end

    patch '/:id/edit' do
      set_user
      @wish = Wish.find(params[:id])
      @wish_list = WishList.find(@wish.wish_list_id)

       if @wish_list.is_own_list?(session[:user_id])
         @wish.name = params[:name]
         @wish.description = params[:description]
         @wish.url = params[:url]
         @wish.save
         redirect "/wish_lists/show/#{@wish.wish_list_id}"
       else
         flash[:message] = "oops, you don't seem to be the owner of this list. Only the owner of the list edit it."
         redirect '/wish_lists'
       end
    end

    delete '/:id' do
      @wish = Wish.find(params[:id])
      @wish_list = WishList.find(@wish.wish_list_id)

      if Helper.is_logged_in?(session) && @wish_list.is_own_list?(session[:user_id])
        @wish.delete
        redirect "/wish_lists/show/#{@wish_list.id}"
      else
        flash[:message] = "oops, you don't seem to be the owner of this list. Only the owner of the list edit it."
        redirect '/wish_lists'
      end
    end

    private

    def find_wish_list_from_params
      @wish_list = WishList.find(params[:wish_list_id])
    end

  end
end
