class Post < ActiveRecord::Base

  has_many :comments
  has_many :comment_replies, through: :comments

  belongs_to :user
  belongs_to :subreddit
  belongs_to :post_type

end