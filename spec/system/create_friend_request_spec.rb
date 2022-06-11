require 'rails_helper'

RSpec.describe 'Creating a friend request', type: :system do
  before do
    @user_1 = FactoryBot.create(:user)
    @user_2 = FactoryBot.create(:user)

    login_as(@user_1, :scope => :user)
  end

  scenario 'requestee becomes pending friend' do
    visit users_path
    click_on 'Send Friend Request'
    expect(page).to have_content('Pending Friend Request') # Updates friend request to pending

    visit friend_requests_path
    expect(page).to have_content @user_2.username # Pending request shows up under list of pending friends
  end

  scenario 'friend request appears as notification' do
    @user_2.outgoing_friend_requests.create(requestee: @user_1) # Make a new friend request
    visit posts_path

    expect(page).to have_content("Friend Requests\n1") # Notification for one friend request

    user_3 = FactoryBot.create(:user)
    user_3.outgoing_friend_requests.create(requestee: @user_1) # Make an additional friend request

    visit posts_path
    expect(page).to have_content("Friend Requests\n2") # Notification for two friend requests
  end
end