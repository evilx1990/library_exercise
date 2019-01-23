# frozen_string_literal: true

class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :message, type: String

  belongs_to  :user
  belongs_to  :book

  index({ user: 1, book: 1 })

  validates :message, presence: true
end
