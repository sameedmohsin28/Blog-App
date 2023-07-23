class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_comments_counter_for_post
  after_destroy :update_comments_counter_for_post

  def update_comments_counter_for_post
    post.update(comments_counter: post.comments.count)
  end
end
