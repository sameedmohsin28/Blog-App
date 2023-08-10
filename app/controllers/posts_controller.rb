class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments, :likes)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
      format.json { render :json => @posts }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @author = @post.author
    return unless @post.destroy!

    redirect_to user_posts_path(@author, @post), notice: 'Post was deleted successfully'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

# rails generate controller PostsController index show
