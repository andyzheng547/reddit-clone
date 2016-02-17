class CreatePostType < ActiveRecord::Migration
  def change
    create_table :post_types do |t|
      t.string :name
    end
  end
end
