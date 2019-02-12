# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :find_book, except: %i[index create]

  def index
    @books = Book.order_by(created_at: :desc).page(params[:page]).per(20)
    @book = Book.new
  end

  def show
    @comments = @book.comments.order_by(taken_in: :desc).page(params[:page]).per(10)
  end

  def create
    @book = Book.new(book_params)

    redirect_to books_path if @book.save
  end

  def edit; end

  def update
    redirect_to book_path(@book) if @book.update(book_params)
  end

  def vote
    @book.votes.create!(rating: params[:rating], user: current_user)
    @book.update_rating
  end

  def take
    return unless @book.history.last.returned_in
    @book.history.create(user: current_user)
    @book.update(status: false)
  end

  def return
    @record = @book.history.where(user: current_user, returned_in: nil)
    @record.update(returned_in: Time.now)
    @book.update(status: true)
  end

  def destroy
    @book.destroy
    redirect_to books_path if params[:redirect]
  end

  private

  def book_params
    params.require(:book).permit(:image, :title, :author, :description)
  end

  def find_book
    @book = Book.find(params[:id])
  end
end
