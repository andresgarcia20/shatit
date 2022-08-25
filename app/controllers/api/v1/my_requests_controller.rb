module Api
  module V1
    class MyRequestsController < ApplicationController
      before_action :set_headers

      def index
        my_requests = TripJoinRequest.where(user_id: current_user.id)
        render json: my_requests.to_json, status: :ok
      end

      private

      def set_headers
        response.headers["Content-Type"] = "application/vnd.api+json"
      end
    end
  end
end
