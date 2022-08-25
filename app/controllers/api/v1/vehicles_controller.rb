module Api
  module V1
    class VehiclesController < ApplicationController
      before_action :set_headers

      def index
        vehicles = Vehicle.all
        render json: vehicles.to_json, status: :ok
      end

      private

      def set_headers
        response.headers["Content-Type"] = "application/vnd.api+json"
      end
    end
  end
end
