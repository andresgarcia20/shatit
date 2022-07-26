class CanceledController < ApplicationController
  before_action :set_canceled_trip_join_request, only: %i[ update ]

  def update
    respond_to do |format|
      if @trip_join_request.update(trip_join_request_params)
        format.html { redirect_to trip_trip_join_request_url(id: params[:id]), notice: "Trip join request stage was successfully updated." }
        format.json { render trip_trip_join_request_url(id: params[:id]), status: :created, location: @trip_join_request.trip_id }
      else
        format.html { render trip_trip_join_request_url(id: params[:id]), status: :unprocessable_entity }
        format.json { render json: @trip_join_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_canceled_trip_join_request
    @trip_join_request = TripJoinRequest.find(params[:id])
  end

  def trip_join_request_params
    params.require(:trip_join_request).permit(:companions, :pets, :luggage, :stage, :trip_id, kids: [])
  end
end
