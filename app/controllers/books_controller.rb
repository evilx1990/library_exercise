# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :find_book, except: %i[index create]

  def index
    @books = Book.order_by(created_at: :desc).page(params[:page]).per(20)
    @book = Book.new
  end

  def show; end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to books_path
    end
  end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def vote
    @book.votes.create(rating: params[:rating], user: current_user)
    @book.update_rating
  end

  def take
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
