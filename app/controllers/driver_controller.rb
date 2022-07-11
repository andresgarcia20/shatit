class DriverController < ApplicationController
  def index
    query = Trip.by_user(current_user.id)
    query = query.select { |elm| elm.date_valid? } if params[:filter] == "done"
    query = query.select { |elm| elm.date_valid? == false } if params[:filter] == "todo"
    @trips = query
  end
end
