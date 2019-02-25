# frozen_string_literal: true

require 'rails_helper'

describe 'Most popular carousel', type: :feature do
  before do
    create_list(:vote, 10)
    login_as(create(:user), scope: :user)
    visit books_path
  end

  context 'must contain'do
    it '5 books' do
      expect(page).to have_selector('.carousel-slide', count: 5)
    end

    it 'previous navigate link' do
      expect(page).to have_selector('.carousel-nav.left')
    end

    it 'next navigate link' do
      expect(page).to have_selector('.carousel-nav.right')
    end

    it 'book author' do
      expect(page).to have_selector('.author')
    end

    it 'book title' do
      expect(page).to have_selector('.title')
    end

    it 'book status' do
      expect(page).to have_selector('.status')
    end
  end

  context 'must switch slide after click', driver: :selenium_chrome_headless do
    it 'to next slide link' do
      find('#carousel > div > div > div:nth-child(3) > div > span').click
      sleep(2)
      expect(page).to have_selector('#carousel > div > div > div.col-10.m-0.p-0 > div > div:nth-child(2).active-slide')
    end

    it 'to previous slide link' do
      find('#carousel > div > div > div:nth-child(1) > div > span').click
      sleep(1)
      expect(page).to have_selector('#carousel > div > div > div.col-10.m-0.p-0 > div > div:nth-child(5).active-slide')
    end
  end
end
