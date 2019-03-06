# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      def token
        user = User.find_by(email: params[:email])

        if user&.valid_password?(params[:password])
          render json: { token: user.authentication_token }, status: :found
        else
          render json: { status: 'Not found' }, status: :not_found
        end
      end
    end
  end
end
