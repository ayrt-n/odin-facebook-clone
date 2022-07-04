require 'rails_helper'

RSpec.describe User, type: :system do
  before do
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
  end

  context 'valid inputs' do
    it 'updates username' do
      visit edit_user_path(@user)
      fill_in 'Username', with: 'Testy_McGee'
      fill_in 'Bio', with: 'I am a robot who loves to test and ensure the integrity of web applications!'
      click_on 'Update User'

      expect(page).to have_content('Testy_McGee')
      expect(page).to have_content('I am a robot who loves to test and ensure the integrity of web applications!')
    end
  end

  context 'invalid inputs' do
    it 'does not update user if username blank' do
      visit edit_user_path(@user)
      fill_in 'Username', with: ''
      click_on 'Update User'

      expect(page).to have_content("Username can't be blank")
    end
  end
end