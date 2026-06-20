class Ticket < ApplicationRecord
  belongs_to :screening

  validates :seat_number, presence: true
  validates :status, presence: true, inclusion: { in: %w[available reserved sold] }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :customer_name, presence: true, if: :reserved_or_sold?
  validates :customer_email, presence: true, if: :reserved_or_sold?

  scope :available, -> { where(status: "available") }
  scope :sold, -> { where(status: "sold") }
  scope :by_seat, -> { order(:seat_number) }
  scope :standard, -> { where(seat_type: "standard") }
  scope :premium, -> { where(seat_type: "premium") }
  scope :accessible, -> { where(seat_type: ["wheelchair", "companion"]) }

  private

  def reserved_or_sold?
    status == "reserved" || status == "sold"
  end
end
