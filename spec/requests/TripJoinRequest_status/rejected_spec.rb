require "rails_helper"

RSpec.describe "/trip_join_requests/:id/rejected", type: :request do
  before { sign_in user }
  let(:user) { create(:user) }
  let(:vehicle) { create(:vehicle, user: user) }
  let(:trip) { create(:trip, user: user, vehicle: vehicle) }
  let(:trip_request) { create(:trip_join_request, :two_kid) }

  let(:invalid_attributes) { { "id" => 1 } }

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          companions: 0,
          pets: 1,
          luggage: 1,
          kids: ["no"],
          stage: "rejected",
        }
      }

      it "updates the requested trip_rejected" do
        patch trip_rejected_url(trip_request, :trip_id => trip.id), params: { trip_join_request: new_attributes }
        trip_request.reload
        expect(trip_request.stage).to eq("rejected")
      end

      it "redirects to the trip with the stage updated" do
        patch trip_rejected_url(trip_request, :trip_id => trip.id), params: { trip_join_request: new_attributes }
        trip_request.reload
        expect(response).to redirect_to(trip_trip_join_request_url(id: trip_request.id))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch trip_rejected_url(trip_request, :trip_id => trip.id), params: { trip_join_request: invalid_attributes }
        expect(response).to have_http_status(302)
      end
    end
  end
end
