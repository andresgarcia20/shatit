module Api
  module V1
    class TripsController < ApplicationController
      before_action :set_headers
      before_action :set_trips

      def index
        render json: @trips.to_json, status: :ok
      end

      private

      def set_headers
        response.headers["Content-Type"] = "application/vnd.api+json"
      end

      def set_trips
        @trips = Trip.all
      end
    end
  end
end
