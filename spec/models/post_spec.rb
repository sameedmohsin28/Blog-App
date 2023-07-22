require 'rails_helper'

RSpec.describe Post, type: :model do
  before :all do
    @user = User.create(name: 'John', bio: 'Doctor', photo: 'No link', posts_counter: 2)
    @post = Post.create(author_id: @user, title: 'Spec Post', text: 'This is a testing post', comments_counter: 3, likes_counter: 4)
  end

  it 'title should be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'title should have maximum of 250 characters' do
    @post.title = 'a' * 260
    expect(@post).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to zero' do
    @post.comments_counter = -5
    expect(@post).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to zero' do
    @post.likes_counter = -5
    expect(@post).to_not be_valid
  end

  it 'shows a maximum of 3 comments upon calling the most_recent method' do
    expect(@post.most_recent.length).to be < 3
  end
end