class Trip < ApplicationRecord
  belongs_to :user
  has_one :vehicle
  serialize :destinations, Array

  validates :origin, presence: true
  validates :destinations, presence: true, length: { minimum: 1, maximum: 9 }
  validates :available_seats, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :departure_date, presence: true

  def expired?
    check_if_date_valid == true
  end

  private

  def check_if_date_valid
    current_date = Time.zone.now
    current_date > departure_date
  end
end
