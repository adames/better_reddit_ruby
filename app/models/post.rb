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
    @first_page = @new_posts.send(sort_by, limit:30)
    post_objects = @first_page.map do |post|
      post_object = {
        post_id: post.id,
        url: post.url,
        title: post.title,
        thumbnail: post.thumbnail,
        # top_comment: post.comments[0] ? post.comments.max{ |c| c.score}.body : nil
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




    @second_page = @new_posts.send(sort_by, limit: 15, after: @first_page)
    @first_page = @new_posts.send(sort_by, limit: 15, before: @second_page)

    post_objects = @second_page.map do |post|
      post_object = {
        id: post.id,
        url: post.url,
        title: post.title
      }
    end
#
#
#     first_page = spiders.top(time: :all)
# second_page = spiders.top(time: :all, after: first_page.after)

  end

end
