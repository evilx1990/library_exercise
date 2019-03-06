# frozen_string_literal: true

FactoryBot.define do
  factory :history do
    association :user, factory: :user
    association :book, factory: :out_book
  end

  factory :history_returned_book, class: 'History' do
    returned_in { Time.now }
    association :user, factory: :user
    association :book, factory: :book
  end
end
