# frozen_string_literal: true

class CommentsController < ApplicationController # :nodoc:
  before_action :find_book

  def index
    @comments = @book.comments
  end

  def create
    @comment = @book.comments.new(comment_params)
    @comment.user = current_user

    redirect_to book_path(@book) if @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end

  def find_book
    @book = Book.find(params[:book_id])
  end
end
