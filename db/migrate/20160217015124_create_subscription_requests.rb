class CreateSubscriptionRequests < ActiveRecord::Migration
  def change
    create_table :subscription_requests do |t|
      t.integer :user_id
      t.integer :subscription_id
    end
  end
end
