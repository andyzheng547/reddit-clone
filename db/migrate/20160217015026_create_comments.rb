class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :upvotes, :default => 1
      t.integer :user_id
      t.integer :post_id
      t.references :parent
    end
  end
end
