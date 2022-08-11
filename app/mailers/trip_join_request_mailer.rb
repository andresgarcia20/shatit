class TripJoinRequestMailer < ApplicationMailer
  default from: "no-reply@shatit.com"

  def stage_update(trip_request_id)
    @trip_request = TripJoinRequest.find(trip_request_id)
    requester = @trip_request.user.email
    mail(to: requester, subject: "Trip request status update")
  end

  def driver_stage_update(trip_request_id)
    @trip_request = TripJoinRequest.find(trip_request_id)
    driver = @trip_request.trip.user.email
    mail(to: driver, subject: "Trip request status update for your trip")
  end
end
