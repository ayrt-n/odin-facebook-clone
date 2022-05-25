# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

u1 = User.create(email: 'tester1@gmail.com', password: 'password')
u2 = User.create(email: 'tester2@gmail.com', password: 'password')
u3 = User.create(email: 'tester3@gmail.com', password: 'password')
u4 = User.create(email: 'tester4@gmail.com', password: 'password')
u5 = User.create(email: 'tester5@gmail.com', password: 'password')

FriendRequest.create(requester: u2, requestee: u1)
FriendRequest.create(requester: u3, requestee: u1)

Friendship.create(user: u1, friend: u4)

u4.posts.create(body: 'I seeded this post!')
u2.posts.create(body: 'Unable to see until we become frenz')