# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    image       { File.read('spec/support/9780099549482.jpg') }
    title       { 'Some title' }
    author      { 'Some author' }
    description { Faker::String.random(200) }

    association :user, factory: :user

    factory :out_book do
      create(:history, book: book, user: user, returned_in: nil)
    end

    factory :book_with_votes do
      create_list(:vote, 3, book: book)
    end

    factory :book_with_history do
      create_list(:history, 3, book: book)
    end

    factory :book_with_comments do
      create_list(:comment, 3, book: book)
    end
  end
end
