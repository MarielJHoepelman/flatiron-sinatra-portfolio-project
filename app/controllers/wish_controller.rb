class WishController <ApplicationController
  # use Rack::Flash

  namespace '/wish' do
    get '/:wish_list_id/new' do
      @wishlist = WishList.find(params[:wish_list_id])
      erb :'add_wish_to_wishlist'
    end

    post '/:wish_list_id/new' do
      @wish = Wish.create(name: params[:name], description: params[:description], url: params[:url], wish_list_id: params[:wish_list_id])
      redirect "/wish_list/show/#{@wish.wish_list_id}"
    end
  end
end
