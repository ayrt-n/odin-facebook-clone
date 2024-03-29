class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :photo

  validates :body, presence: true, unless: :photo_attached?

  scope :posted_by, -> (users) { where user: users }
  scope :with_likes, -> { includes(:likes) }
  scope :with_comments, -> { includes({ comments: [{ user: [{ avatar_attachment: :blob }] }] }) }
  scope :with_user, -> { includes({ user: [{ avatar_attachment: :blob }] })}
  scope :timeline_by_users, -> (users) { includes({ photo_attachment: :blob }).with_comments.with_likes.with_user
                                                                              .posted_by(users).order('created_at DESC') }

  enum status: %i[unedited edited]

  before_update :set_edit_status if unedited

  def liked?
    return false if self.likes_count.nil? || self.likes_count.zero?

    true
  end

  def liked_by?(user)
    liked_by = likes.collect(&:user_id)
    liked_by.include?(user.id)
  end

  private

  def photo_attached?
    photo.attached?
  end

  def set_edit_status
    self.status = 'edited' if changed?
  end
end
