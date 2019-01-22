# frozen_string_literal: true

class Book
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :image,           type: String
  field :title,           type: String
  field :author,          type: String
  field :description,     type: String
  field :status,          type: Boolean
  field :votes_count,     type: Integer,  default: 0
  field :takes_count,     type: Integer,  default: 0

  belongs_to  :user
  has_many    :votes
  has_many    :comments
  has_many    :histories

  index({ title: 1, author: 1 })

  mount_uploader :image,  ImageUploader
end
