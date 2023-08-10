require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  before do
    @user1 = User.create(name: 'Sameed', bio: 'He is from Pakistan', photo: 'https://placekitten.com/200/200',
                         posts_counter: 0)

    @post1 = Post.create(author_id: @user1.id, title: 'Post 1', text: 'Text for post 1', comments_counter: 1,
                         likes_counter: 8)
    @post2 = Post.create(author_id: @user1.id, title: 'Post 2', text: 'Text for post 2', comments_counter: 2,
                         likes_counter: 7)
    @post3 = Post.create(author_id: @user1.id, title: 'Post 3', text: 'Text for post 3', comments_counter: 3,
                         likes_counter: 6)
    @post4 = Post.create(author_id: @user1.id, title: 'Post 4', text: 'Text for post 4', comments_counter: 4,
                         likes_counter: 5)

    visit user_path(@user1)
  end

  scenario 'displays user profile picture' do
    expect(page).to have_css("img[src*='https://placekitten.com/200/200']")
  end

  scenario 'displays user name, user bio, and number of posts by the user' do
    expect(page).to have_content('Sameed')
    expect(page).to have_content('He is from Pakistan')
    expect(page).to have_content('Number of posts: 4')
  end

  scenario 'displays three most recent user posts' do
    expect(page).to have_content('Post 4')
    expect(page).to have_content('Post 3')
    expect(page).to have_content('Post 2')
    expect(page).not_to have_content('Post 1')
  end

  scenario 'displays See all posts button' do
    expect(page).to have_link('See all posts')
  end

  scenario 'redirects to the post show page' do
    click_link Post.last.title
    expect(page).to have_current_path(user_post_path(@user1, @post4))
  end

  scenario 'redirects to the posts index page' do
    click_link('See all posts')
    expect(page).to have_current_path(user_posts_path(@user1))
  end
end
