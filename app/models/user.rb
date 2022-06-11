class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[github]

  validates :username, presence: true, uniqueness: true

  # Friendship-system associations
  has_many :outgoing_friend_requests, class_name: 'FriendRequest', foreign_key: :requester_id, dependent: :destroy
  has_many :incoming_friend_requests, class_name: 'FriendRequest', foreign_key: :requestee_id, dependent: :destroy
  has_many :pending_friends, through: :outgoing_friend_requests, source: :requestee
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # Post-system associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Avatar associations
  has_one_attached :avatar, dependent: :destroy

  after_commit :add_default_avatar, on: [:create, :update]
  after_create :send_welcome_email

  scope :not_friends_with, -> (user) { where.not(id: user.friends.ids.push(user.id)) }

  # Find or create new user using Omniauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # Return list of friends ids and current user id as array
  def friends_list
    self.friend_ids << self.id
  end

  # Check if user has a pending friend request with another user, returns true or false
  def pending_friend_request?(user)
    friend_requests = self.incoming_friend_requests.collect(&:requester_id)
    friend_requests = friend_requests.concat(self.outgoing_friend_requests.collect(&:requestee_id))
    friend_requests.include?(user.id)
  end

  # Check if user has any incoming friend requests, returns true or false
  def incoming_friend_requests?
    return false if self.incoming_friend_requests_count.nil? || self.incoming_friend_requests_count.zero?

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
