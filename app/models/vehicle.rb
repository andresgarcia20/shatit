class Vehicle < ApplicationRecord
  belongs_to :user
  has_one :trips

  validates :model, length: { minimum: 3 }
  validates :air_conditioning, inclusion: { in: [true, false] }
  enum vehicle_type: { car: 0, van: 1, boat: 2, yatch: 3, motorbike: 4, bike: 5, caravan: 6 }
  validates :consumption, presence: true, numericality: { only_float: true, greater_than: 0 }
  validates :nickname, presence: true, length: { minimum: 2, maximum: 10 }
end
