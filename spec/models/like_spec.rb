require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Model Validatons' do
    before(:each) do
      @user = User.create(name: 'John', bio: 'Doctor', photo: 'No link', posts_counter: 2)
      @post = Post.create(author_id: @user.id, title: 'Title', text: 'First post', likes_counter: 0,
                          comments_counter: 0)
      @like = Like.new(user_id: @user.id, post_id: @post.id)
    end

    it 'Should update likes counter' do
      @like.save
      @post.reload
      expect(@post.likes_counter).to eq(1)
    end
  end
end
