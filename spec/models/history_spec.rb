# frozen_string_literal: true

require 'rails_helper'

describe History, type: :model do
  let(:history) { create(:history_returned_book) }

  it 'to be mongoid document' do
    expect(History).to be_mongoid_document
  end

  it 'will be correctly save in DB' do
    expect(history).to eql(History.first)
  end

  context 'Fields' do
    it 'taker_in' do
      expect(History).to have_field(:taken_in).of_type(Time)
    end

    it 'returned_id' do
      expect(History).to have_field(:returned_in).of_type(Time)
    end
  end

  context 'Validates' do
    context 'belongs to' do
      it 'user' do
        expect(History).to belong_to(:user)
      end

      it 'book' do
        expect(History).to belong_to(:book).with_counter_cache
      end
    end
  end

  context 'Indexes' do
    it 'user' do
      expect(History).to have_index_for(user: 1)
    end

    it 'book' do
      expect(History).to have_index_for(book: 1)
    end
  end
end
