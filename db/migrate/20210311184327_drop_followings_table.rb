class DropFollowingsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :followings
  end
  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
