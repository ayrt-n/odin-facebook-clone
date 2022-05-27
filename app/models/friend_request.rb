class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'

  validates :requester_id, uniqueness: { scope: :requestee_id }

  # If there is already a pending request to become friends, just create new friendship
  after_create :create_new_friendship, if: :pending_request?

  private

  def pending_request?
    inverse_request = FriendRequest.where(requester_id: requestee_id, requestee_id: requester_id)
    inverse_request.exists?
  end

  def create_new_friendship
    Friendship.create(user_id: requester_id, friend_id: requestee_id)
    FriendRequest.where(requester_id: requester_id, requestee_id: requestee_id).destroy_all
    FriendRequest.where(requester_id: requestee_id, requestee_id: requester_id).destroy_all
  end
end
