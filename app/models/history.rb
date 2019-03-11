# frozen_string_literal: true

class History # :nodoc:
  include Mongoid::Document

  field :taken_in,    type: Time,   default: ->{ Time.now }
  field :returned_in, type: Time

  belongs_to  :user
  belongs_to  :book, counter_cache: :taken_count

  index({ user: 1 })
  index({ book: 1 })
end
