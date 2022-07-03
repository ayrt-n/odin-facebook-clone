class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'

  validates :requester_id, uniqueness: { scope: :requestee_id, message: 'friend request already exists' }
  validate :check_self_friend_request

  # Callbacks to update conditional counter
  after_save :update_incoming_friend_requests_count
  after_destroy :update_incoming_friend_requests_count

  # Scope to query all accepted friend requests for a certain user (i.e., their friends)
  scope :accepted_friend_requests, ->(user) {
    where('accepted = true AND (requester_id = ? OR requestee_id = ?)',
          user.id, user.id)
  }

  # Scope to query all pending friend requests for a certain user
  scope :pending_friend_requests, ->(user) {
    where('accepted = false AND (requester_id = ? OR requestee_id = ?)',
          user.id, user.id)
  }

  def self.friends?(user1, user2)
    users = [user1, user2]
    where(accepted: true).where(requester_id: users).where(requestee_id: users).present?
  end

  private

  def update_incoming_friend_requests_count
    requestee.update_attribute(:incoming_friend_requests_count,
                               FriendRequest.where(accepted: false)
                               .where(requestee: requestee).count)
  end

  def check_self_friend_request
    errors.add(:requester_id, "can't be friend with self") if requester == requestee
  end
end
