# frozen_string_literal: true

class MostPopularUpdateJob < ApplicationJob
  queue_as :popularity

  after_perform do
    MostPopularUpdateJob.set(wait: 1.hour).perform_later
  end

  def perform
    Book.each do |book|
      book.popularity = book.votes_count + book.taken_count
      book.save
    end
  end
end
