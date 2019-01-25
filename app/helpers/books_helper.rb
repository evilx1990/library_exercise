# frozen_string_literal: true

module BooksHelper
  def most_popular
    Book.order_by(popularity: :desc).limit(5)
  end
end
