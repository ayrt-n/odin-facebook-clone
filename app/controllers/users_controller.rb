class UsersController < ApplicationController
  def index
    @users = User.not_friends_with(current_user).includes(:incoming_friend_requests, :outgoing_friend_requests)
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.timeline_by_users(@user)
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
