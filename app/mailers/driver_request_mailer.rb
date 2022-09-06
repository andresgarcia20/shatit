class DriverRequestMailer < ApplicationMailer
  default from: "no-reply@shatit.com"

  def stage_update(driver_request_id)
    @driver_request = DriverRequest.find(driver_request_id)
    requester = @driver_request.user.email
    mail(to: requester, subject: "Driver request status update")
  end

  def admin_stage_update(driver_request_id)
    @driver_request = DriverRequest.find(driver_request_id)
    @user_admin = User.find_by(role: "admin")
    admin = @user_admin.email
    mail(to: admin, subject: "Driver request status update")
  end
end
