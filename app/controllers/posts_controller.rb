class PostsController < ApplicationController
  before_action :verify_post_author, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC')
    @post = Post.new
    @comment = Comment.new
  end

  def show
    @post = Post.find(params[:id])
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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def verify_post_author
    @post = Post.find(params[:id])

    unless current_user == @post.user
      flash[:error] = "You do not have the correct permissions to do this"
      redirect_to posts_path
    end
  end
end
