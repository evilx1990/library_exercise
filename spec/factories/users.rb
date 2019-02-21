# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    email         { Faker::Internet.email }
    password      { Faker::Internet.password(6, 10) }

    trait :without_email do
      email       { nil }
    end

    trait :without_password do
      password    { nil }
    end

    trait :without_first_name do
      first_name  { nil }
    end

    trait :without_last_name do
      last_name   { nil }
    end
  end
end
