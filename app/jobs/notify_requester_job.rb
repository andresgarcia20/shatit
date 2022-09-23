class NotifyRequesterJob < ApplicationJob
  queue_as :default

  def perform(obj)
    TripJoinRequestMailer.stage_update(obj).deliver
  end
end
