# frozen_string_literal: true

Rails.application.routes.draw do
  root 'books#index'
  devise_for :users

  namespace 'api', constraints: { format: :json } do
    resources :books, except: %i[new create edit update] do
      post  :vote,    on: :member
      put   :take,    on: :member
      put   :return,  on: :member
    end

    resources :users, only: :auth_token
  end

  resources :books, except: :new do
    post  :vote,    on: :member
    get   :status,  on: :member
    put   :take,    on: :member
    put   :return,  on: :member

    resources :comments, only: %i[index create]
  end
end
