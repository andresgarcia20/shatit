module Api
  module V1
    class CompanionsController < ApplicationController
      before_action :set_headers

      def index
        companions = Companion.all
        render json: companions.to_json, status: :ok
      end

      private

      def set_headers
        response.headers["Content-Type"] = "application/vnd.api+json"
      end
    end
  end
end
