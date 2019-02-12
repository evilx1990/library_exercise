# frozen_string_literal: true

class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :image,           type: String
  field :title,           type: String
  field :author,          type: String
  field :description,     type: String
  field :status,          type: Boolean,  default: true
  field :rating,          type: Float,    default: 0.0
  field :votes_count,     type: Integer,  default: 0
  field :taken_count,     type: Integer,  default: 0
  field :popularity,      type: Integer,  default: 0  # sum votes & takes(auto-update)

  belongs_to  :user
  has_many    :votes,     dependent: :destroy
  has_many    :comments,  dependent: :destroy
  has_many    :history,   dependent: :destroy,  class_name: 'History'

  index({ title: 1, author: 1 })

  mount_uploader :image,  ImageUploader

  validates :title,   presence: true
  validates :author,  presence: true

  def update_rating
    sum = count = 0.0

    votes.each do |vote|
      sum += vote.rating
      count += 1
    end

    self.rating = (sum / count).round(1)
    self.save
  end

  def voted?(user)
    votes.find_by(user: user)
  end
end
