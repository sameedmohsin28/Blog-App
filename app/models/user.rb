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
