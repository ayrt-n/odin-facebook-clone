class PostsController < ApplicationController
  before_action :verify_post_author, only: %i[edit update destroy]
  before_action :create_new_comment, only: %i[index show create]

  def index
    @posts = Post.timeline_by_users(current_user.friends_ids + [current_user.id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('posts', @post) }
      else
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

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@post) }
      format.html { redirect_to posts_path, status: 303 }
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def verify_post_author
    @post = Post.find(params[:id])
    return if current_user == @post.user

    flash[:alert] = 'You do not have the correct permissions to do this'
    redirect_to posts_path
  end

  def create_new_comment
    @new_comment = Comment.new
  end
end
