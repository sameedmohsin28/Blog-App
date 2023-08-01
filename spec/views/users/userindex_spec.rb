require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  before do
    @user1 = User.create(name: 'Sameed', bio: 'He is from Pakistan', photo: 'https://placekitten.com/200/200', posts_counter: 3)
    @user2 = User.create(name: 'Cisco', bio: 'He is from Nigeria', photo: 'https://placekitten.com/200/200', posts_counter: 4)
    @user3 = User.create(name: 'Reviewer', bio: 'They are from Microverse', photo: 'https://placekitten.com/200/200', posts_counter: 5)
    visit users_path
  end

  scenario 'displays username of all users' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
    expect(page).to have_content(@user3.name)
  end

  scenario 'displays number of posts each user has written' do
    expect(page).to have_content(@user1.posts_counter)
    expect(page).to have_content(@user2.posts_counter)
    expect(page).to have_content(@user3.posts_counter)
  end
end
