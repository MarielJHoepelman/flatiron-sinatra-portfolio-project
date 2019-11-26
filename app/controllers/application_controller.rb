require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
   set :public_folder, 'public'
   set :views, 'app/views'
   enable :sessions
   set :session_secret, "secret"
 end

   get '/' do
     erb "Welcome to whatever this project is about that I still don't know <3"
   end
end
