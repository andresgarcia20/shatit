class DriverController < ApplicationController
  def index
    @trips = Trip.by_user(current_user.id)
  end
end
