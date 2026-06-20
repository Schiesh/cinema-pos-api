class SeatMapRow < ApplicationRecord
  belongs_to :seat_map
  has_many :seats, dependent: :destroy

  validates :row_letter, presence: true
  validates :seats_per_row, presence: true, numericality: { greater_than: 0 }

  after_create :generate_seats

  private

  def generate_seats
    seats_per_row.times do |i|
      position = i + 1
      seats.create!(
        label: "#{row_letter}#{position}",
        seat_type: "standard",
        position: position
      )
    end
  end
end
