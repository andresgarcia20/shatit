class AcceptedDriverRequestsController < ApplicationController
  before_action :set_driver_request, only: %i[ update ]
  before_action :set_user

  def update
    respond_to do |format|
      if @driver_request.accepted!
        @user.driver!
        NotifyRequesterDriverRequestJob.perform_later @driver_request
        NotifyAdminDriverRequestJob.perform_later @driver_request
        format.html { redirect_to user_driver_request_url(id: @driver_request), notice: "Driver request stage was successfully updated." }
        format.json { render user_driver_request_url(id: @driver_request), status: :created, location: @driver_request }
      else
        format.html { render user_driver_request_url(id: @driver_request), status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_driver_request
    @driver_request = DriverRequest.find(params[:driver_request_id])
  end
end
