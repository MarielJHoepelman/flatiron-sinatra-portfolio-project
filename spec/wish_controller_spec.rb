require 'spec_helper'

describe WishController do
  describe 'wish new page' do
    it 'creates a new wish' do
      user = create_user("Scarlet Garcia", "scarletgarcia@aol.com", "soti")
      wish_list = create_wish_list("Sephora", user.id)
      login_user(user)

      visit "/wishes/#{wish_list.id}/new"

      fill_in(:name, :with => "Blush")
      fill_in(:description, :with => "Pink")
      fill_in(:url, :with => "www.example.com")

      click_button 'submit'

      expect(page.body).to include("Blush")
      expect(page.body).to include("Pink")
      expect(page).to have_link("Click here to see item in website.")
    end
  end

  describe 'wish edit page' do
    it 'allows user to edit a wish' do
      user = create_user("Scarlet Garcia", "scarletgarcia@aol.com", "soti")
      wish_list = create_wish_list("Sephora", user.id)
      wish = create_wish("Lipgloss", "Fenty clear gloss", "www.sephora.com", wish_list.id)

      login_user(user)

      visit "/wishes/#{wish.id}/edit"

      fill_in(:name, :with => "Fenty lipgloss")
      fill_in(:description, :with => "Diamond milk")
      fill_in(:url, :with => "www.example.com")

      click_button 'submit'

      expect(page.body).to include("Fenty lipgloss")
      expect(page.body).to include("Diamond milk")
      expect(page.body).to include("www.example.com")
    end
  end


  describe 'wish delete action' do
    it 'allows user to delete a wish' do
      user = create_user("Scarlet Garcia", "scarletgarcia@aol.com", "soti")
      wish_list = create_wish_list("Sephora", user.id)
      wish = create_wish("Lipgloss", "Fenty clear gloss", "www.sephora.com", wish_list.id)

      expect(Wish.where("id = #{wish.id}").length).to eq(1)

      login_user(user)

      visit "/wish_lists/show/#{wish_list.id}"

      click_button 'Delete Wish'

      expect(page.body).to_not include("#{wish.name}")

      expect(Wish.where("id = #{wish.id}").length).to eq(0)
    end
  end
end
