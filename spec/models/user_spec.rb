# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  let(:user) { create(:user) }

  it 'to be mongoid document' do
     expect(User).to be_mongoid_document
  end

  it 'will be correctly save in DB' do
    expect(user).to eql(User.first)
  end

  context 'Fields' do
    it 'email' do
      expect(User).to have_field(:email).of_type(String)
    end

    it 'first_name' do
      expect(User).to have_field(:first_name).of_type(String)
    end

    it 'last_name' do
      expect(User).to have_field(:last_name).of_type(String)
    end

    it 'encrypted_password' do
      expect(User).to have_field(:encrypted_password).of_type(String)
    end

    it 'reset_password_token' do
      expect(User).to have_field(:reset_password_token).of_type(String)
    end

    it 'reset_password_sent_at' do
      expect(User).to have_field(:reset_password_sent_at).of_type(Time)
    end

    it 'remember_created_at' do
      expect(User).to have_field(:remember_created_at).of_type(Time)
    end
  end

  context 'Association' do
    context 'has_many' do
      it 'books' do
        expect(User).to have_many(:books).with_dependent(:destroy)
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

  context 'Validation' do
    context 'validate presence of' do
      it 'first name' do
        expect(User).to validate_presence_of(:first_name)
      end

      it 'last_name' do
        expect(User).to validate_presence_of(:last_name)
      end
    end

    it 'to be valid' do
      expect(build(:user)).to be_valid
    end
  end

  context 'Methods' do
    describe '#read?' do
      let(:history) { create(:history_returned_book) }
      let(:user)    { history.user }
      let(:book)    { history.book }

      it 'user read book' do
        expect(user.read?(book)).to be_truthy
      end
    end

    describe '#generate_authentication_token' do
      it 'must returned unique token' do
        create_list(:user, 10)
        token = build(:user).send(:generate_authentication_token)

        expect(User.where(authentication_token: token).first).to be_falsey
      end
    end
  end

  context 'Callbacks' do
    context 'before save' do
      describe '#ensure_authentication_token' do
        let(:user) { build(:user) }

        it 'token must be present after save' do
          user.save
          expect(user.authentication_token).to be_truthy
        end
      end
    end
  end
end
