class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
  has_many :tickets, through: :screenings

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
