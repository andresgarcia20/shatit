class NotifyDriverJob < ApplicationJob
  queue_as :default

  def perform(id)
    TripJoinRequestMailer.driver_stage_update(id).deliver
  end
end
