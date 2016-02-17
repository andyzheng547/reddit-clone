class SubscriptionRequest < ActiveRecord::Base

  belongs_to :user
  belongs_to :subscription
  has_many :moderators, through: :subscription

end