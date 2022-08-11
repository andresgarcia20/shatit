require "rails_helper"

RSpec.describe "Api::V1::Trips", type: :request do
  describe "GET /index" do
    context "when content type is not json" do
      let(:invalid_header) {
        {
          CONTENT_TYPE: "text/plain",
          authorization: "Basic YWRtaW46YWRtaW4=",
        }
      }

      it "returns false if it not returns json" do
        get api_v1_trips_url, params: {}, headers: invalid_header
        expect(response).to have_http_status(:not_acceptable)
      end
    end

    context "when response data is correct" do
      let(:valid_header) {
        {
          CONTENT_TYPE: "application/json",
          authorization: "Basic YWRtaW46YWRtaW4=",
        }
      }

      it "returns ok status" do
        get api_v1_trips_url, params: {}, headers: valid_header, as: :json
        expect(response.status).to be 200
      end
    end

    context "when is not authorized" do
      let(:invalid_token) {
        {
          CONTENT_TYPE: "application/json",
          authorization: "poldo",
        }
      }

      it "returns 401" do
        get api_v1_trips_url, params: {}, headers: invalid_token
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
