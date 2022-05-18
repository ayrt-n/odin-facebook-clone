class CommentsController < ApplicationController
  before_action :verify_comment_author, only: [:destroy]

  def create
    comment = current_user.comments.build(comment_params)
    comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end

  def verify_comment_author
    @comment = Comment.find(params[:id])

    unless current_user == @comment.user
      flash[:error] = "You do not have the correct permssions to do this"
      redirect_to posts_path
    end
  end
end
