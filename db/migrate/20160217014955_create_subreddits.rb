class CreateSubreddits < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|
      t.string :name
      t.text :description
      t.boolean :is_private, :default => false
    end
  end
end
