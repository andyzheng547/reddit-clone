class Comment < ActiveRecord::Base

  validates_presence_of :content

  has_many :comment_replies

  belongs_to :user
  belongs_to :post

end