module Api
  module V1
    class TripJoinRequestsController < ApplicationController
      before_action :set_headers
      before_action :set_trip_join_requests

      def index
        render json: @trip_join_requests.to_json, status: :ok
      end

      private

      def set_headers
        response.headers["Content-Type"] = "application/vnd.api+json"
      end

      def set_trip_join_requests
        @trip_join_requests = TripJoinRequest.all
      end
    end
  end
end
