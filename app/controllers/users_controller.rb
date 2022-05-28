class UsersController < ApplicationController
  def index
    @users = User.not_friends_with(current_user)
  end

  def show
    @user = User.find(params[:id])
    @new_comment = Comment.new
  end

end
