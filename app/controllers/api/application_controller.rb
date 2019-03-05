# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    # This is our new function that comes before Devise's one
    before_action :authenticate_user_from_token!, except: :auth_token

    private

    def authenticate_user_from_token!
      user_email = params[:user_email].presence
      user       = user_email && User.find_by_email(user_email)

      # Notice how we use Devise.secure_compare to compare the token
      # in the database with the token given in the params, mitigating
      # timing attacks.
      if user && Devise.secure_compare(user.authentication_token, params[:user_token])
        sign_in user, store: false
      end
    end
  end
end
