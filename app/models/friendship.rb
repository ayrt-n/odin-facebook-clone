class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id, message: "friendship already exists" }
  validate :check_self_friendship

  after_create :create_recipricol_friendship
  after_destroy :destroy_recipricol_friendship

  private

  def check_self_friendship
    errors.add(:user_id, "can't be friend with self") if user == friend
  end

  def create_recipricol_friendship
    return if Friendship.where(user_id: friend_id, friend_id: user_id).exists?

    Friendship.create(user_id: friend_id, friend_id: user_id)
  end

  def destroy_recipricol_friendship
    return unless Friendship.where(user_id: friend_id, friend_id: user_id).exists?

    Friendship.where(user_id: friend_id, friend_id: user_id).destroy_all
  end
end
