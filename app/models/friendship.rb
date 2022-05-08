class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id }

  after_create :create_recipricol_friendship
  after_destroy :destroy_recipricol_friendship

  private

  def create_recipricol_friendship
    return if Friendship.where(user_id: friend_id, friend_id: user_id).exists?

    Friendship.create(user_id: friend_id, friend_id: user_id)
  end

  def destroy_recipricol_friendship
    return unless Friendship.where(user_id: friend_id, friend_id: user_id).exists?

    Friendship.where(user_id: friend_id, friend_id: user_id).destroy_all
  end
end
