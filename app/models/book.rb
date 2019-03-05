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
  field :popularity,      type: Integer,  default: 0  # sum votes & taken(auto-update)

  belongs_to  :user
  has_many    :votes,     dependent: :destroy
  has_many    :comments,  dependent: :destroy
  has_many    :history,   dependent: :destroy,  class_name: 'History'

  mount_uploader :image,  ImageUploader

  validates_presence_of :title
  validates_presence_of :author

  def update_rating
    sum = 0.0

    votes.each { |vote| sum += vote.rating }

    self.rating = (sum / self.votes_count).round(1)
    self.save
  end

  def voted?(user)
    votes.find_by(user: user)
  end
end
