require "rails_helper"

RSpec.describe "/trip_join_requests/:id/accepted", type: :request do
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
          stage: 50,
        }
      }

      it "updates the requested rejected_trip_trip_join_request" do
        patch rejected_trip_trip_join_request_url(trip_request, :trip_id => trip.id, :id => trip_request.id), params: { trip_join_request: new_attributes }
        trip_request.reload
        expect(trip_request.stage).to eq(50)
      end

      it "redirects to the trip with the stage updated" do
        patch rejected_trip_trip_join_request_url(trip_request, :trip_id => trip.id, :id => trip_request.id), params: { trip_join_request: new_attributes }
        trip_request.reload
        expect(response).to redirect_to(trip_trip_join_request_url(id: trip_request.id))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch rejected_trip_trip_join_request_url(trip_request, :trip_id => trip.id, :id => trip_request.id), params: { trip_join_request: invalid_attributes }
        expect(response).to have_http_status(302)
      end
    end
  end
end
