# frozen_string_litegal: true

FactoryBot.define do
  factory :vote do
    rating    { Faker::Number.between(0.0, 10.0) }

    trait :null do
      rating  { 0.0 }
    end

    trait :five do
      rating  { 5.0 }
    end

    trait :ten do
      rating  { 10.0 }
    end

    association :book, factory: :book
    association :user, factory: :user
  end
end
