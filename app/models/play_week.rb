class PlayWeek < ApplicationRecord
  has_many :screenings, dependent: :nullify

  validates :start_date, presence:true
  validates :end_date, presence: true
  validate :start_date_must_be_friday
  validate :end_date_must_be_thursday
  validate :no_overlapping_play_weeks

  def self.current
    where("start_date <= ? AND end_date >= ?", Date.current, Date.current).first
  end

  def days
    (start_date..end_date).to_a
  end

  def status
    if end_date < Date.current
      'past'
    elsif start_date > Date.current
      'upcoming'
    else
      'current'
    end
  end

  private

  def start_date_must_be_friday
    return unless start_date
    unless start_date.friday?
      errors.add(:start_date, "must be a Friday")
    end
  end

  def end_date_must_be_thursday
    return unless end_date && start_date
    unless end_date == start_date + 6
      errors.add(:end_date, "must be exactly 6 days after start date (the following Thursday)")
    end
  end

  def no_overlapping_play_weeks
    return unless start_date && end_date
    overlapping = PlayWeek.where(
      "start_date <= ? AND end_date >= ?", end_date, start_date
    )
    overlapping = overlapping.where.not(id: id) if persisted?
    if overlapping.exists?
      errors.add(:start_date, "overlaps with an existing play week")
    end
  end
end
