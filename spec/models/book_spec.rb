# frozen_string_literal: true

require 'rails_helper'

describe Book, type: :model do
  let(:book)  { create(:book) }

  it 'to be mongoid document' do
    expect(Book).to be_mongoid_document
  end

  it 'have timestamps' do
    expect(Book).to have_timestamps
  end

  it 'will be correctly save in DB' do
    expect(book).to eql(Book.first)
  end

  context 'Fields' do
    it 'image' do
      expect(Book).to have_field(:image).of_type(Object)
    end

    it 'title' do
      expect(Book).to have_field(:title).of_type(String)
    end

    it 'author' do
      expect(Book).to have_field(:author).of_type(String)
    end

    it 'description' do
      expect(Book).to have_field(:description).of_type(String)
    end

    it 'status' do
      expect(Book).to have_field(:status).of_type(Mongoid::Boolean).with_default_value_of(true)
    end

    it 'rating' do
      expect(Book).to have_field(:rating).of_type(Float).with_default_value_of(0.0)
    end

    it 'votes_count' do
      expect(Book).to have_field(:votes_count).of_type(Integer).with_default_value_of(0)
    end

    it 'taken_count' do
      expect(Book).to have_field(:taken_count).of_type(Integer).with_default_value_of(0)
    end

    it 'popularity' do
      expect(Book).to have_field(:popularity).of_type(Integer).with_default_value_of(0)
    end
  end

  context 'Associations' do
    context 'belongs to' do
      it 'user' do
        expect(Book).to belong_to(:user)
      end
    end

    context 'has many' do
      it 'votes' do
        expect(Book).to have_many(:votes).with_dependent(:destroy)
      end

      it 'comments' do
        expect(Book).to have_many(:comments).with_dependent(:destroy)
      end

      it 'history' do
        expect(Book).to have_many(:history).with_dependent(:destroy) # class name: History
      end
    end
  end

  context 'Validates' do
    context 'validate presence of' do
      it 'title' do
        expect(Book).to validate_presence_of(:title)
      end

      it 'author' do
        expect(Book).to validate_presence_of(:author)
      end
    end
  end

  context 'Methods' do
    describe '#update_rating' do
      let!(:vote1) { create(:vote, :null, book: book) }
      let!(:vote2) { create(:vote, :five, book: book) }
      let!(:vote3) { create(:vote, :ten, book: book) }

      it 'will update the rating' do
        book.update_rating
        expect(book.rating).to eql(5.0)
      end
    end

    describe '#voted?' do
      let(:book)  { create(:book_with_vote) }
      let(:user)  { book.user }

      it 'will return true if the user has rated the book' do
        expect(book.voted?(user)).to be_truthy
      end
    end
  end
end
