# frozen_string_literal: true

require 'rails_helper'

describe 'Take/Return/Out book', type: :feature do
  let(:book)      { create(:book) }
  let(:user)      { create(:user) }
  let(:out_book)  { create(:out_book) }

  before do
    login_as(create(:user), scope: :user)
    visit book_path(book)
  end

  context 'books/show.html.haml must contain' do
    it 'Take button' do
      expect(page).to have_link('Take')
    end

    it 'Return button if book taken' do
      click_link('Take')
      expect(page).to have_link('Return')
    end

    it 'Missing button if book take other reader' do
      visit book_path(out_book)
      expect(page).to have_button('Out', disabled: true)
    end
  end
end
