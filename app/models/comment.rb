class Comment < ActiveRecord::Base

  validates_presence_of :content

  # Self joining comments
  has_many :replies, class_name: "Comment", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Comment"

  belongs_to :user
  belongs_to :post

end