class PostsController < ApplicationController
  def index
    @something = Post.call_api
  end

end
