class TripJoinRequest < ApplicationRecord
  belongs_to :trip, required: true
  belongs_to :user, required: true

  validates :companions, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :pets, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :luggage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :kids, presence: true

  enum kids_ranges: ["no", "0 to 4", "5 to 12", "13 to 16"]
  enum stage: { requested: 0, accepted: 10, payment_in_progress: 20, paid: 30, booked: 40, rejected: 50, canceled: 60 }, _default: 0

  scope :by_trip_date, ->(date) { joins(:trip).where("DATE(trips.departure_date) = ?", date) }
  scope :by_stage, ->(stage = 0) { where("stage = ?", stage) }
  scope :by_trip, ->(trip_id) { where("trip_id = ?", trip_id) }

  def self.paid_trip_companions_by(trip_id)
    request = TripJoinRequest.by_trip(trip_id).first
    list = [{ "name" => request.user.name, "surname" => request.user.surname, "phone_number" => request.user.phone_number }]
    list + TripJoinRequest.by_trip(trip_id).by_stage(30).map(&:requesters_list).flatten
  end
end
