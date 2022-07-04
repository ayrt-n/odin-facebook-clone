require 'rails_helper'

RSpec.describe 'Accept a friend request', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user_with_post)
    @fr = FactoryBot.create(:friend_request, requester: @user2, requestee: @user1)

    login_as(@user1, :scope => :user)
  end

  scenario 'can see user posts after accepting friend request' do
    visit friend_requests_path
    click_on 'Accept'
    visit root_path

    # After accepting request, can see posts from user
    expect(page).to have_content(@user2.username)
  end
end