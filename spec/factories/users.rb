# User Factory for creating/building user in testing/development
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
  end
end