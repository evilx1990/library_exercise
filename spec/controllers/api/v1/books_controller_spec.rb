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
            email: user.email,
            token: user.authentication_token
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
    context 'when book found' do
      subject! do
        get :show,
            format: :json,
            params: {
              id: book.id,
              email: user.email,
              token: user.authentication_token
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
    end

    context 'when book not found' do
      subject! {
        book.destroy

        get :show,
            format: :json,
            params: {
              id: book.id,
              email: user.email,
              token: user.authentication_token
            }
      }

      it 'hav a 404 code' do
        expect(response).to have_http_status(404)
      end

      it 'json response must contain error message' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['message']).to eql('404:Not found')
      end
    end
  end

  describe 'POST #vote' do
    let(:vote) { build(:vote) }

    context 'when user has not voted' do
      subject! do
        post :vote,
             format: :json,
             params: {
               rating: vote.rating,
               id: book.id,
               email: user.email,
               token: user.authentication_token
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

      it 'json response must contain book rating' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['rating']).to be_truthy
      end
    end

    context 'when user has already voted' do
      subject! {
        @book = create(:book_with_vote, user: user)

        post :vote,
             format: :json,
             params: {
               rating: vote.rating,
               id: @book.id,
               email: user.email,
               token: user.authentication_token
             }
      }

      it 'hav a 400 code' do
        expect(response).to have_http_status(400)
      end

      it 'json response must contain error message' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['message']).to eql('400:Bad request')
      end
    end
  end

  describe 'PUT #take' do
    context 'when user has not taken book' do
      subject! do
        put :take,
            format: :json,
            params: {
              id: book.id,
              email: user.email,
              token: user.authentication_token
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

      it 'json response must contain message with Ok status' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['message']).to eql('200:Ok')
      end
    end

    context 'when user has already taken book' do
      subject! {
        @book = create(:out_book, user: user)

        put :take,
            format: :json,
            params: {
              id: @book.id,
              email: user.email,
              token: user.authentication_token
            }
      }

      it 'hav a 400 code' do
        expect(response).to have_http_status(400)
      end

      it 'json response must contain error message' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['message']).to eql('400:Bad request')
      end
    end
  end

  describe 'PUT #return' do
    context 'when user has not returned book' do
      subject! do
        @book = create(:out_book, user: user)

        put :return,
            format: :json,
            params: {
                id: @book.id,
                email: user.email,
                token: user.authentication_token
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

      it 'json response must contain message with status ok' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['message']).to eql('200:Ok')
      end
    end

    context 'when user has already returned book' do
      subject! {
        put :return,
            format: :json,
            params: {
              id: book.id,
              email: user.email,
              token: user.authentication_token
            }
      }

      it 'hav a 400 code' do
        expect(response).to have_http_status(400)
      end

      it 'json response must contain error message' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['message']).to eql('400:Bad request')
      end
    end
  end
end
