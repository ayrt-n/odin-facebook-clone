class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.where(user: current_user)
  end
end
