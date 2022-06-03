class LikesController < ApplicationController
  def create
    @like = Like.new(post_id: params[:post_id], user_id: current_user.id)
    @post = Post.find(params[:post_id])
    @like.save

    redirect_to post_path(@post)
  end

  def destroy
    @like = Like.where("post_id = ? AND user_id = ?", params[:post_id], current_user.id)
    @post = Post.find(params[:post_id])
    @like.destroy_all

    redirect_to post_path(@post), status: 303
  end
end
