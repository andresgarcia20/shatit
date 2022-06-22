class Vehicle < ApplicationRecord
  belongs_to :user

  validates :model, presence: true, length: { minimum: 3}
  validates :air_conditioning, presence: true, inclusion: { in: [true, false] }
  enum vehicle_type: [:car, :van, :boat, :yatch, :motorbike, :bike, :caravan]
  validates :consumption, presence: true
  validates :nickname, presence: true
end
