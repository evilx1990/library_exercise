# frozen_string_litaral: true

FactoryBot.define do
  factory :comment do
    message { Faker::String.random(100) }

    association :book, factory: :book
    association :user, factory: :user
  end
end
