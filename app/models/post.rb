class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  attribute :comments_counter, :integer, default: 0
  attribute :likes_counter, :integer, default: 0

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
