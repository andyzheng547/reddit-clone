PostType.create(name: "Link")
PostType.create(name: "Text")

User.create(name: "andy", password: "password")
Subreddit.create(name: "New York City", description: "A place to discuss all things NYC.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 1)
Subscription.create(user_id: 1, subreddit_id: 1, access: true)

Subreddit.create(name: "Private", description: "Just private stuff.", is_private: true)
Moderator.create(user_id: 1, subreddit_id: 2)
Subscription.create(user_id: 1, subreddit_id: 2, access: true)

User.create(name: "david", password: "password")
