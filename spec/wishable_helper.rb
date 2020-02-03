module WishableHelper
  def create_user(name, email, password)
    User.create(:name => name, :email => email, :password => password)
  end

  def login_user(user)
    visit '/users/login'

    fill_in(:email, :with => user.email)
    fill_in(:password, :with => user.password)

    click_button 'submit'
  end

  def create_wish_list(name, user_id)
    WishList.create(:name => name, :user_id => user_id)
  end

  def create_wish(name, description, url, wish_list_id)
    Wish.create(:name => name, :description => description, :url => url, :wish_list_id => wish_list_id)
  end
end
