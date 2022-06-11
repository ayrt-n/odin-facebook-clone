class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User', counter_cache: :incoming_friend_requests_count

  validates :requester_id, uniqueness: { scope: :requestee_id }
end
