class DriverController < ApplicationController
  before_action :only => [:index] do
    redirect_to root_path unless current_user && current_user.driver? || current_user.admin?
  end

  def index
    query = Trip.by_user(current_user.id)
    query = query.trips_done if params[:filter] == "done"
    query = query.trips_todo if params[:filter] == "todo"
    @trips = query.all
  end
end
