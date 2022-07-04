require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @fr = FactoryBot.create(:friend_request, requester: @user1, requestee: @user2)
  end

  context '::friends?' do
    it 'returns false if users are not friends' do
      is_friends = FriendRequest.friends?(@user1, @user2)
      expect(is_friends).to eql(false)
    end

    it 'returns true if users are friends' do
      @fr.update_attribute(:accepted, true)
      is_friends = FriendRequest.friends?(@user1, @user2)
      expect(is_friends).to eql(true)
    end
  end

  context '#update_incoming_friend_requests_count' do
    before do
      @user3 = FactoryBot.create(:user)
    end

    it 'increases the requestees count by one after receiving new friend request' do
      expect { FactoryBot.create(:friend_request, requester: @user3, requestee: @user1) }.to change { @user1.incoming_friend_requests_count }.by(1)
    end

    it 'does not increase the requesters count by one after sending a new friend request' do
      expect { FactoryBot.create(:friend_request, requester: @user2, requestee: @user3) }.to change { @user2.incoming_friend_requests_count }.by(0)
    end

    it 'decreases the requestees count by one after accepting the friend request' do
      friend_request = @user2.incoming_friend_requests.first
      count = @user2.incoming_friend_requests_count

      friend_request.update(accepted: true)
      @user2.reload

      expect(@user2.incoming_friend_requests_count).to eql(count - 1)
    end

    it 'decreases the requestees count by one after declining the friend request' do
      friend_request = @user2.incoming_friend_requests.first
      count = @user2.incoming_friend_requests_count

      friend_request.destroy
      @user2.reload

      expect(@user2.incoming_friend_requests_count).to eql(count - 1)
    end
  end
end