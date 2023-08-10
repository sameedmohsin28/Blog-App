require 'rails_helper'

RSpec.feature 'Post show page', type: :feature do
  before do
    @user1 = User.create(name: 'Sameed', bio: 'He is from Pakistan', photo: 'https://placekitten.com/200/200',
                         posts_counter: 0)
    @user2 = User.create(name: 'Cisco', bio: 'He is from Nigeria', photo: 'https://placekitten.com/200/200',
                         posts_counter: 0)
    @user3 = User.create(name: 'Reviewer', bio: 'They are from Microverse', photo: 'https://placekitten.com/200/200',
                         posts_counter: 0)
    @post1 = Post.create(author_id: @user1.id, title: 'Post 1', text: 'Text for post 1', comments_counter: 0,
                         likes_counter: 0)

    @comment1 = Comment.create(user_id: @user1.id, post_id: @post1.id, text: 'This is the first comment for post 1')
    @comment1 = Comment.create(user_id: @user2.id, post_id: @post1.id, text: 'This is the second comment for post 1')
    @comment1 = Comment.create(user_id: @user3.id, post_id: @post1.id, text: 'This is the third comment for post 1')
    @comment1 = Comment.create(user_id: @user1.id, post_id: @post1.id, text: 'This is the fourth comment for post 1')
    @comment1 = Comment.create(user_id: @user2.id, post_id: @post1.id, text: 'This is the fifth comment for post 1')
    @comment1 = Comment.create(user_id: @user3.id, post_id: @post1.id, text: 'This is the sixth comment for post 1')

    Like.create(post_id: @post1.id, user_id: @user1.id)
    Like.create(post_id: @post1.id, user_id: @user2.id)
    Like.create(post_id: @post1.id, user_id: @user3.id)

    visit user_posts_path(@user1, @post1)
  end

  scenario 'displays posts title' do
    expect(page).to have_content('Post 1')
  end

  scenario 'displays post author name' do
    expect(page).to have_content('Sameed')
  end

  scenario 'displays number of comments for the post' do
    expect(page).to have_content('Comments: 6')
  end

  scenario 'displays number of likes for the post' do
    expect(page).to have_content('Likes: 3')
  end

  scenario 'displays post body' do
    expect(page).to have_content('Text for post 1')
  end

  scenario 'displays username of each commentor' do
    within('.comments-container') do
      expect(page).to have_content('Sameed')
      expect(page).to have_content('Cisco')
      expect(page).to have_content('Reviewer')
      expect(page).to have_content('Sameed')
      expect(page).to have_content('Cisco')
      expect(page).to have_content('Reviewer')
    end
  end

  scenario 'displays comment of each commentor' do
    within('.comments-container') do
      expect(page).to have_content(@comment1.text)
    end
  end
end
