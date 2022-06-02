class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :body, presence: true

  scope :posted_by, -> (users) { where user: users }
  scope :timeline_by_users, -> (users) { includes({ comments: :user }, { likes: :user }, :user).posted_by(users).order('created_at DESC') }

  def liked?
    return false if self.likes_count.nil? || self.likes_count.zero?

    true
  end

  def liked_by?(user)
    liked_by = likes.collect(&:user_id)
    liked_by.include?(user.id)
  end
end
