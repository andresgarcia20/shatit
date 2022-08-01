class TripsController < ApplicationController
  before_action :set_trip, only: %i[ show edit update destroy ]
  before_action :only => [:edit] do
    redirect_to new_user_session_path unless current_user && current_user.admin?
  end

  def index
    query = Trip.order("departure_date").trips_todo
    query = query.by_origin(params[:origin]) if params[:origin].present?
    query = query.by_destination(params[:destination]) if params[:destination].present?
    query = query.by_number_of_stops(params[:stops]) if params[:stops].present?
    query = query.by_vehicle(params[:type]) if params[:type].present?
    query = query.by_free_seats(params[:seats]) if params[:seats].present?
    query = query.by_user(params[:user_id]) if params[:user_id].present?
    query = query.trips_date_range(params[:start_date], params[:end_date]) if params[:start_date].present? || params[:end_date].present?
    @trips = query.page(params[:page])
  end

  def show
  end

  def new
    @trip = Trip.new
  end

  def edit
  end

  def create
    @trip = Trip.new({ **trip_params, user_id: current_user.id })

    respond_to do |format|
      if @trip.save
        format.html { redirect_to trip_url(@trip), notice: "Trip was successfully created." }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to trip_url(@trip), notice: "Trip was successfully updated." }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url, notice: "Trip was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:user_id, :vehicle_id, :origin, :available_seats, :departure_date, :kids_age_range, :pets, :luggage, :gasoline_comission, destinations: [])
  end
end
