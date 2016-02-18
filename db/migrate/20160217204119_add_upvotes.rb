class AddUpvotes < ActiveRecord::Migration
  def change
    add_column :posts, :upvotes, :integer, :default => 1
    add_column :comments, :upvotes, :integer, :default => 1
    add_column :comment_replies, :upvotes, :integer, :default => 1
  end
end
