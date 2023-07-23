require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Validating Like Model' do
    before(:each) do
      @user = User.create(name: 'John', bio: 'Doctor', photo: 'No link', posts_counter: 2)
      @post = Post.create(author_id: @user.id, title: 'Title', text: 'First post', likes_counter: 0,
                          comments_counter: 0)
      @like = Like.new(user_id: @user.id, post_id: @post.id)
    end

    it 'post_id must not be blank' do
      @like.post_id = nil
      expect(@like).to_not be_valid
    end
  end
end
