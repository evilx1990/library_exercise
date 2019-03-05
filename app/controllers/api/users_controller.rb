# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    def auth_token
      user = User.find_by(email: params[:email])

      if user&.valid_password?(params[:password])
        render json: user.authentication_token, status: :found
      else
        render json: 'Not found', status: :not_found
      end
    end
  end
end
