# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :find_book, except: %i[index create]

  def index
    @books = Book.order_by(created_at: :desc).page(params[:page]).per(20)
    @book = Book.new
  end

  def show
    @comments = @book.comments.order_by(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user

    redirect_to books_path if @book.save!
  end

  def edit; end

  def update
    redirect_to book_path(@book) if @book.update(book_params)
  end

  def vote
    if @book.voted?(current_user)
      head :bad_request
    else
      @book.votes.create!(rating: params[:rating], user: current_user)
      @book.update_rating
    end
  end

  def take
    if !@book.status
      head :bad_request
    else
      @book.history.create!(user: current_user)
      @book.update(status: false)
    end
  end

  def return
    if @book.status
      head :bad_request
    else
      @record = @book.history.where(user: current_user, returned_in: nil).first
      @record.update_attribute(:returned_in, Time.now)
      @book.update_attribute(:status, true)
    end
  end

  def destroy
    @book.destroy

    if params[:redirect].eql?('true')
      redirect_to books_path
    else
      render 'books/destroy'
    end
  end

  private

  def book_params
    params.require(:book).permit(:image, :title, :author, :description)
  end

  def find_book
    @book = Book.find(params[:id])
  end
end
