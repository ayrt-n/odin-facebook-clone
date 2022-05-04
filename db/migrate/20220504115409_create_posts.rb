class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.references :user
      t.integer :likes_count

      t.timestamps
    end
  end
end
