class PostsController < ApplicationController
  def index
    filters = params
    posts = Post.call_api(filters)
    render json: posts
  end

  def next_page
    filters = params
    next_page = Post.more_posts(filters)

    byebug
    render json: next_page
  end

end
