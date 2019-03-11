# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApiController # :nodoc:
      before_action :find_book, except: %i[index]

      def index
        @books = Book.order_by(popularity: :desc)

        render status: :ok
      end

      def show
        if @book
          render status: :found
        else
          render json: { message: '404:Not found' }, status: :not_found
        end
      end

      def vote
        if @book.voted?(current_user)
          status_bad_request
        else
          @book.votes.create!(rating: params[:rating], user: current_user)
          @book.update_rating

          render json: { rating: @book.rating }, status: :ok
        end
      end

      def take
        if @book.status
          @book.history.create!(user: current_user)
          @book.update(status: false)

          status_ok
        else
          status_bad_request
        end
      end

      def return
        if @book.status
          status_bad_request
        else
          @record = @book.history.where(user: current_user, returned_in: nil).first
          @record.update_attribute(:returned_in, Time.now)
          @book.update_attribute(:status, true)

          status_ok
        end
      end

      private

      def find_book
        @book = Book.find(params[:id])
      end

      def status_bad_request
        render json: { message: '400:Bad request' }, status: :bad_request
      end

      def status_ok
        render json: { message: '200:Ok' }, status: :ok
      end
    end
  end
end
