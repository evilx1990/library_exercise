# frozen_string_literal: true

class User # :nodoc:
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
  ## Recoverable
  field :reset_password_token,    type: String
  field :reset_password_sent_at,  type: Time
  ## Rememberable
  field :remember_created_at,     type: Time
  ## Token Authenticatable
  field :authentication_token

  has_many  :books, dependent: :destroy
  has_many  :votes
  has_many  :comments
  has_many  :history, class_name: 'History'

  validates_presence_of :first_name
  validates_presence_of :last_name

  before_save :ensure_authentication_token

  def read?(book)
    history.where(book: book)&.last&.returned_in.present?
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def name
    first_name + ' ' + last_name
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
