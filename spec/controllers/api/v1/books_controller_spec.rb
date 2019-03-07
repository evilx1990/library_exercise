# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::BooksController, type: :controller do
  let(:user)      { create(:user) }
  let(:book)      { create(:book) }

  describe 'GET #index' do
    let(:books) { create_list(:book, 3) }

    subject! do
      get :index,
          format: :json,
          params: {
            email:    user.email,
            token:    user.authentication_token
          }
    end

    it 'have json format' do
      expect(response.content_type).to eql('application/json')
    end

    it 'has a 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'render index json template' do
      expect(response).to render_template(:index)
    end

    it 'assign @books' do
      expect(assigns(:books)) == books
    end
  end

  describe 'GET #show' do
    subject! do
      get :show,
          format: :json,
          params: {
            id:       book.id,
            email:    user.email,
            token:    user.authentication_token
          }
    end

    it 'have json format' do
      expect(response.content_type).to eql('application/json')
    end

    it 'have a 302 code when book found' do
      expect(response).to have_http_status(302)
    end

    it 'render show template' do
      expect(response).to render_template(:show)
    end

    it 'assign @book' do
      expect(assigns(:book)) == book
    end

    context 'when book not found' do
      subject! {
        book.destroy

        get :show,
            format: :json,
            params: {
              id:       book.id,
              email:    user.email,
              token:    user.authentication_token
            }
      }

      it 'hav a 404 code' do
        expect(response).to have_http_status(404)
      end
    end
  end

  context 'POST #vote' do
    let(:vote)  { build(:vote) }

    subject! do
      post :vote,
           format: :json,
           params: {
             rating:  vote.rating,
             id:      book.id,
             email:   user.email,
             token:   user.authentication_token
           }
    end

    it 'have json format' do
      expect(response.content_type).to eql('application/json')
    end

    it 'have a 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'assign @book' do
      expect(assigns(:book)) == book
    end

    it 'must create vote' do
      expect(Vote.count).to eql(1)
    end

    it 'must update book rating' do
      expect(book.rating).not_to eql(0)
    end

    context 'when user has already voted' do
      subject! {
        @book = create(:book_with_vote, user: user)

        post :vote,
             format: :json,
             params: {
               rating:   vote.rating,
               id:       @book.id,
               email:    user.email,
               token:    user.authentication_token
             }
      }

      it 'hav a 400 code' do
        expect(response).to have_http_status(400)
      end
    end
  end

  context 'PUT #take' do
    subject! do
      put :take,
           format: :json,
           params: {
             id:      book.id,
             email:   user.email,
             token:   user.authentication_token
           }
    end

    it 'have json format' do
      expect(response.content_type).to eql('application/json')
    end

    it 'have a 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'assign @book' do
      expect(assigns(:book)) == book
    end

    it 'must take a book' do
      expect(History.count).to eql(1)
    end

    it 'must update book status' do
      expect(book.reload.status).to be_falsey
    end

    context 'when user has already taken book' do
      subject! {
        @book = create(:out_book, user: user)

        put :take,
             format: :json,
             params: {
               id:       @book.id,
               email:    user.email,
               token:    user.authentication_token
             }
      }

      it 'hav a 400 code' do
        expect(response).to have_http_status(400)
      end
    end
  end

  context 'PUT #return' do
    subject! do
      @book = create(:out_book, user: user)

      put :return,
          format: :json,
          params: {
            id:      @book.id,
            email:   user.email,
            token:   user.authentication_token
          }
    end

    it 'have json format' do
      expect(response.content_type).to eql('application/json')
    end

    it 'have a 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'assign @book' do
      expect(assigns(:book)) == @book
    end

    it 'must return a book' do
      expect(History.last.returned_in).to be_truthy
    end

    it 'must update book status' do
      expect(book.reload.status).to be_truthy
    end

    context 'when user has already returned book' do
      subject! {
        put :return,
             format: :json,
             params: {
               id:       book.id,
               email:    user.email,
               token:    user.authentication_token
             }
      }

      it 'hav a 400 code' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
