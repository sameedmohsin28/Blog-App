require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  before do
    @user1 = User.create(name: 'Sameed', bio: 'He is from Pakistan', photo: 'https://placekitten.com/200/200',
                         posts_counter: 3)
    @user2 = User.create(name: 'Cisco', bio: 'He is from Nigeria', photo: 'https://placekitten.com/200/200',
                         posts_counter: 4)
    @user3 = User.create(name: 'Reviewer', bio: 'They are from Microverse', photo: 'https://placekitten.com/200/200',
                         posts_counter: 5)
    visit users_path
  end

  scenario 'displays username of all users' do
    expect(page).to have_content('Sameed')
    expect(page).to have_content('Cisco')
    expect(page).to have_content('Reviewer')
  end

  scenario 'displays number of posts each user has written' do
    expect(page).to have_content('Number of posts: 3')
    expect(page).to have_content('Number of posts: 4')
    expect(page).to have_content('Number of posts: 5')
  end

  scenario 'displays the profile picture for each user' do
    expect(page).to have_css("img[src*='https://placekitten.com/200/200']", count: 3)
  end

  scenario 'redirect to the user show page' do
    click_link @user1.name
    expect(page).to have_current_path(user_path(@user1))
  end

  scenario 'redirect to the user show page' do
    click_link @user2.name
    expect(page).to have_current_path(user_path(@user2))
  end

  scenario 'redirect to the user show page' do
    click_link @user3.name
    expect(page).to have_current_path(user_path(@user3))
  end
end
