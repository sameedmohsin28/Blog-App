# db/seeds.rb

# Example 1: Create Users
User.create(email: 'user1@example.com', password: 'password1', name: 'User 1')
User.create(email: 'user2@example.com', password: 'password2', name: 'User 2')

# Example 2: Create Posts and Associate with Users
user1 = User.find_by(email: 'user1@example.com')
user2 = User.find_by(email: 'user2@example.com')

post1 = user1.posts.create(title: 'First Post', text: 'This is the content of the first post.')
post2 = user2.posts.create(title: 'Second Post', text: 'This is the content of the second post.')

# Example 3: Create Comments and Associate with Users and Posts
post1.comments.create(text: 'Great post!', user: user2)
post1.comments.create(text: 'I enjoyed reading this.', user: user1)
post2.comments.create(text: 'Looking forward to more content!', user: user1)

