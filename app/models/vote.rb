# frozen_string_literal: true

class Vote # :nodoc:
  include Mongoid::Document

  field :rating,  type: Integer,  default: 0

  belongs_to  :user
  belongs_to  :book, counter_cache: :votes_count

  validates_presence_of :rating

  before_save :normalize_rating

  index({ user: 1 })
  index({ book: 1 })

  def normalize_rating
    self.rating = 1  if rating < 1
    self.rating = 10 if rating > 10
  end
end
