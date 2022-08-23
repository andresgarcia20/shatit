class DriverController < ApplicationController
  before_action :authenticate_user!
  before_action :only => [:index] do
    redirect_to root_path unless current_user && current_user.driver? || current_user.admin?
  end

  def index
    query = Trip.by_user(current_user.id).order("departure_date")
    query = query.trips_date_range(params[:start_date], params[:end_date]) if params[:start_date].present? || params[:end_date].present?
    @trips = query.all
  end
end
