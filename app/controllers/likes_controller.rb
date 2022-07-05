class LikesController < ApplicationController
  def create
    @like = Like.new(post_id: params[:post_id], user_id: current_user.id)
    @post = Post.find(params[:post_id])

    respond_to do |format|
      if @like.save
        @post.reload

        format.turbo_stream {
          render turbo_stream: turbo_stream.update("post_#{params[:post_id]}_likes",
                                                    partial: 'posts/post_likes',
                                                    locals: { post: @post })
        }
        format.html { redirect_to @post }
      else
        redirect_to @post
      end
    end
  end

  def destroy
    @like = Like.where('post_id = ? AND user_id = ?', params[:post_id], current_user.id)
    @post = Post.find(params[:post_id])

    respond_to do |format|
      if @like.destroy_all
        @post.reload

        format.turbo_stream {
          render turbo_stream: turbo_stream.update("post_#{params[:post_id]}_likes",
                                                    partial: 'posts/post_likes',
                                                    locals: { post: @post })
        }
        format.html { redirect_to @post, status: 303 }
      else
        redirect_to @post, status: 303
      end
    end
  end
end
