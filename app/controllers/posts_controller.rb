class PostsController < ApplicationController
  def index
    @user = User.find(params[:author_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
  end
end

# rails generate controller PostsController index show
