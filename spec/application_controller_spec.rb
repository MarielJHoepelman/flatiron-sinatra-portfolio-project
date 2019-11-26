require 'spec_helper'

describe ApplicationController do

  describe "Homepage" do
    it 'loads the homepage' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to Wishable")
    end
  end

  describe "Signup Page" do

      it 'loads the signup page' do
        get '/signup'
        expect(last_response.status).to eq(200)
      end

      it 'signup directs user to twitter index' do
        params = {
          :name => "Flynn Ryder",
          :username => "iloveflynn",
          :email => "flynnryder@aol.com",
          :password => "perrito"
        }
        post '/signup', params
        expect(last_response.location).to include("/tweets")
      end

      it 'does not let a user sign up without a username' do
        params = {
          :name => "Flynn Ryder",
          :username => "",
          :email => "flynnryder@aol.com",
          :password => "perrito"
        }
        post '/signup', params
        expect(last_response.location).to include('/signup')
      end

      it 'does not let a user sign up without an email' do
        params = {
          :name => "Flynn Ryder",
          :username => "iloveflynn",
          :email => "",
          :password => "perrito"
        }
        post '/signup', params
        expect(last_response.location).to include('/signup')
      end

      it 'does not let a user sign up without a password' do
        params = {
          :name => "Flynn Ryder",
          :username => "iloveflynn",
          :email => "flynnryder@aol.com",
          :password => ""
        }
        post '/signup', params
        expect(last_response.location).to include('/signup')
      end

      it 'does not let a user sign up without a name' do
        params = {
          :name => "",
          :username => "iloveflynn",
          :email => "flynnryder@aol.com",
          :password => "perrito"
        }
        post '/signup', params
        expect(last_response.location).to include('/signup')
      end

      it 'does not let a logged in user view the signup page' do
        params = {
          :name => "Ryder",
          :username => "skittles123",
          :email => "skittles@aol.com",
          :password => "rainbows"
        }
        post '/signup', params
        get '/signup'
        expect(last_response.location).to include('/tweets')
      end
    end

    describe "login" do
    it 'loads the login page' do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it 'loads the wishes index after login' do
      user = User.create(:name => "Tanya Hoepelman", :username => "licrubi", :email => "tanyahoepelman@aol.com", :password => "mentes")
      params = {
        :username => "licrubi",
        :password => "mentes"
      }
      post '/login', params
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome,")
    end

    it 'does not let user view login page if already logged in' do
      user = User.create(:name => "Tanya Hoepelman", :username => "licrubi", :email => "tanyahoepelman@aol.com", :password => "mentes")

      params = {
        :username => "licrubi",
        :password => "mentes"
      }
      post '/login', params
      get '/login'
      expect(last_response.location).to include("/wishes")
    end
  end

  describe "logout" do
    it "lets a user logout if they are already logged in and redirects to the login page" do
      user = User.create(:name=> "Tanya Hoepelman", :username => "licrubi", :email => "tanyahoepelman@aol.com", :password => "mentes")

      params = {
        :username => "licrubi",
        :password => "mentes"
      }
      post '/login', params
      get '/logout'
      expect(last_response.location).to include("/login")
    end

    it 'redirects a user to the index page if the user tries to access /logout while not logged in' do
      get '/logout'
      expect(last_response.location).to include("/")

    end

    it 'redirects a user to the login route if a user tries to access /wishes route if user not logged in' do
      get '/wishes'
      expect(last_response.location).to include("/login")
      expect(last_response.status).to eq(302)
    end

    it 'loads /wishes if user is logged in' do
      user = User.create(:name=> "Tanya Hoepelman", :username => "licrubi", :email => "tanyahoepelman@aol.com", :password => "mentes")

      visit '/login'

      fill_in(:username, :with => "licrubi")
      fill_in(:password, :with => "mentes")
      click_button 'submit'
      expect(page.current_path).to eq('/wishes')
      expect(page.body).to include("Welcome")
    end
  end

  describe 'user show page' do
    it 'shows all a user wishes' do
      user = User.create(:name => "Scarlet Garcia",:username => "scarlette", :email => "scarletgarcia@aol.com", :password => "soti")
      wish1 = Wish.create(:name => "Blush", :description => "Magic Hour is a sheer peachy nude with micro glitter.!", :user_id => user.id, :url => "https://example.com")
      wish2 = Wish.create(:name => "SHISEIDO Concealer", :description => "COLOR: 303 - Medium Natural Finish", :user_id => user.id, :url => "https://example2.com")
      get "/users/#{user.slug}"

      expect(last_response.body).to include("Blush")
      expect(last_response.body).to include("SHISEIDO Concealer")

    end
  end





end
