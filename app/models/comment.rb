class Comment < ActiveRecord::Base

  validates_presence_of :content

  has_many :replies

  belongs_to :user
  belongs_to :post

end