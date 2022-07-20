class TripJoinRequest < ApplicationRecord
  belongs_to :trip, required: true
  belongs_to :user, required: true

  before_save :decrease_available_seats
  validates :companions, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :pets, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :luggage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  enum kids_ranges: ["no", "0 to 4", "5 to 12", "13 to 16"]
  enum stage: { requested: 0, accepted: 1, payment_in_progress: 2, paid: 3, booked: 4, rejected: 5, cancelled: 6 }, _default: 0

  COORDINATOR = 1

  def decrease_available_seats
    trip = Trip.find(trip_id)
    seats = trip.available_seats - (companions + COORDINATOR)
    trip.update_column(:available_seats, seats)
  end
end
