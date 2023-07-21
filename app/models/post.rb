class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :likes
  has_many :comments

  def most_recent
    comments.order(created_at: :desc).limit(5)
  end

  def update_posts_counter_for_user
    author.update(posts_counter: author.posts.count)
  end
end
