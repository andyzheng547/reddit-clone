class Comment < ActiveRecord::Base

  has_many :comment_replies

  belongs_to :user
  belongs_to :post

end