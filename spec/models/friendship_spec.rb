require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before do
    @u1 = FactoryBot.create(:user)
    @u2 = FactoryBot.create(:user)
  end

  context '#create_recipricol_friendship' do
    it 'creates two Friendships from each user to the other when creating single Friendship' do
      @u1.friendships.create(user: @u1, friend: @u2)

      expect(@u1.friends).to include(@u2)
      expect(@u2.friends).to include(@u1)
    end
  end

  context '#destroy_recipricol_friendship' do
    it 'destorys Friendships on both users when destroying a single Friendship' do
      @u1.friendships.create(user: @u1, friend: @u2)
      @u1.friendships.destroy_all

      expect(@u1.friends).not_to include(@u2)
      expect(@u2.friends).not_to include(@u1)
    end
  end

  context '#destroy_friend_requests' do
    it 'destroys outstanding FriendRequests between users when Friendship is created' do
      @u1.outgoing_friend_requests.create(requestee: @u2)
      @u1.friendships.create(user: @u1, friend: @u2)

      @u1.reload

      expect(@u1.outgoing_friend_requests).to be_empty
      expect(@u2.incoming_friend_requests).to be_empty
    end
  end
end