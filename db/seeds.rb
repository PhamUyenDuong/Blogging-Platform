# db/seeds.rb
require 'faker'

# Clear existing data
User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all
Relationship.destroy_all

# Create sample users
users = []
10.times do
  users << User.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

# Create sample posts
posts = []
users.each do |user|
  5.times do
    posts << Post.create!(
      content: Faker::Quote.famous_last_words,
      user: user
    )
  end
end

# Create sample comments
posts.each do |post|
  3.times do
    Comment.create!(
      content: Faker::Movies::HarryPotter.quote,
      user: users.sample,
      post: post
    )
  end
end

# Create sample likes
posts.each do |post|
  users.sample(3).each do |user|
    Like.create!(
      user: user,
      post: post
    )
  end
end

# Create sample relationships
users.each do |user|
  following = users.sample(3)
  following.each do |followed|
    unless user == followed || user.following?(followed)
      user.follow(followed)
    end
  end
end

puts "Seed data created successfully!"
