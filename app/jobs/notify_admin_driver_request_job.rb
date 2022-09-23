class NotifyAdminDriverRequestJob < ApplicationJob
  queue_as :default

  def perform(obj)
    DriverRequestMailer.admin_stage_update(obj).deliver
  end
end
