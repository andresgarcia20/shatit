class NotifyAdminDriverRequestJob < ApplicationJob
  queue_as :default

  def perform(id)
    DriverRequestMailer.admin_stage_update(id).deliver
  end
end
