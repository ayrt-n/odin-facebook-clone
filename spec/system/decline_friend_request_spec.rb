require 'rails_helper'

RSpec.describe 'declining a friend request', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    FactoryBot.create(:friend_request, requester: @user2, requestee: @user1)

    login_as(@user1, :scope => :user)
  end

  scenario 'removes request from pending requests' do
    visit friend_requests_path
    expect(page).to have_content @user2.username # Pending request shows up under list of pending friends
    click_on 'Decline'
    expect(page).to have_content 'Friend request declined' # Flash message indicating declined
    expect(page).not_to have_content @user2.username # Pending request no longer visible
  end
end