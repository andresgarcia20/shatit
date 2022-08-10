class EndTripsController < ApplicationController
  before_action :set_trip, only: %i[ update ]

  def update
    respond_to do |format|
      if @trip.finalized!
        format.html { redirect_to trip_url(id: params[:trip_id]), notice: "Trip join request was successfully updated." }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { redirect_to trip_url(id: params[:trip_id]), notice: "Something went wrong." }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end
end
