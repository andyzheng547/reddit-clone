require_relative 'concerns/slugifiable'

class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_secure_password
  
  has_many :posts
  has_many :subscriptions
  has_many :subreddits, through: :subscriptions
  has_many :comments
  has_many :comment_replies

  # Moderators means moderator status
  has_many :moderators
  has_many :subscription_requests, through: :moderators

end