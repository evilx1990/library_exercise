# frozen_string_literal: true

module Api
  class BooksController < ApplicationController
    before_action :find_book, except: %i[index]

    # returned all found books & most popular book
    def index
      @books = Book.all
      render json: books_json_responce, status: :ok
    end

    def show
      if @book
        render json: @book, status: :found
      else
        render json: 'Not found', status: :not_found
      end
    end

    def vote
      render(json: 'Vote exist', status: :bad_request) if @book.voted?(current_user)

      @book.votes.create!(rating: params[:rating], user: current_user)
      @book.update_rating

      render json: @book.rating, status: :ok
    end

    def status
      render json: @book.status
    end

    def take
      render(json: 'Book missing', status: :bad_request) if @book.status

      @book.history.create!(user: current_user)
      @book.update(status: false)

      render status: :ok
    end

    def return
      @record = @book.history.where(user: current_user, returned_in: nil).first
      @record.update_attribute(:returned_in, Time.now)
      @book.update_attribute(:status, true)

      render status: :ok
    end

    def destroy
      render(json: 'Book missing', status: :bad_request) unless @book.destroy

      render status: :ok
    end

    private

    def find_book
      @book = Book.find(params[:id])
    end

    def books_json_responce
      { books: @books, most_popular: Book.order_by(popularity: :desc).limit(5) }
    end
  end
end
