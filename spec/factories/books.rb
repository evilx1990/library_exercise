# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    image       { File.open('spec/support/9780099549482.jpg') }
    title       { 'Some title' }
    author      { 'Some author' }
    description { Faker::Lorem.paragraph }

    association :user, factory: :user

    factory :out_book do
      status    { false }
      after(:create) { |book| create(:history, book: book, user: book.user) }
    end

    factory :book_with_vote do
      after(:create) { |book| create(:vote, book: book, user: book.user) }
    end


    factory :book_with_history do
      status    { false }
      after(:create) { |book| create(:history, book: book, user: book.user) }
    end

    factory :book_with_comments do
      after(:create) { |book| create(:comment, book: book, user: book.user) }
    end

    factory :book_with_comments_history_votes do
      after(:create) do |book|
        create_list(:comment, 3, book: book, user: book.user)
        create_list(:vote, 3, book: book, user: book.user)
        create_list(:history_returned_book, 3, book: book)
        create(:history, book: book, user: book.user)
      end
    end
  end
end
