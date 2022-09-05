require 'rails_helper'

RSpec.describe "DriverRequestRejecteds", type: :request do
  describe "GET /update" do
    it "returns http success" do
      get "/driver_request_rejected/update"
      expect(response).to have_http_status(:success)
    end
  end

end
