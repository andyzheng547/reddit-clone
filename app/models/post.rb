class Post < ActiveRecord::Base

  validates_presence_of :title

  has_many :comments
  has_many :comment_replies, through: :comments

  belongs_to :user
  belongs_to :subreddit
  belongs_to :post_type

end