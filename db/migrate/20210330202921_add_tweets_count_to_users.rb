class AddTweetsCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :tweets_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE users
           SET tweets_count = (SELECT count(1)
                                  FROM tweets
                                  WHERE tweets.user_id = users.id)
    SQL
  end
end
