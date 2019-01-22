# frozen_string_literal: true

class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## Database authenticatable
  field :email,                   type: String
  field :first_name,              type: String
  field :last_name,               type: String
  field :encrypted_password,      type: String
  field :librarian,               type: Boolean,  default: false
  ## Recoverable
  field :reset_password_token,    type: String
  field :reset_password_sent_at,  type: Time
  ## Rememberable
  field :remember_created_at,     type: Time

  has_many  :books
  has_many  :votes
  has_many  :comments
  has_many  :histories
end
