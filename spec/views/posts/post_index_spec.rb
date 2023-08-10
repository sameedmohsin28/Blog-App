require 'rails_helper'

RSpec.feature 'Post index page', type: :feature do
  before do
    @user1 = User.create(name: 'Sameed', bio: 'He is from Pakistan', photo: 'https://placekitten.com/200/200',
                         posts_counter: 0)

    @post1 = Post.create(author_id: @user1.id, title: 'Post 1', text: 'Text for post 1', comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(author_id: @user1.id, title: 'Post 2', text: 'Text for post 2', comments_counter: 0,
                         likes_counter: 4)
    @post3 = Post.create(author_id: @user1.id, title: 'Post 3', text: 'Text for post 3', comments_counter: 0,
                         likes_counter: 0)
    @post4 = Post.create(author_id: @user1.id, title: 'Post 4', text: 'Text for post 4', comments_counter: 0,
                         likes_counter: 0)

    @comment1 = Comment.create(user_id: @user1.id, post_id: @post1.id, text: 'This the first comment for post 1')
    @comment1 = Comment.create(user_id: @user1.id, post_id: @post1.id, text: 'This the second comment for post 1')
    @comment1 = Comment.create(user_id: @user1.id, post_id: @post1.id, text: 'This the third comment for post 1')
    @comment1 = Comment.create(user_id: @user1.id, post_id: @post1.id, text: 'This the fourth comment for post 1')
    @comment1 = Comment.create(user_id: @user1.id, post_id: @post1.id, text: 'This the fifth comment for post 1')
    @comment1 = Comment.create(user_id: @user1.id, post_id: @post1.id, text: 'This the sixth comment for post 1')

    visit user_posts_path(@user1)
  end

  scenario 'displays user profile picture' do
    expect(page).to have_css("img[src*='https://placekitten.com/200/200']")
  end

  scenario 'displays user name, and number of posts by the user' do
    expect(page).to have_content('Sameed')
    expect(page).to have_content('Number of posts: 4')
  end

  scenario 'display posts title' do
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
    expect(page).to have_content('Post 4')
  end

  scenario 'displays some of the post body' do
    expect(page).to have_content('Text for post 1')
    expect(page).to have_content('Text for post 2')
    expect(page).to have_content('Text for post 3')
    expect(page).to have_content('Text for post 4')
  end

  scenario 'displays five most recent comments for a post' do
    expect(page).to have_content('This the sixth comment for post 1')
    expect(page).to have_content('This the fifth comment for post 1')
    expect(page).to have_content('This the fourth comment for post 1')
    expect(page).to have_content('This the third comment for post 1')
    expect(page).to have_content('This the second comment for post 1')
    expect(page).not_to have_content('This the first comment for post 1')
  end

  scenario 'displays number of comments for a post' do
    expect(page).to have_content('Comments: 6')
    expect(page).to have_content('Comments: 0', count: 3)
  end

  scenario 'displays number of likes for a post' do
    expect(page).to have_content('Likes: 4')
    expect(page).to have_content('Likes: 0', count: 3)
  end

  scenario 'displays a button for Pagination' do
    expect(page).to have_button('Pagination')
  end

  scenario 'redirects to the post show page by clicking on a post' do
    click_link @post1.title
    expect(page).to have_current_path(user_post_path(@user1, @post1))
  end
end
