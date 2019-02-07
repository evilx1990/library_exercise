# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_book,     only: %i[create]
  before_action :find_comment,  except: %i[create]

  def create
    # If comment field empty - submit button disabled
    @comment = @book.comments.new(comment_params)
    @comment.user = current_user

    redirect_to book_path(@book) if @comment.save
  end

  def edit; end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end

  def find_book
    @book = Book.find(params[:book_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
