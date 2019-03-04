# frozen_string_literal: true

require 'rails_helper'

describe 'Vote range input', type: :feature do
  let(:book)  { create(:book) }

  before do
    login_as(create(:user), scope: :user)
    visit book_path(book)
  end

  context 'books/show.html.haml must contain' do
    it 'input range' do
      expect(page).to have_selector('input[type=range]')
    end

    it 'rating book' do
      expect(page).to have_selector('#rating')
    end
  end

  context 'user can', driver: :selenium_chrome_headless do
    before do
      find('input[type=range]').click
      find('#rating > a').click
    end

    it 'vote' do
      expect(find('#rating').text).to eql('5.0')
    end

    it 'user can vote only once' do
      expect(page).to have_selector('input[disabled]')
    end
  end
end
