class Moderator < ActiveRecord::Base

  belongs_to :user
  belongs_to :subreddit
  has_many :subscriptions, through: :subreddit

end