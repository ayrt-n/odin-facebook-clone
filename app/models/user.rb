class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Friendship-system associations
  has_many :outgoing_friend_requests, class_name: 'FriendRequest', foreign_key: :requester_id
  has_many :incoming_friend_requests, class_name: 'FriendRequest', foreign_key: :requestee_id
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # Post-system associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
