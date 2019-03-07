# frozen_string_literal: true

require 'rails_helper'

describe Vote, type: :model do
  let(:vote)  { create(:vote) }

  it 'to be mongoid document' do
     expect(Vote).to be_mongoid_document
  end

  it 'will be correctly save in DB' do
    expect(vote).to eql(Vote.first)
  end

  context 'Fields' do
    it 'rating' do
      expect(Vote).to have_field(:rating).of_type(Integer).with_default_value_of(0)
    end
  end

  context 'Association' do
    context 'belongs to' do
      it 'user' do
        expect(Vote).to belong_to(:user)
      end

      it 'book' do
        expect(Vote).to belong_to(:book).with_counter_cache
      end
    end
  end

  context 'Validates' do
    context 'validates_presence_of' do
      it 'rating' do
        expect(Vote).to validate_presence_of(:rating)
      end
    end
  end

  context 'Indexes' do
    it 'user' do
      expect(Vote).to have_index_for(user: 1)
    end

    it 'book' do
      expect(Vote).to have_index_for(book: 1)
    end
  end

  context 'Callbacks' do
    context 'before save' do
      describe '#normalize_rating' do
        let(:vote_more_than_ten)  { build(:vote, :hundred) }
        let(:vote_less_then_one)  { build(:vote, :negative) }
        let(:vote_invalid)        { build(:vote, :invalid) }

        it 'vote more than ten' do
          vote_more_than_ten.save
          expect(vote_more_than_ten.rating).to eql(10)
        end

        it 'vote less than one' do
          vote_less_then_one.save
          expect(vote_less_then_one.rating).to eql(1)
        end

        it 'vote invalid' do
          vote_invalid.save
          expect(vote_invalid.rating).to eql(1)
        end
      end
    end
  end
end
