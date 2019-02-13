# frozen_string_literal: true

FactoryBot.define do
  factory :history do
    taken_in    { Time.now - 1.day }
    returned_in { Time.now }

    association :user, factory: :user
    association :book, factory: :book
  end
end
