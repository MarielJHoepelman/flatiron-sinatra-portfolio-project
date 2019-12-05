class UsersController < ApplicationController
# use Rack::Flash

  get '/users/:slug' do
     @user = User.find_by_slug(params[:slug])
     erb :'/users/index'
   end
end
