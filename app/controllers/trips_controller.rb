class TripsController < ApplicationController
  before_action :set_trip, only: %i[ show edit update destroy ]
  before_action :only => [:edit] do
    redirect_to new_user_session_path unless current_user && current_user.role == "admin"
  end

  # GET /trips or /trips.json
  def index
    query = Trip
    query = query.by_origin(params[:origin]) if params[:origin].present? && !params[:origin].nil?
    query = query.by_destination(params[:destination]) if params[:destination].present? && !params[:destination].nil?
    query = query.by_number_of_stops(params[:stops]) if params[:stops].present? && !params[:stops].nil?
    query = query.by_vehicle(params[:type]) if params[:type].present? && !params[:type].nil?
    query = query.by_free_seats(params[:seats]) if params[:seats].present? && !params[:seats].nil?
    query = query.by_user(params[:user_id]) if params[:user_id].present? && !params[:user_id].nil?
    @trips = query.all
  end

  # GET /trips/1 or /trips/1.json
  def show
    @trip = Trip.find(params[:id])
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
  end

  # POST /trips or /trips.json
  def create
    @trip = Trip.new(trip_params)

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

  # PATCH/PUT /trips/1 or /trips/1.json
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

  # DELETE /trips/1 or /trips/1.json
  def destroy
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url, notice: "Trip was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trip
    @trip = Trip.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trip_params
    params.require(:trip).permit(:user_id, :vehicle_id, :origin, :available_seats, :departure_date, destinations: [])
  end
end
