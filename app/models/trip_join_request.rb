class TripJoinRequest < ApplicationRecord
  belongs_to :trip
  has_one :user
  before_save :decrease_available_seats

  validates :companions, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def decrease_available_seats
    trip = Trip.find(trip_id)
    seats = trip.available_seats - (companions + 1)
    trip.update_column(:available_seats, seats)
  end
end
