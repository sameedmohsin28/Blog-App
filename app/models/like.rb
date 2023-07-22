class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  after_create :update_likes_counter_for_post
  after_destroy :update_likes_counter_for_post

  def update_likes_counter_for_post
    post.update(likes_counter: post.likes.count)
  end
end
