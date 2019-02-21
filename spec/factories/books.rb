# frozen_string_literal: true

FactoryBot.define do
  factory :book, class: 'Book' do
    image       { File.open('spec/support/9780099549482.jpg') }
    title       { 'Some title' }
    author      { 'Some author' }
    description { Faker::Lorem.paragraph }

    association :user, factory: :user

    trait :out do
      status  { false }
    end

    factory :book_with_votes do
      after(:create) do |book|
        FactoryBot.create_list(:vote, 3, book: book)
      end
    end

    factory :book_with_history do
      after(:create) do |book|
        FactoryBot.create_list(:history, 3, book: book)
      end
    end

    factory :book_with_comments do
      after(:create) do |book|
        FactoryBot.create_list(:comment, 3, book: book)
      end
    end

    factory :book_with_comments_history_votes do
      after(:create) do |book|
        FactoryBot.create_list(:comment, 3, book: book, user: book.user)
        FactoryBot.create_list(:history, 3, :returned, book: book, user: book.user)
        FactoryBot.create_list(:vote, 3, book: book, user: book.user)
      end
    end
  end
end
