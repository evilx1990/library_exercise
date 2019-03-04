# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :find_book, except: %i[index create]

  # GET /books.html
  # GET /books.json { returned all found books & most popular book }
  def index
    @books = Book.order_by(created_at: :desc).page(params[:page]).per(20)
    @book = Book.new

    respond_to do |format|
      format.html
      format.json { render json: books_json_responce, status: :ok }
    end
  end

  # GET /books/:id.html
  # GET /books/:id.json
  def show
    @comments = @book.comments.order_by(created_at: :desc).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.json { render json: { book: @book }, status: :found }
    end
  end

  # POST /books.html
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save!
      respond_to do |format|
        format.html { redirect_to books_path }
        format.json { render status: :created }
      end
    end
  end

  # GET /books/:id/edit.html
  # GET /books/:id/edit.json
  def edit
    respond_to do |format|
      format.html
      format.json { render json: {edit_book: @book}, status: :found }
    end
  end

  # PUT/PATCH  /books/:id.html
  # PUT/PATCH  /books/:id.json
  def update
    if @book.update(book_params)
      respond_to do |format|
        format.html { redirect_to book_path(@book) }
        format.json { render status: :ok }
      end
    end
  end

  # POST /books/:id/vote.js
  # POST /books/:id/vote.json
  def vote
    if @book.voted?(current_user)
      respond_to do |format|
        format.js   { return }
        format.json { render status: :forbidden }
      end
    end

    @book.votes.create!(rating: params[:rating], user: current_user)
    @book.update_rating

    respond_to do |format|
      format.js
      format.json { render status: :ok }
    end
  end

  # PUT /books/:id/take.js
  # PUT /books/:id/take.json
  def take
    @book.history.create!(user: current_user)
    @book.update(status: false)

    respond_to do |format|
      format.js
      format.json { render status: :ok }
    end
  end

  # PUT /books/:id/return.js
  # PUT /books/:id/return.json
  def return
    @record = @book.history.where(user: current_user, returned_in: nil).first
    @record.update_attribute(:returned_in, Time.now)
    @book.update_attribute(:status, true)

    respond_to do |format|
      format.js
      format.json { render status: :ok}
    end
  end

  # DELETE /books/:id.js
  # DELETE /books/:id.json
  def destroy
    @book.destroy
    if params[:redirect].eql?('true')
      redirect_to books_path
    else
      respond_to do |format|
        format.js   { render 'books/destroy' }
        format.json { render  status: :ok }
      end
    end
  end

  private

  def book_params
    params.require(:book).permit(:image, :title, :author, :description)
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def books_json_responce
    { books: @books, most_popular: Book.order_by(popularity: :desc).limit(5) }
  end
end
