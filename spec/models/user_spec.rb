# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  let(:user) { create(:user) }

  it 'should be mongoid document' do
     expect(User).to be_mongoid_document
  end

  context 'Validation' do
    context 'should be invalid without' do
      it 'email' do
        expect(build(:user, :without_email)).not_to be_valid
      end

      it 'password' do
        expect(build(:user, :without_password)).not_to be_valid
      end

      it 'first name' do
        expect(build(:user, :without_first_name)).not_to be_valid
      end

      it 'last_name' do
        expect(build(:user, :without_last_name)).not_to be_valid
      end
    end

    it 'should be valid' do
      expect(build(:user)).to be_valid
    end
  end

  context 'Association' do
    context 'has_many' do
      it 'books' do
        expect(User).to have_many(:books)
      end

      it 'votes' do
        expect(User).to have_many(:votes)
      end

      it 'comments' do
        expect(User).to have_many(:comments)
      end

      it 'history' do
        expect(User).to have_many(:history)
      end
    end
  end

  context 'dependent: destroy' do
    let(:book) { create(:book_with_comments_history_votes) }

    #...
  end
end
