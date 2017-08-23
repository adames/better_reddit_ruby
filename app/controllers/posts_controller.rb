class PostsController < ApplicationController
  def index
    filters = params
    posts = Post.call_api(filters)
    render json: posts
  end

  def next_page
    filters = params
    next_page = Post.more_posts(filters)

    render json: next_page
  end

  def create
    post = params[:post]
    saved_object = Post.find_or_create_by(post)
    render json: saved_object
  end

end
