class PostsController < ApplicationController
  def index
    filters = params
    posts = Post.call_api(filters)
    render json: posts
  end

end
