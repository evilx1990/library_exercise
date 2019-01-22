# frozen_string_literal: true

class History
  include Mongoid::Document
  include Mongoid::Timestamps

  field :taken_in,    type: Time,   default: ->{ Time.now }
  field :returned_id, type: Time

  belongs_to  :user
  belongs_to  :book, counter_cache: :takes_count

  index({ user: 1, book: 1 })
end
