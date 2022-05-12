require 'rails_helper'

RSpec.describe 'Creating a post', type: :system do
  before do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end

  scenario 'with valid inputs' do
    visit posts_path
    fill_in 'New post', with: 'Test post!'
    click_on 'Create Post'
    expect(page).to have_content('Test post!')
  end
end
