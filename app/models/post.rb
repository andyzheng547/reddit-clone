require_relative 'concerns/slugifiable'

class Post < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  validates_presence_of :title

  has_many :comments
  has_many :replies, through: :comments

  belongs_to :user
  belongs_to :subreddit
  belongs_to :post_type

  # Overwrite the slug method from the slugifiable module
  # Post uses title instead of name
  def slug
    title.downcase.gsub(/[\'\"]/, "").gsub(/[\W]/, "-")
  end

  def link_host
    link.scan(/[^\/]+[\.]{1}[\w]+/)[0].gsub("www.", "")
  end

end