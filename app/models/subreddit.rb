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

  # Current moderator unsubscribed or deleted account
  # Subreddit reassigns their mod status to next subscriber with access 
  # or deletes self and associated subscriptions 
  def reassign_mod_or_delete_subreddit(mod_subscription)
    subs_with_access = subscriptions.where(access: true)

    # Other mods, only delete current mods subscription
    if moderators.count > 1 
      mod_subscription.delete

    # Only 1 mod. Find new mod or delete all associations with subreddit
    else
      if subs_with_access.count > 1
        moderators.first.update(user_id: subs_with_access.second.user_id)
        mod_subscription.delete
      else
        # Use destroy when you want to delete the associated entry and not just the association
        # Using delete on an association will only turn that associated entry's foreign key to nil, does not delete entry
        subscriptions.destroy_all
        moderators.destroy_all
        self.delete
      end
    end
  end # end of method

end