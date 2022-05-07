class LikesController < ApplicationController
  def create
    like = Like.new(post_id: params[:post_id], user_id: current_user.id)
    like.save
  end

  def destroy
    like = Like.where("post_id = ? AND user_id = ?", params[:post_id], current_user.id)
    like.destroy_all
  end
end
