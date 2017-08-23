require 'redd'

class RedditAdapter
  attr_accessor :first_page, :second_page, :new_posts


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
    @new_posts = session.subreddit(sub_reddit)
    @first_page = new_posts.send(sort_by, limit:2, sort_order: "top")
    post_objects = @first_page.map do |post|
      post_object = {
        post_id: post.id,
        url: post.url,
        title: post.title,
        thumbnail: post.thumbnail,
        # top_comment: post.comments[0] ? post.comments[0].body : nil
      }
    end
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
      @new_posts = session.subreddit(sub_reddit)

      @first_page = new_posts.send(sort_by, limit:3, sort_order: "top")


      @next_page = new_posts.send(sort_by, limit: 3, after: @first_page.after)
      @third_page = new_posts.send(sort_by, limit: 3, after: @next_page.after)
      @next_page = new_posts.send(sort_by, limit: 3, after: @third_page.after)


      post_objects = @next_page.map do |post|
        post_object = {
          id: post.id,
          url: post.url,
          title: post.title,
          thumbnail: post.thumbnail,
          # top_comment: post.comments[0] ? post.comments[0].body : nil
        }
      end
    end
end
