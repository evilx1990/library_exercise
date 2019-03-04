# frozen_string_literal: true

require 'rails_helper'

describe 'User pages', type: :feature do
  # login_as(create(:user), scope: :user)
  describe 'Login page' do
    before do
      visit user_session_path
    end

    context 'must contain' do
      it 'Sign up link' do
        expect(page).to have_link('Sign up')
      end

      it 'email field' do
        expect(page).to have_css('#user_email')
      end

      it 'password field' do
        expect(page).to have_css('#user_password')
      end

      it 'remember me checkbox' do
        expect(page).to have_unchecked_field('user_remember_me')
      end

      it 'Log in button' do
        expect(page).to have_button('Log in')
      end

      it 'Forgot your password? link' do
        expect(page).to have_link('Forgot your password?')
      end
    end
  end

  describe 'Registration page' do
    before do
      visit new_user_registration_path
    end

    context 'must contain' do
      it 'first name field' do
        expect(page).to have_css('#user_first_name')
      end

      it 'last name field' do
        expect(page).to have_css('#user_last_name')
      end

      it 'email field' do
        expect(page).to have_css('#user_email')
      end

      it 'password field' do
        expect(page).to have_css('#user_password')
      end

      it 'confirm password field' do
        expect(page).to have_css('#user_password_confirmation')
      end

      it 'Sign up button' do
        expect(page).to have_button('Sign up')
      end
    end
  end

  describe 'Edit user page' do
    before do
      login_as(create(:user), scope: :user)
      visit edit_user_registration_path
    end

    context 'must contain' do
      it 'first name field' do
        expect(page).to have_css('#user_first_name')
      end

      it 'last name field' do
        expect(page).to have_css('#user_last_name')
      end

      it 'email field' do
        expect(page).to have_css('#user_email')
      end

      it 'current password field' do
        expect(page).to have_css('#user_current_password')
      end

      it 'Update button' do
        expect(page).to have_button('Update')
      end
    end
  end
end
