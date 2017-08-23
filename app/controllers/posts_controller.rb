class PostsController < ApplicationController
  def index
    filters = params
    api = RedditAdapter.new
    posts = api.call_api(filters)
    render json: posts
  end

  def next_page
    filters = params
    api = RedditAdapter.new
    next_page = api.more_posts(filters)
    render json: next_page
  end

  def get_comment
    link = params[:link]
    api = RedditAdapter.new
    new_comment = api.get_comment(link)
    render json: {string:new_comment}
  end


  def create
    post = params[:post]
    saved_object = Post.find_or_create_by(post)
    render json: saved_object
  end

end
