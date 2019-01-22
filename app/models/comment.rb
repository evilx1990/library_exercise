# frozen_string_literal: true

class Comment
  include Mongoid::Document

  field :comment, type: String

  belongs_to  :user
  belongs_to  :book

  index({ user: 1, book: 1 })
end
