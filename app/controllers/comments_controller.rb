class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @comments }
      format.json { render json: @comments }
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to user_post_path(current_user, @post.id)
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    return unless @comment.destroy

    redirect_to user_post_path(current_user, post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
