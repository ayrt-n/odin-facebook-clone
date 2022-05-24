require 'rails_helper'

RSpec.describe 'Deleting a post', type: :system do
  scenario 'valid user' do
    user = create(:user_with_post)
    post_content = user.posts.first.body
    login_as(user, :scope => :user)

    visit posts_path
    expect(page).to have_content(post_content)
    print page.html

    find(:css, 'i.far.fa-trash-alt').click
    accept_alert

    expect(page).not_to have_content(post_content)
  end
end