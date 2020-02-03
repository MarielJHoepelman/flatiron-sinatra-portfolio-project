require 'spec_helper'

describe WishListController do

  describe 'wish lists index page' do
    it 'shows all a wish lists' do
      user1 = create_user("Scarlet Garcia", "scarletgarcia@aol.com", "soti")
      user2 = create_user("Rubi Jaquez", "licrubi@aol.com", "ruby")


      wish_list1 = create_wish_list("Ulta", user1.id)
      wish_list2 = create_wish_list("Sephora", user2.id)

      login_user(user1)

      expect(page.body).to include("Ulta")
      expect(page.body).to include("Sephora")
    end

    it 'shows only the user wish lists' do
      user1 = create_user("Scarlet Garcia", "scarletgarcia@aol.com", "soti")
      user2 = create_user("Rubi Jaquez", "licrubi@aol.com", "ruby")


      wish_list1 = create_wish_list("Ulta", user1.id)
      wish_list2 = create_wish_list("Sephora", user2.id)

      login_user(user1)

      visit '/wish_lists/user_lists'

      expect(page.body).to include("Ulta")
      expect(page.body).to_not include("Sephora")

    end
  end

  describe 'wish lists new page' do
    it 'creates a new wish list' do
      user = create_user("Scarlet Garcia", "scarletgarcia@aol.com", "soti")
      login_user(user)

      visit '/wish_lists/new'

      fill_in(:name, :with => "Sephora")

      click_button 'submit'

      expect(page.body).to include("Sephora")
      expect(page.body).to include(user.name)
    end
  end

  describe 'wish list show page' do
    it 'shows wish list for owner list' do
      user = create_user("Scarlet Garcia", "scarletgarcia@aol.com", "soti")
      wish_list = create_wish_list("Sephora", user.id)

      login_user(user)

      visit "/wish_lists/show/#{wish_list.id}"

      expect(page.body).to include("Sephora")
      expect(page.body).to include(user.name)
      expect(page.body).to include("You don't have any wishes in this list.")
      expect(page.body).to include("Add wishes to this wish list below!")

      expect(page).to have_link("Back")
      expect(page).to have_link("Add Wish")
      expect(page).to have_link("Edit List")
      expect(page).to have_button("Delete List")
    end

    it 'shows wish list to any user but not add/edit/delete buttons' do
      user1 = create_user("Scarlet Garcia", "scarletgarcia@aol.com", "soti")
      user2 = create_user("Mariangel Fermin", "mariangel@aol.com", "mari")
      wish_list = create_wish_list("Sephora", user1.id)

      login_user(user2)

      visit "/wish_lists/show/#{wish_list.id}"

      expect(page.body).to include("Sephora")
      expect(page.body).to include(user1.name)
      expect(page.body).to_not include("You don't have any wishes in this list.")
      expect(page.body).to_not include("Add wishes to this wish list below!")

      expect(page).to have_link("Back")
      expect(page).to_not have_link("Add Wish")
      expect(page).to_not have_link("Edit List")
      expect(page).to_not have_button("Delete List")
    end
  end


  describe 'wish lists edit page' do
    it 'allows user to edit a wish list' do
      user = create_user("Scarlet Garcia", "scarletgarcia@aol.com", "soti")
      wish_list = create_wish_list("Sephora", user.id)

      login_user(user)

      visit "/wish_lists/#{wish_list.id}/edit"

      fill_in(:name, :with => "Ulta")

      click_button 'submit'

      expect(page.body).to include("Ulta")
    end
  end


  describe 'wish lists delete action' do
    it 'allows user to delete a wish list' do
      user = create_user("Scarlet Garcia", "scarletgarcia@aol.com", "soti")
      wish_list = create_wish_list("Sephora", user.id)

      expect(WishList.where("id = #{wish_list.id}").length).to eq(1)

      login_user(user)

      visit "/wish_lists/show/#{wish_list.id}"

      click_button 'Delete'

      expect(page.body).to_not include("#{wish_list.name}")

      expect(WishList.where("id = #{wish_list.id}").length).to eq(0)
    end
  end

  private

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
end
