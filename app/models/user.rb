class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[github]

  validates :username, presence: true, uniqueness: true

  # Friendship-system associations
  has_many :outgoing_friend_requests, -> { where accepted: false }, class_name: 'FriendRequest',
                                                                    foreign_key: :requester_id,
                                                                    dependent: :destroy
  has_many :incoming_friend_requests, -> { where accepted: false }, class_name: 'FriendRequest',
                                                                    foreign_key: :requestee_id,
                                                                    dependent: :destroy

  # Post-system associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Avatar associations
  has_one_attached :avatar, dependent: :destroy
  after_commit :add_default_avatar, on: %i[create update]

  # Callback for sending welcome email
  after_create :send_welcome_email

  # Scope to query for users which are not friends of a given user
  scope :not_friends_with, -> (user) { where.not(id: user.friends_ids + [user.id]) }

  # Find or create new user using Omniauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # Return array of user friends ids
  def friends_ids
    accepted_frs = FriendRequest.accepted_friend_requests(self)
    accepted_frs.map { |fr| fr.requester_id == id ? fr.requestee_id : fr.requester_id }
  end

  # Return array of user friends (users)
  def friends
    User.where(id: friends_ids)
  end

  # Check if user has a pending friend request with another user, returns true or false
  def pending_friend_request?(user)
    friend_requests = FriendRequest.pending_friend_requests(self)
    friend_requests = friend_requests.map { |fr| fr.requester_id == id ? fr.requestee_id : fr.requester_id }
    friend_requests.include?(user.id)
  end

  # Check if user has any incoming friend requests, returns true or false
  def incoming_friend_requests?
    return false if incoming_friend_requests_count.nil? || incoming_friend_requests_count.zero?

    true
  end

  private

  # Add default avatar to user if no avatar attached
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_avatar.png'
          )
        ), filename: 'default_avatar.png',
        content_type: 'image/png'
      )
    end
  end

  # Send out welcome email to user using UserMailer
  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_now
  end
end
