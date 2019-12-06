require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
   set :public_folder, 'public'
   set :views, 'app/views'
   enable :sessions
   set :session_secret, "secret"
  end

  get '/' do
     if Helper.is_logged_in?(session)
    redirect "/list"
    else
      erb :'/homepage'
    end
  end
end
