class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show edit update destroy ]

  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    @vehicle = Vehicle.new
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @vehicle = @user.vehicles.create(vehicle_params)

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to user_vehicle_url(id: @vehicle.id), notice: "Vehicle was successfully created." }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to user_vehicle_url(@vehicle.user, @vehicle), notice: "Vehicle was successfully updated." }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @vehicle.destroy

    respond_to do |format|
      format.html { redirect_to user_vehicles_url(@user), notice: "Vehicle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:user_id, :model, :air_conditioning, :vehicle_type, :consumption, :nickname)
  end
end
