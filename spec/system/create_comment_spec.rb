require 'rails_helper'

RSpec.describe 'Creating a comment', type: :system do
  before do
    user = FactoryBot.create(:user_with_post)
    login_as(user, :scope => :user)
  end

  scenario 'with valid inputs' do
    visit posts_path
    fill_in 'New comment', with: 'Test comment!'
    click_on 'Create Comment'
    visit posts_path
    expect(page).to have_content('Test comment!')
  end
end
