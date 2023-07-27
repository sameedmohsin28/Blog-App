ActiveRecord::Schema[7.0].define(version: 20_230_721_211_746) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'comments', force: :cascade do |t|
    t.string 'text'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'post_id', null: false
    t.index ['post_id'], name: 'index_comments_on_post_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.bigint 'post_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_likes_on_post_id'
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.integer 'author_id'
    t.string 'title'
    t.text 'text'
    t.integer 'comments_counter'
    t.integer 'likes_counter'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['author_id'], name: 'index_posts_on_author_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'bio'
    t.string 'photo'
    t.integer 'posts_counter'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'comments', 'posts'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'likes', 'posts'
  add_foreign_key 'likes', 'users'
  add_foreign_key 'posts', 'users', column: 'author_id', name: 'fk_posts_author_id'
end

class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def most_recent
    posts.order(created_at: :desc).limit(3)
  end
end

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { in: 1..250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  after_create :update_posts_counter_for_user
  after_destroy :update_posts_counter_for_user

  def most_recent
    comments.order(created_at: :desc).limit(5)
  end

  def update_posts_counter_for_user
    author.update(posts_counter: author.posts.count)
  end
end

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_comments_counter_for_post
  after_destroy :update_comments_counter_for_post

  def update_comments_counter_for_post
    post.update(comments_counter: post.comments.count)
  end
end

Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/show'
  get 'users/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:index]
  resources :users, only: [:show] do
    resources :posts, only: [:index]
  end
  resources :posts, only: [:show]

  root 'users#index'
end

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_likes_counter_for_post
  after_destroy :update_likes_counter_for_post

  def update_likes_counter_for_post
    post.update(likes_counter: post.likes.count)
  end
end

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end
end

class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:author_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find_by(id: params[:id])
  end
end
