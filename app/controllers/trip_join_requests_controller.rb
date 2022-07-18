class TripJoinRequestsController < ApplicationController
  before_action :set_trip_join_request, only: %i[ show edit update destroy ]

  # GET /trip_join_requests or /trip_join_requests.json
  def index
    @trip_join_requests = TripJoinRequest.all
  end

  # GET /trip_join_requests/1 or /trip_join_requests/1.json
  def show
  end

  # GET /trip_join_requests/new
  def new
    @trip_join_request = TripJoinRequest.new
  end

  # GET /trip_join_requests/1/edit
  def edit
  end

  # POST /trip_join_requests or /trip_join_requests.json
  def create
    @trip_join_request = TripJoinRequest.new(trip_join_request_params)

    respond_to do |format|
      if @trip_join_request.save
        format.html { redirect_to trip_join_request_url(@trip_join_request), notice: "Trip join request was successfully created." }
        format.json { render :show, status: :created, location: @trip_join_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trip_join_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trip_join_requests/1 or /trip_join_requests/1.json
  def update
    respond_to do |format|
      if @trip_join_request.update(trip_join_request_params)
        format.html { redirect_to trip_join_request_url(@trip_join_request), notice: "Trip join request was successfully updated." }
        format.json { render :show, status: :ok, location: @trip_join_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trip_join_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trip_join_requests/1 or /trip_join_requests/1.json
  def destroy
    @trip_join_request.destroy

    respond_to do |format|
      format.html { redirect_to trip_join_requests_url, notice: "Trip join request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_join_request
      @trip_join_request = TripJoinRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trip_join_request_params
      params.require(:trip_join_request).permit(:companions, :pets, :luggage, :kids, :stage)
    end
end
