class SeatMap < ApplicationRecord
  belongs_to :screen
  has_many :seat_map_rows, dependent: :destroy
  has_many :seats, through: :seat_map_rows

  validates :rows, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 26 }

  def generate_rows(seats_per_row, has_aisle: false, aisle_after_seat: nil)
    row_letters = ("A".."Z").first(rows)
    row_letters.each do |letter|
      seat_map_rows.create!(
        row_letter: letter,
        seats_per_row: seats_per_row,
        has_aisle: has_aisle,
        aisle_after_seat: aisle_after_seat
      )
    end
  end
end
