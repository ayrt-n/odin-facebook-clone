class PostsController < ApplicationController
  before_action :verify_post_author, only: [:edit, :update, :destroy]

  def index
    @friends = current_user.friends.ids.push(current_user.id)
    @posts = Post.posted_by(@friends).order('created_at DESC')
    @new_comment = Comment.new
  end

  def show
    @post = Post.find(params[:id])
    @new_comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @new_comment = Comment.new

    respond_to do |format|
      if @post.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('posts', @post) }
      else
        @posts = Post.all.order('created_at DESC')

        format.html { render :new, status: :unprocessable_entity }
      end
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

    redirect_to posts_path, status: 303
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def verify_post_author
    @post = Post.find(params[:id])

    unless current_user == @post.user
      flash[:alert] = "You do not have the correct permissions to do this"
      redirect_to posts_path
    end
  end
end
