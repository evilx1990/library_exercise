# frozen_string_literal: true

require 'rails_helper'

describe Comment, type: :model do
  let(:comment) { create(:comment) }

  it 'to be mongoid document' do
    expect(Comment).to be_mongoid_document
  end

  it 'have timestamps' do
    expect(Comment).to have_timestamps
  end

  it 'will be correctly save in DB' do
    expect(comment).to eql(Comment.first)
  end

  context 'Fields' do
    it 'message' do
      expect(Comment).to have_field(:message).of_type(String)
    end
  end

  context 'Associations' do
    context 'belongs to' do
      it 'user' do
        expect(Comment).to belong_to(:user)
      end

      it 'book' do
        expect(Comment).to belong_to(:book)
      end
    end
  end

  context 'Validates' do
    context 'validates_presence_of' do
      it 'message' do
        expect(Comment).to validate_presence_of(:message)
      end
    end
  end

  context 'Indexes' do
    it 'book' do
      expect(Comment).to have_index_for(book: 1)
    end
  end
end