class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User', counter_cache: :incoming_friend_requests_count

  validates :requester_id, uniqueness: { scope: :requestee_id }

  # Callbacks to update conditional counter
  after_update :update_incoming_friend_requests_count
  after_destroy :update_incoming_friend_requests_count

  scope :accepted_friend_requests, -> (user) {
    where('requester_id = ? OR requestee_id = ? AND accepted = true',
          user.id, user.id)
  }

  private

  def update_incoming_friend_requests_count
    self.requestee.incoming_friend_requests_count = FriendRequest.count(conditions: ['accepted = false AND requestee_id = ?', self.requestee.id])
  end
end
