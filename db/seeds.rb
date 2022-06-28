# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Stop letter_opener from opening emails while seeding
ActionMailer::Base.perform_deliveries = false

# Generate seed data
u1 = User.create(username: Faker::Name.name, email: 'tester1@gmail.com', password: 'password', bio: Faker::Lorem.paragraph)
u2 = User.create(username: Faker::Name.name, email: 'tester2@gmail.com', password: 'password', bio: Faker::Lorem.paragraph)
u3 = User.create(username: Faker::Name.name, email: 'tester3@gmail.com', password: 'password', bio: Faker::Lorem.paragraph)
u4 = User.create(username: Faker::Name.name, email: 'tester4@gmail.com', password: 'password', bio: Faker::Lorem.paragraph)
u5 = User.create(username: Faker::Name.name, email: 'tester5@gmail.com', password: 'password', bio: Faker::Lorem.paragraph)

FriendRequest.create(requester: u2, requestee: u1)
FriendRequest.create(requester: u3, requestee: u1)
FriendRequest.create(user: u1, friend: u4, accepted: true)

u4.posts.create(body: 'I seeded this post!')
u4.posts.create(body: 'I seeded this post x2!')
u2.posts.create(body: 'Unable to see until we become frenz')