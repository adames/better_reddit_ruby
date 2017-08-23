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

  def create
    post = params[:post]
    saved_object = Post.find_or_create_by(post)
    render json: saved_object
  end

end
