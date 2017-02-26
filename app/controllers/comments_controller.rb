class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:body))

    redirect_to post_path(@post), notice: "Ha realizado el comentario con éxito"
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post), notice: "Ha eliminado el comentario con éxito"
  end
end
