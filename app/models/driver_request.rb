class DriverRequest < ApplicationRecord
  belongs_to :user, required: true
  mount_uploader :driver_licence_front, DriverIdUploader
  mount_uploader :driver_licence_back, DriverIdUploader

  validates :driver_licence_front, presence: true
  validates :driver_licence_back, presence: true

  enum stage: { requested: 0, accepted: 10, rejected: 20 }, _default: 0

  scope :by_user, ->(user_id) { where("user_id = ?", user_id) }
  scope :by_requested, ->() { where(stage: :requested) }
  scope :by_accepted, ->() { where(stage: :accepted) }
  scope :by_rejected, ->() { where(stage: :rejected) }
end
