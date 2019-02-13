# frozen_string_literal: true

require 'rails_helper'

describe BooksController, type: :controller do
  let(:book) { create(:book) }

  before do
    @user = create(:user)
    sign_in(@user)
  end

  describe 'GET #index' do
    let(:book)  { Book.new }
    let(:books) { create_list(:book, 3) }

    subject! { get :index }

    it 'has a 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'render index template' do
      expect(response).to render_template(:index)
    end

    it 'assign @books' do
      expect(assigns(:books)) == books
    end

    it 'assign @book' do
      expect(assigns(:book)) == book
    end
  end

  describe 'GET #show' do
    let(:comments) { create_list(:comment, 3, book: book) }

    subject! { get :show, params: { id: book.id } }

    it 'has code 200' do
      expect(response).to have_http_status(200)
    end

    it 'render show template' do
      expect(response).to render_template(:show)
    end

    it 'assign @book' do
      expect(assigns(:book)) == book
    end

    it 'assign @comments' do
      expect(assigns(:comments)) == comments
    end
  end

  describe 'POST #create' do
    let(:book) { build(:book) }

    subject! do
      post :create,
           params: {
             book: {
               image:       book.image,
               title:       book.title,
               author:      book.author,
               description: book.description
             }
           }
    end

    it 'has a 302 code' do
      expect(response).to have_http_status(302)
    end

    it 'redirect to books_path' do
      expect(response).to redirect_to(books_path)
    end

    it 'assign @book' do
      expect(assigns(:book)) == book
    end

    it 'create record book into DB' do
      expect(Book.count) == 1
    end
  end

  describe 'GET #edit' do
    subject! { get :edit, params: { id: book.id } }

    it 'has a 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'render edit template' do
      expect(response).to render_template(:edit)
    end

    it 'assign @book' do
      expect(assigns(:book)) == book
    end
  end

  describe 'PUT #update' do
    subject! do
      put :update,
          params: {
            id: book.id,
            book: {
              image:       book.image,
              title:       book.title,
              author:      book.author,
              description: book.description
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
  end

  describe 'POST #vote' do
    subject! { post :vote, xhr: :js, params: { id: book.id, rating: 10} }

    it 'has a 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'render vote template' do
      expect(response).to render_template(:vote)
    end

    it 'assign @book' do
      expect(assigns(:book)) == book
    end

    it 'create vote record into DB' do
      expect(Vote.count) == 1
    end

    it 'update book rating' do
      expect(assigns(:book).rating) == 10
    end
  end

  describe 'PUT #take' do
    subject! { put :take, xhr: :js, params: { id: book.id } }

    it 'has a 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'render take template' do
      expect(response).to render_template(:take)
    end

    it 'assign @book' do
      expect(assigns(:book)) == book
    end

    it 'create history record in db' do
      expect(History.count) == 1
    end

    it 'update book status' do
      expect(assigns(:book).status).to be_falsey
    end

    context 'if status equal <false> before start action' do
      let(:book) { create(:book, :out) }

      subject! { put :take, xhr: :js, params: { id: book.id } }

      it 'has a 200 code' do
        expect(response).to have_http_status(200)
      end

      it 'render take_error template' do
        expect(response).to render_template(:take_error)
      end
    end
  end

  describe 'PUT #return' do
    let(:book) { create(:history, user: @user).book }

    subject! { put :return, xhr: :js, params: { id: book.id } }

    it 'has a 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'render return template' do
      expect(response).to render_template(:return)
    end

    it 'assign @book' do
      expect(assigns(:book)) == book
    end

    it 'assign @record' do
      expect(assigns(:record)) == book.history.first
    end

    it 'history record must have returned timestamp' do
      expect(assigns(:record).returned_in).to be_truthy
    end

    it 'book record must have status <true>' do
      expect(assigns(:book).status).to be_truthy
    end
  end

  describe 'DELETE #destroy' do
    context 'redirect: true' do
      subject! do
        delete :destroy,
               params: {
                 redirect: 'true',
                 id: book.id
               }
      end

      it 'has a 302 code' do
        expect(response).to have_http_status(302)
      end

      it 'redirect to books_path' do
        expect(response).to redirect_to(books_path(assigns(:book)))
      end

      it 'destroy book record into DB' do
        expect(Book.count) == 0
      end
    end

    context 'redirect: false' do
      subject! do
        delete :destroy,
               xhr: :js,
               params: {
                 redirect: 'false',
                 id: book.id
               }
      end

      it 'has a 200 code' do
        expect(response).to have_http_status(200)
      end

      it 'redirect to books_path' do
        expect(response).to render_template(:destroy)
      end

      it 'destroy book record into DB' do
        expect(Book.count) == 0
      end
    end
  end
end
