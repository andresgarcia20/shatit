class CompanionsController < ApplicationController
  before_action :set_companion, only: %i[ show edit update destroy ]

  def index
    @companions = Companion.all
  end

  def show
  end

  def new
    @companion = Companion.new
  end

  def edit
  end

  def create
    @companion = Companion.new({ **companion_params, user_id: params[:user_id] })

    respond_to do |format|
      if @companion.save
        format.html { redirect_to user_companion_url(id: @companion.id), notice: "Companion was successfully created." }
        format.json { render :show, status: :created, location: @companion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @companion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @companion.update(companion_params)
        format.html { redirect_to user_companion_url(id: @companion.id), notice: "Companion was successfully updated." }
        format.json { render :show, status: :ok, location: @companion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @companion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @companion.destroy

    respond_to do |format|
      format.html { redirect_to user_companions_url(@companion), notice: "Companion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_companion
    @companion = Companion.find(params[:id])
  end

  def companion_params
    params.require(:companion).permit(:name, :surname, :phone_number, :user_id)
  end
end
