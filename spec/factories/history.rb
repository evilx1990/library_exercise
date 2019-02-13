# frozen_string_literal: true

FactoryBot.define do
  factory :history, class: 'History' do
    association :user, factory: :user
    association :book, factory: :book

    trait :returned do
      returned_in { Time.now }
    end
  end
end
