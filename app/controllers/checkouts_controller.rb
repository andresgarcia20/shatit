class CheckoutsController < ApplicationController
  before_action :set_trip_join_request, only: %i[ edit update payment_receipt ]

  def index
  end

  def new
    @trip_join_request = TripJoinRequest.new
  end

  def edit
  end

  def create
    trip_join_request = TripJoinRequest.new
    @checkout = trip_join_request.transfer_receipt(checkout_params)

    respond_to do |format|
      if @checkout.save
        format.html { redirect_to trip_trip_join_request_url(trip_id: @trip_join_request.trip.id, id: @trip_join_request), notice: "Trip join request was successfully created." }
        format.json { render :show, status: :created, location: @trip_join_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @trip_join_request.update(trip_join_request_params)
        format.html { redirect_to trip_trip_join_request_url(trip_join_request_id: @trip_join_request), notice: "Trip join request was successfully updated." }
        format.json { render :show, status: :ok, location: @trip_join_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trip_join_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def payment_receipt
  end

  private

  def set_trip_join_request
    @trip_join_request = TripJoinRequest.find(params[:trip_join_request_id])
  end

  def checkout_params
    params.fetch(:checkout).permit(:file)
  end
end
