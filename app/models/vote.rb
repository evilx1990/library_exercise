# frozen_string_literal: true

class Vote
  include Mongoid::Document

  field :vote,  type: Integer,  default: 0

  belongs_to  :user
  belongs_to  :book, counter_cache: :votes_count

  index({ user: 1, book: 1 })
end
