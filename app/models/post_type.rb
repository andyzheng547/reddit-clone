class PostType < ActiveRecord::Base
  # Only exists to categorize Posts
  # Cannot add any other type of post types
  # Only 2 exist: 
    # 1 - Link post
    # 2 - Text post
end