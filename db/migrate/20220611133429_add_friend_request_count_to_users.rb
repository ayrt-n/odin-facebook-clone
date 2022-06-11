class AddFriendRequestCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :incoming_friend_requests_count, :integer
  end
end
