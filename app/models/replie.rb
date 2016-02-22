class Replie < ActiveRecord::Base

  validates_presence_of :content

  belongs_to :comment
  belongs_to :user

end