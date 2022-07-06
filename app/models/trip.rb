class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle

  validates :origin, presence: true
  validates :destinations, presence: true, length: { minimum: 1, maximum: 9 }
  validates :available_seats, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :departure_date, presence: true
  validates :pets, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  enum kids: { no: 0, indiferent: 1, "0 to 4": 2, "5 to 12": 3, "13 to 16": 4 }, _default: 0
  validates :luggage, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :gasoline_comission, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :date_valid?
  before_save :downcase_fields

  def date_valid?
    current_date = Time.zone.now
    return true if departure_date.present? && current_date < departure_date

    errors.add(:departure_date, "departure date must be after #{current_date.to_date}")

    false
  end

  def number_of_stops
    # Number of stops without counting the final destination
    destinations.size - 1
  end

  def downcase_fields
    origin.downcase!
    destinations.map { |el| el.downcase! }
  end

  scope :by_origin, ->(origin) { where("origin = ?", origin) }
  scope :by_destination, ->(destination) { where("? = ANY (destinations)", destination) }
  scope :by_number_of_stops, ->(stops) { where("ARRAY_LENGTH(destinations, 1) = ?", (stops + 1)) }
  scope :by_vehicle, ->(type) { joins(:vehicle).where("Vehicles.vehicle_type = ?", type) }
  scope :by_free_seats, ->(seats) { where("available_seats = ?", seats) }
  scope :by_user, ->(user_id) { where("user_id = ?", user_id) }
end
