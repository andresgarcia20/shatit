class Trip < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :vehicle, required: true
  has_many :trip_join_requests

  validates :origin, presence: true
  validates :destinations, presence: true, length: { minimum: 1, maximum: 9 }
  validates :available_seats, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :departure_date, presence: true
  validates :pets, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :luggage, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :gasoline_comission, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :date_valid?
  before_save :downcase_fields

  scope :by_origin, ->(origin) { where("origin = ?", origin) }
  scope :by_destination, ->(destination) { where("? = ANY (destinations)", destination) }
  scope :by_number_of_stops, ->(stops) { where("ARRAY_LENGTH(destinations, 1) = ?", (stops.to_i + 1)) }
  scope :by_vehicle, ->(type) { joins(:vehicle).where("Vehicles.vehicle_type = ?", type) }
  scope :by_free_seats, ->(seats) { where("available_seats = ?", seats) }
  scope :by_user, ->(user_id) { where("user_id = ?", user_id) }
  scope :trips_todo, ->(date = Date.today) { where("departure_date >= ?", date) }

  enum kids_age_range: { no: 0, indifferent: 1, "0 to 4": 2, "5 to 12": 3, "13 to 16": 4 }, _default: 0
  enum trip_status: { not_finalized: 0, finalized: 10 }, _default: 0

  def self.trips_date_range(start_date, end_date)
    if start_date == ""
      Trip.where("departure_date <= ?", end_date)
    elsif end_date == ""
      Trip.where("departure_date >= ?", start_date)
    else
      Trip.where("departure_date >= ? AND departure_date <= ?", start_date, end_date)
    end
  end

  def date_valid?
    current_date = Time.zone.now
    return true if departure_date.present? && current_date < departure_date

    errors.add(:departure_date, "departure date must be after #{current_date.to_date}")

    false
  end

  def number_of_stops
    destinations.size - 1
  end

  def downcase_fields
    origin.downcase!
    destinations.map { |el| el.downcase! }
  end

  def update_availability(incoming_values)
    remaining_seats = available_seats - incoming_values[:seats]
    remaining_pets = pets - incoming_values[:pets]

    self.update_column(:available_seats, remaining_seats)
    self.update_column(:pets, remaining_pets)
  end
end
