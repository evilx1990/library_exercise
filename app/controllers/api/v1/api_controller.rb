# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API # :nodoc:
      before_action :authenticate_user_from_token!, except: :token
      before_action :authenticate_user!, except: :token
      before_action :set_default_format

      private

      def authenticate_user_from_token!
        user_email = params[:email].presence
        user       = user_email && User.find_by(email: user_email)

        # Notice how we use Devise.secure_compare to compare the token
        # in the database with the token given in the params, mitigating
        # timing attacks.
        if user && Devise.secure_compare(user.authentication_token, params[:token])
          sign_in user, store: false
        else
          render json: { error: 'Invalid email or token' }, status: :bad_request
        end
      end

      def set_default_format
        request.format = :json
      end
    end
  end
end
