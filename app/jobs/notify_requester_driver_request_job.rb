class NotifyRequesterDriverRequestJob < ApplicationJob
  queue_as :default

  def perform(obj)
    DriverRequestMailer.stage_update(obj).deliver
  end
end
