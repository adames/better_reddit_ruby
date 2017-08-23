require 'httparty'
class RedditAdapter
  attr_accessor :first_page, :second_page, :new_posts

  @@after = ""

  def call_api(filters)
    sub_reddit = filters[:sub_reddit]
    sort_by = filters[:sort_by]

    session = Redd.it(
    user_agent: 'BetterReddit',
    client_id:  ENV["reddit_client_id"],
    secret:     ENV["reddit_secret"],
    username:   ENV["reddit_username"],
    password:   ENV["reddit_password"]
    )

    url = "https://api.reddit.com/r/#{sub_reddit}/?sort=#{sort_by}"
    response = HTTParty.get(url)
    json_response = response.parsed_response
    after = json_response["data"]["after"]
    @@after = after
    posts = json_response["data"]["children"] #25 posts

    post_objects = posts.map do |post|
      {
        post_id: post["data"]["id"],
        url: post["data"]["url"],
        title: post["data"]["title"],
        thumbnail: post["data"]["thumbnail"],
        post_hint: post["data"]["post_hint"],
        ups: post["data"]["ups"],
        permalink: post["data"]["permalink"],
      }
    end

    return post_objects


  end

    def more_posts(filters)
      sub_reddit = filters[:sub_reddit]
      sort_by = filters[:sort_by]

      session = Redd.it(
      user_agent: 'BetterReddit',
      client_id:  ENV["reddit_client_id"],
      secret:     ENV["reddit_secret"],
      username:   ENV["reddit_username"],
      password:   ENV["reddit_password"]
      )

      url = "https://api.reddit.com/r/#{sub_reddit}/?sort=#{sort_by}&after=#{@@after}"
      response = HTTParty.get(url)
      json_response = response.parsed_response
      after = json_response["data"]["after"]
      @@after = ""
      @@after = after
      posts = json_response["data"]["children"] #25 posts

      post_objects = posts.map do |post|
        {
          post_id: post["data"]["id"],
          url: post["data"]["url"],
          title: post["data"]["title"],
          thumbnail: post["data"]["thumbnail"],
          post_hint: post["data"]["post_hint"],
          ups: post["data"]["ups"],
          permalink: post["data"]["permalink"],
        }
      end
      return post_objects

    end

end
