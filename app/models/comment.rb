# frozen_string_literal: true

class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :message, type: String

  belongs_to  :user
  belongs_to  :book

  validates_presence_of :message

  index({ book: 1 })
end
