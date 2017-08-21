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

    session.subreddit('all').comment_stream do |comment|
      print "do something"
    end
  end

end
