module Api
  module V1
    class TripsController < ApplicationController
      skip_before_action :authenticate_user!

      def index
        trips = Trip.all
        render json: trips.to_json, status: :ok
      end
    end
  end
end
