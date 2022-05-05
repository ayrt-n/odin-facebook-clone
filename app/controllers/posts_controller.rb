class PostsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    @post.save
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
