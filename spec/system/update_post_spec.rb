require 'rails_helper'

RSpec.describe 'Updating a post', type: :system do
  scenario 'valid inputs' do
    user = FactoryBot.create(:user_with_post)
    login_as(user, :scope => :user)
    visit post_path(user.posts.first)

    find(:css, 'i.far.fa-edit').click
    fill_in 'post_body', with: 'THIS IS A TEST'
    click_on 'Update Post'

    expect(page).to have_content('THIS IS A TEST')
  end

  scenario 'invalid inputs' do
    user = FactoryBot.create(:user_with_post)
    login_as(user, :scope => :user)
    visit post_path(user.posts.first)

    find(:css, 'i.far.fa-edit').click
    fill_in 'post_body', with: ''
    click_on 'Update Post'

    expect(page).to have_content("New post can't be blank")
  end
end