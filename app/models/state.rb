class State < ApplicationRecord
  has_many :locations, dependent: :restrict_with_error

  validates :name, presence: true
  validates :abbreviation, presence: true, uniqueness: true
  validates :time_zone, presence: true, inclusion: { in: ActiveSupport::TimeZone::MAPPING.values }
end