class AddIndexToFollowing < ActiveRecord::Migration[6.1]
  def change
  end
  add_index :followings, :follower_id
  add_index :followings, :followed_id
  add_index :followings, [:follower_id, :followed_id], unique: true
end
