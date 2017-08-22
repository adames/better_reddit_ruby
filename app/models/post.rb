require 'redd'

class Post < ApplicationRecord

  def self.call_api(filters)
    sub_reddit = filters[:sub_reddit]
    sort_by = filters[:sort_by]
    session = Redd.it(
    user_agent: 'BetterReddit',
    client_id:  ENV["reddit_client_id"],
    secret:     ENV["reddit_secret"],
    username:   ENV["reddit_username"],
    password:   ENV["reddit_password"]
    )
    @new_posts = session.subreddit(sub_reddit)
    @first_page = @new_posts.send(sort_by, limit:15)
    byebug
    post_objects = @first_page.map do |post|
      post_object = {
        id: post.id,
        url: post.url,
        title: post.title
      }
    end
  end

  def self.more_posts(filters)
    sub_reddit = filters[:sub_reddit]
    sort_by = filters[:sort_by]

    session = Redd.it(
    user_agent: 'BetterReddit',
    client_id:  ENV["reddit_client_id"],
    secret:     ENV["reddit_secret"],
    username:   ENV["reddit_username"],
    password:   ENV["reddit_password"]
    )
    @new_posts = session.subreddit(sub_reddit)
    



    @second_page = @new_posts.send(sort_by, limit: 2, after: @first_page)
    byebug
    @first_page = @new_posts.send(sort_by, limit: 2, before: @second_page)
    byebug
#
#
#     first_page = spiders.top(time: :all)
# second_page = spiders.top(time: :all, after: first_page.after)

  end

end
