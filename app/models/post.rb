class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :photo

  validates :body, presence: true, unless: :photo_attached?

  scope :posted_by, -> (users) { where user: users }
  scope :timeline_by_users, -> (users) { includes({ comments: [{ user: [{ avatar_attachment: :blob }] }] }, :likes, { photo_attachment: :blob },
                                         { user: [{ avatar_attachment: :blob }] }).posted_by(users).order('created_at DESC') }

  def liked?
    return false if self.likes_count.nil? || self.likes_count.zero?

    true
  end

  def liked_by?(user)
    liked_by = likes.collect(&:user_id)
    liked_by.include?(user.id)
  end

  def edited?
    created_at != updated_at
  end

  private

  def photo_attached?
    photo.attached?
  end
end
