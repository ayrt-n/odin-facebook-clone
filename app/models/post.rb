class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :body, presence: true

  scope :posted_by, -> (user_ids) { where user_id: user_ids }

  def liked?
    return false if self.likes_count.nil? || self.likes_count.zero?

    true
  end
end
