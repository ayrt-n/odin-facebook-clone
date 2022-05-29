class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[github]

  validates :username, presence: true

  # Friendship-system associations
  has_many :outgoing_friend_requests, class_name: 'FriendRequest', foreign_key: :requester_id
  has_many :incoming_friend_requests, class_name: 'FriendRequest', foreign_key: :requestee_id
  has_many :pending_friends, through: :outgoing_friend_requests, source: :requestee
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # Post-system associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Avatar associations
  has_one_attached :avatar

  after_commit :add_default_avatar, on: [:create, :update]

  scope :not_friends_with, -> (user) { where.not(id: user.friends.ids.push(user.id)) }

  def self.from_omniauth(auth)
    puts 'auth is:'
    puts auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  private

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
end
