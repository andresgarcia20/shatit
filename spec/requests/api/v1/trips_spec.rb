require "rails_helper"
require "devise/jwt/test_helpers"

RSpec.describe "Api::V1::Trips", type: :request do
  describe "GET /index" do
    let(:user) { create(:user) }
    let(:headers) { { "Accept" => "application/json", "Content-Type" => "application/json" } }
    let(:invalid_headers) { { "Accept" => "application/json", "Content-Type" => "text/plain" } }
    let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }

    context "when response data is correct" do
      it "returns ok status" do
        get api_v1_trips_url, params: {}, headers: auth_headers, as: :json
        expect(response.status).to be 200
      end
    end

    context "when is not authorized" do
      it "returns 401" do
        get api_v1_trips_url, params: {}, headers: invalid_headers
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
