class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id }

  after_create :create_recipricol_friendship

  private

  def create_recipricol_friendship
    return if Friendship.where(user_id: friend_id, friend_id: user_id).exists?

    Friendship.create(user_id: friend_id, friend_id: user_id)
  end
end
