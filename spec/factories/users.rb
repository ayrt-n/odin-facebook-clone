# User Factory for creating/building user in testing/development
FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    incoming_friend_requests_count { 0 }

    factory :user_with_post do
      after(:create) do |user|
        create(:post, user: user)
      end
    end
  end
end