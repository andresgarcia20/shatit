class TripJoinRequest < ApplicationRecord
  belongs_to :trip
  has_one :user
end
