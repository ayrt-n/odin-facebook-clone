class CommentsController < ApplicationController
  before_action :verify_comment_author, only: [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:post_id])

    respond_to do |format|
      if @comment.save
        format.turbo_stream { 
            render turbo_stream: turbo_stream.append("post_#{params[:post_id]}_comments",
                                                     partial: 'comment',
                                                     locals: { comment: @comment, post: @post })
          }
        format.html { redirect_to @post }
      else
        format.html{ render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
      format.html { redirect_to posts_path, status: 303 }
    end
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
