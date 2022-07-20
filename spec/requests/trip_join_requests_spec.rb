require "rails_helper"

RSpec.describe "/trip_join_requests", type: :request do
  before { sign_in user }
  let(:user) { create(:user) }
  let(:vehicle) { create(:vehicle, user: user) }
  let(:trip) { create(:trip, user: user, vehicle: vehicle) }
  let(:trip_request) { create(:trip_join_request, :two_kid) }

  let(:valid_attributes) { attributes_for(:trip_join_request, :two_kid, stage: "requested") }

  let(:invalid_attributes) { { "id" => 1 } }

  describe "GET /index" do
    it "renders a successful response" do
      trip_request
      get trip_trip_join_requests_url(:trip_id => trip.id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      trip_request
      get trip_trip_join_request_url(trip_request, :trip_id => trip.id)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_trip_trip_join_request_url(:trip_id => trip.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_trip_trip_join_request_url(trip_request, :trip_id => trip.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new TripJoinRequest" do
        expect {
          post trip_trip_join_requests_url(:trip_id => trip.id), params: { trip_join_request: valid_attributes }
        }.to change(TripJoinRequest, :count).by(1)
      end

      it "expects kids array" do
        post trip_trip_join_requests_url(:trip_id => trip.id), params: { trip_join_request: valid_attributes }
        expect(TripJoinRequest.last.kids).to eq(valid_attributes[:kids])
      end

      it "redirects to the created trip_join_request" do
        post trip_trip_join_requests_url(:trip_id => trip.id), params: { trip_join_request: valid_attributes }
        expect(response).to redirect_to(trip_trip_join_request_url(id: TripJoinRequest.last.id))
      end
    end

    context "with invalid parameters" do
      it "does not create a new TripJoinRequest" do
        expect {
          post trip_trip_join_requests_url(:trip_id => trip.id), params: { trip_join_request: invalid_attributes }
        }.to change(TripJoinRequest, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post trip_trip_join_requests_url(:trip_id => trip.id), params: { trip_join_request: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          companions: 0,
          pets: 1,
          luggage: 1,
          kids: ["no"],
          stage: "requested",
        }
      }

      it "updates the requested trip_join_request" do
        patch trip_trip_join_request_url(trip_request, :trip_id => trip.id), params: { trip_join_request: new_attributes }
        trip_request.reload
        expect(trip_request.pets).to eq(1)
      end

      it "redirects to the trip_join_request" do
        patch trip_trip_join_request_url(trip_request, :trip_id => trip.id), params: { trip_join_request: new_attributes }
        trip_request.reload
        expect(response).to redirect_to(trip_trip_join_request_url(id: trip_request.id))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch trip_trip_join_request_url(trip_request, :trip_id => trip.id), params: { trip_join_request: invalid_attributes }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested trip_join_request" do
      trip_request
      expect {
        delete trip_trip_join_request_url(trip_request, :trip_id => trip.id)
      }.to change(TripJoinRequest, :count).by(-1)
    end

    it "redirects to the trip_join_requests list" do
      delete trip_trip_join_request_url(trip_request, :trip_id => trip.id)
      expect(response).to redirect_to(trip_trip_join_requests_url)
    end
  end
end
