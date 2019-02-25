# frozen_string_literal: true

require 'rails_helper'

describe 'Take/Return book', type: :feature do
  let(:book) { create(:book) }

  before do
    login_as(create(:user), scope: :user)
    visit book_path(book)
  end

  context 'books/show.html.haml must contain' do
    it 'take button' do
      expect(page).to have_link('Take')
    end

    it 'return button if book taken', driver: :selenium_chrome_headless do
      click_link('Take')
      expect(page).to have_link('Return')
    end
  end
end
