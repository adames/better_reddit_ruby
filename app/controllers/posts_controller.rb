class PostsController < ApplicationController
  def index
    @posts = Post.call_api
  end

end
