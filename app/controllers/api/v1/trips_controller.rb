module Api
  module V1
    class TripsController < ApplicationController
      skip_before_action :authenticate_user!
      before_action :check_content_type
      http_basic_authenticate_with name: "admin", password: "admin"

      def index
        trips = Trip.all
        render json: trips.to_json, status: :ok
      end

      private

      def check_content_type
        render json: { message: "406 Not Acceptable" }, status: :not_acceptable if content_type != "application/json"
      end

      def content_type
        request.headers["HTTP_CONTENT_TYPE"] || request.headers["CONTENT_TYPE"]
      end
    end
  end
end
