class DriverRequestsController < ApplicationController
  before_action :set_driver_request, only: %i[ show edit update destroy ]

  # GET /driver_requests or /driver_requests.json
  def index
    @driver_requests = DriverRequest.all
  end

  # GET /driver_requests/1 or /driver_requests/1.json
  def show
  end

  # GET /driver_requests/new
  def new
    @driver_request = DriverRequest.new
  end

  # GET /driver_requests/1/edit
  def edit
  end

  # POST /driver_requests or /driver_requests.json
  def create
    @driver_request = DriverRequest.new({ **driver_request_params, user_id: current_user.id })
    @driver_request.driver_licence_front = params[:file]
    @driver_request.driver_licence_back = params[:file]
    # check paraams for files

    respond_to do |format|
      if @driver_request.save
        format.html { redirect_to driver_request_url(@driver_request), notice: "Driver request was successfully created." }
        format.json { render :show, status: :created, location: @driver_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @driver_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /driver_requests/1 or /driver_requests/1.json
  def update
    respond_to do |format|
      if @driver_request.update(driver_request_params)
        format.html { redirect_to driver_request_url(@driver_request), notice: "Driver request was successfully updated." }
        format.json { render :show, status: :ok, location: @driver_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @driver_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /driver_requests/1 or /driver_requests/1.json
  def destroy
    @driver_request.destroy

    respond_to do |format|
      format.html { redirect_to driver_requests_url, notice: "Driver request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_driver_request
    @driver_request = DriverRequest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def driver_request_params
    params.require(:driver_request).permit(:user_id, :driver_licence_front, :driver_licence_back, :file)
  end
end
