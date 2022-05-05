class PostsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.new
    @comment = Comment.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
