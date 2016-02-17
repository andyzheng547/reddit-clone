class Subreddit < ActiveRecord::Base

  has_many :posts
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :comments, through: :posts
  has_many :comment_replies, through: :comments

  # Moderators means moderator status
  has_many :moderators

end