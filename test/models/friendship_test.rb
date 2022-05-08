require "test_helper"

class FriendshipTest < ActiveSupport::TestCase
  # Tests for Friendship validations
  test 'valid friendship' do
    friendship = Friendship.new(user: users(:one), friend: users(:two))
    assert friendship.valid?
  end

  test 'invalid friendship with non-existent user' do
    friendship = Friendship.new(user: users(:one), friend_id: 999_999_999)
    assert_not friendship.valid?, 'Friendship is valid with non-existent friend_id'
  end

  test 'invalid friendship without friend' do
    friendship = Friendship.new(user: users(:one))
    assert_not friendship.valid?, 'Friendship is valid without friend'
  end

  test 'invalid friendship without user' do
    friendship = Friendship.new(friend: users(:one))
    assert_not friendship.valid?, 'Friendship is valid without user'
  end

  test 'invalid friendship when already exists' do
    Friendship.create(user: users(:one), friend: users(:two))
    friendship_duplicate = Friendship.new(user: users(:one), friend: users(:two))
    assert_not friendship_duplicate.valid?, 'Duplicate friendship is valid'
  end
end
