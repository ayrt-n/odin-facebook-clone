# User Factory for creating/building user in testing/development
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }

    factory :user_with_post do
      after(:create) do |user|
        create(:post, user: user)
      end
    end
  end
end