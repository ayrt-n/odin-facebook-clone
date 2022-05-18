# Post Factory for creating/building post in testing/development
FactoryBot.define do
  factory :post do
    user
    body { Faker::Lorem.sentence }
  end
end