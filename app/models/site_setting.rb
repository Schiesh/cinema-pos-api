class SiteSetting < ApplicationRecord
  validates :time_zone, presence: true, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }

  def self.current
    first || create!(time_zone: "Central Time (US & Canada)")
  end
end