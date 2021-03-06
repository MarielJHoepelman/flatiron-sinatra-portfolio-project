require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  register Sinatra::Namespace

  configure do
   set :public_folder, 'public'
   set :views, 'app/views'
   enable :sessions
   set :session_secret, "secret"
  end

  get '/' do
    if Helper.is_logged_in?(session)
      redirect "/wish_lists"
    else
      erb :'/welcome'
    end
  end

  private

  def set_user
    @user = Helper.current_user(session)
  end
end
