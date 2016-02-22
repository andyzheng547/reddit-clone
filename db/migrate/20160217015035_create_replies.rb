class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content
      t.integer :upvotes, :default => 1
      t.integer :user_id
      t.integer :comment_id
    end
  end
end
