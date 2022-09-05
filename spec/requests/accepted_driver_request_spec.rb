require 'rails_helper'

RSpec.describe "AcceptedDriverRequests", type: :request do
  before { sign_in user }
  let(:user) { create(:user) }
  let(:driver_request) { create(:driver_request) }

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the driver request" do
        patch user_driver_request_accepted_driver_request_path(user_id: user.id, driver_request_id: driver_request.id)
        driver_request.reload
        expect(driver_request.stage).to eq("accepted")
      end

      it "redirects to the driver request updated" do
        patch user_driver_request_accepted_driver_request_path(user_id: user.id, driver_request_id: driver_request.id)
        driver_request.reload
        expect(response).to redirect_to(user_driver_request_path( user_id: user.id, id: driver_request.id))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { "color": "blue" } }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch user_driver_request_accepted_driver_request_path(user_id: user.id, driver_request_id: driver_request.id), params: invalid_attributes
        expect(response).to have_http_status(302)
      end
    end
  end
end
