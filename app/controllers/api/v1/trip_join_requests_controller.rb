module Api
  module V1
    class TripJoinRequestsController < ApplicationController
      before_action :set_headers

      def index
        trip_join_requests = TripJoinRequest.all
        render json: trip_join_requests.to_json, status: :ok
      end

      private

      def set_headers
        response.headers["Content-Type"] = "application/vnd.api+json"
      end
    end
  end
end