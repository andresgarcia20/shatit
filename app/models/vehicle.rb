class Vehicle < ApplicationRecord
  belongs_to :user

  validates :model, presence: true, length: { minimum: 3}
  validates :air_conditioning, inclusion: { in: [true, false] }
  enum vehicle_type: [:car, :van, :boat, :yatch, :motorbike, :bike, :caravan]
  validates :consumption, presence: true, numericality: { only_float: true, greater_than: 0 }
  validates :nickname, presence: true, length: { minimum: 2, maximum: 10 }
end
