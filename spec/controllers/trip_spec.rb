require "rails_helper"
RSpec.describe TripsController, type: :controller do
  include Devise::Test::ControllerHelpers
  describe "GET 'index'" do
    let(:user) { create(:user) }
    let(:vehicle) { create(:vehicle, user: user) }
    let!(:first_trip) { create(:trip, user: user, vehicle: vehicle) }
    let!(:trip_origin_valencia) { create(:trip, user: user, vehicle: vehicle, origin: "Valencia") }
    let!(:trip_origin_barcelona) { create(:trip, user: user, vehicle: vehicle, origin: "Barcelona") }
    let!(:trip_three_destinations) { create(:trip, user: user, vehicle: vehicle, destinations: ["Cuenca", "Valencia", "Barcelona"]) }
    before { sign_in user }

    context "when there are no filters" do
      before { get :index }

      it "assigns @trips" do
        expect(assigns(:trips).count).to eq(4)
      end

      it "assigns all @trips" do
        expect(assigns(:trips).map(&:id)).to eq([first_trip.id, trip_origin_valencia.id, trip_origin_barcelona.id, trip_three_destinations.id])
      end
    end

    context "filters by origin = madrid" do
      before { get :index, params: { origin: "madrid" } }

      it { expect(assigns(:trips).map(&:id)).to eq([first_trip.id, trip_three_destinations.id]) }
    end

    context "filters by origin = valencia" do
      before { get :index, params: { origin: "valencia" } }

      it { expect(assigns(:trips).map(&:id)).to eq([trip_origin_valencia.id]) }
    end

    context "filters by origin = barcelona" do
      before { get :index, params: { origin: "barcelona" } }

      it { expect(assigns(:trips).map(&:id)).to eq([trip_origin_barcelona.id]) }
    end

    context "filters by destinations = barcelona" do
      before { get :index, params: { destinations: "barcelona" } }
      it {
        binding.pry
        expect(assigns(:trips).map(&:id)).to eq([trip_three_destinations.id])
      }
    end
  end
end
