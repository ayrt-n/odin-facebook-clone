require 'rails_helper'

RSpec.describe 'Deleting a comment', type: :system do
  before do
    user_with_post = FactoryBot.create(:user_with_post)
    user_comment = FactoryBot.create(:user)
    user_no_post.friends << user_with_post

    login_as(user_no_post, :scope => :user)
  end

  scenario 'successfully deletes comment' do
    visit posts_path
    fill_in 'New comment', with: 'Test comment!'
    click_on 'Create Comment'
    expect(page).to have_content('Test comment!')

    find(:css, 'i.far.fa-trash-alt').click
    accept_alert

    expect(page).not_to have_content('Test comment!')
  end
end
