class FriendsController < ApplicationController
  def index
    @users = current_user.friends.with_attached_avatar
    @users = @users.filter_by_name(params[:q]) if params[:q].present?
  end
end
