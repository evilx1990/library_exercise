# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_book

  # GET /books.json
  def index
    @comments = @book.comments

    respond_to do |format|
      format.json { render json: { commetns: @comments } }
    end
  end

  # POST /books.html
  # POST /books.json
  def create
    @comment = @book.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to book_path(@book) }
        format.json { render status: :ok }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end

  def find_book
    @book = Book.find(params[:book_id])
  end
end
