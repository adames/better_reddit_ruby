class PostsController < ApplicationController
  def index
    sub_reddit = params[:sub_reddit]
    posts = Post.call_api(sub_reddit)
    render json: posts
  end

end
