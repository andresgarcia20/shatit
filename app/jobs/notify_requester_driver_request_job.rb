class NotifyRequesterDriverRequestJob < ApplicationJob
  queue_as :default

  def perform(id)
    DriverRequestMailer.stage_update(id).deliver
  end
end
