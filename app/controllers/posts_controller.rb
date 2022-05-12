class PostsController < ApplicationController
  def index
    @posts = Post.all.order('created_at DESC')
    @post = Post.new
    @comment = Comment.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path
    else
      @posts = Post.all.order('created_at DESC')
      @comment = Comment.new

      render :index, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
