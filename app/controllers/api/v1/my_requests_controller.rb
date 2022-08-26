module Api
  module V1
    class MyRequestsController < ApplicationController
      before_action :set_headers
      before_action :set_user

      def index
        render json: @user_requests.to_json, status: :ok
      end

      private

      def set_headers
        response.headers["Content-Type"] = "application/vnd.api+json"
      end

      def set_user
        @user_requests = TripJoinRequest.find_by_user_id(current_user.id)
      end
    end
  end
end
