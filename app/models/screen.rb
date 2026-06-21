class Screen < ApplicationRecord
  belongs_to :location
  has_one :seat_map, dependent: :destroy
  has_many :screenings, dependent: :nullify

  validates :name, presence: true
  validates :screen_type, presence: true, inclusion: {
    in: ["Standard", "PLF", "IMAX", "4DX", "Dolby Cinema", "ScreenX"]
  }
  validates :capacity, presence: true, numericality: {
    greater_than: 0,
    less_than_or_equal_to: 1000
  }

  scope :active, -> { where(active: true) }

  def has_seat_map?
    seat_map.present?
  end
end
