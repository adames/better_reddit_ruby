class PostsController < ApplicationController
  def index
    posts = Post.call_api
    render json: posts
  end

end
