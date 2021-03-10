class CreateFollowings < ActiveRecord::Migration[6.1]
  def change
    create_table :followings do |t|
      t.integer :followed_id
      t.integer :follower_id

      t.timestamps
    end
  end
end
