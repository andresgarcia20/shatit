class NotifyDriverJob < ApplicationJob
  queue_as :default

  def perform(obj)
    TripJoinRequestMailer.driver_stage_update(obj).deliver
  end
end
