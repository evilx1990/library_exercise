# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController # :nodoc:
      def token
        @user = User.find_by(email: params[:email])

        if @user&.valid_password?(params[:password].to_s)
          render json: { token: @user.authentication_token }, status: :found
        else
          render json: { message: '404:Not found' }, status: :not_found
        end
      end
    end
  end
end
