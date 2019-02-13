# frozen_string_litegal: true

FactoryBot.define do
  factory :vote do
    rating  { Faker::Number.between(1, 10) }

    association :book, factory: :book
    association :user, factory: :user
  end
end
