require 'redd'

class Post < ApplicationRecord

  def self.call_api
    session = Redd.it(
    user_agent: 'BetterReddit',
    client_id:  ENV["reddit_client_id"],
    secret:     ENV["reddit_secret"],
    username:   ENV["reddit_username"],
    password:   ENV["reddit_password"]
    )
    new_posts = session.subreddit('woahdude').new.to_ary

    post_objects = new_posts.map do |post|
      post_object = {
        id: post.id,
        url: post.url,
        title: post.title
      }
    end
  end

end
