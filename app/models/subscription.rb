class Subscription < ActiveRecord::Base

  belongs_to :user
  belongs_to :subreddit
  has_many :moderators, through: :subreddit

end