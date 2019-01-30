# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'books#index'

  resources :books, except: %i[:new] do
    post  :vote,    on: :member
    put   :take,    on: :member
    put   :return,  on: :member

    resources :comments, except: %i[index show new]
  end
end
