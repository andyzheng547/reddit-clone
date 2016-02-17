class CreateSubreddits < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|
      t.string :name
      t.text :description
      t.boolean :public
    end
  end
end
