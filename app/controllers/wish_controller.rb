class WishController <ApplicationController
  # use Rack::Flash

  get '/add_wish_to_wishlist/:id' do
    @wishlist = WishList.find(params[:id])
    erb :'add_wish_to_wishlist'
  end

  post '/add_wish_to_wishlist/:wish_list_id' do
    @wish = Wish.create(name: params[:name], description: params[:description], url: params[:url], wish_list_id: params[:wish_list_id])
    redirect "/show_wish_list/#{@wish.wish_list_id}"
  end
end
