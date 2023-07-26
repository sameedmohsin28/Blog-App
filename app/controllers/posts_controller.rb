class PostsController < ApplicationController
  def index
    @user = User.find_by_id(params[:author_id])
    Post.where(author_id: params[:user_id])
  end

  def show
    @post = Post.find_by(id: params[:id])
  end
end

# rails generate controller PostsController index show
