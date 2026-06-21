class Movie < ApplicationRecord
  attribute :coming_soon_toggle, :boolean, default: true

  has_many :screenings, dependent: :destroy
  has_many :tickets, through: :screenings

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  scope :now_showing, -> {
    joins(screenings: { screen: { location: :state } })
      .where(
        "(screenings.showtime AT TIME ZONE 'UTC' AT TIME ZONE states.time_zone)::date = 
        (NOW() AT TIME ZONE states.time_zone)::date"
      )
      .where(
        "screenings.showtime + (? * INTERVAL '1 minute') >= NOW()",
        SiteSetting.current.booking_cutoff_minutes
      )
      .distinct
  }

  scope :coming_soon, -> {
    now_showing_ids = now_showing.pluck(:id)

    has_future_screening = joins(screenings: { screen: { location: :state } })
      .where(
        "(screenings.showtime AT TIME ZONE 'UTC' AT TIME ZONE states.time_zone)::date > 
        (NOW() AT TIME ZONE states.time_zone)::date"
      )
      .distinct

    manually_flagged = where(coming_soon_toggle: true)

    where(id: has_future_screening.pluck(:id) + manually_flagged.pluck(:id))
      .where.not(id: now_showing_ids)
      .distinct
  } 
end
