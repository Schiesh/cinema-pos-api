class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :screen, optional: true
  has_many :tickets, dependent: :destroy

  validates :showtime, presence: true
  validates :seats_total, presence: true, numericality: { greater_than: 0 }
  validates :screen_number, presence: true

  after_create :generate_tickets_from_seat_map

  private

  def generate_tickets_from_seat_map
    return unless screen&.has_seat_map?

    screen.seat_map.seats.active.each do |seat|
      tickets.create!(
        seat_number: seat.label,
        seat_type: seat.seat_type,
        status: "available",
        price: price || movie.price
      )
    end

    update_column(:seats_total, tickets.count)
    update_column(:seats_available, tickets.count)
  end
end
