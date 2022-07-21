class TripJoinRequest < ApplicationRecord
  belongs_to :trip
  has_one :user

  before_save :decrease_available_seats
  validates :companions, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :pets, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :luggage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :kids, presence: true

  enum stage: { requested: 0, accepted: 10, payment_in_progress: 20, paid: 30, booked: 40, rejected: 50, canceled: 60 }, _default: 0

  def decrease_available_seats
    trip = Trip.find(trip_id)
    seats = trip.available_seats - (companions + 1)
    trip.update_column(:available_seats, seats)
  end

  # private

  # def stage_management # Conditionals? no escalable
  # end
end
