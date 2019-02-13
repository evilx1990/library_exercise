# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    image       { File.open('spec/support/9780099549482.jpg') }
    title       { 'Some title' }
    author      { 'Some author' }
    description { Faker::Lorem.paragraph }

    association :user, factory: :user

    trait :out do
      status  { false }
    end

    factory :book_with_votes do
      after(:create) do
        FactoryBot.create_list(:vote, 3, book: book)
      end
    end

    factory :book_with_history do
      after(:create) do
        FactoryBot.create_list(:history, 3, book: book)
      end
    end

    factory :book_with_comments do
      after(:create) do
        FactoryBot.create_list(:comment, 3, book: book)
      end
    end

    factory :book_with_comments_and_history do
      after(:create) do
        FactoryBot.create_list(:comment, 3, book: book)
        FactoryBot.create_list(:history, 3, book: book)
      end
    end
  end
end
