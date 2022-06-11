require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  context '#add_default_avatar' do
    it 'adds default avatar after create' do
      expect(@user.avatar.attached?).to eql(true)
    end
  end

  context '#pending_friend_request?' do
    before do
      @second_user = FactoryBot.create(:user)
    end

    it 'returns true if user has an incoming FriendRequest from specified user' do
      @second_user.outgoing_friend_requests.create(requestee: @user)

      expect(@user.pending_friend_request?(@second_user)).to eql(true)
    end

    it 'returns true if user has an outgoing FriendRequest to specified user' do
      @user.outgoing_friend_requests.create(requestee: @second_user)

      expect(@user.pending_friend_request?(@second_user)).to eql(true)
    end

    it 'returns false if user does not have an incoming FriendRequest from specified user' do
      expect(@user.pending_friend_request?(@second_user)).to eql(false)
    end
  end
end