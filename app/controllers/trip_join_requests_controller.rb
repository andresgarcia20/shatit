class TripJoinRequestsController < ApplicationController
  before_action :set_trip_join_request, only: %i[ show edit update destroy ]
  before_action :set_trip, only: %i[edit new]

  def index
    @trip_join_requests = TripJoinRequest.where(trip_id: params[:trip_id])
  end

  def show
  end

  def show_my_requests
    @trip_join_requests = TripJoinRequest.where(user_id: current_user.id)
  end

  def new
    @trip_join_request = TripJoinRequest.new
  end

  def edit
  end

  def create
    @trip_join_request = TripJoinRequest.new({ **trip_join_request_params, trip_id: params[:trip_id], user_id: current_user.id })

    respond_to do |format|
      if @trip_join_request.save
        format.html { redirect_to trip_trip_join_request_url(id: @trip_join_request), notice: "Trip join request was successfully created." }
        format.json { render :show, status: :created, location: @trip_join_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trip_join_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @trip_join_request.update(trip_join_request_params)
        format.html { redirect_to trip_trip_join_request_url(id: @trip_join_request), notice: "Trip join request was successfully updated." }
        format.json { render :show, status: :ok, location: @trip_join_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trip_join_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @trip_join_request.destroy

    respond_to do |format|
      format.html { redirect_to trip_trip_join_requests_url, notice: "Trip join request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_trip_join_request
    @trip_join_request = TripJoinRequest.find(params[:id])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def trip_join_request_params
    params.require(:trip_join_request).permit(:companions, :pets, :luggage, :stage, :trip_id, :user_id, :transfer_receipt, kids: [], requesters_list: [])
  end
end
