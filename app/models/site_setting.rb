class SiteSetting < ApplicationRecord
  validates :booking_cutoff_minutes, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: -1440, less_than_or_equal_to: 1440 }

  def self.current
    first || create!(booking_cutoff_minutes: 0)
  end
end