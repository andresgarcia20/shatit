class DriverRequest < ApplicationRecord
  belongs_to :user, required: true
  mount_uploader :driver_licence_front, DriverIdUploader
  mount_uploader :driver_licence_back, DriverIdUploader

  validates :driver_licence_front, presence: true
  validates :driver_licence_back, presence: true

  enum stage: { requested: 0, accepted: 10, rejected: 20 }, _default: 0

  scope :by_user, ->(user) { where("user_id = ?", user) }
  scope :by_requested, ->() { where("stage = 0") }
  scope :by_accepted, ->() { where("stage = 10") }
  scope :by_rejected, ->() { where("stage = 20") }
end
