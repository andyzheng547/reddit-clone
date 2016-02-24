require_relative 'concerns/slugifiable'

class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_secure_password
  validates_presence_of :name, :password_digest
  validates_uniqueness_of :name
  
  has_many :posts
  has_many :subscriptions
  has_many :subreddits, through: :subscriptions
  has_many :comments

  # Moderators means moderator status
  has_many :moderators
  has_many :subscription_requests, through: :moderators

  # Compares username with stripped version of the username
  # Valid usernames have only letters, numbers, dashes and underscores
  # Example: valid-user_name123 is valid
  def self.valid_username?(username)
    username == username.gsub(/[^\w-]/, "")
  end

end