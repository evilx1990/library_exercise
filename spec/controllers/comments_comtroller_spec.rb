# frozen_string_literal: true

require 'rails_helper'

describe CommentsController, type: :controller do
  let(:book)    { create(:book) }
  let(:comment) { build(:comment) }
  before do
    @user = create(:user)
    sign_in(@user)
  end

  describe 'POST #create' do
    subject! do
      post :create,
           params: {
             book_id: book.id,
             comment: {
               message: comment.message
             }
           }
    end

    it 'has a 302 code' do
      expect(response).to have_http_status(302)
    end

    it 'redirect to book_path(@book)' do
      expect(response).to redirect_to(book_path(assigns(:book)))
    end

    it 'assign @book' do
      expect(assigns(:book)) == book
    end

    it 'assign @comment' do
      expect(assigns(:comment)) == comment
    end
  end
end
