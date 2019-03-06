# frozen_string_litegal: true

FactoryBot.define do
  factory :vote do
    rating    { Faker::Number.between(0.0, 10.0) }

    trait :one do
      rating  { 1.0 }
    end

    trait :five do
      rating  { 5.0 }
    end

    trait :ten do
      rating  { 10.0 }
    end

    trait :hundred do
      rating  { 100 }
    end

    trait :negative do
      rating  { -1 }
    end

    trait :invalid do
      rating  { 'lorem' }
    end

    association :book, factory: :book
    association :user, factory: :user
  end
end
