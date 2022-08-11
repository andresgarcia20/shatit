class NotifyRequesterJob < ApplicationJob
  queue_as :default

  def perform(id)
    TripJoinRequestMailer.stage_update(id).deliver
  end
end
