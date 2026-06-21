class Location < ApplicationRecord
  belongs_to :state
  has_many :screens, dependent: :restrict_with_error

  validates :name, presence: true

  delegate :time_zone, to: :state
end