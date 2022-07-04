require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:user3) { FactoryBot.create(:user) }
  let(:user4) { FactoryBot.create(:user) }

  context '#add_default_avatar' do
    it 'adds default avatar after create' do
      user1
      expect(user1.avatar.attached?).to eql(true)
    end
  end

  context '#pending_friend_request?' do
    it 'returns true if user has an incoming FriendRequest from specified user' do
      user2.outgoing_friend_requests.create(requestee: user1)

      expect(user1.pending_friend_request?(user2)).to eql(true)
    end

    it 'returns true if user has an outgoing FriendRequest to specified user' do
      user1.outgoing_friend_requests.create(requestee: user2)

      expect(user1.pending_friend_request?(user2)).to eql(true)
    end

    it 'returns false if user does not have an incoming FriendRequest from specified user' do
      expect(user1.pending_friend_request?(user2)).to eql(false)
    end
  end

  context '#pending_friends_ids' do
    it 'returns array of the ids of users with pending friend requests' do
      user2.outgoing_friend_requests.create(requestee: user1)
      user1.outgoing_friend_requests.create(requestee: user3)

      user_ids = [user2.id, user3.id]
      expect(user1.pending_friends_ids).to eql(user_ids)
    end
  end

  context '#friends_ids' do
    it 'returns array of friends user ids' do
      user2.outgoing_friend_requests.create(requestee: user1, accepted: true) # Friend
      user3.outgoing_friend_requests.create(requestee: user1, accepted: true) # Friend
      user4.outgoing_friend_requests.create(requestee: user1) # Pending

      friend_ids = [user2.id, user3.id]
      expect(user1.friends_ids).to eql(friend_ids)
    end
  end

  context '#friends_with?' do
    it 'returns true if the user is friends with the specified user' do
      user2.outgoing_friend_requests.create(requestee: user1, accepted: true)
      expect(user1).to be_friends_with(user2)
    end

    it 'returns false if the user is not friends with the specified user' do
      user2.outgoing_friend_requests.create(requestee: user1)
      expect(user1).not_to be_friends_with(user2)
    end
  end
end