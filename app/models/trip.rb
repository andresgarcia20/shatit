class Trip < ApplicationRecord
  belongs_to :user
  has_one :vehicle
  serialize :destinations, Array

  validates :origin, presence: true
  validates :destinations, presence: true, length: { minimum: 1, maximum: 9 }
  validates :available_seats, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :departure_date, presence: true
  validate :date_valid?

  def date_valid?
    current_date = Time.zone.now
    valid = current_date < departure_date
    unless valid
      errors.add(:departure_date, "departure date must be after #{current_date.to_date}")
    end
    valid
  end

  def number_of_stops
    # Number of stops without counting the final destination
    destination.size - 1
  end
end
