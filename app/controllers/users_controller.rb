class UsersController < ApplicationController
  def index
    @users = User.not_friends_with(current_user)
                 .with_attached_avatar
    @users = @users.filter_by_name(params[:q]) if params[:q].present?

    @pending_friends_ids = current_user.pending_friends_ids
  end

  def show
    @user = User.find(params[:id])
    @friendship_status = FriendRequest.where(requester_id: [current_user, @user])
                                      .where(requestee_id: [current_user, @user])
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
