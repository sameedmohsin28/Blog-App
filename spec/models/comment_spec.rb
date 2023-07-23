require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Model Validatons' do
    before(:each) do
      @user = User.create(name: 'John', bio: 'Doctor', photo: 'No link', posts_counter: 2)
      @post = Post.create(author_id: @user.id, title: 'Title', text: 'First post', likes_counter: 0,
                          comments_counter: 0)
      @comment = Comment.new(text: 'comment1', user_id: @user.id, post_id: @post.id)
    end

    it 'Should update comments counter' do
      @comment.save
      @post.reload
      expect(@post.comments_counter).to eq(1)
    end
  end
end
