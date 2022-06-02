class UsersController < ApplicationController
  def index
    # Load all users not currently friends with the current user
    @users = User.not_friends_with(current_user)

    # Load pending friend requests to determine available action in view
    @current_user_pending_friend_ids = current_user.pending_friend_ids
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:comments, :likes).order("created_at DESC")
    @current_user_likes = @user.posts.includes(:likes).where(likes: { user_id: current_user })
    @new_comment = Comment.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :bio, :avatar)
  end
end
