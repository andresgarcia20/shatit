module Api
  module V1
    class VehiclesController < ApplicationController
      before_action :set_headers
      before_action :set_vehicles

      def index
        render json: @vehicles.to_json, status: :ok
      end

      private

      def set_headers
        response.headers["Content-Type"] = "application/vnd.api+json"
      end

      def set_vehicles
        @vehicles = Vehicle.all
      end
    end
  end
end
