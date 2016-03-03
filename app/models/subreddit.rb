require_relative 'concerns/slugifiable'

class Subreddit < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :posts
  has_many :subscriptions
  has_many :users, through: :subscriptions

  # Moderators means moderator status
  has_many :moderators

  # Change slug to account for spaces and punctuation in subreddit name
  def slug
    name.downcase.gsub(/[\'\"]/, "").gsub(/[\W]/, "-")
  end

end