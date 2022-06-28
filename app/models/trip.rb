class Trip < ApplicationRecord
  belongs_to :user
  has_one :vehicle
  serialize :destinations, Array

  validates :origin, presence: true
  validates :destinations, presence: true, length: { minimum: 1, maximum: 9 }
  validates :available_seats, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :departure_date, presence: true

  def correct_date?
    checkDaysAlreadyPast == true
  end

  private

  def checkDaysAlreadyPast
    currentDate = Time.zone.now.to_date
    departureDate = Time.zone.parse(departure_date.to_s).to_date
    currentDate < departureDate
  end
end
