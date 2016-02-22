class Helpers
  def self.current_user(session)
    User.find(session[:user_id])
  end

  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  def self.get_posts(page_num)
    total_posts = Post.all
    max_pages = (total_posts.count.to_f / page_num).ceil
    max_pages = 1 if max_pages == 0

    # Orders posts by id. Higher ids are the current entries
    select_posts = Post.all.order(id: :desc).limit(25 * page_num)
    @posts = select_posts.limit(select_posts.count%25)

    return @posts, max_pages
  end

  def self.get_subreddit_posts(subreddit_slug, page_num)
    subreddit = Subreddit.find_by_slug(subreddit_slug)
    subreddit_posts = Post.where(subreddit_id: subreddit.id)

    max_pages = (subreddit_posts.count.to_f / page_num).ceil
    max_pages = 1 if max_pages == 0

    # Orders posts by id. Higher ids are the current entries
    select_posts = subreddit_posts.order(id: :desc).limit(25 * page_num)
    @posts = select_posts.limit(select_posts.count%25)

    return @posts, max_pages
  end

end