class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :link
      t.text :content

      t.integer :post_type_id
      t.integer :user_id
      t.integer :subreddit_id
    end
  end
end
