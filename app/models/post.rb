class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  after_create :update_posts_counter_for_user
  after_destroy :update_posts_counter_for_user

  def most_recent
    comments.order(created_at: :desc).limit(5)
  end

  def update_posts_counter_for_user
    author.update(posts_counter: author.posts.count)
  end
end
