require 'rails_helper'

RSpec.describe 'Creating a comment', type: :system do
  before do
    user = FactoryBot.create(:user_with_post)
    login_as(user, :scope => :user)
  end

  scenario 'valid inputs' do
    visit posts_path
    fill_in 'New comment', with: 'Test comment!'
    click_on 'Create Comment'

    expect(page).to have_content('Test comment!')
  end

  scenario 'invalid inputs' do
    visit posts_path
    fill_in 'New comment', with: ''
    click_on 'Create Comment'

    expect(page).to have_content("New comment can't be blank")
  end
end
