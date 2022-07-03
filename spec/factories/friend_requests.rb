# User Factory for creating/building friend requests in testing/development
FactoryBot.define do
  factory :friend_request do
    requester {}
    requestee {}
    accepted { false }
  end
end