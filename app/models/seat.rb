class Seat < ApplicationRecord
  belongs_to :seat_map_row

  validates :label, presence: true
  validates :seat_type, presence: true, inclusion: {
    in: ["standard", "premium", "wheelchair", "companion"]
  }
  validates :position, presence: true, numericality: { greater_than: 0 }

  scope :active, -> { where(active: true) }
  scope :by_position, -> { order(:position) }
  scope :standard, -> { where(seat_type: "standard") }
  scope :premium, -> { where(seat_type: "premium") }
  scope :accessible, -> { where(seat_type: ["wheelchair", "companion"]) }
end
