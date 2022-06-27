class Trip < ApplicationRecord
  belongs_to :user
  has_one :vehicle
  serialize :destinations, Array

end
