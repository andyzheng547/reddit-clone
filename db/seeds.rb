PostType.create(name: "Link")
PostType.create(name: "Text")

# User 1
User.create(name: "andy", password: "password")

# Subreddit 1
Subreddit.create(name: "New York City", description: "A place to discuss all things NYC.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 1)
Subscription.create(user_id: 1, subreddit_id: 1, access: true)
Post.create(post_type_id: 1, title: "New York, New York by Frank Sinatra", link: "https://www.youtube.com/watch?v=EUrUfJW1JGk", user_id: 1, subreddit_id: 1)

# Subreddit 2
Subreddit.create(name: "Private", description: "Just private stuff.", is_private: true)
Moderator.create(user_id: 1, subreddit_id: 2)
Subscription.create(user_id: 1, subreddit_id: 2, access: true)
Post.create(post_type_id: 2, title: "Private post in a private place", content: "No one will see this.", user_id: 1, subreddit_id: 2)

# Subreddit 3
Subreddit.create(name: "AskReddit", description: "/r/AskReddit is the place to ask and answer thought-provoking questions.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 3)
Subscription.create(user_id: 1, subreddit_id: 3, access: true)
Post.create(post_type_id: 2, title: "Would you rather fight a horse sized duck or a duck sized horse?", content: "", user_id: 1, subreddit_id: 3)

# Subreddit 4
Subreddit.create(name: "movies", description: "News & Discussion about Major Motion Pictures", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 4)
Subscription.create(user_id: 1, subreddit_id: 4, access: true)
Post.create(post_type_id: 1, title: "Leonardo DiCaprio Wins Best Actor in a Drama at the 2016 Golden Globes", link: "https://www.youtube.com/watch?v=ncgFQAISaGo", user_id: 1, subreddit_id: 4)

# Subreddit 5
Subreddit.create(name: "news", description: "Real new articles. Get up to date on the ongoings of the world.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 5)
Subscription.create(user_id: 1, subreddit_id: 5, access: true)
Post.create(post_type_id: 1, title: "LinkedIn’s CEO Is Giving His Entire $14 Million Bonus to His Employees", link: "http://time.com/money/4246847/linkedin-ceo-bonus-giveaway/?xid=yahoo_monpartner?xid=yahoo_money", user_id: 1, subreddit_id: 5)

# Subreddit 6
Subreddit.create(name: "nba", description: "All things NBA basketball.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 6)
Subscription.create(user_id: 1, subreddit_id: 6, access: true)

Post.create(post_type_id: 1, title: "Steph Curry's Game Winner Heard Around the World", link: "https://www.youtube.com/watch?v=bhtpppMxfQs", user_id: 1, subreddit_id: 6)
Post.create(post_type_id: 1, title: "San Antonio Spurs Tribute - The Beautiful Game", link: "https://www.youtube.com/watch?v=T3y7cWmoBCI", user_id: 1, subreddit_id: 6)

# User 2
User.create(name: "stephen_hawking", password: "password")

# Subreddit 7
Subreddit.create(name: "IAmA", description: "I Am A, where the mundane becomes fancinating and the outrageous suddenly seems normal.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 7)
Subscription.create(user_id: 1, subreddit_id: 7, access: true)
Post.create(post_type_id: 2, title: "I am Stephen Hawking. Ask me anything.", content: "I know everything about all things.", user_id: 2, subreddit_id: 7)

# Subreddit 8
Subreddit.create(name: "gaming", description: "A subreddit for (almost) anything related to games - video games, board games, card games, etc. (but not sports).", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 8)
Subscription.create(user_id: 1, subreddit_id: 8, access: true)
Post.create(post_type_id: 2, title: "Map Attack - An urban geofencing game", content: "This seems like an <a href='http://mapattack.org/'>interesting idea.</a>", user_id: 1, subreddit_id: 8)

# Subreddit 9
Subreddit.create(name: "ShowerThoughts", description: "A subreddit to share anything that goes on in your head whilst in the shower.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 9)
Subscription.create(user_id: 1, subreddit_id: 9, access: true)
Post.create(post_type_id: 2, title: "A cat is just a tiny tiger that lives in your house.", content: "Dogs are better.", user_id: 1, subreddit_id: 9)

# User 3
User.create(name: "conspiracy_nut", password: "password")

# Subreddit 10
Subreddit.create(name: "conspiracy", description: "They are watching us.", is_private: true)
Moderator.create(user_id: 3, subreddit_id: 10)
Subscription.create(user_id: 3, subreddit_id: 10, access: true)
Post.create(post_type_id: 2, title: "Just saw an FBI surverllance van occurence near me.", content: "They just popped up when I was looking for wifi. Why would they do that?", user_id: 3, subreddit_id: 10)

# Subreddit 11
Subreddit.create(name: "technology", description: "For all things futuristic and shiny.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 11)
Subscription.create(user_id: 1, subreddit_id: 11, access: true)
Post.create(post_type_id: 1, title: "Scientists Have Created Batteries Using Carbon Dioxide From The Atmosphere Which Could Replace Phone And Electric Car Batteries", link: "http://www.thelatestnews.com/scientists-have-created-batteries-using-carbon-dioxide-from-the-atmosphere/", user_id: 1, subreddit_id: 11)
Post.create(post_type_id: 1, title: "Quantum Computers Explained – Limits of Human Technology", link: "https://www.youtube.com/watch?v=JhHMJCUmq28", user_id: 1, subreddit_id: 11)

# Subreddit 12
Subreddit.create(name: "politics", description: "/r/Politics is for news and discussion politics.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 12)
Subscription.create(user_id: 1, subreddit_id: 12, access: true)
Post.create(post_type_id: 1, title: "Last Week Tonight with John Oliver: Donald Trump (HBO)", link: "https://www.youtube.com/watch?v=DnpO_RTSNmQ", user_id: 1, subreddit_id: 12)

# Subreddit 13
Subreddit.create(name: "television", description: "A community to for your favorite tv serieses.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 13)
Subscription.create(user_id: 1, subreddit_id: 13, access: true)
Post.create(post_type_id: 1, title: "Last Week Tonight with John Oliver: Donald Trump (HBO)", link: "https://www.youtube.com/watch?v=DnpO_RTSNmQ", user_id: 1, subreddit_id: 13)

# User 4
User.create(name: "five", password: "password")

# Subreddit 14
Subreddit.create(name: "eli5", description: "Explain like I'm five.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 14)
Subscription.create(user_id: 1, subreddit_id: 14, access: true)
Post.create(post_type_id: 2, title: "How are babbies made?", content: "A five year needs to know.", user_id: 4, subreddit_id: 14)

# Subreddit 15
Subreddit.create(name: "interestingasfuck", description: "Really cool stuff", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 15)
Subscription.create(user_id: 1, subreddit_id: 15, access: true)

Post.create(post_type_id: 1, title: "Walking under a sheet of ice.", link: "https://media.giphy.com/media/26FPHxvWv0SV9Fsg8/giphy.gif", user_id: 1, subreddit_id: 15)
Post.create(post_type_id: 1, title: "Dyslexia Simulator - An approximation of how a severely dyslexic person sees text", link: "https://geon.github.io/programming/2016/03/03/dsxyliea", user_id: 1, subreddit_id: 15)

# Subreddit 16
Subreddit.create(name: "photoshopbattles", description: "Photoshop contests on reddit. A place to battle using image manipulation software, play photoshop tennis, create new images from old photos, or even win reddit gold.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 16)
Subscription.create(user_id: 1, subreddit_id: 16, access: true)

Post.create(post_type_id: 1, title: "PsBattle: Female rugby player taking a stiff-arm to the face", link: "http://sp.imgci.com/PICTURES/CMS/35300/35361.jpg", user_id: 1, subreddit_id: 16)
Post.create(post_type_id: 1, title: "PsBattle: Donald Trump", link: "http://i.imgur.com/U0YpKFe.jpg", user_id: 1, subreddit_id: 16)
Post.create(post_type_id: 1, title: "PsBattle: Kim Jong-Un squatting", link: "http://i.imgur.com/nDZh89q.jpg", user_id: 1, subreddit_id: 16)
Post.create(post_type_id: 1, title: "PsBattle: Donald Trump eyes closed", link: "http://i.imgur.com/tDfBaLu.jpg", user_id: 1, subreddit_id: 16)
Post.create(post_type_id: 1, title: "PsBattle: Hilary high five", link: "https://i.imgur.com/RyuOK7d.png", user_id: 1, subreddit_id: 16)

# Subreddit 17
Subreddit.create(name: "GetMotivated", description: "Welcome to /r/GetMotivated! We’re glad you made it. This is the subreddit that will help you finally get up and do what you know you need to do. It’s the subreddit to give and receive motivation through pictures, videos, text, music, AMA’s, personal stories, and anything and everything that you find particularly motivating and/or inspiring.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 17)
Subscription.create(user_id: 1, subreddit_id: 17, access: true)
Post.create(post_type_id: 1, title: "How to Find Fulfilling Work, by The School of Life", link: "https://www.youtube.com/watch?v=veriqDHLXsw", user_id: 1, subreddit_id: 17)

# Subreddit 18
Subreddit.create(name: "videos", description: "A great place for video content of all kinds.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 18)
Subscription.create(user_id: 1, subreddit_id: 18, access: true)
Post.create(post_type_id: 1, title: "Cannonball Ice Dude - jumps into frozen pool", link: "https://www.youtube.com/watch?v=VBXKoZQwvDE", user_id: 1, subreddit_id: 18)
Post.create(post_type_id: 1, title: "Adam Savage – Mythbusters Finale AMA", link: "https://www.youtube.com/watch?v=BSOGV1GYdw4", user_id: 1, subreddit_id: 18)
Post.create(post_type_id: 1, title: "Quantum Computers Explained – Limits of Human Technology", link: "https://www.youtube.com/watch?v=JhHMJCUmq28", user_id: 1, subreddit_id: 18)

# Subreddit 19
Subreddit.create(name: "science", description: "The Science subreddit is a place to share new findings. Read about the latest advances in astronomy, biology, medicine, physics and the social sciences. Find and submit the best writeup on the web about a discovery, and make sure it cites its sources.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 19)
Subscription.create(user_id: 1, subreddit_id: 19, access: true)
Post.create(post_type_id: 1, title: "Monkeys Drive Wheelchairs Using Only Their Thoughts", link: "https://medschool.duke.edu/about-us/news-and-communications/med-school-blog/monkeys-drive-wheelchairs-using-only-their-thoughts", user_id: 1, subreddit_id: 19)

# Subreddit 20
Subreddit.create(name: "EarthPorn", description: "Natural Landscapes, Mother Nature in all of her succulent beauty.", is_private: false)
Moderator.create(user_id: 1, subreddit_id: 20)
Subscription.create(user_id: 1, subreddit_id: 20, access: true)
Post.create(post_type_id: 1, title: "Bay of Fires, Tasmania, Australia", link: "http://imgur.com/GDA6RTj", user_id: 1, subreddit_id: 20)









