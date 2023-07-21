class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_likes_counter_for_post
    post.update(likes_counter: post.likes.count)
  end
end
