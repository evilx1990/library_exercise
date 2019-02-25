# frozen_string_literal: true

require 'rails_helper'

describe 'Books settings', type: :feature do
  before do
    create(:book)
    login_as(create(:user), scope: :user)
    visit books_path
  end

  it 'must present' do
    expect(page).to have_selector('#books > div:nth-child(2) > div > div:nth-child(1) > div.manip > div > button > img')
  end

  context 'must contain' do
    before do
      find('#books > div:nth-child(2) > div > div:nth-child(1) > div.manip > div > button > img').click
    end

    it 'edit link' do
      expect(page).to have_selector('#dropdown-width > a:nth-child(1)')
    end

    it 'delete link' do
      expect(page).to have_selector('#dropdown-width > a:nth-child(3)')
    end
  end
end
