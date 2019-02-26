# frozen_string_literal: true

require 'rails_helper'

describe 'Sidebar', type: :feature do
  context 'User is not authorized' do
    context 'must contain' do
      before do
        visit root_path
        find('body > nav > img').click
      end

      it 'Sign in link' do
        expect(page).to have_selector('body > aside > a:nth-child(1)', text: 'sign in')
      end

      it 'Sign up link' do
        expect(page).to have_selector('body > aside > a:nth-child(2)', text: 'sign up')
      end
    end
  end

  context 'User authorized' do
    context 'must contain' do
      before do
        login_as(create(:user), scope: :user)
        visit books_path
        find('body > nav > img').click
      end

      it 'Home link' do
        expect(page).to have_selector('body > aside > a:nth-child(1)', text: 'home')
      end

      it 'Profile link' do
        expect(page).to have_selector('body > aside > a:nth-child(2)', text: 'profile')
      end

      it 'Log out' do
        expect(page).to have_selector('body > aside > a:nth-child(4)', text: 'log out')
      end
    end
  end
end
