# frozen_string_litaral: true

require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #token' do
    context 'user valid' do
      subject! do
        get :token,
            format: :json,
            params: {
              email: user.email,
              password: user.password
            }
      end

      it 'have json format' do
        expect(response.content_type).to eql('application/json')
      end

      it 'have a 302 code when user found and password valid' do
        expect(response).to have_http_status(302)
      end

      it 'json response must contain user token' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['token']).to eql(user.authentication_token)
      end
    end

    context 'user invalid' do
      subject! do
        get :token,
            format: :json,
            params: {
              user: user.email,
              password: Faker::Internet.password
            }
      end

      it 'have a 404 code when given invalid password' do
        expect(response).to have_http_status(404)
      end

      it 'json response must contain error message' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['message']).to eql('404:Not found')
      end
    end
  end
end
