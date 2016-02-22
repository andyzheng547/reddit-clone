class CreateCommentReplies < ActiveRecord::Migration
  def change
    create_table :comment_replies do |t|
      t.text :content
      t.integer :upvotes, :default => 1
      t.integer :user_id
      t.integer :comment_id
    end
  end
end
