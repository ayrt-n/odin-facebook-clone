require 'rails_helper'

RSpec.describe 'Liking and unliking a post', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user_with_post)
    FactoryBot.create(:friend_request, requester: @user2, requestee: @user1, accepted: true)

    login_as(@user1, :scope => :user)
  end

  scenario 'increases/decreases like counter after liking/unliking a post' do
    visit root_path
    find(:css, 'i.far.fa-thumbs-up').click # Like
    expect(page).to have_content('1 person likes this')

    find(:css, 'i.fas.fa-thumbs-up').click # Unlike
    expect(page).not_to have_content('1 person likes this')
  end
end