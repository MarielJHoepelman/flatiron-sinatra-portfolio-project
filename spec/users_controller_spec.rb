require 'spec_helper'

describe UsersController do

  describe "Signup Page" do
    it 'loads the signup page' do
      get '/users/signup'
      expect(last_response.status).to eq(200)
    end

    it 'signup directs user to wishable index' do
      params = {
        :name => "Flynn Ryder",
        :email => "flynnryder@aol.com",
        :password => "perrito"
      }
      post '/users/signup', params
      expect(last_response.location).to include("/wish_lists")
    end

    it 'does not let a user sign up without a email' do
      params = {
        :name => "Flynn Ryder",
        :email => "",
        :password => "perrito"
      }
      post '/users/signup', params
      expect(last_response.location).to include('/users/signup')
    end

    it 'does not let a user sign up without a password' do
      params = {
        :name => "Flynn Ryder",
        :email => "flynnryder@aol.com",
        :password => ""
      }
      post '/users/signup', params
      expect(last_response.location).to include('/users/signup')
    end

    it 'does not let a user sign up without a name' do
      params = {
        :name => "",
        :email => "flynnryder@aol.com",
        :password => "perrito"
      }
      post '/users/signup', params
      expect(last_response.location).to include('/users/signup')
    end

    it 'does not let a logged in user view the signup page' do
      params = {
        :name => "Ryder",
        :email => "skittles@aol.com",
        :password => "rainbows"
      }
      post '/users/signup', params
      get '/users/signup'

      expect(last_response.location).to include('/wish_lists')
    end
  end

  describe "login" do
  it 'loads the login page' do
    get '/users/login'
    expect(last_response.status).to eq(200)
  end

  it 'loads the wishes index after login' do
    user = User.create(:name => "Tanya Hoepelman", :email => "tanyahoepelman@aol.com", :password => "mentes")
    params = {
      :email => "tanyahoepelman@aol.com",
      :password => "mentes"
    }
    post '/users/login', params
    expect(last_response.status).to eq(302)
    follow_redirect!
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Welcome,")
  end

  it 'does not let user view login page if already logged in' do
    user = User.create(:name => "Tanya Hoepelman", :email => "tanyahoepelman@aol.com", :password => "mentes")

    params = {
      :email => "tanyahoepelman@aol.com",
      :password => "mentes"
    }
    post '/users/login', params
    get '/users/login'
    expect(last_response.location).to include("/wish_lists")
  end
end

describe "logout" do
  it "lets a user logout if they are already logged in and redirects to the homepage" do
    user = User.create(:name=> "Tanya Hoepelman", :email => "tanyahoepelman@aol.com", :password => "mentes")

    params = {
      :email => "tanyahoepelman@aol.com",
      :password => "mentes"
    }
    post '/users/login', params
    get 'users/logout'
    expect(last_response.location).to include("/")
  end

  it 'redirects a user to the index page if the user tries to access /users/logout while not logged in' do
    get '/users/logout'
    expect(last_response.location).to include("/")

  end

  it 'redirects a user to the login route if a user tries to access /wish_lists route if user not logged in' do
    get '/wish_lists'
    expect(last_response.location).to include("/users/login")
    expect(last_response.status).to eq(302)
  end

  it 'loads /wish_lists if user is logged in' do
    user = User.create(:name=> "Tanya Hoepelman", :email => "tanyahoepelman@aol.com", :password => "mentes")

    visit '/users/login'

    fill_in(:email, :with => "tanyahoepelman@aol.com")
    fill_in(:password, :with => "mentes")
    click_button 'submit'
    expect(page.current_path).to eq('/wish_lists')
    expect(page.body).to include("Welcome")
  end
end

describe 'wish lists index page' do
  it 'shows all a wish lists' do
    user1 = User.create(:name => "Scarlet Garcia", :email => "scarletgarcia@aol.com", :password => "soti")
    user2 = User.create(:name => "Rubi Jaquez", :email => "licrubi@aol.com", :password => "ruby")

    wish1 = WishList.create(:name => "Blush", :user_id => user1.id)
    wish2 = WishList.create(:name => "SHISEIDO Concealer", :user_id => user2.id)

    visit '/users/login'

    fill_in(:email, :with => user1.email)
    fill_in(:password, :with => user1.password)

    click_button 'submit'

    expect(page.body).to include("Blush")
    expect(page.body).to include("SHISEIDO Concealer")
  end

    it 'shows only the user wish lists' do
      user1 = User.create(:name => "Scarlet Garcia", :email => "scarletgarcia@aol.com", :password => "soti")
      user2 = User.create(:name => "Rubi Jaquez", :email => "licrubi@aol.com", :password => "ruby")

      wish1 = WishList.create(:name => "Blush", :user_id => user1.id)
      wish2 = WishList.create(:name => "SHISEIDO Concealer", :user_id => user2.id)

      visit '/users/login'

      fill_in(:email, :with => user1.email)
      fill_in(:password, :with => user1.password)

      click_button 'submit'

      visit '/wish_lists/user_lists'
      expect(page.body).to include("Blush")
      expect(page.body).to_not include("SHISEIDO Concealer")

    end
  end
end
