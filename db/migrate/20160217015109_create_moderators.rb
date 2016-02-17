class CreateModerators < ActiveRecord::Migration
  def change
    create_table :moderators do |t|
      t.integer :user_id
      t.integer :subreddit_id
    end
  end
end
