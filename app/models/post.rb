require 'redd'

class Post < ApplicationRecord

  def self.call_api
    session = Redd.it(
    user_agent: 'BetterReddit',
    client_id:  'tSojb2-za9wAgw',
    secret:     'R41xQZ37zTJXYfNQdHQhD8FMBSo',
    username:   'Better_Reddit_API',
    password:   'orange10'
    )

    session.subreddit('woahdude').new do |post|
      p post
      # post_array << {
      #   id: post.id,
      #   title: post.title,
      #   url: post.url
      # }
    end

  end

end
