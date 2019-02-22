# frozen_string_literal: true

class Vote
  include Mongoid::Document

  field :rating,  type: Integer,  default: 0

  belongs_to  :user
  belongs_to  :book, counter_cache: :votes_count

  validates_presence_of :rating

  index({ user: 1 })
  index({ book: 1 })
end
