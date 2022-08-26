class DriverRequest < ApplicationRecord
  belongs_to :user, required: true
  mount_uploader :driver_licence_front, DriverIdUploader
  mount_uploader :driver_licence_back, DriverIdUploader

  validates :driver_licence_front, presence: true
  validates :driver_licence_back, presence: true

  enum stage: { requested: 0, accepted: 10 }, _default: 0
end
